package gearcalc
{
   import flash.utils.Dictionary;
   
   public class Weapon implements Gearable
   {
      
      public static const SLOT_GRADE:int = 1;
      
      public static const SLOT_MANUFACTURER:int = 2;
      
      public static const SLOT_TYPE:int = 3;
      
      public static const SLOT_BODY:int = 4;
      
      public static const SLOT_GRIP:int = 5;
      
      public static const SLOT_MAGAZINE:int = 6;
      
      public static const SLOT_BARREL:int = 7;
      
      public static const SLOT_SIGHT:int = 8;
      
      public static const SLOT_STOCK:int = 9;
      
      public static const SLOT_ACTION:int = 10;
      
      public static const SLOT_ACCESSORY:int = 11;
      
      public static const SLOT_MATERIAL:int = 12;
      
      public static const SLOT_PREFIX:int = 13;
      
      public static const SLOT_TITLE:int = 14;
      
      public static const NUM_PART_SLOTS:int = 14;
      
      public static const BASE_TEDIORE_REGEN:int = 10;
      
      public const GEAR_TYPE:uint = 3;
      
      public var gunType:String = "None";
      
      internal var slotReqs:Vector.<Slot>;
      
      public var label:String = "";
      
      private var attr:Dictionary = null;
      
      internal var parts:Vector.<Part> = new Vector.<Part>();
      
      private var qualityLevel:int = 0;
      
      private var expLevel:int = 0;
      
      public var stats:StatSet = null;
      
      public var elemental:String = "";
      
      public var slotNum:int = 0;
      
      public var showable:Boolean;
      
      public function Weapon()
      {
         super();
         this.showable = true;
         var _loc1_:int = 0;
         while(_loc1_ < NUM_PART_SLOTS)
         {
            this.parts.push(GearCalcUtil.OBJ_PART_NULL);
            _loc1_++;
         }
         this.slotReqs = Slot.createSlotTemplate(this.getGearType());
      }
      
      public function getAttributes() : Dictionary
      {
         return this.attr;
      }
      
      public function getAttribute(param1:String) : Attribute
      {
         return this.attr[param1];
      }
      
      public function setAttribute(param1:String, param2:Number) : void
      {
         this.attr[param1] = param2;
      }
      
      public function setAttributes(param1:Dictionary) : void
      {
         this.attr = param1;
      }
      
      public function setParts(param1:Vector.<Part>) : void
      {
         this.parts = param1;
      }
      
      public function getSlotAmount() : uint
      {
         return this.parts.length;
      }
      
      public function getPart(param1:String) : Part
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.parts.length)
         {
            if(param1 == this.parts[_loc2_].getType())
            {
               return this.parts[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getSlottedPart(param1:String) : Part
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.slotReqs.length)
         {
            if(param1 == this.slotReqs[_loc2_].name)
            {
               return this.parts[_loc2_];
            }
            if(param1 == GearCalcUtil.PART_TYPE_PREFIX && this.slotReqs[_loc2_].acceptableTypes == GearCalcUtil.PART_TYPE_GENERAL_NAME)
            {
               return this.parts[this.parts.length - 2];
            }
            if(param1 == GearCalcUtil.PART_TYPE_TITLE && this.slotReqs[_loc2_].acceptableTypes == GearCalcUtil.PART_TYPE_GENERAL_NAME)
            {
               return this.parts[this.parts.length - 1];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getParts() : Vector.<Part>
      {
         return this.parts;
      }
      
      public function getExpLevel() : int
      {
         return this.expLevel;
      }
      
      public function getQualityLevel() : int
      {
         return this.qualityLevel;
      }
      
      public function setExpLevel(param1:int) : void
      {
         this.expLevel = param1;
      }
      
      public function setQualityLevel(param1:int) : void
      {
         this.qualityLevel = param1;
      }
      
      public function addPart(param1:int, param2:Part) : void
      {
         this.parts[param1] = param2;
      }
      
      public function removePart(param1:String) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.slotReqs.length)
         {
            if(this.slotReqs[_loc2_].name == param1)
            {
               this.parts[_loc2_] = null;
               break;
            }
            _loc2_++;
         }
      }
      
      public function getSlotRequirements() : Vector.<Slot>
      {
         return this.slotReqs;
      }
      
      public function getCurrentStats() : StatSet
      {
         return this.stats;
      }
      
      public function setStats(param1:StatSet) : void
      {
         this.stats = param1;
      }
      
      public function getGearType() : int
      {
         return GearCalcUtil.GEAR_WEAPON;
      }
      
      public function setLabel(param1:String) : void
      {
         this.label = param1;
      }
      
      public function getModifiersOfType(param1:String) : Vector.<AttributeModifier>
      {
         var _loc3_:Vector.<AttributeModifier> = null;
         var _loc4_:Part = null;
         var _loc5_:AttributeModifier = null;
         var _loc2_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         for each(_loc4_ in this.parts)
         {
            _loc3_ = _loc4_.getAttrModifiers();
            for each(_loc5_ in _loc3_)
            {
               if(_loc5_.getAttrToMod() == param1)
               {
                  _loc2_.push(_loc5_);
               }
            }
         }
         return _loc2_;
      }
      
      public function calculateBase(param1:StatSet) : StatSet
      {
         var _loc2_:Number = 0;
         _loc2_ = Calculator.calcStandardFormula(1,1.16,this.getExpLevel(),0);
         param1.addNumericalStat(GearCalcUtil.ATTR_COST,Math.round(_loc2_ * 10) / 10);
         param1.addNumericalStat(GearCalcUtil.ATTR_RARITY,0);
         _loc2_ = Calculator.calcStandardFormula(0.8,this.getExpLevel(),1.3,9);
         param1.addNumericalStat(GearCalcUtil.ATTR_DAMAGE,_loc2_);
         param1.addNumericalStat(GearCalcUtil.ATTR_CLIP,0);
         param1.addNumericalStat(GearCalcUtil.ATTR_FIRERATE,0);
         param1.addNumericalStat(GearCalcUtil.ATTR_PROJECTILE_COUNT,1);
         param1.addNumericalStat(GearCalcUtil.ATTR_SHOT_COST,1);
         param1.addNumericalStat(GearCalcUtil.ATTR_BURST_COUNT,0);
         param1.addNumericalStat(GearCalcUtil.ATTR_CRIT,1);
         param1.addNumericalStat(GearCalcUtil.ATTR_TECH_REGEN,4);
         param1.addNumericalStat(GearCalcUtil.ATTR_AMMO_REGEN,0);
         param1.addNumericalStat(GearCalcUtil.ATTR_TECH,0);
         param1.addNumericalStat(GearCalcUtil.ATTR_ACC_REGEN,-8);
         param1.addNumericalStat(GearCalcUtil.ATTR_ACC_MAX,12);
         param1.addNumericalStat(GearCalcUtil.ATTR_ACC_MIN,2);
         return param1;
      }
      
      public function postCalculate(param1:StatSet) : void
      {
         var _loc2_:Number = param1.getStat(GearCalcUtil.ATTR_DAMAGE);
         var _loc3_:Number = Calculator.calcStandardFormula(0.8,this.getExpLevel(),1.3,9);
         param1.addNumericalStat(GearCalcUtil.ATTR_DAMAGE_NORMAL,_loc2_ / _loc3_);
         var _loc4_:Number = param1.getStat(GearCalcUtil.ATTR_CLIP);
         var _loc5_:Number = param1.getStat(GearCalcUtil.ATTR_FIRERATE);
         var _loc6_:Number = param1.getStat(GearCalcUtil.ATTR_RELOAD);
         var _loc7_:Number = param1.getStat(GearCalcUtil.ATTR_PROJECTILE_COUNT);
         var _loc8_:Number = _loc4_ * _loc2_ * _loc7_ / (_loc4_ * _loc5_ + _loc6_);
         param1.addNumericalStat(GearCalcUtil.ATTR_DPS,_loc8_);
         var _loc9_:Number = 100 - 25 / 3 * param1.getStat(GearCalcUtil.ATTR_SPREAD);
         param1.addNumericalStat(GearCalcUtil.ATTR_CARD_ACCURACY,_loc9_);
         param1.addNumericalStat(GearCalcUtil.ATTR_TECH_POOL,param1.getStat(GearCalcUtil.ATTR_TECH) * 4);
         var _loc10_:Number = param1.getStat(GearCalcUtil.ATTR_AMMO_REGEN);
         var _loc11_:Part = this.getSlottedPart(GearCalcUtil.PART_TYPE_MANUFACT);
         if(_loc10_ > 0)
         {
            if(_loc11_ != null && _loc11_.getTrueName().indexOf("tediore") != -1)
            {
               _loc10_ = BASE_TEDIORE_REGEN + this.getExpLevel() * _loc10_;
               param1.addNumericalStat(GearCalcUtil.ATTR_AMMO_REGEN,_loc10_);
            }
         }
         var _loc12_:Number = param1.getStat(GearCalcUtil.ATTR_SPREAD) * 90 / 12;
         if(_loc12_ >= 90)
         {
            _loc12_ = 89.9;
         }
         param1.addNumericalStat(GearCalcUtil.ATTR_FIRING_CONE,_loc12_);
      }
      
      public function getTechAbilities() : Vector.<TechAbility>
      {
         var _loc1_:Part = this.getPart(GearCalcUtil.PART_TYPE_ACCESSORY);
         if(_loc1_ != null && _loc1_.getTechAbilities() != null && _loc1_.getTechAbilities().length > 0)
         {
            return _loc1_.getTechAbilities();
         }
         return null;
      }
      
      public function getName() : String
      {
         return this.label;
      }
      
      public function contains(param1:String) : Part
      {
         var _loc2_:Part = null;
         for each(_loc2_ in this.parts)
         {
            if(_loc2_.getID() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function isEridian() : Boolean
      {
         var _loc1_:Part = this.getSlottedPart(GearCalcUtil.PART_TYPE_MANUFACT);
         if(_loc1_ != null && _loc1_.getManufacturer().indexOf("Eridian") != -1)
         {
            return true;
         }
         return false;
      }
   }
}

