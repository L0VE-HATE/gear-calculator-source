package gearcalc
{
   public interface ModifierSource
   {
      
      function getAttrModifiers() : Vector.<AttributeModifier>;
      
      function getSourceID() : String;
   }
}

