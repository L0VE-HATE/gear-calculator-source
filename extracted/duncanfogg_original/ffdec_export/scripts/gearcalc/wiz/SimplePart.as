package gearcalc.wiz
{
   import gearcalc.AttributeModifier;
   import gearcalc.Part;
   import gearcalc.PartCollection;
   
   public class SimplePart
   {
      
      internal var id:String;
      
      internal var base:Part;
      
      internal var allMods:Vector.<AttributeModifier>;
      
      internal var curMods:Vector.<AttributeModifier>;
      
      public function SimplePart(param1:Part)
      {
         super();
         this.base = param1;
         this.id = param1.getID();
         this.curMods = new Vector.<AttributeModifier>();
         this.allMods = param1.getAttrModifiers();
      }
      
      internal function prep(param1:String) : void
      {
         var _loc2_:AttributeModifier = null;
         this.curMods = new Vector.<AttributeModifier>();
         for each(_loc2_ in this.allMods)
         {
            if(_loc2_.getAttrToMod() == param1)
            {
               this.curMods.push(_loc2_);
            }
         }
      }
      
      internal function isModifierOf(param1:String) : Boolean
      {
         var _loc2_:AttributeModifier = null;
         for each(_loc2_ in this.allMods)
         {
            if(_loc2_.getAttrToMod() == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      internal function isNullPart() : Boolean
      {
         if(this.id == PartCollection.NULL_PART.getID())
         {
            return true;
         }
         return false;
      }
   }
}

