package
{
   import flash.system.ApplicationDomain;
   import flash.system.Security;
   import flash.utils.Dictionary;
   import flashx.textLayout.compose.ISWFContext;
   import mx.core.EmbeddedFontRegistry;
   import mx.core.IFlexModule;
   import mx.core.IFlexModuleFactory;
   import mx.core.Singleton;
   import mx.managers.SystemManager;
   import mx.preloaders.SparkDownloadProgressBar;
   
   [SWF(width="500", height="375", backgroundColor="#ffffff", frameRate="24")]
   public class _GearCalcApp_mx_managers_SystemManager extends SystemManager implements IFlexModuleFactory, ISWFContext
   {
      
      private var _preloadedRSLs:Dictionary;
      
      public function _GearCalcApp_mx_managers_SystemManager()
      {
         super();
      }
      
      override public function callInContext(param1:Function, param2:Object, param3:Array, param4:Boolean = true) : *
      {
         if(param4)
         {
            return param1.apply(param2,param3);
         }
         param1.apply(param2,param3);
      }
      
      override public function create(... rest) : Object
      {
         if(rest.length > 0 && !(rest[0] is String))
         {
            return super.create.apply(this,rest);
         }
         var _loc2_:String = rest.length == 0 ? "GearCalcApp" : String(rest[0]);
         var _loc3_:Class = Class(getDefinitionByName(_loc2_));
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:Object = new _loc3_();
         if(_loc4_ is IFlexModule)
         {
            IFlexModule(_loc4_).moduleFactory = this;
         }
         if(rest.length == 0)
         {
            Singleton.registerClass("mx.core::IEmbeddedFontRegistry",Class(getDefinitionByName("mx.core::EmbeddedFontRegistry")));
            EmbeddedFontRegistry.registerFonts(this.info()["fonts"],this);
         }
         return _loc4_;
      }
      
      override public function info() : Object
      {
         return {
            "applicationComplete":"loadData();",
            "cdRsls":[{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.0.0.14159/framework_4.0.0.14159.swz","framework_4.0.0.14159.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["f74fcd943bac79e6dadbf0307b55b0697c5907e49161e6970b8452e8dcd92d04","f74fcd943bac79e6dadbf0307b55b0697c5907e49161e6970b8452e8dcd92d04"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.0.0.14159/osmf_flex.4.0.0.13495.swz","osmf_flex.4.0.0.13495.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["c3306b26751d6a80eb1fcb651912469ae18819aba42869379acb17e49ec1f9f0","c3306b26751d6a80eb1fcb651912469ae18819aba42869379acb17e49ec1f9f0"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/tlf/1.0.0.595/textLayout_1.0.0.595.swz","textLayout_1.0.0.595.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["7421c71f94db4f028e7528b2d278f3fe4dc21273e3cc1c663c569f102564811c","7421c71f94db4f028e7528b2d278f3fe4dc21273e3cc1c663c569f102564811c"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.0.0.14159/rpc_4.0.0.14159.swz","rpc_4.0.0.14159.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["d796ac95bd6e16151b6d3c0019a52e648ced1fe1609272931a1aa6fe6c39d3a1","d796ac95bd6e16151b6d3c0019a52e648ced1fe1609272931a1aa6fe6c39d3a1"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.0.0.14159/spark_4.0.0.14159.swz","spark_4.0.0.14159.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["33d9983bc427dd69df151e816fb0ab02c0b8d5cfa9105cf9a10282adc14a0e64","33d9983bc427dd69df151e816fb0ab02c0b8d5cfa9105cf9a10282adc14a0e64"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            },{
               "rsls":["http://fpdownload.adobe.com/pub/swz/flex/4.0.0.14159/sparkskins_4.0.0.14159.swz","sparkskins_4.0.0.14159.swz"],
               "policyFiles":["http://fpdownload.adobe.com/pub/swz/crossdomain.xml",""],
               "digests":["67ba9f962eec4d8b413432afad5c88bb810426b995aa9721fc1b503d0c2d30e0","67ba9f962eec4d8b413432afad5c88bb810426b995aa9721fc1b503d0c2d30e0"],
               "types":["SHA-256","SHA-256"],
               "isSigned":[true,true]
            }],
            "compiledLocales":["en_US"],
            "compiledResourceBundleNames":["SharedResources","collections","components","containers","controls","core","effects","formatters","layout","skins","sparkEffects","styles","textLayout"],
            "currentDomain":ApplicationDomain.currentDomain,
            "currentState":"cruncher",
            "fonts":{"Prototype":{
               "regular":true,
               "bold":false,
               "italic":false,
               "boldItalic":false
            }},
            "mainClassName":"GearCalcApp",
            "mixins":["_GearCalcApp_FlexInit","_GearCalcApp_Styles","mx.messaging.config.LoaderConfig","mx.managers.systemClasses.ActiveWindowManager"],
            "preloader":SparkDownloadProgressBar
         };
      }
      
      override public function get preloadedRSLs() : Dictionary
      {
         if(this._preloadedRSLs == null)
         {
            this._preloadedRSLs = new Dictionary(true);
         }
         return this._preloadedRSLs;
      }
      
      override public function allowDomain(... rest) : void
      {
         var _loc2_:Object = null;
         Security.allowDomain(rest);
         for(_loc2_ in this._preloadedRSLs)
         {
            if(Boolean(_loc2_.content) && "allowDomainInRSL" in _loc2_.content)
            {
               _loc2_.content["allowDomainInRSL"](rest);
            }
         }
      }
      
      override public function allowInsecureDomain(... rest) : void
      {
         var _loc2_:Object = null;
         Security.allowInsecureDomain(rest);
         for(_loc2_ in this._preloadedRSLs)
         {
            if(Boolean(_loc2_.content) && "allowInsecureDomainInRSL" in _loc2_.content)
            {
               _loc2_.content["allowInsecureDomainInRSL"](rest);
            }
         }
      }
   }
}

