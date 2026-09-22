package gearcalc
{
   public class Part implements ModifierSource
   {
      
      private var attrMods:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
      
      private var cardMods:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
      
      private var linkedRefs:Vector.<String> = new Vector.<String>();
      
      private var techAbilities:Vector.<TechAbility> = new Vector.<TechAbility>();
      
      private var id:String = null;
      
      private var type:String = null;
      
      private var help:String = null;
      
      private var titleText:String = null;
      
      private var titleAddend:String = null;
      
      private var dispName:String = null;
      
      private var trueName:String = null;
      
      private var manufacturer:String = null;
      
      private var costMod:uint = 1;
      
      private var rarityMod:uint = 1;
      
      private var priority:Number = 0;
      
      private var gearType:int;
      
      public var label:String = "";
      
      public function Part(param1:String, param2:String)
      {
         super();
         this.id = param1;
         this.type = param2;
         this.trueName = param1;
         this.techAbilities = new Vector.<TechAbility>();
      }
      
      public function getGearType() : int
      {
         return this.gearType;
      }
      
      public function setGearType(param1:int) : void
      {
         this.gearType = param1;
      }
      
      public function getID() : String
      {
         return this.id;
      }
      
      public function setTrueName(param1:String) : void
      {
         this.trueName = param1;
      }
      
      public function getTrueName() : String
      {
         return this.trueName;
      }
      
      public function addLinkedPartRef(param1:String) : void
      {
         this.linkedRefs.push(param1);
      }
      
      public function addModifier(param1:AttributeModifier, param2:Boolean) : void
      {
         if(param2 == true)
         {
            this.attrMods.push(param1);
         }
         else
         {
            this.cardMods.push(param1);
         }
      }
      
      public function setAttrModifiers(param1:Vector.<AttributeModifier>) : void
      {
         this.attrMods = param1;
      }
      
      public function setCardModifiers(param1:Vector.<AttributeModifier>) : void
      {
         this.cardMods = param1;
      }
      
      public function setType(param1:String) : void
      {
         this.type = param1;
      }
      
      public function getType() : String
      {
         return this.type;
      }
      
      public function setCostMod(param1:uint) : void
      {
         this.costMod = param1;
      }
      
      public function setRarityMod(param1:uint) : void
      {
         this.rarityMod = param1;
      }
      
      public function setManufacturer(param1:String) : void
      {
         this.manufacturer = param1;
      }
      
      public function getCostMod() : uint
      {
         return this.costMod;
      }
      
      public function getRarityMod() : uint
      {
         return this.rarityMod;
      }
      
      public function getManufacturer() : String
      {
         return this.manufacturer;
      }
      
      public function getLinkedPartRefs() : Vector.<String>
      {
         return this.linkedRefs;
      }
      
      public function getAttrModifiers() : Vector.<AttributeModifier>
      {
         return this.attrMods;
      }
      
      public function getCardMods() : Vector.<AttributeModifier>
      {
         return this.cardMods;
      }
      
      public function getPartID() : String
      {
         return this.id;
      }
      
      public function getDisplayName() : String
      {
         return this.dispName;
      }
      
      public function setDisplayName(param1:String) : void
      {
         this.dispName = param1;
      }
      
      public function isNullPart() : Boolean
      {
         if(this.id == GearCalcUtil.PART_NONE)
         {
            return true;
         }
         return false;
      }
      
      public function setHelpText(param1:String) : void
      {
         this.help = param1;
      }
      
      public function getHelpText() : String
      {
         return this.help;
      }
      
      public function getSourceID() : String
      {
         return this.getID();
      }
      
      public function setTitleText(param1:String) : void
      {
         this.titleText = param1;
      }
      
      public function getTitleText() : String
      {
         return this.titleText;
      }
      
      public function setTitleAddend(param1:String) : void
      {
         this.titleAddend = param1;
      }
      
      public function getTitleAddend() : String
      {
         return this.titleAddend;
      }
      
      public function getPriority() : Number
      {
         return this.priority;
      }
      
      public function setPriority(param1:Number) : void
      {
         this.priority = param1;
      }
      
      public function equals(param1:Part) : Boolean
      {
         return this.getID() == param1.getID();
      }
      
      public function addTechAbility(param1:TechAbility) : void
      {
         this.techAbilities.push(param1);
      }
      
      public function getTechAbilities() : Vector.<TechAbility>
      {
         return this.techAbilities;
      }
   }
}

