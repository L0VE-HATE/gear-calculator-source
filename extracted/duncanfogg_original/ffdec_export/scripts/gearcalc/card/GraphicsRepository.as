package gearcalc.card
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import gearcalc.GearCalcUtil;
   import gearcalc.PartCollection;
   import nochump.util.zip.*;
   
   public class GraphicsRepository
   {
      
      internal static var zipPath:String;
      
      private static var images:Dictionary;
      
      internal static var root:String;
      
      public static var useSockets:Boolean = false;
      
      public static var scaleFactor:Number = 0.67;
      
      public static const MASK_CORROSIVE:uint = 6618995;
      
      public static const MASK_EXPLOSIVE:uint = 16777151;
      
      public static const MASK_SHOCK:uint = 8485887;
      
      public static const MASK_INCENDIARY:int = 16723502;
      
      public static const MASK_UNTOUCHED:uint = 16750080;
      
      public static const MATERIAL_ID_PREFIX:String = "x";
      
      private static const ANCHOR_X:int = 0;
      
      private static const ANCHOR_Y:int = 0;
      
      public static var width:int = 260;
      
      public static var height:int = 180;
      
      private var queue:Vector.<String>;
      
      public function GraphicsRepository()
      {
         super();
         this.queue = new Vector.<String>();
      }
      
      public static function loadArchive(param1:Function, param2:Boolean) : void
      {
         var loader:URLLoader = null;
         var queue:Vector.<DrawablePart> = null;
         var onFileLoad:Function = null;
         var loadNext:Function = null;
         var notifier:Function = param1;
         var bulkLoad:Boolean = param2;
         onFileLoad = function(param1:Event):void
         {
            var _loc3_:Object = null;
            trace("Zip loaded");
            var _loc2_:ZipFile = new ZipFile(loader.data as ByteArray);
            DrawablePart.zipLib = _loc2_;
            if(bulkLoad)
            {
               trace("Loading BULK");
               for each(_loc3_ in images)
               {
                  queue.push(_loc3_ as DrawablePart);
               }
            }
            loadNext();
         };
         loadNext = function():void
         {
            if(queue.length > 0)
            {
               queue.shift().load(loadNext);
            }
            else
            {
               notifier();
            }
         };
         if(zipPath == null)
         {
            notifier();
            return;
         }
         loader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,onFileLoad);
         loader.load(new URLRequest(zipPath));
         loader.dataFormat = URLLoaderDataFormat.BINARY;
         queue = new Vector.<DrawablePart>();
      }
      
      public static function init(param1:XML, param2:PartCollection) : void
      {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:DrawablePart = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         images = new Dictionary();
         root = param1.RootPath;
         DrawPriorityManager.initManagers(param1,param2);
         var _loc3_:String = "../" + root;
         if(param1.Width.length() == 1)
         {
            width = parseInt(param1.Width);
         }
         if(param1.Height.length() == 1)
         {
            height = parseInt(param1.Height);
         }
         if(param1.ZipFile.length() == 1)
         {
            zipPath = _loc3_ + param1.ZipFile;
         }
         if(zipPath != null)
         {
            _loc3_ = "";
         }
         var _loc7_:int = 0;
         while(_loc7_ < param1.Folder.length())
         {
            _loc4_ = param1.Folder[_loc7_];
            _loc8_ = 0;
            while(_loc8_ < _loc4_.Image.length())
            {
               _loc6_ = new DrawablePart();
               _loc5_ = _loc3_ + _loc4_.Name + "/" + _loc4_.Image[_loc8_].File;
               _loc6_.add(_loc5_,DrawablePart.IMG_MAIN);
               if(_loc4_.Image[_loc8_].EleMask.length() == 1)
               {
                  _loc5_ = _loc3_ + _loc4_.Name + "/" + _loc4_.Image[_loc8_].EleMask;
                  _loc6_.add(_loc5_,DrawablePart.IMG_MASK);
               }
               _loc9_ = 0;
               while(_loc9_ < _loc4_.Image[_loc8_].Textured.length())
               {
                  _loc5_ = _loc3_ + _loc4_.Name + "/" + _loc4_.Image[_loc8_].Textured[_loc9_];
                  _loc6_.add(_loc5_,DrawablePart.IMG_MAT,_loc4_.Image[_loc8_].Textured[_loc9_].@ref);
                  _loc9_++;
               }
               _loc9_ = 0;
               while(_loc9_ < _loc4_.Image[_loc8_].Def.length())
               {
                  _loc5_ = _loc4_.Image[_loc8_].Def[_loc9_].toString();
                  images[_loc5_] = _loc6_;
                  _loc9_++;
               }
               _loc8_++;
            }
            _loc7_++;
         }
      }
      
      public static function loadAll(param1:Function) : void
      {
         var _loc3_:Object = null;
         var _loc2_:GraphicsRepository = new GraphicsRepository();
         for(_loc3_ in images)
         {
            _loc2_.addRequest(_loc3_ as String);
         }
         _loc2_.process(param1);
      }
      
      public static function trim(param1:BitmapData) : BitmapData
      {
         var _loc2_:Rectangle = param1.getColorBoundsRect(4278190080,0,false);
         if(_loc2_.width == 0)
         {
            return param1;
         }
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height);
         _loc3_.copyPixels(param1,_loc2_,new Point(0,0));
         return _loc3_;
      }
      
      public static function rotate(param1:BitmapData, param2:Number) : BitmapData
      {
         var radius:int;
         var rotImg:BitmapData;
         var img:BitmapData = param1;
         var degAngle:Number = param2;
         var calcInscribedRadius:Function = function(param1:Number, param2:Number):Number
         {
            return Math.sqrt(0.5 * param1 ^ 2 + 0.5 * param2 ^ 2);
         };
         var matrix:Matrix = new Matrix();
         matrix.translate(-img.width / 2,-img.height / 2);
         matrix.rotate(degAngle * Math.PI / 180);
         radius = Math.ceil(calcInscribedRadius(img.width,img.height));
         rotImg = new BitmapData(2 * radius,2 * radius,true,0);
         matrix.translate(img.width / 2,img.height / 2);
         rotImg.draw(img,matrix);
         return rotImg;
      }
      
      public function addRequest(param1:String) : void
      {
         this.queue.push(param1);
      }
      
      public function draw(param1:String, param2:String) : BitmapData
      {
         var _loc7_:String = null;
         var _loc8_:DrawablePart = null;
         var _loc3_:Vector.<String> = DrawPriorityManager.prioritize(param1,this.queue);
         var _loc4_:String = this.extractMaterialRef(_loc3_);
         var _loc5_:BitmapData = new BitmapData(width,height,true,13434879);
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc7_ = _loc3_[_loc6_];
            _loc8_ = this.retrieve(_loc7_);
            if(_loc8_ != null)
            {
               _loc5_.draw(_loc8_.prepImage(_loc4_,param2));
            }
            _loc6_++;
         }
         this.queue = new Vector.<String>();
         return trim(_loc5_);
      }
      
      private function extractMaterialRef(param1:Vector.<String>) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = PartCollection.getPartType(_loc2_);
            if(_loc3_ == GearCalcUtil.PART_TYPE_MATERIAL)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function drawWithSockets(param1:String, param2:String, param3:String) : BitmapData
      {
         var _loc6_:DrawablePart = null;
         var _loc8_:int = 0;
         var _loc10_:DrawablePart = null;
         var _loc11_:Boolean = false;
         var _loc4_:Vector.<String> = DrawPriorityManager.prioritize(param1,this.queue);
         var _loc5_:BitmapData = new BitmapData(width,height,true,13434879);
         var _loc7_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc4_.length)
         {
            _loc10_ = this.retrieve(_loc4_[_loc8_]);
            if(_loc10_ != null)
            {
               _loc10_.prepImage(param3,param2);
               if(_loc10_.isHub)
               {
                  _loc6_ = _loc10_;
                  _loc7_ = _loc8_;
               }
            }
            _loc8_++;
         }
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc9_:BitmapData = _loc6_.createCanvas();
         _loc8_ = 0;
         while(_loc8_ < _loc4_.length)
         {
            _loc10_ = this.retrieve(_loc4_[_loc8_]);
            if(_loc10_ != null && !_loc10_.isHub)
            {
               _loc11_ = _loc8_ > _loc7_ ? true : false;
               _loc9_ = _loc6_.attach(_loc9_,_loc10_,_loc11_);
            }
            _loc8_++;
         }
         return trim(_loc9_);
      }
      
      public function process(param1:Function) : void
      {
         var loadQueue:Vector.<String> = null;
         var mat:String = null;
         var str:String = null;
         var loadNext:Function = null;
         var notifier:Function = param1;
         loadNext = function():void
         {
            if(loadQueue.length > 0)
            {
               retrieve(loadQueue.shift()).load(mat,loadNext);
            }
            else
            {
               notifier();
            }
         };
         loadQueue = new Vector.<String>();
         mat = this.extractMaterialRef(this.queue);
         for each(str in this.queue)
         {
            if(this.retrieve(str) != null && !this.retrieve(str).isLoaded(mat))
            {
               loadQueue.push(str);
            }
         }
         loadNext();
      }
      
      private function retrieve(param1:String) : DrawablePart
      {
         return images[param1] as DrawablePart;
      }
   }
}

