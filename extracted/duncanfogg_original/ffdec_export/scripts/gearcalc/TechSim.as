package gearcalc
{
   public class TechSim
   {
      
      public static const TERMINATION_TIME:String = "Time Controlled";
      
      public static const TERMINATION_PROC:String = "Cumulative Controlled";
      
      public static const TERMINATION_BULLETS:String = "Bullet Count";
      
      public static const TERMINATION_HIGH_PROC:String = "Cumulative Higher Proc";
      
      public static const TERMINATION_DEPLETION:String = "Shots to Depletion";
      
      public var techPool:Number;
      
      public var costs:Vector.<Number>;
      
      public var probs:Vector.<Number>;
      
      public var rof:Number;
      
      public var clip:int;
      
      public var reload:Number;
      
      public var regen:Number;
      
      public var runTime:Number;
      
      public var runLength:int;
      
      public var trialTotal:int;
      
      public var maxProcs:int;
      
      public var termType:String;
      
      public var averages:SimResultSet;
      
      public var isAuto:Boolean;
      
      private var random:Number = -1;
      
      private var set:SimResultSet;
      
      public function TechSim()
      {
         super();
         this.termType = TERMINATION_PROC;
         this.isAuto = false;
         this.averages = null;
         this.costs = new Vector.<Number>();
         this.probs = new Vector.<Number>();
         this.techPool = 60;
         this.regen = 4;
         this.rof = 4.7;
         this.clip = 20;
         this.reload = 1.14;
         this.runLength = 200;
         this.runTime = 60;
         this.maxProcs = 20;
         this.trialTotal = 20000;
      }
      
      public function getTestableLength() : int
      {
         return this.costs.length;
      }
      
      public function addTechAbility(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param2;
         if(_loc3_ > 1)
         {
            _loc3_ /= 100;
         }
         this.costs.push(param1);
         this.probs.push(_loc3_);
      }
      
      private function regenPool(param1:Number, param2:Number) : Number
      {
         if(param1 < this.techPool && this.isAuto)
         {
            if(param1 + this.regen * param2 <= this.techPool)
            {
               return param1 + this.regen * param2;
            }
            return this.techPool;
         }
         return this.techPool;
      }
      
      public function runElementalSim() : SimResultSet
      {
         var _loc1_:SimResultSet = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.averages = new SimResultSet(this.costs.length);
         _loc2_ = 0;
         while(_loc2_ < this.trialTotal)
         {
            _loc1_ = this.doSingleRun();
            _loc3_ = 0;
            while(_loc3_ < this.averages.procTotals.length)
            {
               this.averages.procTotals[_loc3_] += _loc1_.procTotals[_loc3_];
               _loc3_++;
            }
            this.averages.shotCount += _loc1_.shotCount;
            this.averages.elapsedTime += _loc1_.elapsedTime;
            this.averages.depletedCount += _loc1_.depletedCount;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.averages.procTotals.length)
         {
            this.averages.floatTotals[_loc2_] = this.averages.procTotals[_loc2_] / this.trialTotal;
            this.averages.procTotals[_loc2_] = Math.round(this.averages.floatTotals[_loc2_]);
            this.averages.netProcs += this.averages.floatTotals[_loc2_];
            _loc2_++;
         }
         this.averages.elapsedTime /= this.trialTotal;
         this.averages.depletedCount /= this.trialTotal;
         this.averages.shotCount /= this.trialTotal;
         return this.averages;
      }
      
      private function isContinue(param1:int, param2:Number, param3:int, param4:Number) : Boolean
      {
         if(this.techPool < this.costs[0])
         {
            return false;
         }
         if((this.termType == TERMINATION_PROC || this.termType == TERMINATION_HIGH_PROC) && param3 == this.maxProcs)
         {
            return false;
         }
         if(this.termType == TERMINATION_TIME && param2 + 1 / this.rof > this.runTime)
         {
            return false;
         }
         if(this.termType == TERMINATION_BULLETS && param1 == this.runLength)
         {
            return false;
         }
         if(this.termType == TERMINATION_DEPLETION && param4 < this.costs[0])
         {
            return false;
         }
         return true;
      }
      
      public function doSingleRun() : SimResultSet
      {
         var curClip:int;
         var shotCount:int;
         var procCount:int;
         var depleteCount:int;
         var time:Number = NaN;
         var curPool:Number = NaN;
         var fire:Function = function():void
         {
            time += 1 / rof;
            ++shotCount;
            --curClip;
            var _loc1_:* = false;
            var _loc2_:* = int(probs.length - 1);
            while(_loc2_ >= 0)
            {
               if(costs[_loc2_] <= curPool && rollDice(probs[_loc2_]))
               {
                  set.procTotals[_loc2_] += 1;
                  curPool += -1 * costs[_loc2_];
                  ++procCount;
                  if(termType == TERMINATION_HIGH_PROC && _loc2_ == 0)
                  {
                     --procCount;
                  }
                  break;
               }
               _loc2_--;
            }
         };
         this.set = new SimResultSet(this.costs.length);
         time = 0;
         curPool = this.techPool;
         curClip = this.clip;
         shotCount = 0;
         procCount = 0;
         depleteCount = 0;
         while(this.isContinue(shotCount,time,procCount,curPool))
         {
            if(curClip <= 0)
            {
               curClip = this.clip;
               time += this.reload;
               curPool = this.regenPool(curPool,this.reload);
            }
            else
            {
               curPool = this.regenPool(curPool,1 / this.rof);
               fire();
            }
            if(curPool < this.costs[0])
            {
               depleteCount++;
            }
         }
         this.set.depletedCount = depleteCount;
         this.set.elapsedTime = time;
         this.set.shotCount = shotCount;
         return this.set;
      }
      
      private function rollDice(param1:Number) : Boolean
      {
         var _loc2_:* = Math.random();
         if(param1 >= _loc2_)
         {
            return true;
         }
         return false;
      }
   }
}

