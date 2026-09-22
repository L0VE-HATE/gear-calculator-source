package
{
   import gearcalc.Part;
   import mx.collections.ArrayCollection;
   
   public class NameFolder
   {
      
      public var label:String;
      
      public var children:ArrayCollection;
      
      public function NameFolder(param1:String)
      {
         super();
         this.label = param1;
         this.children = new ArrayCollection();
      }
      
      public function addName(param1:Part) : void
      {
         this.children.addItem(param1);
      }
      
      public function addNames(param1:Vector.<Part>) : void
      {
         var _loc2_:Part = null;
         for each(_loc2_ in param1)
         {
            this.children.addItem(_loc2_);
         }
      }
   }
}

