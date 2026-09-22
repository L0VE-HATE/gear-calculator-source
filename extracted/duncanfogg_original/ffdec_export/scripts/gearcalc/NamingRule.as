package gearcalc
{
   public class NamingRule
   {
      
      public var type:String;
      
      public var length:int;
      
      public var target:String;
      
      public var text:String;
      
      public var trimForward:Boolean;
      
      private var condPluses:Vector.<Boolean>;
      
      private var conditions:Vector.<String>;
      
      public function NamingRule(param1:String, param2:String)
      {
         super();
         this.type = param2;
         this.length = 0;
         this.trimForward = true;
         this.conditions = new Vector.<String>();
         this.condPluses = new Vector.<Boolean>();
         if(param2 == NamingConvention.TYPE_SPACER)
         {
            this.text = NamingConvention.STRING_SPACER;
         }
      }
      
      public function addConditionRef(param1:String, param2:Boolean) : void
      {
         this.conditions.push(param1);
         this.condPluses.push(param2);
      }
      
      public function evaluate(param1:Gearable) : String
      {
         var index:int = 0;
         var testPart:Part = null;
         var gear:Gearable = param1;
         var isIn:Function = function(param1:Vector.<Part>):int
         {
            var _loc3_:Part = null;
            var _loc2_:int = 0;
            loop0:
            while(_loc2_ < conditions.length)
            {
               var _loc4_:int = 0;
               var _loc5_:* = param1;
               do
               {
                  for each(_loc3_ in _loc5_)
                  {
                  }
                  _loc2_++;
                  continue loop0;
               }
               while(_loc3_.getID() != conditions[_loc2_]);
               return _loc2_;
            }
            return -1;
         };
         var suit:Function = function():String
         {
            if(text == NamingConvention.STRING_TA)
            {
               return gear.getSlottedPart(target).getTitleAddend();
            }
            if(text == NamingConvention.STRING_TT)
            {
               return gear.getSlottedPart(target).getTitleText();
            }
            return text;
         };
         if(this.type == NamingConvention.TYPE_CONDITIONAL)
         {
            index = isIn(gear.getParts());
            if(index != -1 && this.condPluses[index])
            {
               return this.text;
            }
            if(index == -1 && !this.condPluses[index])
            {
               return this.text;
            }
            return "";
         }
         if(this.type == NamingConvention.TYPE_SPACER)
         {
            return NamingConvention.STRING_SPACER;
         }
         if(this.type == NamingConvention.TYPE_STANDARD)
         {
            testPart = gear.getSlottedPart(this.type);
            if(this.text == NamingConvention.STRING_TT)
            {
               return this.trim(testPart.getTitleText());
            }
            if(this.text == NamingConvention.STRING_TA)
            {
               return this.trim(testPart.getTitleAddend());
            }
         }
         return "";
      }
      
      private function trim(param1:String) : String
      {
         if(this.length > 0 && param1.length > this.length)
         {
            if(this.trimForward)
            {
               return param1.substr(0,this.length);
            }
            return param1.substr(param1.length - 1 - this.length,this.length);
         }
         return param1;
      }
   }
}

