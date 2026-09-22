package gearcalc.wiz
{
   import gearcalc.AttributeModifier;
   import gearcalc.Calculator;
   import gearcalc.GearTemplate;
   import gearcalc.Gearable;
   
   public class SimpleCalculator extends Calculator
   {
      
      internal var source:Vector.<AttributeModifier>;
      
      public function SimpleCalculator(param1:Gearable, param2:GearTemplate)
      {
         super(param1,param2);
      }
      
      public function init(param1:Vector.<SpinnerBin>) : void
      {
         var _loc3_:SpinnerBin = null;
         var _loc4_:Vector.<AttributeModifier> = null;
         var _loc5_:AttributeModifier = null;
         var _loc2_:String = "PARTS: ";
         this.source = new Vector.<AttributeModifier>();
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_.collectActiveMods();
            for each(_loc5_ in _loc4_)
            {
               this.source.push(_loc5_);
               _loc2_ += " " + _loc5_.getParent().getID();
            }
         }
      }
      
      override public function collectModifiers(param1:String) : Vector.<AttributeModifier>
      {
         return this.source;
      }
   }
}

