package gearcalc
{
   public class Constraint
   {
      
      public static const RULE_GREATER:String = "GreaterThan";
      
      public static const RULE_GREATER_EQUAL:String = "GreaterThanOrEqual";
      
      public static const RULE_EQUAL:String = "Equal";
      
      public static const RULE_LESS:String = "LessThan";
      
      public static const RULE_LESS_EQUAL:String = "LessThanOrEqual";
      
      private var target:Part = null;
      
      private var type:String = "Equal";
      
      private var attr:String = null;
      
      private var operandOne:Number = 0;
      
      private var operandTwo:Number = 0;
      
      public function Constraint(param1:Part, param2:String)
      {
         super();
         this.type = param2;
         this.target = param1;
      }
      
      public function getTarget() : Part
      {
         return this.target;
      }
      
      public function getOperator() : String
      {
         return this.type;
      }
      
      public function getAttr() : String
      {
         return this.attr;
      }
      
      public function getOperandOne() : Number
      {
         return this.operandOne;
      }
      
      public function getOperandTwo() : Number
      {
         return this.operandTwo;
      }
      
      public function setAttributeOperand(param1:String) : void
      {
         this.attr = param1;
         this.operandOne = 0;
      }
      
      public function setOperandOne(param1:Number) : void
      {
         this.operandOne = param1;
         this.attr = null;
      }
      
      public function setOperandTwo(param1:Number) : void
      {
         this.operandTwo = param1;
      }
      
      public function approxEvaluate(param1:StatSet, param2:Number) : Boolean
      {
         var _loc3_:Number = 0;
         var _loc4_:Boolean = false;
         if(this.attr != null)
         {
            _loc3_ = param1.getStat(this.attr);
         }
         else
         {
            _loc3_ = this.operandOne;
         }
         switch(this.type)
         {
            case RULE_GREATER:
               _loc4_ = _loc3_ > this.operandTwo;
               break;
            case RULE_GREATER_EQUAL:
               _loc4_ = _loc3_ >= this.operandTwo;
               break;
            case RULE_EQUAL:
               if(param2 == 0)
               {
                  _loc4_ = _loc3_ == this.operandTwo;
               }
               else
               {
                  _loc4_ = _loc3_ <= this.operandTwo * (1 + param2) && _loc3_ >= this.operandTwo * (1 - param2);
               }
               break;
            case RULE_LESS:
               _loc4_ = _loc3_ < this.operandTwo;
               break;
            case RULE_LESS_EQUAL:
               _loc4_ = _loc3_ <= this.operandTwo;
         }
         return _loc4_;
      }
      
      public function evaluate(param1:StatSet) : Boolean
      {
         return this.approxEvaluate(param1,0);
      }
   }
}

