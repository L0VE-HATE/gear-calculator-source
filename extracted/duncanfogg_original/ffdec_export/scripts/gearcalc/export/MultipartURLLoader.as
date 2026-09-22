package gearcalc.export
{
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   
   public class MultipartURLLoader extends EventDispatcher
   {
      
      public static var BLOCK_SIZE:uint = 64 * 1024;
      
      public var _loader:URLLoader;
      
      private var _boundary:String;
      
      private var _variableNames:Array;
      
      private var _fileNames:Array;
      
      private var _variables:Dictionary;
      
      private var _files:Dictionary;
      
      private var _async:Boolean = false;
      
      private var _path:String;
      
      private var _data:ByteArray;
      
      private var _prepared:Boolean = false;
      
      private var asyncWriteTimeoutId:Number;
      
      private var asyncFilePointer:uint = 0;
      
      private var totalFilesSize:uint = 0;
      
      private var writtenBytes:uint = 0;
      
      public var requestHeaders:Array;
      
      public function MultipartURLLoader()
      {
         super();
         this._fileNames = new Array();
         this._files = new Dictionary();
         this._variableNames = new Array();
         this._variables = new Dictionary();
         this._loader = new URLLoader();
         this.requestHeaders = new Array();
      }
      
      public function load(param1:String, param2:Boolean = false) : void
      {
         if(param1 == null || param1 == "")
         {
            throw new IllegalOperationError("You cant load without specifing PATH");
         }
         this._path = param1;
         this._async = param2;
         if(this._async)
         {
            if(!this._prepared)
            {
               this.constructPostDataAsync();
            }
            else
            {
               this.doSend();
            }
         }
         else
         {
            this._data = this.constructPostData();
            this.doSend();
         }
      }
      
      public function startLoad() : void
      {
         if(this._path == null || this._path == "" || this._async == false)
         {
            throw new IllegalOperationError("You can use this method only if loading asynchronous.");
         }
         if(!this._prepared && this._async)
         {
            throw new IllegalOperationError("You should prepare data before sending when using asynchronous.");
         }
         this.doSend();
      }
      
      public function prepareData() : void
      {
         this.constructPostDataAsync();
      }
      
      public function close() : void
      {
         try
         {
            this._loader.close();
         }
         catch(e:Error)
         {
         }
      }
      
      public function addVariable(param1:String, param2:Object = "") : void
      {
         if(this._variableNames.indexOf(param1) == -1)
         {
            this._variableNames.push(param1);
         }
         this._variables[param1] = param2;
         this._prepared = false;
      }
      
      public function addFile(param1:ByteArray, param2:String, param3:String = "Filedata", param4:String = "application/octet-stream") : void
      {
         var _loc5_:FilePart = null;
         if(this._fileNames.indexOf(param2) == -1)
         {
            this._fileNames.push(param2);
            this._files[param2] = new FilePart(param1,param2,param3,param4);
            this.totalFilesSize += param1.length;
         }
         else
         {
            _loc5_ = this._files[param2] as FilePart;
            this.totalFilesSize -= _loc5_.fileContent.length;
            _loc5_.fileContent = param1;
            _loc5_.fileName = param2;
            _loc5_.dataField = param3;
            _loc5_.contentType = param4;
            this.totalFilesSize += param1.length;
         }
         this._prepared = false;
      }
      
      public function clearVariables() : void
      {
         this._variableNames = new Array();
         this._variables = new Dictionary();
         this._prepared = false;
      }
      
      public function clearFiles() : void
      {
         var _loc1_:String = null;
         for each(_loc1_ in this._fileNames)
         {
            (this._files[_loc1_] as FilePart).dispose();
         }
         this._fileNames = new Array();
         this._files = new Dictionary();
         this.totalFilesSize = 0;
         this._prepared = false;
      }
      
      public function dispose() : void
      {
         clearInterval(this.asyncWriteTimeoutId);
         this.removeListener();
         this.close();
         this._loader = null;
         this._boundary = null;
         this._variableNames = null;
         this._variables = null;
         this._fileNames = null;
         this._files = null;
         this.requestHeaders = null;
         this._data = null;
      }
      
      public function getBoundary() : String
      {
         var _loc1_:int = 0;
         if(this._boundary == null)
         {
            this._boundary = "";
            _loc1_ = 0;
            while(_loc1_ < 32)
            {
               this._boundary += String.fromCharCode(int(97 + Math.random() * 25));
               _loc1_++;
            }
         }
         return this._boundary;
      }
      
      public function get ASYNC() : Boolean
      {
         return this._async;
      }
      
      public function get PREPARED() : Boolean
      {
         return this._prepared;
      }
      
      public function get dataFormat() : String
      {
         return this._loader.dataFormat;
      }
      
      public function set dataFormat(param1:String) : void
      {
         if(param1 != URLLoaderDataFormat.BINARY && param1 != URLLoaderDataFormat.TEXT && param1 != URLLoaderDataFormat.VARIABLES)
         {
            throw new IllegalOperationError("Illegal URLLoader Data Format");
         }
         this._loader.dataFormat = param1;
      }
      
      public function get loader() : URLLoader
      {
         return this._loader;
      }
      
      private function doSend() : void
      {
         var _loc1_:URLRequest = new URLRequest();
         _loc1_.url = this._path;
         _loc1_.method = URLRequestMethod.POST;
         _loc1_.data = this._data;
         _loc1_.requestHeaders.push(new URLRequestHeader("Content-type","multipart/form-data; boundary=" + this.getBoundary()));
         if(this.requestHeaders.length)
         {
            _loc1_.requestHeaders = _loc1_.requestHeaders.concat(this.requestHeaders);
         }
         this.addListener();
         this._loader.load(_loc1_);
      }
      
      private function constructPostDataAsync() : void
      {
         clearInterval(this.asyncWriteTimeoutId);
         this._data = new ByteArray();
         this._data.endian = Endian.BIG_ENDIAN;
         this._data = this.constructVariablesPart(this._data);
         this.asyncFilePointer = 0;
         this.writtenBytes = 0;
         this._prepared = false;
         if(this._fileNames.length)
         {
            this.nextAsyncLoop();
         }
         else
         {
            this._data = this.closeDataObject(this._data);
            this._prepared = true;
            dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE));
         }
      }
      
      private function constructPostData() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.endian = Endian.BIG_ENDIAN;
         _loc1_ = this.constructVariablesPart(_loc1_);
         _loc1_ = this.constructFilesPart(_loc1_);
         return this.closeDataObject(_loc1_);
      }
      
      private function closeDataObject(param1:ByteArray) : ByteArray
      {
         param1 = this.BOUNDARY(param1);
         return this.DOUBLEDASH(param1);
      }
      
      private function constructVariablesPart(param1:ByteArray) : ByteArray
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         for each(_loc4_ in this._variableNames)
         {
            param1 = this.BOUNDARY(param1);
            param1 = this.LINEBREAK(param1);
            _loc3_ = "Content-Disposition: form-data; name=\"" + _loc4_ + "\"";
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               param1.writeByte(_loc3_.charCodeAt(_loc2_));
               _loc2_++;
            }
            param1 = this.LINEBREAK(param1);
            param1 = this.LINEBREAK(param1);
            param1.writeUTFBytes(this._variables[_loc4_]);
            param1 = this.LINEBREAK(param1);
         }
         return param1;
      }
      
      private function constructFilesPart(param1:ByteArray) : ByteArray
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(this._fileNames.length)
         {
            for each(_loc4_ in this._fileNames)
            {
               param1 = this.getFilePartHeader(param1,this._files[_loc4_] as FilePart);
               param1 = this.getFilePartData(param1,this._files[_loc4_] as FilePart);
               param1 = this.LINEBREAK(param1);
            }
            param1 = this.closeFilePartsData(param1);
         }
         return param1;
      }
      
      private function closeFilePartsData(param1:ByteArray) : ByteArray
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         param1 = this.LINEBREAK(param1);
         param1 = this.BOUNDARY(param1);
         param1 = this.LINEBREAK(param1);
         _loc3_ = "Content-Disposition: form-data; name=\"Upload\"";
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            param1.writeByte(_loc3_.charCodeAt(_loc2_));
            _loc2_++;
         }
         param1 = this.LINEBREAK(param1);
         param1 = this.LINEBREAK(param1);
         _loc3_ = "Submit Query";
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            param1.writeByte(_loc3_.charCodeAt(_loc2_));
            _loc2_++;
         }
         return this.LINEBREAK(param1);
      }
      
      private function getFilePartHeader(param1:ByteArray, param2:FilePart) : ByteArray
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         param1 = this.BOUNDARY(param1);
         param1 = this.LINEBREAK(param1);
         _loc4_ = "Content-Disposition: form-data; name=\"Filename\"";
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            param1.writeByte(_loc4_.charCodeAt(_loc3_));
            _loc3_++;
         }
         param1 = this.LINEBREAK(param1);
         param1 = this.LINEBREAK(param1);
         param1.writeUTFBytes(param2.fileName);
         param1 = this.LINEBREAK(param1);
         param1 = this.BOUNDARY(param1);
         param1 = this.LINEBREAK(param1);
         _loc4_ = "Content-Disposition: form-data; name=\"" + param2.dataField + "\"; filename=\"";
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            param1.writeByte(_loc4_.charCodeAt(_loc3_));
            _loc3_++;
         }
         param1.writeUTFBytes(param2.fileName);
         param1 = this.QUOTATIONMARK(param1);
         param1 = this.LINEBREAK(param1);
         _loc4_ = "Content-Type: " + param2.contentType;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            param1.writeByte(_loc4_.charCodeAt(_loc3_));
            _loc3_++;
         }
         param1 = this.LINEBREAK(param1);
         return this.LINEBREAK(param1);
      }
      
      private function getFilePartData(param1:ByteArray, param2:FilePart) : ByteArray
      {
         param1.writeBytes(param2.fileContent,0,param2.fileContent.length);
         return param1;
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onComplete(param1:Event) : void
      {
         this.removeListener();
         dispatchEvent(param1);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         this.removeListener();
         dispatchEvent(param1);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         this.removeListener();
         dispatchEvent(param1);
      }
      
      private function onHTTPStatus(param1:HTTPStatusEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function addListener() : void
      {
         this._loader.addEventListener(Event.COMPLETE,this.onComplete,false,0,false);
         this._loader.addEventListener(ProgressEvent.PROGRESS,this.onProgress,false,0,false);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError,false,0,false);
         this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus,false,0,false);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError,false,0,false);
      }
      
      private function removeListener() : void
      {
         this._loader.removeEventListener(Event.COMPLETE,this.onComplete);
         this._loader.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus);
         this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
      }
      
      private function BOUNDARY(param1:ByteArray) : ByteArray
      {
         var _loc2_:int = this.getBoundary().length;
         param1 = this.DOUBLEDASH(param1);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.writeByte(this._boundary.charCodeAt(_loc3_));
            _loc3_++;
         }
         return param1;
      }
      
      private function LINEBREAK(param1:ByteArray) : ByteArray
      {
         param1.writeShort(3338);
         return param1;
      }
      
      private function QUOTATIONMARK(param1:ByteArray) : ByteArray
      {
         param1.writeByte(34);
         return param1;
      }
      
      private function DOUBLEDASH(param1:ByteArray) : ByteArray
      {
         param1.writeShort(11565);
         return param1;
      }
      
      private function nextAsyncLoop() : void
      {
         var _loc1_:FilePart = null;
         if(this.asyncFilePointer < this._fileNames.length)
         {
            _loc1_ = this._files[this._fileNames[this.asyncFilePointer]] as FilePart;
            this._data = this.getFilePartHeader(this._data,_loc1_);
            this.asyncWriteTimeoutId = setTimeout(this.writeChunkLoop,10,this._data,_loc1_.fileContent,0);
            ++this.asyncFilePointer;
         }
         else
         {
            this._data = this.closeFilePartsData(this._data);
            this._data = this.closeDataObject(this._data);
            this._prepared = true;
            dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS,this.totalFilesSize,this.totalFilesSize));
            dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE));
         }
      }
      
      private function writeChunkLoop(param1:ByteArray, param2:ByteArray, param3:uint = 0) : void
      {
         var _loc4_:uint = Math.min(BLOCK_SIZE,param2.length - param3);
         param1.writeBytes(param2,param3,_loc4_);
         if(_loc4_ < BLOCK_SIZE || param3 + _loc4_ >= param2.length)
         {
            param1 = this.LINEBREAK(param1);
            this.nextAsyncLoop();
            return;
         }
         param3 += _loc4_;
         this.writtenBytes += _loc4_;
         if(this.writtenBytes % BLOCK_SIZE * 2 == 0)
         {
            dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS,this.writtenBytes,this.totalFilesSize));
         }
         this.asyncWriteTimeoutId = setTimeout(this.writeChunkLoop,10,param1,param2,param3);
      }
   }
}

import flash.utils.ByteArray;

class FilePart
{
   
   public var fileContent:ByteArray;
   
   public var fileName:String;
   
   public var dataField:String;
   
   public var contentType:String;
   
   public function FilePart(param1:ByteArray, param2:String, param3:String = "Filedata", param4:String = "application/octet-stream")
   {
      super();
      this.fileContent = param1;
      this.fileName = param2;
      this.dataField = param3;
      this.contentType = param4;
   }
   
   public function dispose() : void
   {
      this.fileContent = null;
      this.fileName = null;
      this.dataField = null;
      this.contentType = null;
   }
}
