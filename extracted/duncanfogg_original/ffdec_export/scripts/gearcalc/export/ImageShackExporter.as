package gearcalc.export
{
   import flash.errors.IOError;
   import flash.events.Event;
   import flash.net.URLRequestHeader;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import mx.graphics.codec.PNGEncoder;
   
   public class ImageShackExporter extends GenericExporter
   {
      
      public static const KEY_LINK:String = "Image Link";
      
      public static const KEY_BB:String = "BBCode Link";
      
      internal static const DEV_KEY:String = "2GJNOUVY37a1a0b97d65921486ea3adfbcda648f";
      
      public static const SERVICE_ADDRESS:String = "http://www.imageshack.us/upload_api.php";
      
      internal static const PROXY_ADDRESS:String = "http://myborderlands.com/ProxyUtil.ashx";
      
      internal static const HEADER_DEST:String = "FINALDEST";
      
      protected static const PARAM_FILE:String = "fileupload";
      
      protected static const PARAM_DEV:String = "key";
      
      protected static const PARAM_USER:String = "a_username";
      
      protected static const PARAM_PASS:String = "a_password";
      
      protected static const PARAM_TAGS:String = "tags";
      
      public var user:String;
      
      public var pass:String;
      
      private var entry:ImageEntry;
      
      private var loader:MultipartURLLoader;
      
      public function ImageShackExporter()
      {
         super(GenericExporter.SINGLE);
      }
      
      protected static function cleanXML(param1:XML) : XML
      {
         var _loc2_:String = param1.toXMLString();
         _loc2_ = _loc2_.replace(/xmlns(:[A-Za-z0-9]+)?=[^"]*"[^"]*"/gi,"");
         _loc2_ = _loc2_.replace(/<*:/gi,"_");
         return new XML(_loc2_);
      }
      
      override public function abort() : void
      {
         if(this.loader != null)
         {
            this.loader.close();
         }
      }
      
      override protected function doExport(param1:ByteArray, param2:String, param3:String, param4:Function) : void
      {
         var service:MultipartURLLoader = null;
         var onResult:Function = null;
         var img:ByteArray = param1;
         var filename:String = param2;
         var imgType:String = param3;
         var callback:Function = param4;
         onResult = function(param1:Event):void
         {
            var _loc2_:XML = new XML(service._loader.data);
            _loc2_ = cleanXML(_loc2_);
            var _loc3_:String = _loc2_.links.image_link;
            _loc3_ = _loc3_.replace("http_","http:");
            if(_loc3_.length > 0)
            {
               success = true;
            }
            result = new Dictionary();
            result[KEY_LINK] = _loc3_;
            result[KEY_BB] = "[IMG]" + _loc3_ + "[/IMG]";
            callback();
         };
         var enc:PNGEncoder = new PNGEncoder();
         service = new MultipartURLLoader();
         this.loader = service;
         if(this.user != null && this.user.length > 0 && this.pass != null && this.pass.length > 0)
         {
            service.addVariable(PARAM_USER,this.user);
            service.addVariable(PARAM_PASS,this.pass);
         }
         service.addEventListener(Event.COMPLETE,onResult);
         service.addVariable(PARAM_DEV,DEV_KEY);
         service.addFile(img,filename,PARAM_FILE,imgType);
         service.requestHeaders.push(new URLRequestHeader(HEADER_DEST,SERVICE_ADDRESS));
         try
         {
            service.load(PROXY_ADDRESS);
         }
         catch(error:IOError)
         {
            success = false;
            callback();
         }
      }
   }
}

