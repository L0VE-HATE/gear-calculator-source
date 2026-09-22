package gearcalc
{
   import flash.utils.Dictionary;
   
   public class Calculator
   {
      
      private var baseMods:Vector.<AttributeModifier> = null;
      
      private var modSources:Vector.<ModifierSource> = null;
      
      public var stats:StatSet;
      
      public var gear:Gearable;
      
      public var template:GearTemplate;
      
      public function Calculator(param1:Gearable, param2:GearTemplate)
      {
         var _loc3_:Vector.<Part> = null;
         var _loc4_:int = 0;
         super();
         this.modSources = new Vector.<ModifierSource>();
         this.baseMods = param2.getBaseModifiers();
         if(param1 != null)
         {
            _loc3_ = param1.getParts();
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               this.addModifierSource(_loc3_[_loc4_]);
               _loc4_++;
            }
            this.stats = new StatSet(param1.getExpLevel());
         }
         else
         {
            this.stats = new StatSet(0);
         }
         this.addModifierSource(param2);
         this.gear = param1;
         this.template = param2;
      }
      
      public static function calcStandardFormula(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 * (Math.pow(param2,param3) + param4);
      }
      
      public function addModifierSource(param1:ModifierSource) : void
      {
         this.modSources.push(param1);
      }
      
      public function calculate() : void
      {
         this.stats = new StatSet(this.gear.getExpLevel());
         this.gear.calculateBase(this.stats);
         this.calc(this.baseMods,true,GearCalcUtil.MOD_STATE_ALL);
         this.calc(this.collectModifiers(GearCalcUtil.MOD_STATE_ALL),false,GearCalcUtil.MOD_STATE_ALL);
         this.gear.postCalculate(this.stats);
         this.calc(this.collectModifiers(GearCalcUtil.MOD_STATE_ZOOM),false,GearCalcUtil.MOD_STATE_ZOOM);
      }
      
      public function collectModifiers(param1:String) : Vector.<AttributeModifier>
      {
         var _loc2_:Vector.<AttributeModifier> = null;
         var _loc4_:ModifierSource = null;
         var _loc5_:AttributeModifier = null;
         var _loc3_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         for each(_loc4_ in this.modSources)
         {
            _loc2_ = _loc4_.getAttrModifiers();
            for each(_loc5_ in _loc2_)
            {
               if(_loc5_.getActiveState() == param1)
               {
                  _loc3_.push(_loc5_);
               }
            }
         }
         return _loc3_;
      }
      
      public function calc(param1:Vector.<AttributeModifier>, param2:Boolean, param3:String) : void
      {
         var _loc9_:AttributeModifier = null;
         var _loc10_:StatSet = null;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc13_:AttributeModifier = null;
         var _loc14_:Dictionary = null;
         var _loc15_:Number = NaN;
         var _loc16_:Object = null;
         var _loc4_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         var _loc5_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         var _loc6_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         var _loc7_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         var _loc8_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         for each(_loc9_ in param1)
         {
            switch(_loc9_.getModType())
            {
               case GearCalcUtil.MOD_PREADD:
                  _loc4_.push(_loc9_);
                  break;
               case GearCalcUtil.MOD_SCALE:
                  if(_loc9_.getValue() >= 0)
                  {
                     _loc5_.push(_loc9_);
                  }
                  else
                  {
                     _loc6_.push(_loc9_);
                  }
                  break;
               case GearCalcUtil.MOD_POSTADD:
                  _loc8_.push(_loc9_);
                  break;
               case GearCalcUtil.MOD_MULTIPLIER:
                  _loc7_.push(_loc9_);
            }
         }
         _loc10_ = this.stats;
         if(param3 != GearCalcUtil.MOD_STATE_ALL)
         {
            _loc10_ = new StatSet(this.stats.getExpLevel());
            for each(_loc16_ in this.stats)
            {
               _loc10_.addNumericalStat(_loc16_ as String,this.stats.getStat(_loc16_ as String));
            }
         }
         _loc12_ = 0;
         while(_loc12_ < _loc4_.length)
         {
            _loc11_ = _loc10_.getStat(_loc4_[_loc12_].getAttrToMod());
            _loc10_.addNumericalStat(_loc4_[_loc12_].getAttrToMod(),_loc11_ + this.initMod(_loc4_[_loc12_],_loc10_));
            _loc12_++;
         }
         for each(_loc13_ in _loc7_)
         {
            _loc11_ = _loc10_.getStat(_loc13_.getAttrToMod());
            _loc10_.addNumericalStat(_loc13_.getAttrToMod(),_loc11_ * this.initMod(_loc13_,_loc10_));
         }
         _loc14_ = new Dictionary();
         for each(_loc9_ in _loc5_)
         {
            _loc11_ = _loc10_.getStat(_loc9_.getAttrToMod());
            if(param2)
            {
               _loc10_.addNumericalStat(_loc9_.getAttrToMod(),_loc11_ * _loc9_.getValue());
            }
            else
            {
               if(!(_loc14_[_loc9_.getAttrToMod()] is Number))
               {
                  _loc14_[_loc9_.getAttrToMod()] = Number(0);
               }
               _loc14_[_loc9_.getAttrToMod()] = _loc14_[_loc9_.getAttrToMod()] + _loc9_.getValue();
            }
         }
         for(_loc16_ in _loc14_)
         {
            _loc15_ = Number(_loc14_[_loc16_]);
            _loc11_ = _loc10_.getStat(String(_loc16_));
            _loc10_.addNumericalStat(String(_loc16_),_loc11_ + _loc15_ * _loc11_);
         }
         _loc14_ = new Dictionary();
         for each(_loc9_ in _loc6_)
         {
            if(!(_loc14_[_loc9_.getAttrToMod()] is Number))
            {
               _loc14_[_loc9_.getAttrToMod()] = Number(0);
            }
            _loc14_[_loc9_.getAttrToMod()] = _loc14_[_loc9_.getAttrToMod()] + _loc9_.getValue();
         }
         for(_loc16_ in _loc14_)
         {
            _loc15_ = Number(_loc14_[_loc16_]);
            _loc11_ = _loc10_.getStat(String(_loc16_));
            _loc10_.addNumericalStat(String(_loc16_),_loc11_ / (1 + Math.abs(_loc15_)));
         }
         _loc12_ = 0;
         while(_loc12_ < _loc8_.length)
         {
            _loc11_ = _loc10_.getStat(_loc8_[_loc12_].getAttrToMod());
            _loc10_.addNumericalStat(_loc8_[_loc12_].getAttrToMod(),_loc11_ + this.initMod(_loc8_[_loc12_],_loc10_));
            _loc12_++;
         }
         if(param3 != GearCalcUtil.MOD_STATE_ALL)
         {
            for each(_loc16_ in _loc10_)
            {
               this.stats.addNumericalStat(GearCalcUtil.statify(_loc16_ as String,param3),_loc10_.getStat(_loc16_ as String));
            }
         }
      }
      
      private function initMod(param1:AttributeModifier, param2:StatSet) : Number
      {
         var _loc3_:Number = param2.getStat(param1.getAttrToMod());
         if(param1.getInitDefinition() != null && param1.getInitDefinition() != "")
         {
            return param1.getValue() * param2.getStat(param1.getInitDefinition());
         }
         return param1.getValue();
      }
      
      private function findModsOfType(param1:String, param2:String) : Number
      {
         var _loc4_:Vector.<AttributeModifier> = null;
         var _loc5_:ModifierSource = null;
         var _loc6_:AttributeModifier = null;
         var _loc3_:Number = 0;
         for each(_loc5_ in this.modSources)
         {
            _loc4_ = _loc5_.getAttrModifiers();
            for each(_loc6_ in _loc4_)
            {
               if(_loc6_.getAttrToMod() == param1 && _loc6_.getModType() == param2)
               {
                  _loc3_ += _loc6_.getValue();
               }
            }
         }
         return _loc3_;
      }
      
      public function getResults() : StatSet
      {
         return this.stats;
      }
   }
}

