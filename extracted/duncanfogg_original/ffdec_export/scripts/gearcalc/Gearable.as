package gearcalc
{
   import flash.utils.Dictionary;
   
   public interface Gearable
   {
      
      function getAttributes() : Dictionary;
      
      function getAttribute(param1:String) : Attribute;
      
      function setAttribute(param1:String, param2:Number) : void;
      
      function setAttributes(param1:Dictionary) : void;
      
      function getSlotRequirements() : Vector.<Slot>;
      
      function getParts() : Vector.<Part>;
      
      function getName() : String;
      
      function addPart(param1:int, param2:Part) : void;
      
      function removePart(param1:String) : void;
      
      function getExpLevel() : int;
      
      function getQualityLevel() : int;
      
      function setExpLevel(param1:int) : void;
      
      function setQualityLevel(param1:int) : void;
      
      function getCurrentStats() : StatSet;
      
      function getGearType() : int;
      
      function getPart(param1:String) : Part;
      
      function getSlottedPart(param1:String) : Part;
      
      function setLabel(param1:String) : void;
      
      function setStats(param1:StatSet) : void;
      
      function calculateBase(param1:StatSet) : StatSet;
      
      function postCalculate(param1:StatSet) : void;
      
      function contains(param1:String) : Part;
   }
}

