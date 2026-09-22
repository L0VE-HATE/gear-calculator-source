package gearcalc
{
   public class NameRegister
   {
      
      internal static const POSITION_BODY:int = 0;
      
      internal static const POSITION_PART_STR:int = 1;
      
      internal static const POSITION_MAT:int = 2;
      
      internal static const NUM_POS_STOCK:int = 1;
      
      internal static const NUM_POS_MAG:int = 2;
      
      internal static const REG_LENGTH:int = 5;
      
      private var extras:Vector.<String>;
      
      private var register:Vector.<String>;
      
      private var numReg:Vector.<int>;
      
      private var template:GearTemplate;
      
      public function NameRegister(param1:GearTemplate)
      {
         super();
         this.template = param1;
         this.register = new Vector.<String>();
         this.numReg = new Vector.<int>();
         this.extras = new Vector.<String>();
         this.numReg.push(-1);
         this.numReg.push(-1);
         this.numReg.push(-1);
         this.numReg.push(-1);
      }
      
      public static function nameEridian(param1:Weapon) : String
      {
         if(!param1.isEridian())
         {
            return "";
         }
         var _loc2_:Part = param1.getSlottedPart(GearCalcUtil.PART_TYPE_STOCK);
         var _loc3_:Part = param1.getSlottedPart(GearCalcUtil.PART_TYPE_MAG);
         var _loc4_:String = _loc2_ != null ? _loc2_.getTitleAddend() : "";
         var _loc5_:String = _loc3_ != null ? _loc3_.getTitleAddend() : "";
         _loc4_ = _loc4_ != null ? _loc4_ : "";
         _loc5_ = _loc5_ != null ? _loc5_ : "";
         var _loc6_:String = "";
         if(_loc5_.length < _loc4_.length)
         {
            _loc6_ = _loc4_.substr(0,_loc4_.length - _loc5_.length) + _loc5_;
         }
         else
         {
            _loc6_ = _loc4_ + _loc5_;
         }
         return _loc6_;
      }
      
      public function push(param1:Part) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.getType() == GearCalcUtil.PART_TYPE_STOCK || param1.getType() == GearCalcUtil.PART_TYPE_SHIELD_RIGHT)
         {
            this.addNum(param1.getTitleAddend(),NUM_POS_STOCK,true);
            if(!this.template.isBasePart(param1) && this.extras.length == 0)
            {
               this.extras.push("0");
            }
         }
         else if(param1.getType() == GearCalcUtil.PART_TYPE_MAG || param1.getType() == GearCalcUtil.PART_TYPE_SHIELD_LEFT)
         {
            this.addNum(param1.getTitleAddend(),NUM_POS_MAG,false);
            if(!this.template.isBasePart(param1) && this.extras.length == 0)
            {
               this.extras.push("0");
            }
         }
         else
         {
            this.register.push(param1.getTitleText());
         }
      }
      
      private function addNum(param1:String, param2:int, param3:Boolean) : void
      {
         var num:int;
         var newReg:Vector.<int> = null;
         var str:String = null;
         var i:int = 0;
         var strNum:String = param1;
         var index:int = param2;
         var isLeft:Boolean = param3;
         var add:Function = function(param1:Vector.<int>):void
         {
            var _loc5_:* = 0;
            var _loc2_:Vector.<int> = new Vector.<int>();
            if(numReg.length > newReg.length)
            {
               _loc5_ = 0;
               while(_loc5_ < numReg.length - newReg.length)
               {
                  newReg.push(-1);
                  _loc5_++;
               }
            }
            else if(newReg.length > numReg.length)
            {
               _loc5_ = 0;
               while(_loc5_ < newReg.length - numReg.length)
               {
                  numReg.push(-1);
                  _loc5_++;
               }
            }
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            _loc5_ = int(newReg.length - 1);
            while(_loc5_ >= 0)
            {
               if(newReg[_loc5_] != -1 && numReg[_loc5_] != -1)
               {
                  _loc4_ = newReg[_loc5_] + numReg[_loc5_] + _loc3_;
               }
               else if(newReg[_loc5_] == -1 && numReg[_loc5_] != -1 || newReg[_loc5_] != -1 && numReg[_loc5_] == -1)
               {
                  _loc4_ = nummify(newReg,_loc5_) + nummify(numReg,_loc5_) + _loc3_;
               }
               else
               {
                  _loc4_ = -1;
               }
               if(_loc4_ >= 10)
               {
                  _loc3_ = 1;
                  _loc4_ -= 10;
               }
               else if(_loc3_ > 0 && _loc4_ >= 0)
               {
                  _loc4_ += _loc3_;
                  _loc3_ = 0;
               }
               else if(_loc3_ > 0)
               {
                  _loc4_ = _loc3_;
                  _loc3_ = 0;
               }
               _loc2_.push(_loc4_);
               _loc5_--;
            }
            if(_loc3_ > 0)
            {
               _loc2_.push(_loc3_);
            }
            var _loc6_:Vector.<int> = new Vector.<int>();
            _loc5_ = int(_loc2_.length - 1);
            while(_loc5_ >= 0)
            {
               _loc6_.push(_loc2_[_loc5_]);
               _loc5_--;
            }
            numReg = _loc6_;
         };
         var nummify:Function = function(param1:Vector.<int>, param2:int):int
         {
            if(param1[param2] == -1)
            {
               return 0;
            }
            return param1[param2];
         };
         if(strNum == null || isNaN(Number(strNum)))
         {
            return;
         }
         num = int(strNum);
         newReg = new Vector.<int>();
         if(index >= 0 && index < this.numReg.length)
         {
            str = String(num);
            i = 0;
            while(i < this.numReg.length)
            {
               newReg.push(-1);
               i++;
            }
            i = 0;
            while(i < str.length)
            {
               if(isLeft && index + i < newReg.length)
               {
                  newReg[index + i] = int(str.substr(i,1));
               }
               else if(!isLeft && index - i >= 0 && index - i < newReg.length)
               {
                  newReg[index - i] = int(str.substr(str.length - 1 - i,1));
               }
               i++;
            }
            add(newReg);
         }
      }
      
      public function name() : String
      {
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc1_:String = "";
         for each(_loc2_ in this.numReg)
         {
            if(_loc2_ != -1)
            {
               _loc1_ += String(_loc2_);
            }
         }
         if(_loc1_.length > 0)
         {
            for each(_loc5_ in this.extras)
            {
               _loc1_ += _loc5_;
            }
         }
         var _loc3_:String = "";
         var _loc4_:int = 0;
         while(_loc4_ < this.register.length)
         {
            if(_loc4_ == POSITION_PART_STR)
            {
               _loc3_ += _loc1_;
            }
            if(this.register[_loc4_] != null)
            {
               _loc3_ += this.register[_loc4_];
            }
            else
            {
               _loc3_ += "";
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}

