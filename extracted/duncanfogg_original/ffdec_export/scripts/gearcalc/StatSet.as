package gearcalc
{
   import flash.utils.Dictionary;
   
   public class StatSet
   {
      
      private var stats:Dictionary = null;
      
      private var statTypes:Dictionary = null;
      
      private var counter:int;
      
      private var isLegit:Boolean;
      
      private var expLevel:int;
      
      public function StatSet(param1:int)
      {
         super();
         this.stats = new Dictionary();
         this.statTypes = new Dictionary();
         this.counter = 0;
         this.isLegit = true;
         this.expLevel = param1;
      }
      
      public function getExpLevel() : int
      {
         return this.expLevel;
      }
      
      public function addNumericalStat(param1:String, param2:Number) : void
      {
         this.stats[param1] = param2;
         this.statTypes[param1] = GearCalcUtil.STAT_TYPE_NUM;
         ++this.counter;
      }
      
      public function addTextStat(param1:String, param2:String) : void
      {
         this.stats[param1] = param2;
         this.statTypes[param1] = GearCalcUtil.STAT_TYPE_TEXT;
         ++this.counter;
      }
      
      public function getStatType(param1:String) : String
      {
         if(this.statTypes[param1] != null)
         {
            return this.statTypes[param1];
         }
         return "";
      }
      
      public function getStat(param1:String) : Number
      {
         if(this.stats[param1] is Number)
         {
            return Number(this.stats[param1]);
         }
         return 0;
      }
      
      public function getTextStat(param1:String) : String
      {
         if(this.stats[param1] is String)
         {
            return String(this.stats[param1]);
         }
         return null;
      }
      
      public function getAllStats() : Dictionary
      {
         return this.stats;
      }
      
      public function contains(param1:String) : Boolean
      {
         var _loc2_:Object = null;
         for(_loc2_ in this.stats)
         {
            if(_loc2_ is String && _loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setIsLegit(param1:Boolean) : void
      {
         this.isLegit = param1;
      }
      
      public function isGearLegit() : Boolean
      {
         return this.isLegit;
      }
   }
}

