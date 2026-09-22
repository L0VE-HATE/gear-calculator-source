package gearcalc.card
{
   import flash.text.engine.TextLine;
   import gearcalc.Attribute;
   import gearcalc.GearCalcUtil;
   
   public class BBCoder
   {
      
      public static const BB_BOLD:String = "B";
      
      public static const BB_ITALICS:String = "I";
      
      public static const BB_UL:String = "U";
      
      public static const BB_SIZE:String = "SIZE";
      
      public static const BB_COLOR:String = "COLOR";
      
      public static const BB_INDENT:String = "INDENT";
      
      public static const FILLER_BUFFER:int = 3;
      
      public static const FILLER:String = ".";
      
      public static const BULLET:String = String.fromCharCode(149) + " ";
      
      public static const MONEY_COLOR:uint = 6723840;
      
      public static const COLOR_SLIGHT_GRAY:uint = 12303291;
      
      public static const COLOR_FILLER:uint = 5592405;
      
      public function BBCoder()
      {
         super();
      }
      
      public static function exportCardToBB(param1:WeaponCard, param2:int) : String
      {
         var _loc5_:CardLine = null;
         var _loc6_:CardLine = null;
         var _loc3_:String = "";
         _loc3_ += tag(tag(colorize(param1.name,param1.nameColor),BB_UL),BB_BOLD) + newline();
         _loc3_ += tag(param1.manufacturer,BB_BOLD) + newline();
         _loc3_ += tag("Level Requirement: ",BB_BOLD) + tag(param1.level.toString(),BB_ITALICS) + newline();
         if(param2 == GearCalcUtil.GEAR_WEAPON)
         {
            _loc3_ += tag("Dmg: ",BB_BOLD) + tag(param1.damage,BB_ITALICS) + " ";
            _loc3_ += tag("Acc: ",BB_BOLD) + tag(param1.accuracy,BB_ITALICS) + " ";
            _loc3_ += tag("ROF: ",BB_BOLD) + tag(param1.rof,BB_ITALICS) + " ";
            _loc3_ += tag("Clip: ",BB_BOLD) + tag(param1.clip,BB_ITALICS) + newline();
         }
         var _loc4_:String = "";
         for each(_loc5_ in param1.text)
         {
            if(_loc5_.color != 16777215)
            {
               _loc4_ += " " + BULLET + colorize(_loc5_.text,_loc5_.color) + newline();
            }
            else
            {
               _loc4_ += " " + BULLET + colorize(_loc5_.text,COLOR_SLIGHT_GRAY) + newline();
            }
         }
         _loc4_ = tag(_loc4_,BB_ITALICS);
         _loc6_ = param1.getTechDecoratedString();
         if(_loc6_ != null)
         {
            _loc4_ += colorize(_loc6_.text,_loc6_.color) + newline();
         }
         _loc4_ += colorize("$" + param1.cost.toFixed(0),MONEY_COLOR);
         return _loc3_ + _loc4_;
      }
      
      public static function exportAttributesBB(param1:Vector.<Attribute>, param2:String, param3:uint) : String
      {
         var _loc6_:Attribute = null;
         var _loc7_:* = undefined;
         var _loc4_:String = colorize(param2,param3);
         _loc4_ = size(tag(tag(_loc4_,BB_BOLD),BB_ITALICS),3) + newline();
         _loc4_ = _loc4_ + ("---------------------------------------" + newline());
         var _loc5_:Number = calcFillLength(param1,"bold",":");
         for each(_loc6_ in param1)
         {
            _loc7_ = fill(_loc6_.name,_loc5_,"bold");
            _loc4_ += BULLET + " " + tag(_loc6_.name + ": ",BB_BOLD) + _loc7_;
            _loc4_ = _loc4_ + (tag(colorize(_loc6_.text,COLOR_SLIGHT_GRAY),BB_ITALICS) + newline());
         }
         return _loc4_;
      }
      
      public static function fill(param1:String, param2:Number, param3:String) : String
      {
         var _loc4_:String = "";
         var _loc5_:Number = 0;
         var _loc6_:Number = createTemp(param1,param3).width;
         while(_loc6_ + _loc5_ < param2)
         {
            _loc4_ += FILLER;
            _loc5_ = createTemp(_loc4_,null).width;
         }
         return _loc4_;
      }
      
      public static function calcFillLength(param1:Vector.<Attribute>, param2:String, param3:String) : Number
      {
         var _loc5_:Attribute = null;
         var _loc6_:String = null;
         var _loc7_:TextLine = null;
         var _loc4_:Number = 0;
         for each(_loc5_ in param1)
         {
            _loc7_ = createTemp(_loc5_.name + param3,param2);
            if(_loc7_.width > _loc4_)
            {
               _loc4_ = _loc7_.width;
            }
         }
         _loc6_ = "";
         while(_loc6_.length < FILLER_BUFFER)
         {
            _loc6_ += FILLER;
         }
         return _loc4_ + createTemp(_loc6_,null).width;
      }
      
      private static function createTemp(param1:String, param2:String) : TextLine
      {
         return CardPainter.textIt(param1,"Arial",12,16777215,param2,null);
      }
      
      public static function newline() : String
      {
         return GearCalcUtil.NEWLINE_STRING;
      }
      
      public static function size(param1:String, param2:int) : String
      {
         return "[" + BB_SIZE + "=" + quotify(param2.toFixed(0)) + "]" + param1 + "[/" + BB_SIZE + "]";
      }
      
      public static function colorize(param1:String, param2:uint) : String
      {
         return "[" + BB_COLOR + "=" + quotify(toHex(param2)) + "]" + param1 + "[/" + BB_COLOR + "]";
      }
      
      public static function quotify(param1:String) : String
      {
         return String.fromCharCode(34) + param1 + String.fromCharCode(34);
      }
      
      public static function tag(param1:String, param2:String) : String
      {
         return "[" + param2 + "]" + param1 + "[/" + param2 + "]";
      }
      
      public static function toHex(param1:uint) : String
      {
         var _loc2_:String = param1.toString(16);
         while(_loc2_.length < 6)
         {
            _loc2_ = "0" + _loc2_;
         }
         return "#" + _loc2_;
      }
   }
}

