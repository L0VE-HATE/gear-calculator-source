package gearcalc
{
   import flash.external.ExternalInterface;
   
   public class GearStringEncoder
   {
      
      public static const ID_LENGTH:int = 4;
      
      public static const MODE_ID:int = 321;
      
      public static const MODE_STD:int = 423;
      
      private static const BREAKPOINT:int = 110;
      
      private static const EXCLUDE_MIN:int = 91;
      
      private static const EXCLUDE_MAX:int = 96;
      
      private static const SALT_OBFUSCATOR:int = 115;
      
      private static const GENERAL_SEED:int = 109;
      
      private static const ID_SALT:int = 2;
      
      private var engine:GearCalcEngine;
      
      private var currentCode:String;
      
      public var mode:int;
      
      public function GearStringEncoder(param1:GearCalcEngine)
      {
         super();
         this.engine = param1;
         this.currentCode = null;
         this.mode = MODE_STD;
      }
      
      public static function clearURL() : void
      {
      }
      
      public function processHash() : Boolean
      {
         var _loc1_:String = ExternalInterface.call("asjs_get_decoded_hash");
         if(_loc1_ != null && _loc1_.length > 0)
         {
            this.decode(_loc1_);
            return true;
         }
         return false;
      }
      
      public function sendToJavascript(param1:String) : Boolean
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("asjs_update_hash",param1);
            return true;
         }
         return false;
      }
      
      private function saltIt() : int
      {
         if(this.mode == MODE_STD)
         {
            return Math.round(Math.random() * 3);
         }
         if(this.mode == MODE_ID)
         {
            return ID_SALT;
         }
         return 0;
      }
      
      public function encode(param1:Gearable) : String
      {
         var _loc6_:int = 0;
         var _loc7_:Part = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = this.saltIt();
         var _loc3_:String = String.fromCharCode(_loc2_ + SALT_OBFUSCATOR) + this.encryptNum(param1.getGearType(),GENERAL_SEED,_loc2_);
         var _loc4_:Vector.<Part> = param1.getParts();
         var _loc5_:String = param1.getExpLevel().toString();
         while(_loc5_.length < 2)
         {
            _loc5_ = "0" + _loc5_;
         }
         _loc3_ += this.encryptNum(param1.getQualityLevel(),GENERAL_SEED,_loc2_);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ += this.encryptNum(int(_loc5_.substr(_loc6_,1)),GENERAL_SEED,_loc2_);
            _loc6_++;
         }
         for each(_loc7_ in _loc4_)
         {
            _loc8_ = _loc7_.getID();
            if(_loc8_.length == ID_LENGTH && _loc8_ != PartCollection.NULL_PART.getID())
            {
               _loc9_ = _loc8_.charCodeAt(0);
               _loc3_ += _loc8_.substr(0,1);
               _loc6_ = 1;
               while(_loc6_ < _loc8_.length)
               {
                  _loc3_ += this.encryptNum(int(_loc8_.substr(_loc6_,1)),_loc9_,_loc2_);
                  _loc6_++;
               }
            }
            else
            {
               _loc3_ += PartCollection.NULL_PART.getID().toLowerCase();
            }
         }
         this.currentCode = _loc3_;
         return _loc3_;
      }
      
      public function decode(param1:String) : Gearable
      {
         var seedStr:String;
         var salt:int;
         var type:int;
         var qual:int;
         var temp:String;
         var exp:int;
         var workable:Boolean;
         var src:String = param1;
         var code:String = src;
         if(src == null)
         {
            code = this.pullQueryString();
         }
         if(code.length < 5)
         {
            return null;
         }
         seedStr = String.fromCharCode(GENERAL_SEED);
         salt = code.charCodeAt(0) - SALT_OBFUSCATOR;
         type = this.decryptNum(code.charAt(1),seedStr,salt);
         qual = this.decryptNum(code.charAt(2),seedStr,salt);
         temp = this.decryptNum(code.charAt(3),seedStr,salt).toString() + this.decryptNum(code.charAt(4),seedStr,salt).toString();
         exp = int(temp);
         code = code.substring(5);
         this.engine.setGearType(type);
         workable = false;
         try
         {
            workable = this.engine.construct(this.build(code,salt),qual,exp);
         }
         catch(e:Error)
         {
            workable = false;
            trace(e.toString());
         }
         if(!workable)
         {
            trace(GearCalcEngine.getErrorCode());
            this.engine.reset();
         }
         return this.engine.build;
      }
      
      private function build(param1:String, param2:int) : Vector.<Part>
      {
         var _loc4_:String = null;
         var _loc5_:Part = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc3_:Vector.<Part> = new Vector.<Part>();
         var _loc6_:int = 0;
         while(_loc6_ <= param1.length - ID_LENGTH)
         {
            _loc4_ = param1.substr(_loc6_,ID_LENGTH);
            _loc8_ = _loc7_ = param1.substr(_loc6_,1);
            if(_loc4_ == PartCollection.NULL_PART.getID())
            {
               _loc5_ = PartCollection.NULL_PART;
            }
            else
            {
               _loc9_ = 1;
               while(_loc9_ < _loc4_.length)
               {
                  _loc8_ += this.decryptNum(_loc4_.substr(_loc9_,1),_loc7_,param2);
                  _loc9_++;
               }
               _loc5_ = this.engine.parts.retrieve(_loc8_);
            }
            if(_loc5_ != null)
            {
               _loc3_.push(_loc5_);
            }
            _loc6_ += ID_LENGTH;
         }
         return _loc3_;
      }
      
      private function pullQueryString() : String
      {
         return ExternalInterface.call("window.location.search.substring",1);
      }
      
      private function encryptNum(param1:int, param2:int, param3:int) : String
      {
         if(param2 > BREAKPOINT)
         {
            return String.fromCharCode(param2 - param1 - param3);
         }
         return String.fromCharCode(param2 + param1 + param3);
      }
      
      private function decryptNum(param1:String, param2:String, param3:int) : int
      {
         var _loc4_:int = param1.charCodeAt(0);
         var _loc5_:int = param2.charCodeAt(0);
         if(_loc5_ > BREAKPOINT)
         {
            return _loc5_ - _loc4_ - param3;
         }
         return _loc4_ - _loc5_ - param3;
      }
   }
}

