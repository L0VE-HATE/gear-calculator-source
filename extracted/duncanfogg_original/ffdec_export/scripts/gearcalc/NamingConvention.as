package gearcalc
{
   public class NamingConvention
   {
      
      public static const TYPE_SPACER:String = "Spacer";
      
      public static const TYPE_STANDARD:String = "Standard";
      
      public static const TYPE_CONDITIONAL:String = "Conditional";
      
      public static const NC_DELIM:String = "#";
      
      public static const NC_PLUS_COND:String = "positive";
      
      public static const NC_NEG_COND:String = "negative";
      
      public static const STRING_TT:String = "TitleText";
      
      public static const STRING_TA:String = "TitleAddend";
      
      public static const STRING_SPACER:String = " ";
      
      internal var rules:Vector.<NamingRule>;
      
      public function NamingConvention()
      {
         super();
         this.rules = new Vector.<NamingRule>();
      }
      
      public function name(param1:Gearable) : String
      {
         var _loc3_:NamingRule = null;
         var _loc2_:String = "";
         for each(_loc3_ in this.rules)
         {
            if(_loc3_.type == TYPE_SPACER)
            {
               _loc2_ += _loc3_.text;
            }
            else
            {
               _loc2_ += _loc3_.evaluate(param1);
            }
         }
         return _loc2_;
      }
   }
}

