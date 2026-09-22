package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import gearcalc.*;
   import mx.controls.Image;
   
   public class GearCalcAppUtil
   {
      
      public static const WT_HANDLE_CHANGE:String = "HandleGearChange";
      
      public static const WT_NOTIFY_STATUS:String = "NotifyStatus";
      
      public static const STATUS_LOADING:String = "loading";
      
      public static const STATUS_READY:String = "ready";
      
      public static const STATUS_BUSY:String = "busy";
      
      public static const DISP_WEAPON:String = "Weapon";
      
      public static const DISP_SHIELD:String = "Shield";
      
      public static const DISP_COM:String = "Class Mod";
      
      public static const CARD_AS_BBCODE:String = "Copy as BBCode";
      
      public static const CARD_AS_PNG:String = "Save as Image";
      
      public static const CARD_TO_SHACK:String = "Host on ImageShack";
      
      public static const STATS_AS_TEXT:String = "Copy as Text";
      
      public static const STATS_AS_BBCODE:String = "Copy as BBCode";
      
      public static const COOKIE_DURATION:int = 365;
      
      public static const COOKIE_PREF:String = "gcPrefs";
      
      public static const START_PREF:String = "[";
      
      public static const END_PREF:String = "]";
      
      public static const DIVIDER_PREF:String = "=";
      
      public static const PREF_AN:String = "AutoName";
      
      public static const PREF_TECH:String = "TechCalc";
      
      public static const PREF_HISTORY:String = "LastBuild";
      
      public static const PREF_DO_HISTORY:String = "SaveHist";
      
      public static const PREF_PRELOAD:String = "Preload";
      
      public static const DESIRED_HEIGHT_GUN:int = 36;
      
      public static const DESIRED_HEIGHT_SHIELD:int = 60;
      
      public static const SCALE_LIM:Number = 1.6;
      
      public var isAutoName:Boolean;
      
      public var isTechie:Boolean;
      
      public var isZippy:Boolean;
      
      public var isHistory:Boolean;
      
      public var status:String;
      
      private var isWillow:Boolean;
      
      private var prefs:Dictionary;
      
      private var engine:GearCalcEngine;
      
      public function GearCalcAppUtil(param1:GearCalcEngine, param2:Boolean)
      {
         super();
         this.engine = param1;
         this.isWillow = param2;
         this.prefs = new Dictionary();
         this.status = STATUS_LOADING;
         if(!param2)
         {
            this.loadPreferences();
         }
         var _loc3_:String = this.getPreference(PREF_AN);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            this.isAutoName = stringToBool(_loc3_);
         }
         else
         {
            this.isAutoName = false;
         }
         _loc3_ = this.getPreference(PREF_TECH);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            this.isTechie = stringToBool(_loc3_);
         }
         else
         {
            this.isTechie = true;
         }
         _loc3_ = this.getPreference(PREF_PRELOAD);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            this.isZippy = stringToBool(_loc3_);
         }
         else
         {
            this.isZippy = false;
         }
         _loc3_ = this.getPreference(PREF_DO_HISTORY);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            this.isHistory = stringToBool(_loc3_);
         }
         else
         {
            this.isHistory = true;
         }
      }
      
      public static function boolToString(param1:Boolean) : String
      {
         return param1.toString();
      }
      
      public static function stringToBool(param1:String) : Boolean
      {
         if(param1 == "true" || param1 == "1")
         {
            return true;
         }
         return false;
      }
      
      public function notifyWillowTree(param1:Gearable) : void
      {
         var _loc4_:Part = null;
         var _loc5_:String = null;
         var _loc2_:Array = new Array();
         var _loc3_:Vector.<Part> = param1.getParts();
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = _loc4_.getTrueName();
            if(_loc5_ == PartCollection.NULL_PART.getTrueName())
            {
               _loc5_ = "None";
            }
            _loc2_.push(_loc5_);
         }
         ExternalInterface.call(WT_HANDLE_CHANGE,_loc2_,param1.getExpLevel(),param1.getQualityLevel());
      }
      
      public function notifyStatus(param1:String = null) : void
      {
         if(param1 != null)
         {
            this.status = param1;
         }
         ExternalInterface.call(WT_NOTIFY_STATUS,this.status);
      }
      
      public function positionImage(param1:Image, param2:Point, param3:BitmapData, param4:int) : void
      {
         var _loc5_:Number = param4 / param3.height;
         _loc5_ = _loc5_ > SCALE_LIM ? SCALE_LIM : _loc5_;
         param1.height = param3.height * _loc5_;
         param1.width = param3.width * _loc5_;
         param1.x = param2.x - param1.width;
         param1.y = param2.y - param1.height / 2;
         var _loc6_:Bitmap = new Bitmap(param3);
         _loc6_.smoothing = true;
         param1.source = _loc6_;
         param1.maintainAspectRatio = true;
         param1.scaleContent = true;
      }
      
      public function checkUrlForGear() : Boolean
      {
         var _loc1_:GearStringEncoder = new GearStringEncoder(this.engine);
         return _loc1_.processHash();
      }
      
      public function addHistoryPref(param1:Gearable) : void
      {
         if(param1 == null || !this.isHistory)
         {
            this.addPreference(PREF_HISTORY,null);
            return;
         }
         var _loc2_:GearStringEncoder = new GearStringEncoder(this.engine);
         this.addPreference(PREF_HISTORY,_loc2_.encode(param1));
      }
      
      public function linkifyGear(param1:Gearable) : String
      {
         var _loc2_:GearStringEncoder = null;
         var _loc3_:String = null;
         if(param1 != null)
         {
            _loc2_ = new GearStringEncoder(this.engine);
            _loc3_ = _loc2_.encode(param1);
            if(!this.isWillow)
            {
               _loc2_.sendToJavascript(_loc3_);
            }
            return _loc3_;
         }
         return null;
      }
      
      public function writeStandardPrefs() : void
      {
         this.addPreference(PREF_AN,boolToString(this.isAutoName));
         this.addPreference(PREF_TECH,boolToString(this.isTechie));
         this.addPreference(PREF_PRELOAD,boolToString(this.isZippy));
         this.addPreference(PREF_DO_HISTORY,boolToString(this.isHistory));
      }
      
      public function loadHistoryBuild() : Gearable
      {
         var _loc2_:GearStringEncoder = null;
         var _loc1_:String = this.getPreference(PREF_HISTORY);
         if(_loc1_ != null && _loc1_ != "null")
         {
            _loc2_ = new GearStringEncoder(this.engine);
            return _loc2_.decode(this.getPreference(PREF_HISTORY));
         }
         return null;
      }
      
      public function commitPreferences() : void
      {
         var _loc2_:Object = null;
         if(this.isWillow)
         {
            return;
         }
         var _loc1_:String = "";
         for(_loc2_ in this.prefs)
         {
            _loc1_ += START_PREF + (_loc2_ as String) + DIVIDER_PREF + (this.prefs[_loc2_] as String) + END_PREF;
         }
         CookieUtil.setCookie(COOKIE_PREF,_loc1_,COOKIE_DURATION);
      }
      
      public function addPreference(param1:String, param2:String) : void
      {
         this.prefs[param1] = param2;
      }
      
      public function getPreference(param1:String) : String
      {
         return this.prefs[param1] as String;
      }
      
      public function loadPreferences() : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(this.isWillow)
         {
            return;
         }
         var _loc1_:String = CookieUtil.getCookie(COOKIE_PREF) as String;
         trace("Cookie: " + _loc1_);
         if(_loc1_ != null && _loc1_.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length && _loc1_.indexOf(START_PREF,_loc2_) != -1 && _loc1_.indexOf(END_PREF,_loc2_) != -1)
            {
               _loc2_ = _loc1_.indexOf(START_PREF,_loc2_);
               _loc3_ = _loc1_.substring(_loc2_ + 1,_loc1_.indexOf(END_PREF,_loc2_));
               _loc4_ = _loc3_.substring(0,_loc3_.indexOf(DIVIDER_PREF));
               _loc5_ = _loc3_.substring(_loc3_.indexOf(DIVIDER_PREF) + 1);
               if(_loc4_ != null && _loc4_.length > 0 && _loc5_ != null && _loc5_.length > 0)
               {
                  this.prefs[_loc4_] = _loc5_;
               }
               _loc2_ = _loc1_.indexOf(END_PREF,_loc2_) + 1;
            }
         }
      }
   }
}

