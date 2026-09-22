package gearcalc.wiz
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import gearcalc.*;
   
   public class WizEngine
   {
      
      public static const MIN_MATCH_ARGS:int = 2;
      
      private var spinners:Vector.<SpinnerBin>;
      
      private var base:StatSet;
      
      private var template:GearTemplate;
      
      private var level:int;
      
      private var criteria:Vector.<Constraint>;
      
      public var matches:Vector.<PartList>;
      
      public var fudge:Number = 0.04;
      
      public function WizEngine(param1:GearTemplate, param2:Number)
      {
         var _loc4_:SpinnerBin = null;
         var _loc5_:Slot = null;
         var _loc6_:SpinnerBin = null;
         super();
         this.level = param2;
         this.template = param1;
         this.matches = null;
         this.spinners = new Vector.<SpinnerBin>();
         this.criteria = new Vector.<Constraint>();
         var _loc3_:Vector.<Slot> = param1.getSlots();
         for each(_loc5_ in _loc3_)
         {
            _loc6_ = new SpinnerBin(_loc5_.name);
            if(_loc4_ != null)
            {
               _loc4_.nextBin = _loc6_;
            }
            _loc4_ = _loc6_;
            this.spinners.push(_loc6_);
         }
      }
      
      public function addCriterion(param1:String, param2:Number, param3:String) : void
      {
         var _loc4_:Constraint = new Constraint(null,param3);
         _loc4_.setAttributeOperand(param1);
         _loc4_.setOperandTwo(param2);
         this.criteria.push(_loc4_);
      }
      
      public function isCriterion(param1:String) : Boolean
      {
         var _loc2_:Constraint = null;
         for each(_loc2_ in this.criteria)
         {
            if(_loc2_.getAttr() == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getBin(param1:String) : SpinnerBin
      {
         var _loc2_:SpinnerBin = null;
         for each(_loc2_ in this.spinners)
         {
            if(_loc2_.type == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addPivot(param1:Part, param2:String) : void
      {
         if(this.getBin(param2) != null)
         {
            this.getBin(param2).initPivot(param1);
         }
      }
      
      public function addParts(param1:Vector.<Part>, param2:String) : void
      {
         if(this.getBin(param2) == null)
         {
            return;
         }
         this.getBin(param2).init(param1);
      }
      
      public function execute() : Boolean
      {
         var _loc3_:Weapon = null;
         var _loc4_:Calculator = null;
         var _loc5_:PartList = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc1_:Boolean = false;
         this.matches = new Vector.<PartList>();
         this.searchSingle(this.criteria[0]);
         var _loc2_:Vector.<PartList> = new Vector.<PartList>();
         for each(_loc5_ in this.matches)
         {
            _loc3_ = new Weapon();
            _loc3_.setExpLevel(this.level);
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.list.length)
            {
               _loc3_.addPart(_loc7_,_loc5_.list[_loc7_]);
               _loc7_++;
            }
            _loc4_ = new Calculator(_loc3_,this.template);
            _loc4_.calculate();
            _loc8_ = false;
            _loc7_ = 1;
            while(_loc7_ < this.criteria.length)
            {
               _loc8_ = this.criteria[_loc7_].approxEvaluate(_loc4_.getResults(),this.fudge);
               if(!_loc8_)
               {
                  break;
               }
               _loc7_++;
            }
            if(_loc8_)
            {
               _loc2_.push(_loc5_);
            }
         }
         if(_loc2_.length > 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function searchSingle(param1:Constraint) : void
      {
         var keepGoing:Boolean = false;
         var calc:SimpleCalculator = null;
         var isPass:Boolean = false;
         var buildVec:Vector.<Part> = null;
         var count:int = 0;
         var packet:int = 0;
         var delay:int = 0;
         var timer:Timer = null;
         var bin:SpinnerBin = null;
         var check:Function = null;
         var test:Constraint = param1;
         var iterate:Function = function():void
         {
            calc.init(spinners);
            calc.calculate();
            isPass = test.approxEvaluate(calc.stats,fudge);
            if(isPass)
            {
               generateMatches();
            }
            keepGoing = spinners[0].spin();
            ++count;
            if(count >= packet)
            {
               timer = new Timer(delay);
               timer.addEventListener(TimerEvent.TIMER,check);
               timer.start();
            }
            else
            {
               check();
            }
         };
         check = function(param1:TimerEvent = null):void
         {
            if(param1 != null)
            {
               timer.stop();
               count = 0;
            }
            if(keepGoing)
            {
               iterate();
            }
         };
         var generateMatches:Function = function():void
         {
            var _loc2_:SpinnerBin = null;
            var _loc3_:SpinnerBin = null;
            var _loc4_:Boolean = false;
            var _loc5_:SpinnerBin = null;
            var _loc6_:Vector.<Part> = null;
            var _loc1_:Vector.<SpinnerBin> = new Vector.<SpinnerBin>();
            for each(_loc3_ in spinners)
            {
               _loc5_ = new SpinnerBin(_loc3_.type);
               if(_loc2_ != null)
               {
                  _loc2_.nextBin = _loc5_;
               }
               _loc2_ = _loc5_;
               _loc5_.init(_loc3_.spec());
            }
            _loc4_ = true;
            do
            {
               _loc6_ = new Vector.<Part>();
               _loc1_[0].addToBuild(_loc6_);
               matches.push(new PartList(_loc6_,"Match"));
            }
            while(_loc4_ = _loc1_[0].spin());
         };
         var gear:Weapon = new Weapon();
         gear.setExpLevel(this.level);
         keepGoing = true;
         calc = new SimpleCalculator(gear,this.template);
         count = 0;
         packet = 300;
         delay = 17;
         for each(bin in this.spinners)
         {
            bin.filterFor(test.getAttr());
         }
         iterate();
      }
   }
}

