package gearcalc.card
{
   public class MaterialEntry
   {
      
      internal var path:String;
      
      internal var refs:Vector.<String>;
      
      public function MaterialEntry()
      {
         super();
         this.refs = new Vector.<String>();
      }
      
      internal function addMatRef(param1:String) : void
      {
         this.refs.push(param1);
      }
      
      internal function isMatSupported(param1:String) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in this.refs)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      internal function length() : int
      {
         return this.refs.length;
      }
   }
}

