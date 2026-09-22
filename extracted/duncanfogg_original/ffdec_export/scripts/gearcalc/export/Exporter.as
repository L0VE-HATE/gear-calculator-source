package gearcalc.export
{
   import flash.utils.Dictionary;
   
   public interface Exporter
   {
      
      function push(param1:ImageEntry) : void;
      
      function export() : void;
      
      function isSuccessful() : Boolean;
      
      function addProgressListener(param1:Function) : void;
      
      function addCompletionListener(param1:Function) : void;
      
      function getResult() : Dictionary;
      
      function getTotal() : int;
   }
}

