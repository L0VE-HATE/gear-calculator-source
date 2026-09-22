package gearcalc.card
{
   import flash.display.BitmapData;
   
   public class InterpolatedBitmapData extends BitmapData
   {
      
      public function InterpolatedBitmapData(param1:int, param2:int, param3:Boolean = true, param4:uint = 4294967295)
      {
         super(param1,param2,param3,param4);
      }
      
      private static function A(param1:Number) : Number
      {
         var _loc2_:Number = param1 + 2 > 0 ? param1 + 2 : 0;
         var _loc3_:Number = param1 + 1 > 0 ? param1 + 1 : 0;
         var _loc4_:Number = param1 > 0 ? param1 : 0;
         var _loc5_:Number = param1 - 1 > 0 ? param1 - 1 : 0;
         return 1 / 6 * (_loc2_ * _loc2_ * _loc2_ - 4 * (_loc3_ * _loc3_ * _loc3_) + 6 * (_loc4_ * _loc4_ * _loc4_) - 4 * (_loc5_ * _loc5_ * _loc5_));
      }
      
      private static function P(param1:Number) : Number
      {
         return param1 > 0 ? param1 : 0;
      }
      
      private static function r(param1:int) : int
      {
         return param1 >> 16 & 0xFF;
      }
      
      private static function g(param1:int) : int
      {
         return param1 >> 8 & 0xFF;
      }
      
      private static function b(param1:int) : int
      {
         return param1 >> 0 & 0xFF;
      }
      
      public function getPixelBicubic(param1:Number, param2:Number) : Number
      {
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Number = NaN;
         var _loc3_:int = int(param1);
         var _loc4_:int = int(param2);
         if(_loc3_ - 1 < 0 || _loc4_ - 1 < 0)
         {
            return getPixel(_loc3_,_loc4_);
         }
         if(_loc3_ + 1 >= width || _loc3_ + 2 >= width || _loc4_ + 1 >= height || _loc4_ + 2 >= height)
         {
            return getPixel(_loc3_,_loc4_);
         }
         var _loc5_:Number = param1 - _loc3_;
         var _loc6_:Number = param2 - _loc4_;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         var _loc10_:Array = new Array(4);
         var _loc11_:Array = new Array(4);
         var _loc12_:int = -1;
         while(_loc12_ <= 2)
         {
            _loc10_[_loc12_ + 1] = A(_loc12_ - _loc5_);
            _loc12_++;
         }
         var _loc13_:int = -1;
         while(_loc13_ <= 2)
         {
            _loc11_[_loc13_ + 1] = A(_loc6_ - _loc13_);
            _loc13_++;
         }
         _loc12_ = -1;
         while(_loc12_ <= 2)
         {
            _loc13_ = -1;
            while(_loc13_ <= 2)
            {
               _loc17_ = int(getPixel(_loc3_ + _loc12_,_loc4_ + _loc13_));
               _loc18_ = _loc17_ >> 16 & 0xFF;
               _loc19_ = _loc17_ >> 8 & 0xFF;
               _loc20_ = _loc17_ >> 0 & 0xFF;
               _loc21_ = _loc10_[_loc12_ + 1] * _loc11_[_loc13_ + 1];
               _loc7_ += _loc18_ * _loc21_;
               _loc8_ += _loc19_ * _loc21_;
               _loc9_ += _loc20_ * _loc21_;
               _loc13_++;
            }
            _loc12_++;
         }
         var _loc14_:int = int(_loc7_ + 0.5);
         if(_loc14_ < 0)
         {
            _loc14_ = 0;
         }
         else if(_loc14_ > 255)
         {
            _loc14_ = 255;
         }
         var _loc15_:int = int(_loc8_ + 0.5);
         if(_loc15_ < 0)
         {
            _loc15_ = 0;
         }
         else if(_loc15_ > 255)
         {
            _loc15_ = 255;
         }
         var _loc16_:int = int(_loc9_ + 0.5);
         if(_loc16_ < 0)
         {
            _loc16_ = 0;
         }
         else if(_loc16_ > 255)
         {
            _loc16_ = 255;
         }
         return _loc14_ << 16 | _loc15_ << 8 | _loc16_ << 0;
      }
      
      public function getPixelBilinear(param1:Number, param2:Number) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         _loc3_ = Math.floor(param1);
         _loc4_ = Math.floor(param2);
         if(_loc3_ < 1 || _loc4_ < 1 || _loc3_ + 2 >= width || _loc4_ + 2 >= height)
         {
            return getPixel(_loc3_,_loc4_);
         }
         _loc5_ = param1 - _loc3_;
         _loc6_ = param2 - _loc4_;
         _loc8_ = 1 - _loc5_;
         _loc7_ = 1 - _loc6_;
         _loc9_ = int(getPixel(_loc3_,_loc4_));
         _loc10_ = int(getPixel(_loc3_ + 1,_loc4_));
         _loc11_ = int(getPixel(_loc3_,_loc4_ + 1));
         _loc12_ = int(getPixel(_loc3_ + 1,_loc4_ + 1));
         _loc13_ = (r(_loc9_) * _loc8_ + r(_loc10_) * _loc5_) * _loc7_ + (r(_loc11_) * _loc8_ + r(_loc12_) * _loc5_) * _loc6_;
         _loc14_ = (g(_loc9_) * _loc8_ + g(_loc10_) * _loc5_) * _loc7_ + (g(_loc11_) * _loc8_ + g(_loc12_) * _loc5_) * _loc6_;
         _loc15_ = (b(_loc9_) * _loc8_ + b(_loc10_) * _loc5_) * _loc7_ + (b(_loc11_) * _loc8_ + b(_loc12_) * _loc5_) * _loc6_;
         if(_loc13_ < 0)
         {
            _loc13_ = 0;
         }
         else if(_loc13_ > 255)
         {
            _loc13_ = 255;
         }
         if(_loc14_ < 0)
         {
            _loc14_ = 0;
         }
         else if(_loc14_ > 255)
         {
            _loc14_ = 255;
         }
         if(_loc15_ < 0)
         {
            _loc15_ = 0;
         }
         else if(_loc15_ > 255)
         {
            _loc15_ = 255;
         }
         return _loc13_ << 16 | _loc14_ << 8 | _loc15_ << 0;
      }
      
      public function getIntensity(param1:int, param2:int) : int
      {
         var _loc3_:int = int(getPixel(param1,param2));
         var _loc4_:int = _loc3_ >> 16 & 0xFF;
         var _loc5_:int = _loc3_ >> 8 & 0xFF;
         var _loc6_:int = _loc3_ >> 0 & 0xFF;
         return Math.ceil((_loc4_ + _loc5_ + _loc6_) / 3);
      }
   }
}

