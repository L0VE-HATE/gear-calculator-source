package gearcalc
{
   public class ManufacturerSpec
   {
      
      public var name:String;
      
      public var levels:Vector.<int>;
      
      public function ManufacturerSpec(param1:String)
      {
         super();
         this.name = param1;
         this.levels = new Vector.<int>();
      }
      
      public function addQualityLevel(param1:int) : void
      {
         this.levels.push(param1);
      }
      
      public function getLevel(param1:int) : int
      {
         return this.levels[param1];
      }
   }
}

