package gearcalc
{
   public class SimResultSet
   {
      
      public var procTotals:Vector.<int>;
      
      public var floatTotals:Vector.<Number>;
      
      public var elapsedTime:Number;
      
      public var shotCount:Number;
      
      public var depletedCount:int;
      
      public var netProcs:int = 0;
      
      public function SimResultSet(param1:int)
      {
         super();
         this.procTotals = new Vector.<int>();
         this.floatTotals = new Vector.<Number>();
         this.elapsedTime = 0;
         this.shotCount = 0;
         this.depletedCount = 0;
         this.netProcs = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            this.procTotals.push(0);
            this.floatTotals.push(0);
            _loc2_++;
         }
      }
   }
}

