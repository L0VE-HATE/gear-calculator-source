package gearcalc.export
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import gearcalc.card.CardPainter;
   import mx.graphics.codec.PNGEncoder;
   
   public class ImageEntry
   {
      
      public var destination:String;
      
      public var filename:String;
      
      public var extension:String;
      
      public var data:BitmapData;
      
      public var imageSrc:CardPainter;
      
      public function ImageEntry()
      {
         super();
         this.extension = ".png";
      }
      
      public function getFilename() : String
      {
         if(this.filename.toLowerCase().indexOf(this.extension.toLowerCase()) == -1)
         {
            return this.filename + this.extension;
         }
         return this.filename;
      }
      
      public function encode() : ByteArray
      {
         var _loc1_:PNGEncoder = new PNGEncoder();
         return _loc1_.encode(this.data);
      }
      
      public function format(param1:Function) : void
      {
         var onPainted:Function = null;
         var onDelay:Function = null;
         var listener:Function = param1;
         onPainted = function(param1:Bitmap):void
         {
            listener(imageSrc.unscaledImg);
         };
         onDelay = function():void
         {
            listener(imageSrc.unscaledImg);
         };
         if(this.data != null)
         {
            listener(this.data);
            return;
         }
         if(this.imageSrc != null)
         {
            if(this.imageSrc.unscaledImg != null)
            {
               this.doLater(onDelay,10);
            }
            else
            {
               this.imageSrc.paint(onPainted);
            }
            return;
         }
         listener(null);
      }
      
      private function doLater(param1:Function, param2:int) : void
      {
         var timer:Timer = null;
         var timerDone:Function = null;
         var func:Function = param1;
         var milliDelay:int = param2;
         timerDone = function(param1:Event):void
         {
            timer.stop();
            func();
         };
         timer = new Timer(milliDelay);
         timer.addEventListener(TimerEvent.TIMER,timerDone);
         timer.start();
      }
   }
}

