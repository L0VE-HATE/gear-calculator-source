package gearcalc
{
   public class AttributeModifier
   {
      
      private var modType:String = "Scale";
      
      private var attrToMod:String = null;
      
      private var value:Number = 1;
      
      private var text:String = null;
      
      private var parent:Part = null;
      
      private var activeState:String;
      
      private var initDef:String;
      
      public var variable:uint;
      
      public function AttributeModifier(param1:Part, param2:String, param3:String)
      {
         super();
         this.attrToMod = param2;
         this.modType = param3;
         this.value = this.value;
         this.parent = param1;
         this.activeState = GearCalcUtil.MOD_STATE_ALL;
      }
      
      public function setInitDefinition(param1:String) : void
      {
         this.initDef = param1;
      }
      
      public function getInitDefinition() : String
      {
         return this.initDef;
      }
      
      public function getActiveState() : String
      {
         return this.activeState;
      }
      
      public function setActiveState(param1:String) : void
      {
         this.activeState = param1;
      }
      
      public function getModType() : String
      {
         return this.modType;
      }
      
      public function getAttrToMod() : String
      {
         return this.attrToMod;
      }
      
      public function getValue() : Number
      {
         return this.value;
      }
      
      public function setValue(param1:Number) : void
      {
         this.value = param1;
      }
      
      public function setText(param1:String) : void
      {
         this.text = param1;
      }
      
      public function getText() : String
      {
         return this.text;
      }
      
      public function getParent() : Part
      {
         return this.parent;
      }
   }
}

