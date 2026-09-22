package gearcalc
{
   public class GearTemplate implements ModifierSource
   {
      
      public var gearType:int = 3;
      
      private var slots:Vector.<Slot> = null;
      
      private var manufacturers:Vector.<String> = null;
      
      private var partLists:Vector.<PartList>;
      
      private var generalPool:Vector.<String>;
      
      private var manuSpecs:Vector.<ManufacturerSpec>;
      
      private var baseStats:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
      
      private var attrMods:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
      
      private var constraints:Vector.<Constraint> = null;
      
      private var base:String = null;
      
      private var overrideNaming:Boolean = false;
      
      public var overrideTitle:String = null;
      
      internal var basePartStr:String = null;
      
      private var targetType:String = null;
      
      internal var naming:NamingConvention = null;
      
      public function GearTemplate(param1:XML, param2:PartCollection)
      {
         var _loc3_:Vector.<Part> = null;
         var _loc4_:XML = null;
         var _loc9_:int = 0;
         var _loc10_:ManufacturerSpec = null;
         var _loc11_:NamingRule = null;
         var _loc12_:Boolean = false;
         var _loc13_:int = 0;
         var _loc14_:Part = null;
         var _loc15_:String = null;
         super();
         this.slots = new Vector.<Slot>();
         this.partLists = new Vector.<PartList>();
         this.manufacturers = new Vector.<String>();
         this.manuSpecs = new Vector.<ManufacturerSpec>();
         this.constraints = new Vector.<Constraint>();
         this.generalPool = new Vector.<String>();
         this.targetType = param1.TargetType;
         this.baseStats = new Vector.<AttributeModifier>();
         this.basePartStr = "";
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:Constraint = null;
         if(param1.BaseTemplate.length() == 1)
         {
            this.base = param1.BaseTemplate;
         }
         if(param1.Gear.length() == 1)
         {
            if(param1.Gear == "Shield")
            {
               this.gearType = GearCalcUtil.GEAR_SHIELD;
            }
            else if(param1.Gear == "Class Mod")
            {
               this.gearType = GearCalcUtil.GEAR_COM;
            }
            else
            {
               this.gearType = GearCalcUtil.GEAR_WEAPON;
            }
         }
         if(param1.OverrideNaming.length() >= 1)
         {
            this.overrideNaming = true;
         }
         if(param1.Naming.length() == 1)
         {
            this.naming = new NamingConvention();
            _loc9_ = 0;
            while(_loc9_ < param1.Naming.Slot.length())
            {
               _loc4_ = param1.Naming.Slot[_loc9_];
               _loc11_ = new NamingRule(_loc4_.Target,_loc4_.Type);
               if(_loc4_.Length.length() == 1)
               {
                  _loc11_.length = new int(_loc4_.Length);
               }
               if(_loc4_.Text.length() == 1)
               {
                  _loc11_.text = _loc4_.Text;
               }
               if(_loc4_.Test.length() > 0 && _loc11_.type == NamingConvention.TYPE_CONDITIONAL)
               {
                  _loc13_ = 0;
                  while(_loc13_ < _loc4_.Test.length())
                  {
                     if(_loc4_.Test[_loc9_].@type == NamingConvention.NC_PLUS_COND)
                     {
                        _loc11_.addConditionRef(_loc4_.Test[_loc9_],true);
                     }
                     else
                     {
                        _loc11_.addConditionRef(_loc4_.Test[_loc9_],false);
                     }
                     _loc13_++;
                  }
               }
               this.naming.rules.push(_loc11_);
               _loc9_++;
            }
         }
         if(param1.BaseStats.length() == 1)
         {
            this.baseStats = GearCalcUtil.parseMods(null,new XMLList(param1.BaseStats),true);
         }
         if(param1.AttrMod.length() == 1)
         {
            this.attrMods = GearCalcUtil.parseMods(null,new XMLList(param1.AttrMod),true);
         }
         _loc9_ = 0;
         while(_loc9_ < param1.PartList.length())
         {
            _loc4_ = param1.PartList[_loc9_];
            _loc3_ = new Vector.<Part>();
            _loc13_ = 0;
            while(_loc13_ < _loc4_.OptionBin.length())
            {
               _loc5_ = 0;
               _loc6_ = 0;
               _loc15_ = _loc4_.OptionBin[_loc13_];
               if(_loc15_.indexOf(GearCalcUtil.XML_RULE_RANGE_DELIMITER) != -1 && _loc15_ != "p001-p048")
               {
                  GearCalcUtil.parseAndAddIdRange(_loc15_,_loc3_,param2);
               }
               else if(_loc15_ != "p001-p048")
               {
                  while(_loc5_ < _loc15_.length)
                  {
                     _loc6_ = _loc15_.indexOf(GearCalcUtil.XML_RULE_DELIMITER,_loc5_);
                     if(_loc6_ == -1)
                     {
                        _loc3_.push(param2.retrieve(_loc15_.substring(_loc5_)));
                        break;
                     }
                     _loc7_ = _loc15_.substring(_loc5_,_loc6_);
                     _loc3_.push(param2.retrieve(_loc7_));
                     _loc5_ = _loc6_ + 1;
                  }
               }
               _loc13_++;
            }
            _loc13_ = 0;
            while(_loc13_ < _loc4_.GeneralPool.length())
            {
               if(this.generalPool == null)
               {
                  this.generalPool = new Vector.<String>();
               }
               _loc5_ = 0;
               _loc6_ = 0;
               _loc15_ = _loc4_.GeneralPool[_loc13_];
               if(_loc15_.indexOf(GearCalcUtil.XML_RULE_RANGE_DELIMITER) != -1)
               {
                  GearCalcUtil.parseAndAddIdRange(_loc15_,_loc3_,param2);
               }
               else
               {
                  while(_loc5_ < _loc15_.length)
                  {
                     _loc6_ = _loc15_.indexOf(GearCalcUtil.XML_RULE_DELIMITER,_loc5_);
                     if(_loc6_ == -1)
                     {
                        this.generalPool.push(_loc15_.substring(_loc5_));
                        break;
                     }
                     _loc7_ = _loc15_.substring(_loc5_,_loc6_);
                     this.generalPool.push(_loc7_);
                     _loc5_ = _loc6_ + 1;
                  }
               }
               _loc13_++;
            }
            _loc13_ = 0;
            while(_loc13_ < _loc4_.Option.length())
            {
               _loc3_.push(param2.retrieve(param1.PartList[_loc9_].Option[_loc13_]));
               _loc13_++;
            }
            if(_loc4_.BasePart.length() == 1)
            {
               this.basePartStr += _loc4_.BasePart;
            }
            this.partLists.push(new PartList(_loc3_,_loc4_.PartType));
            _loc9_++;
         }
         _loc3_ = new Vector.<Part>();
         _loc9_ = 0;
         while(_loc9_ < param1.ValidMakes.Manufacturer.length())
         {
            _loc3_.push(param2.retrieve(param1.ValidMakes.Manufacturer[_loc9_].Name));
            _loc10_ = new ManufacturerSpec(param1.ValidMakes.Manufacturer[_loc9_].Name);
            _loc13_ = 0;
            while(_loc13_ < param1.ValidMakes.Manufacturer[_loc9_].ExpLevel.length())
            {
               _loc10_.addQualityLevel(parseInt(param1.ValidMakes.Manufacturer[_loc9_].ExpLevel[_loc13_]));
               _loc13_++;
            }
            this.manuSpecs.push(_loc10_);
            _loc9_++;
         }
         this.partLists.push(new PartList(_loc3_,GearCalcUtil.PART_TYPE_MANUFACT));
         if(param1.ConstraintList.length() == 1)
         {
            _loc9_ = 0;
            while(_loc9_ < param1.ConstraintList.Option.length())
            {
               _loc4_ = param1.ConstraintList.Option[_loc9_];
               _loc13_ = 0;
               while(_loc13_ < _loc4_.Constraint.length())
               {
                  _loc8_ = new Constraint(param2.retrieve(_loc4_.Tag),_loc4_.Constraint[_loc13_].CompOperator);
                  _loc8_.setAttributeOperand(_loc4_.Constraint[_loc13_].AttrToCheck);
                  _loc8_.setOperandTwo(new Number(_loc4_.Constraint[_loc13_].OperandTwo));
                  this.constraints.push(_loc8_);
                  _loc13_++;
               }
               _loc9_++;
            }
         }
      }
      
      public function isBasePart(param1:Part) : Boolean
      {
         if(this.basePartStr.indexOf(param1.getID()) != -1 || this.basePartStr.length == 0)
         {
            return true;
         }
         return false;
      }
      
      public function getGeneralPool() : Vector.<String>
      {
         return this.generalPool;
      }
      
      public function isOverrideNaming() : Boolean
      {
         return this.overrideNaming;
      }
      
      private function retrieveAllLinkedNames(param1:PartCollection, param2:String) : Vector.<Part>
      {
         var _loc4_:PartList = null;
         var _loc5_:Vector.<String> = null;
         var _loc6_:Part = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:Vector.<Part> = new Vector.<Part>();
         var _loc7_:int = 0;
         while(_loc7_ < this.partLists.length)
         {
            _loc4_ = this.partLists[_loc7_];
            _loc8_ = 0;
            while(_loc8_ < _loc4_.list.length)
            {
               _loc5_ = _loc4_.list[_loc8_].getLinkedPartRefs();
               _loc9_ = 0;
               while(_loc9_ < _loc5_.length)
               {
                  _loc6_ = param1.retrieve(_loc5_[_loc9_]);
                  if(_loc6_.getType() == param2)
                  {
                     _loc3_.push(_loc6_);
                  }
                  _loc9_++;
               }
               _loc8_++;
            }
            _loc7_++;
         }
         return _loc3_;
      }
      
      public function initSlotReqs() : void
      {
         var _loc1_:Vector.<Part> = null;
         var _loc2_:Slot = null;
         var _loc3_:Part = null;
         var _loc4_:Part = null;
         this.slots = Slot.createSlotTemplate(this.gearType);
         for each(_loc2_ in this.slots)
         {
            _loc1_ = this.getPartList(_loc2_.name);
            if(_loc1_ == null)
            {
               _loc2_.acceptableTypes = GearCalcUtil.PART_NONE;
               _loc2_.isRequired = false;
            }
            else
            {
               for each(_loc3_ in _loc1_)
               {
                  if(!_loc2_.isAcceptable(_loc3_.getType()))
                  {
                     _loc2_.addAcceptableType(_loc3_.getType());
                  }
               }
            }
         }
         if(this.overrideNaming)
         {
            this.overrideTitle = "";
            _loc1_ = this.getPartList(GearCalcUtil.PART_TYPE_TITLE);
            for each(_loc4_ in _loc1_)
            {
               this.overrideTitle += _loc4_.getID();
            }
         }
      }
      
      public function addPartList(param1:Vector.<Part>, param2:String) : void
      {
         var _loc3_:PartList = new PartList(param1,param2);
         this.partLists.push(_loc3_);
      }
      
      public function setStats(param1:Vector.<AttributeModifier>) : void
      {
         this.baseStats = param1;
      }
      
      public function getSlots() : Vector.<Slot>
      {
         return this.slots;
      }
      
      public function getAcceptableParts(param1:String) : Vector.<Part>
      {
         return this.findPartList(param1);
      }
      
      public function getPartLists() : Vector.<PartList>
      {
         return this.partLists;
      }
      
      public function getBaseModifiers() : Vector.<AttributeModifier>
      {
         return this.baseStats;
      }
      
      public function getType() : String
      {
         return this.targetType;
      }
      
      public function getAttrModifiers() : Vector.<AttributeModifier>
      {
         return this.attrMods;
      }
      
      public function setGeneralPool(param1:Vector.<String>) : void
      {
         this.generalPool = param1;
      }
      
      public function getBaseTemplateName() : String
      {
         return this.base;
      }
      
      public function getSourceID() : String
      {
         return this.getType();
      }
      
      public function getConstraints() : Vector.<Constraint>
      {
         return this.constraints;
      }
      
      public function hasSlot(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.slots.length)
         {
            if(this.slots[_loc2_].name == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function setAttrMods(param1:Vector.<AttributeModifier>) : void
      {
         this.attrMods = param1;
      }
      
      public function setConstraints(param1:Vector.<Constraint>) : void
      {
         this.constraints = param1;
      }
      
      public function findPartList(param1:String) : Vector.<Part>
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.partLists.length)
         {
            if(this.partLists[_loc2_].type == param1)
            {
               return this.partLists[_loc2_].list;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function isCompatible(param1:Part) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<Part> = this.findPartList(param1.getType());
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_].equals(param1))
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      public function getPartList(param1:String) : Vector.<Part>
      {
         var _loc2_:PartList = null;
         for each(_loc2_ in this.partLists)
         {
            if(_loc2_.type == param1)
            {
               return _loc2_.list;
            }
         }
         return null;
      }
      
      public function matchManufacturerQuality(param1:String, param2:int) : int
      {
         var _loc3_:ManufacturerSpec = null;
         if(param2 >= 0)
         {
            for each(_loc3_ in this.manuSpecs)
            {
               if(_loc3_.name == param1)
               {
                  return _loc3_.getLevel(param2);
               }
            }
         }
         return 0;
      }
   }
}

