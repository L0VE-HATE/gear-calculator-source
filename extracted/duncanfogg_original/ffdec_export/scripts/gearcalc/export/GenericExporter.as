package gearcalc.export
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import mx.graphics.codec.PNGEncoder;
   
   public class GenericExporter extends EventDispatcher implements Exporter
   {
      
      protected static const PNG_TYPE:String = "image/png";
      
      protected static const SINGLE:String = "Single";
      
      protected static const BULK:String = "Bulk";
      
      protected var queue:Vector.<ImageEntry>;
      
      protected var type:String;
      
      protected var success:Boolean;
      
      protected var result:Dictionary;
      
      private var active:Boolean;
      
      private var total:int;
      
      private var count:int;
      
      private var keepGoing:Boolean;
      
      public function GenericExporter(param1:String)
      {
         super();
         this.type = param1;
         this.queue = new Vector.<ImageEntry>();
         this.result = new Dictionary();
         this.success = false;
         this.active = false;
         this.keepGoing = true;
         this.count = 0;
         this.total = 0;
      }
      
      public function abort() : void
      {
         this.keepGoing = false;
      }
      
      public function isActive() : Boolean
      {
         return this.active;
      }
      
      public function getTotal() : int
      {
         return this.total;
      }
      
      public function getProgress() : int
      {
         return this.count;
      }
      
      public function push(param1:ImageEntry) : void
      {
         if(this.type == SINGLE)
         {
            this.queue = new Vector.<ImageEntry>();
            this.queue.push(param1);
         }
         else
         {
            this.queue.push(param1);
         }
         ++this.total;
      }
      
      public function isSuccessful() : Boolean
      {
         return this.success;
      }
      
      public function export() : void
      {
         var current:ImageEntry = null;
         var onFormatted:Function = null;
         var onCallback:Function = null;
         onFormatted = function(param1:BitmapData):void
         {
            var _loc2_:PNGEncoder = new PNGEncoder();
            doExport(_loc2_.encode(param1),current.getFilename(),PNG_TYPE,onCallback);
         };
         onCallback = function():void
         {
            if(!keepGoing)
            {
               return;
            }
            if(queue.length > 0)
            {
               ++count;
               notifyProgress();
               export();
            }
            else
            {
               postProcess();
               notifyCompletion();
            }
         };
         if(!this.keepGoing)
         {
            return;
         }
         this.active = true;
         if(this.queue.length > 0)
         {
            current = this.queue.shift();
            current.format(onFormatted);
         }
         else
         {
            this.notifyCompletion();
         }
      }
      
      protected function doExport(param1:ByteArray, param2:String, param3:String, param4:Function) : void
      {
         param4();
      }
      
      public function getResult() : Dictionary
      {
         return this.result;
      }
      
      protected function postProcess() : void
      {
      }
      
      protected function notifyCompletion() : void
      {
         this.active = false;
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      protected function notifyProgress() : void
      {
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function addProgressListener(param1:Function) : void
      {
         this.addEventListener(Event.CHANGE,param1);
      }
      
      public function addCompletionListener(param1:Function) : void
      {
         this.addEventListener(Event.COMPLETE,param1);
      }
   }
}

