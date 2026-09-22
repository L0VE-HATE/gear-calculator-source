package gearcalc.card
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import gearcalc.GearCalcUtil;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipError;
   import nochump.util.zip.ZipFile;
   
   public class DrawablePart
   {
      
      internal static var zipLib:ZipFile;
      
      public static var canvasWidth:int = 300;
      
      public static var canvasHeight:int = 200;
      
      internal static const IMG_MASK:String = "Elemental Mask";
      
      internal static const IMG_MAT:String = "Material Version";
      
      internal static const IMG_MAIN:String = "BaseImage";
      
      internal var image:BitmapData;
      
      internal var materialized:Dictionary;
      
      internal var mask:BitmapData;
      
      internal var x:int;
      
      internal var y:int;
      
      internal var width:int;
      
      internal var height:int;
      
      internal var isHub:Boolean;
      
      internal var anchor:Socket;
      
      private var ports:Dictionary;
      
      private var paths:Dictionary;
      
      private var current:BitmapData = null;
      
      public function DrawablePart()
      {
         super();
         this.isHub = false;
         this.ports = new Dictionary();
         this.paths = new Dictionary();
         this.materialized = new Dictionary();
         this.x = 0;
         this.y = 0;
         this.width = 0;
         this.height = 0;
      }
      
      private static function fitToBox(param1:BitmapData, param2:Rectangle, param3:Boolean = false, param4:Rectangle = null) : BitmapData
      {
         var _loc9_:Number = NaN;
         var _loc5_:Number = param1.width > param2.width ? param2.width / param1.width : param1.width / param2.width;
         var _loc6_:Number = param1.height > param2.height ? param2.height / param1.height : param1.height / param2.height;
         if(param4 != null)
         {
            _loc5_ = param4.width > param2.width ? param2.width / param4.width : param4.width / param2.width;
            _loc6_ = param4.height > param2.height ? param2.height / param4.height : param4.height / param2.height;
         }
         var _loc7_:BitmapData = new BitmapData(param2.width,param2.height,true,0);
         var _loc8_:Matrix = new Matrix();
         if(param3)
         {
            _loc9_ = _loc5_ < _loc6_ ? _loc5_ : _loc6_;
            _loc8_.scale(_loc9_,_loc9_);
            _loc7_ = new BitmapData(param1.width * _loc9_,param1.height * _loc9_,true,0);
         }
         else
         {
            _loc8_.scale(_loc5_,_loc6_);
         }
         _loc7_.draw(param1,_loc8_);
         return _loc7_;
      }
      
      private static function drawCentered(param1:BitmapData, param2:BitmapData, param3:Number = 1, param4:Number = 1) : void
      {
         var _loc5_:Matrix = new Matrix(1,0,0,1,(param1.width - param2.width) / 2,(param1.height - param2.height) / 2);
         _loc5_.scale(param3,param4);
         param1.draw(param2,_loc5_);
      }
      
      internal function setAnchor(param1:int, param2:int, param3:String) : void
      {
         this.anchor = new Socket(param3);
         this.anchor.x = param1;
         this.anchor.y = param2;
      }
      
      internal function addSocket(param1:Socket) : void
      {
         this.ports[param1.id] = param1;
      }
      
      internal function getPreppedImage() : BitmapData
      {
         var _loc1_:BitmapData = this.current;
         this.current = null;
         return _loc1_;
      }
      
      internal function prepImage(param1:String, param2:String) : BitmapData
      {
         var _loc4_:BitmapData = null;
         var _loc3_:BitmapData = new BitmapData(this.image.width,this.image.height,true,0);
         if(this.materialized[param1] != null)
         {
            _loc3_.draw(this.materialized[param1] as BitmapData);
         }
         else
         {
            _loc3_.draw(this.image);
         }
         if(param2 != null && param2 != "" && this.mask != null)
         {
            _loc4_ = new BitmapData(this.mask.width,this.mask.height,true,0);
            _loc4_.draw(this.mask);
            this.changeElementalColor(_loc4_,this.calcAverageColor(_loc4_),this.resolveMaskColor(param2));
            _loc3_.draw(_loc4_);
         }
         this.current = _loc3_;
         return _loc3_;
      }
      
      internal function createCanvas() : BitmapData
      {
         if(this.current == null)
         {
            return null;
         }
         var _loc1_:BitmapData = new BitmapData(canvasWidth,canvasHeight);
         var _loc2_:Matrix = new Matrix(1,0,0,1,_loc1_.width / 2 - this.anchor.x,_loc1_.height / 2 - this.anchor.y);
         _loc1_.draw(this.current,_loc2_);
         return _loc1_;
      }
      
      internal function attach(param1:BitmapData, param2:DrawablePart, param3:Boolean) : BitmapData
      {
         var prepped:BitmapData = null;
         var img:BitmapData = null;
         var offsetX:Number = NaN;
         var offsetY:Number = NaN;
         var port:Socket = null;
         var matrix:Matrix = null;
         var canvas:BitmapData = param1;
         var arm:DrawablePart = param2;
         var armOnTop:Boolean = param3;
         var isProper:Function = function():Boolean
         {
            if(arm.anchor.x > 0 && arm.anchor.x < prepped.width && arm.anchor.y > 0 && arm.anchor.y < prepped.height)
            {
               return true;
            }
            return false;
         };
         prepped = arm.getPreppedImage();
         if(this.isHub && prepped != null && this.current != null && this.ports[arm.anchor.id] != null)
         {
            img = new BitmapData(canvas.width,canvas.height,true,0);
            offsetX = (canvas.width - this.current.width) / 2;
            offsetY = (canvas.height - this.current.height) / 2;
            port = this.ports[arm.anchor.id] as Socket;
            matrix = new Matrix();
            if(port.type == Socket.TYPE_ANCHOR && Boolean(isProper()))
            {
               matrix.translate(port.x - arm.anchor.x + offsetX,port.y - arm.anchor.y + offsetY);
            }
            else if(port.type == Socket.TYPE_BOUNDING)
            {
               if(arm.anchor.width > 0 && arm.anchor.height > 0)
               {
                  prepped = fitToBox(prepped,port.bounds(),arm.anchor.bounds());
                  matrix.translate(offsetX + port.x - arm.anchor.width,offsetY + port.y - arm.anchor.height);
               }
               else
               {
                  prepped = fitToBox(prepped,port.bounds());
                  matrix.translate(offsetX + port.x,offsetY + port.y);
               }
            }
            if(armOnTop)
            {
               img.draw(canvas);
               img.draw(prepped,matrix);
            }
            else
            {
               img.draw(prepped,matrix);
               img.draw(canvas);
            }
            return img;
         }
         return null;
      }
      
      private function resolveMaskColor(param1:String) : uint
      {
         var _loc2_:uint = GraphicsRepository.MASK_UNTOUCHED;
         if(param1 == GearCalcUtil.TECH_CORROSIVE)
         {
            _loc2_ = GraphicsRepository.MASK_CORROSIVE;
         }
         else if(param1 == GearCalcUtil.TECH_INCENDIARY)
         {
            _loc2_ = uint(GraphicsRepository.MASK_INCENDIARY);
         }
         else if(param1 == GearCalcUtil.TECH_SHOCK)
         {
            _loc2_ = GraphicsRepository.MASK_SHOCK;
         }
         else if(param1 == GearCalcUtil.TECH_EXPLOSIVE)
         {
            _loc2_ = GraphicsRepository.MASK_EXPLOSIVE;
         }
         return _loc2_;
      }
      
      private function changeElementalColor(param1:BitmapData, param2:uint, param3:uint) : void
      {
         var _loc4_:int = 1;
         var _loc5_:ColorTransform = new ColorTransform();
         var _loc6_:ColorTransform = new ColorTransform();
         _loc5_.color = param2;
         _loc6_.color = param3;
         var _loc7_:ColorTransform = new ColorTransform();
         _loc7_.redMultiplier = _loc5_.redMultiplier + (_loc6_.redMultiplier - _loc5_.redMultiplier) * _loc4_;
         _loc7_.greenMultiplier = _loc5_.greenMultiplier + (_loc6_.greenMultiplier - _loc5_.greenMultiplier) * _loc4_;
         _loc7_.blueMultiplier = _loc5_.blueMultiplier + (_loc6_.blueMultiplier - _loc5_.blueMultiplier) * _loc4_;
         _loc7_.redOffset = _loc5_.redOffset + (_loc6_.redOffset - _loc5_.redOffset) * _loc4_;
         _loc7_.greenOffset = _loc5_.greenOffset + (_loc6_.greenOffset - _loc5_.greenOffset) * _loc4_;
         _loc7_.blueOffset += (_loc6_.blueOffset - _loc5_.blueOffset) * _loc4_;
         param1.colorTransform(new Rectangle(0,0,this.mask.width,this.mask.height),_loc7_);
      }
      
      private function calcAverageColor(param1:BitmapData) : uint
      {
         var _loc6_:Number = NaN;
         var _loc8_:int = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         while(_loc7_ < param1.width)
         {
            _loc8_ = 0;
            while(_loc8_ < param1.height)
            {
               _loc6_ = param1.getPixel32(_loc7_,_loc8_);
               if((_loc6_ >> 24 & 0xFF) > 0)
               {
                  _loc2_ += _loc6_ >> 16 & 0xFF;
                  _loc3_ += _loc6_ >> 8 & 0xFF;
                  _loc4_ += _loc6_ & 0xFF;
                  _loc5_ += 1;
               }
               _loc8_++;
            }
            _loc7_++;
         }
         _loc2_ /= _loc5_;
         _loc3_ /= _loc5_;
         _loc4_ /= _loc5_;
         return _loc2_ << 16 | _loc3_ << 8 | _loc4_;
      }
      
      internal function add(param1:String, param2:String, param3:String = null) : void
      {
         var _loc4_:MaterialEntry = null;
         if(param2 == IMG_MAT)
         {
            if(this.paths[param1] != null && this.paths[param1] is MaterialEntry)
            {
               _loc4_ = this.paths[param1] as MaterialEntry;
               _loc4_.refs.push(param3);
            }
            else
            {
               _loc4_ = new MaterialEntry();
               _loc4_.path = param1;
               if(param3 != null && param3.length > 0)
               {
                  _loc4_.refs.push(param3);
               }
               this.paths[param1] = _loc4_;
            }
         }
         else
         {
            this.paths[param1] = param2;
         }
      }
      
      internal function isLoaded(param1:String) : Boolean
      {
         if(param1 != null && this.materialized[param1] != null)
         {
            return true;
         }
         if(param1 == null && this.image != null)
         {
            return true;
         }
         return false;
      }
      
      internal function load(param1:String, param2:Function) : void
      {
         var queue:Vector.<String> = null;
         var key:Object = null;
         var onLoad:Function = null;
         var keyStr:String = null;
         var entry:MaterialEntry = null;
         var matRef:String = param1;
         var extListener:Function = param2;
         onLoad = function(param1:Bitmap, param2:String):void
         {
            var _loc3_:MaterialEntry = null;
            var _loc4_:String = null;
            if(param2 == IMG_MAIN)
            {
               image = param1.bitmapData;
            }
            else if(param2 == IMG_MASK)
            {
               mask = param1.bitmapData;
            }
            else
            {
               _loc3_ = paths[param2] as MaterialEntry;
               for each(_loc4_ in _loc3_.refs)
               {
                  if(_loc4_ != null)
                  {
                     materialized[_loc4_] = param1.bitmapData;
                  }
               }
            }
            load();
         };
         var load:Function = function():void
         {
            var _loc1_:String = null;
            var _loc2_:String = null;
            if(queue.length > 0)
            {
               _loc1_ = queue.shift();
               _loc2_ = paths[_loc1_] is MaterialEntry ? _loc1_ : paths[_loc1_] as String;
               loadImage(_loc1_,_loc2_,onLoad);
            }
            else
            {
               extListener();
            }
         };
         if(this.isLoaded(matRef))
         {
            extListener();
            return;
         }
         queue = new Vector.<String>();
         for(key in this.paths)
         {
            keyStr = key as String;
            if(matRef != null && this.paths[keyStr] != null && this.paths[keyStr] is MaterialEntry)
            {
               entry = this.paths[keyStr] as MaterialEntry;
               if(entry.isMatSupported(matRef))
               {
                  queue.push(keyStr);
               }
            }
            if(this.paths[keyStr] == IMG_MAIN)
            {
               queue.push(keyStr);
            }
            if(this.mask == null && this.paths[keyStr] == IMG_MASK)
            {
               queue.push(keyStr);
            }
         }
         load();
      }
      
      private function loadImage(param1:String, param2:String, param3:Function) : void
      {
         var loader:Loader = null;
         var notify:Function = null;
         var entry:ZipEntry = null;
         var data:ByteArray = null;
         var path:String = param1;
         var type:String = param2;
         var notifier:Function = param3;
         notify = function(param1:Event):void
         {
            notifier(loader.content,type);
         };
         try
         {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,notify);
            if(zipLib != null)
            {
               entry = zipLib.getEntry(path);
               data = zipLib.getInput(entry);
               loader.loadBytes(data);
            }
            else
            {
               loader.load(new URLRequest(path));
            }
         }
         catch(err:IOErrorEvent)
         {
            trace("Error loading: " + path);
         }
         catch(zipErr:ZipError)
         {
            trace("Zip error");
         }
      }
      
      internal function setImage(param1:BitmapData) : void
      {
         this.image = param1;
         this.width = param1.width;
         this.height = param1.height;
      }
      
      internal function addMaterialized(param1:BitmapData, param2:String) : void
      {
         this.materialized[param2] = param1;
      }
      
      internal function getMaterialized(param1:String) : BitmapData
      {
         return this.materialized[param1] as BitmapData;
      }
   }
}

