package gearcalc
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class GearCalcEngine extends EventDispatcher
   {
      
      private static var baseGuns:Dictionary = null;
      
      internal static var error:String = "";
      
      public var gearType:int;
      
      public var parts:PartCollection = null;
      
      public var filter:GearPartsFilter = null;
      
      public var build:Gearable;
      
      public var isDataLoaded:Boolean = false;
      
      public var strict:Boolean = true;
      
      public var typeChangeListener:Function;
      
      public function GearCalcEngine()
      {
         super();
         this.build = null;
         this.gearType = GearCalcUtil.GEAR_WEAPON;
         this.parts = new PartCollection();
         baseGuns = new Dictionary();
         this.filter = new GearPartsFilter();
         this.reset();
         this.isDataLoaded = false;
      }
      
      internal static function addErrorCode(param1:String) : void
      {
         error = error + "\n>> " + param1;
      }
      
      public static function getErrorCode() : String
      {
         var _loc1_:String = error;
         error = "";
         return "\n" + _loc1_ + "\n";
      }
      
      public function duplicate() : GearCalcEngine
      {
         var _loc1_:GearCalcEngine = new GearCalcEngine();
         _loc1_.parts = this.parts;
         _loc1_.filter = this.filter.duplicate();
         _loc1_.isDataLoaded = this.isDataLoaded;
         _loc1_.strict = this.strict;
         _loc1_.gearType = this.gearType;
         _loc1_.build = this.build;
         return _loc1_;
      }
      
      public function setGearType(param1:int) : void
      {
         this.gearType = param1;
         if(this.typeChangeListener != null)
         {
            this.typeChangeListener(param1);
         }
      }
      
      public function initRuleCollection(param1:XML) : Boolean
      {
         var _loc2_:XMLList = param1..GearTemplate;
         var _loc3_:GearTemplate = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length())
         {
            _loc3_ = new GearTemplate(_loc2_[_loc4_],this.parts);
            this.filter.registerTemplate(_loc3_);
            _loc4_++;
         }
         this.filter.initDerivedTemplates();
         this.isDataLoaded = true;
         return this.isDataLoaded;
      }
      
      private function mapXMLAttributes(param1:XMLList) : void
      {
         var _loc2_:XML = null;
         var _loc3_:Attribute = null;
         if(GearCalcUtil.attrLookup == null)
         {
            GearCalcUtil.attrLookup = new Vector.<Attribute>();
         }
         for each(_loc2_ in param1)
         {
            if(GearCalcUtil.isInLookup(_loc2_.TagName) == null)
            {
               _loc3_ = new Attribute(_loc2_.TagName);
               _loc3_.text = _loc2_.Target;
               GearCalcUtil.attrLookup.push(_loc3_);
            }
         }
      }
      
      public function initPartCollection(param1:XML, param2:int) : Boolean
      {
         var _loc9_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:Boolean = false;
         var _loc13_:Vector.<AttributeModifier> = null;
         var _loc3_:PartCollection = this.parts;
         var _loc4_:XMLList = param1..Part;
         var _loc5_:XML = null;
         var _loc6_:Part = null;
         var _loc7_:TechAbility = null;
         var _loc8_:AttributeModifier = null;
         this.mapXMLAttributes(param1.AttrLookup..Attribute);
         var _loc10_:int = 0;
         while(_loc10_ < _loc4_.length())
         {
            _loc5_ = _loc4_[_loc10_];
            _loc6_ = new Part(_loc5_.@id,_loc5_.PartType);
            if(_loc6_.getType() != GearCalcUtil.PART_TYPE_MANUFACT)
            {
               _loc6_.setGearType(param2);
            }
            else
            {
               _loc6_.setGearType(GearCalcUtil.GEAR_GLOBAL);
            }
            if(_loc5_.Name.length() == 1)
            {
               _loc6_.setTrueName(_loc5_.Name);
               if(_loc5_.PartType == GearCalcUtil.PART_TYPE_TITLE || _loc5_.PartType == GearCalcUtil.PART_TYPE_PREFIX)
               {
                  _loc6_.label = _loc6_.getTrueName().substr(_loc6_.getTrueName().indexOf(".") + 1);
               }
               else if(_loc5_.PartType == GearCalcUtil.PART_TYPE_GRADE)
               {
                  _loc6_.label = _loc6_.getTrueName().substr(_loc6_.getTrueName().lastIndexOf("_") + 1);
                  if(_loc6_.getTrueName().indexOf("reward") != -1)
                  {
                     _loc6_.label += " (Reward)";
                  }
                  else if(_loc6_.getTrueName().indexOf("GBX") != -1)
                  {
                     _loc6_.label += " (Gearbox)";
                  }
                  else if(_loc6_.getTrueName().indexOf("Eridan") != -1)
                  {
                     _loc6_.label = "Eridian " + _loc6_.label;
                  }
               }
               else
               {
                  _loc6_.label = _loc6_.getTrueName().substr(_loc6_.getTrueName().lastIndexOf(".") + 1);
               }
            }
            _loc11_ = 0;
            while(_loc11_ < _loc5_.Spawn.length())
            {
               _loc6_.addLinkedPartRef(_loc5_.Spawn[_loc11_]);
               _loc11_++;
            }
            if(_loc5_.DamageType.length() == 1)
            {
               _loc6_.setHelpText(_loc5_.DamageType);
            }
            if(_loc5_.DispName.length() == 1)
            {
               _loc6_.setDisplayName(_loc5_.DispName);
            }
            if(_loc5_.Manufacturer.length() == 1)
            {
               _loc6_.setManufacturer(_loc5_.Manufacturer);
            }
            else
            {
               _loc6_.setManufacturer(null);
            }
            _loc11_ = 0;
            while(_loc11_ < _loc5_.LinkedPrefix.length())
            {
               _loc6_.addLinkedPartRef(_loc5_.LinkedPrefix[_loc11_]);
               _loc11_++;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc5_.LinkedTitle.length())
            {
               _loc6_.addLinkedPartRef(_loc5_.LinkedTitle[_loc11_]);
               _loc11_++;
            }
            if(_loc5_.Manufacturer.length() == 1)
            {
               _loc6_.setManufacturer(_loc5_.Manufacturer);
            }
            if(_loc5_.HelpText.length() == 1)
            {
               _loc6_.setHelpText(_loc5_.HelpText);
            }
            if(_loc5_.AttrMod.length() > 0)
            {
               _loc6_.setAttrModifiers(GearCalcUtil.parseMods(_loc6_,_loc5_.AttrMod,true));
               if(param2 == GearCalcUtil.GEAR_SHIELD)
               {
                  _loc13_ = _loc6_.getAttrModifiers();
                  _loc6_.setAttrModifiers(GearCalcUtil.accomodateShields(_loc13_));
               }
            }
            if(_loc5_.CardMod.length() > 0)
            {
               _loc6_.setCardModifiers(GearCalcUtil.parseMods(_loc6_,_loc5_.CardMod,false));
            }
            if(_loc5_.TechMod.length() == 1)
            {
               _loc8_ = new AttributeModifier(_loc6_,GearCalcUtil.ATTR_TECH,GearCalcUtil.MOD_PREADD);
               _loc8_.setValue(_loc5_.TechMod);
               _loc6_.addModifier(_loc8_,true);
            }
            if(_loc5_.Priority.length() > 0)
            {
               _loc8_ = new AttributeModifier(_loc6_,GearCalcUtil.ATTR_PRIORITY,GearCalcUtil.MOD_PREADD);
               _loc8_.setValue(_loc5_.Priority);
               _loc6_.setPriority(Number(_loc5_.Priority));
               _loc6_.addModifier(_loc8_,true);
            }
            if(_loc5_.CardText.length() > 0)
            {
               _loc11_ = 0;
               while(_loc11_ < _loc5_.CardText.length())
               {
                  _loc8_ = new AttributeModifier(_loc6_,GearCalcUtil.CARD_MOD_TEXT,GearCalcUtil.CARD_MOD_TEXT);
                  _loc8_.setValue(new Number(_loc5_.CardText[_loc11_].CardPriority));
                  _loc8_.setText(_loc5_.CardText[_loc11_].Text);
                  if(_loc5_.CardText[_loc11_].Color.length() > 0)
                  {
                     _loc8_.variable = uint("0x" + _loc5_.CardText[_loc11_].Color);
                  }
                  else
                  {
                     _loc8_.variable = 16777215;
                  }
                  _loc6_.addModifier(_loc8_,false);
                  _loc11_++;
               }
            }
            if(_loc5_.CostMod.length() == 1)
            {
               _loc8_ = new AttributeModifier(_loc6_,GearCalcUtil.ATTR_COST,GearCalcUtil.MOD_MULTIPLIER);
               _loc8_.setValue(GearCalcUtil.resolveCostRarity(_loc5_.CostMod));
               _loc6_.addModifier(_loc8_,true);
            }
            if(_loc5_.RarityMod.length() == 1)
            {
               _loc8_ = new AttributeModifier(_loc6_,GearCalcUtil.ATTR_RARITY,GearCalcUtil.MOD_PREADD);
               _loc8_.setValue(GearCalcUtil.resolveCostRarity(_loc5_.RarityMod));
               _loc6_.addModifier(_loc8_,true);
            }
            if(_loc5_.TitleText.length() == 1)
            {
               _loc6_.setTitleText(_loc5_.TitleText);
            }
            if(_loc5_.TitleAddend.length() == 1)
            {
               _loc6_.setTitleAddend(_loc5_.TitleAddend);
            }
            _loc3_.insert(_loc6_);
            _loc12_ = false;
            _loc11_ = 0;
            while(_loc11_ < _loc5_.TechAbility.length())
            {
               _loc7_ = new TechAbility(parseInt(_loc5_.TechAbility[_loc11_].@grade));
               _loc7_.setType(_loc5_.TechAbility[_loc11_].TechType);
               _loc7_.setCost(new Number(_loc5_.TechAbility[_loc11_].TechCost));
               _loc7_.setLevel(parseInt(_loc5_.TechAbility[_loc11_].TechLevel));
               _loc7_.setProcChance(new Number(_loc5_.TechAbility[_loc11_].ProcChance));
               _loc7_.bullet = _loc5_.TechAbility[_loc11_].Bullet;
               _loc12_ = true;
               if(_loc5_.TechAbility[_loc11_].LinkedPrefix.length() == 1)
               {
                  _loc7_.linkPrefix(_loc5_.TechAbility[_loc11_].LinkedPrefix);
               }
               _loc6_.addTechAbility(_loc7_);
               _loc11_++;
            }
            if(_loc12_)
            {
               _loc8_ = new AttributeModifier(_loc6_,GearCalcUtil.ATTR_DMG_IS_ELEMENTAL,GearCalcUtil.MOD_PREADD);
               _loc8_.setValue(1);
               _loc6_.addModifier(_loc8_,true);
            }
            _loc10_++;
         }
         return this.isDataLoaded;
      }
      
      public function reset() : void
      {
         this.build = null;
         GearCalcEngine.getErrorCode();
         this.filter.reset();
      }
      
      public function getCollection() : PartCollection
      {
         return this.parts;
      }
      
      public function autoName(param1:Vector.<Part>, param2:int, param3:int) : Vector.<Part>
      {
         this.unstrictConstruct(param1,param2,param3);
         var _loc4_:StatSet = this.calculate(false);
         var _loc5_:LegitChecker = new LegitChecker();
         return _loc5_.autoName(this.build,_loc4_,this.parts,this.filter.template);
      }
      
      public function calculate(param1:Boolean) : StatSet
      {
         var _loc2_:StatSet = null;
         var _loc3_:Vector.<Part> = null;
         var _loc4_:Gearable = null;
         var _loc5_:int = 0;
         var _loc6_:StatSet = null;
         if(this.build != null)
         {
            _loc2_ = this.filter.calc(this.build);
            _loc3_ = this.build.getParts();
            _loc4_ = new Weapon();
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               if(_loc3_[_loc5_].getType() != GearCalcUtil.PART_TYPE_PREFIX && _loc3_[_loc5_].getType() != GearCalcUtil.PART_TYPE_TITLE)
               {
                  _loc4_.addPart(_loc5_,_loc3_[_loc5_]);
               }
               _loc5_++;
            }
            _loc4_.setQualityLevel(this.build.getQualityLevel());
            _loc4_.setExpLevel(this.build.getExpLevel());
            _loc6_ = this.filter.calc(_loc4_);
            if(param1)
            {
               _loc2_.setIsLegit(this.filter.checkLegitness(this.build,_loc6_,this.parts));
            }
            return _loc2_;
         }
         return null;
      }
      
      public function getSlotAmount() : int
      {
         return this.build.getSlotRequirements().length;
      }
      
      public function unstrictConstruct(param1:Vector.<Part>, param2:int, param3:int) : void
      {
         if(this.gearType == GearCalcUtil.GEAR_WEAPON)
         {
            this.build = new Weapon();
         }
         else if(this.gearType == GearCalcUtil.GEAR_SHIELD)
         {
            this.build = new Shield();
         }
         else if(this.gearType == GearCalcUtil.GEAR_COM)
         {
            this.build = new ClassMod();
         }
         if(this.build == null)
         {
            return;
         }
         this.build.setQualityLevel(param2);
         this.build.setExpLevel(param3);
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            this.build.addPart(_loc4_,param1[_loc4_]);
            _loc4_++;
         }
      }
      
      public function construct(param1:Vector.<Part>, param2:int, param3:int) : Boolean
      {
         var _loc6_:Part = null;
         var _loc7_:Part = null;
         var _loc4_:Vector.<Slot> = null;
         if(this.filter.template == null)
         {
            _loc6_ = GearCalcUtil.getPartFromVector(param1,GearCalcUtil.PART_TYPE_GRADE);
            _loc7_ = GearCalcUtil.getPartFromVector(param1,GearCalcUtil.PART_TYPE_TYPE);
            if(_loc6_ != null && _loc7_ != null)
            {
               this.filter.filterAndMatch(_loc6_,_loc7_,GearCalcUtil.PART_TYPE_GRIP,this.gearType);
            }
         }
         if(this.filter.template == null)
         {
            this.build = null;
            return false;
         }
         if(this.gearType == GearCalcUtil.GEAR_COM)
         {
            this.build = new ClassMod();
         }
         else if(this.gearType == GearCalcUtil.GEAR_SHIELD)
         {
            this.build = new Shield();
         }
         else
         {
            this.build = new Weapon();
         }
         _loc4_ = this.filter.getSlotRequirements();
         this.build.setQualityLevel(param2);
         this.build.setExpLevel(param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_].isAcceptable(param1[_loc5_].getType()) || param1[_loc5_].getType() == GearCalcUtil.PART_NONE && !_loc4_[_loc5_].isRequired)
            {
               this.build.addPart(_loc5_,param1[_loc5_]);
            }
            else if(this.strict)
            {
               addErrorCode("[" + _loc4_[_loc5_].name + "] part is required.");
               this.build = null;
               return false;
            }
            _loc5_++;
         }
         if(!this.filter.verifyManufacturer(this.build) && this.strict)
         {
            addErrorCode("Manufacturers must match: check manufacturer-specific parts.");
            this.build = null;
            return false;
         }
         if(this.gearType == GearCalcUtil.GEAR_WEAPON && this.strict)
         {
            if(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_MANUFACT).getManufacturer() == "Jakobs" && this.build.getSlottedPart(GearCalcUtil.PART_TYPE_ACCESSORY).getTechAbilities().length > 0)
            {
               error = "\nJakobs is incompatible with elemental accessories.\n" + error;
               this.build = null;
               return false;
            }
            if(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_MANUFACT).getManufacturer() == "Maliwan" && this.build.getSlottedPart(GearCalcUtil.PART_TYPE_ACCESSORY).getTechAbilities().length < 1 && this.build.getSlottedPart(GearCalcUtil.PART_TYPE_TYPE).getTrueName().indexOf("auncher") == -1)
            {
               error = "\nMaliwan must be elemental.\n" + error;
               this.build = null;
               return false;
            }
            if(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_ACCESSORY).getTechAbilities().length > 0)
            {
               (this.build as Weapon).elemental = this.build.getSlottedPart(GearCalcUtil.PART_TYPE_ACCESSORY).getTechAbilities()[0].getType();
            }
            else
            {
               (this.build as Weapon).elemental = "";
            }
         }
         return true;
      }
      
      public function getAllPartsOfType(param1:String) : Vector.<Part>
      {
         return this.parts.getAllPartsOfType(param1,this.gearType);
      }
      
      public function nameGear() : String
      {
         var _loc6_:NameRegister = null;
         if(this.build == null)
         {
            return null;
         }
         var _loc1_:String = "";
         var _loc2_:String = this.build.getSlottedPart(GearCalcUtil.PART_TYPE_PREFIX).getDisplayName();
         var _loc3_:Part = this.build.getSlottedPart(GearCalcUtil.PART_TYPE_TITLE);
         var _loc4_:String = _loc3_.getDisplayName();
         var _loc5_:Vector.<Part> = this.build.getParts();
         if(!this.filter.template.isOverrideNaming() || this.filter.template.overrideTitle.indexOf(_loc3_.getID()) == -1)
         {
            if((this.build as Weapon).isEridian())
            {
               _loc1_ = NameRegister.nameEridian(this.build as Weapon);
            }
            else
            {
               _loc6_ = new NameRegister(this.filter.template);
               if(this.gearType == GearCalcUtil.GEAR_WEAPON)
               {
                  _loc6_.push(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_BODY));
                  _loc6_.push(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_STOCK));
                  _loc6_.push(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_MAG));
                  _loc6_.push(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_MATERIAL));
               }
               else if(this.gearType == GearCalcUtil.GEAR_SHIELD)
               {
                  _loc6_.push(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_MATERIAL));
                  _loc6_.push(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_SHIELD_RIGHT));
                  _loc6_.push(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_SHIELD_LEFT));
                  _loc6_.push(this.build.getSlottedPart(GearCalcUtil.PART_TYPE_SHIELD_BODY));
               }
               _loc1_ = _loc6_.name();
            }
         }
         this.build.setLabel(_loc1_ + " " + _loc2_ + " " + _loc4_);
         return (this.build as Weapon).label;
      }
      
      public function importGear(param1:String) : Weapon
      {
         var _loc8_:String = null;
         var _loc10_:Part = null;
         var _loc12_:Weapon = null;
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = -1;
         var _loc6_:int = -1;
         var _loc7_:Boolean = true;
         while(_loc3_ < param1.length)
         {
            if(param1.indexOf("\n",_loc3_) != -1)
            {
               _loc8_ = param1.substring(_loc3_,param1.indexOf("\n",_loc3_));
               if(isNaN(Number(_loc8_)))
               {
                  _loc2_.push(_loc8_);
               }
               else if(++_loc4_ == 2)
               {
                  _loc5_ = int(_loc8_);
               }
               _loc3_ = param1.indexOf("\n",_loc3_) + 1;
            }
            else
            {
               if(!(_loc4_ == 3 && _loc7_))
               {
                  break;
               }
               _loc6_ = int(_loc8_);
               _loc7_ = false;
            }
         }
         var _loc9_:Vector.<Part> = new Vector.<Part>();
         var _loc11_:int = 0;
         while(_loc11_ < _loc2_.length)
         {
            _loc10_ = this.parts.matchTrueName(_loc2_[_loc11_]);
            if(_loc10_ == null)
            {
               _loc10_ = PartCollection.NULL_PART;
            }
            _loc9_.push(_loc10_);
            _loc11_++;
         }
         if(_loc9_[0].getGearType() == GearCalcUtil.GEAR_WEAPON)
         {
            _loc12_ = new Weapon();
         }
         else if(_loc9_[0].getGearType() == GearCalcUtil.GEAR_SHIELD)
         {
            _loc12_ = new Shield();
         }
         else
         {
            if(_loc9_[0].getGearType() != GearCalcUtil.GEAR_COM)
            {
               return null;
            }
            _loc12_ = new ClassMod();
         }
         _loc12_.setParts(this.filter.verifyImport(_loc12_.getGearType(),_loc9_));
         _loc12_.setQualityLevel(_loc5_);
         _loc12_.setExpLevel(_loc6_);
         return _loc12_;
      }
   }
}

