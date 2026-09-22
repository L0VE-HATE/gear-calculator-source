package gearcalc
{
   public class DPSCalculator
   {
      
      private var gun:Weapon;
      
      public var range:Number;
      
      public var targetWidth:Number;
      
      public var targetHeight:Number;
      
      public var rofMod:Number;
      
      public var dmgMod:Number;
      
      public var spreadMod:Number;
      
      public function DPSCalculator()
      {
         super();
         this.reset();
      }
      
      public function reset() : void
      {
         this.range = 10;
         this.targetWidth = 3;
         this.targetHeight = 7;
         this.rofMod = 0;
         this.dmgMod = 0;
         this.spreadMod = 0;
      }
      
      public function calculate(param1:Weapon) : Number
      {
         this.gun = param1;
         var _loc2_:Number = this.getStat(GearCalcUtil.ATTR_SPREAD);
         trace("Spread: " + _loc2_);
         if(_loc2_ > 11.2)
         {
            _loc2_ = 11.2;
         }
         var _loc3_:Number = this.range * Math.tan(Math.PI / 24 * _loc2_);
         var _loc4_:Number = this.circleRectOverlapPercent(_loc3_,this.targetWidth,this.targetHeight);
         var _loc5_:Number = this.getStat(GearCalcUtil.ATTR_DAMAGE) * this.getStat(GearCalcUtil.ATTR_PROJECTILE_COUNT) * this.getStat(GearCalcUtil.ATTR_CLIP);
         _loc5_ = _loc5_ * _loc4_ / (this.getStat(GearCalcUtil.ATTR_CLIP) * this.getStat(GearCalcUtil.ATTR_FIRERATE) + this.getStat(GearCalcUtil.ATTR_RELOAD));
         trace("range: " + this.range + "width: " + this.targetWidth);
         trace("Radius: " + _loc3_ + ", probability: " + _loc4_ + ", dps: " + _loc5_);
         return _loc5_;
      }
      
      private function circleRectOverlapPercent(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc4_:Number = NaN;
         if(param2 >= 2 * param1 && param3 >= 2 * param1)
         {
            return 1;
         }
         if(this.calcHypotenuse(param2,param3) <= param1)
         {
            trace("hypot");
            return param2 * param3 / (Math.PI * Math.pow(param1,2));
         }
         _loc4_ = 0;
         if(param2 < 2 * param1)
         {
            _loc4_ += 2 * this.calcSegmentArea(param1,param1 - param2 / 2);
         }
         if(param3 < 2 * param1)
         {
            _loc4_ += 2 * this.calcSegmentArea(param1,param1 - param3 / 2);
         }
         trace("trimarea: " + _loc4_);
         return 1 - _loc4_ / (Math.PI * Math.pow(param1,2));
      }
      
      private function calcHypotenuse(param1:Number, param2:Number) : Number
      {
         return Math.sqrt(Math.pow(param1,2) + Math.pow(param2,2));
      }
      
      private function calcSegmentArea(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = Math.pow(param1,2) * Math.acos((param1 - param2) / param1);
         return _loc3_ - (param1 - param2) * Math.sqrt(2 * param1 * param2 - Math.pow(param2,2));
      }
      
      private function getStat(param1:String) : Number
      {
         return this.gun.stats.getStat(param1);
      }
   }
}

