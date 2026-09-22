package gearcalc.card
{
   import flash.geom.Rectangle;
   
   public class Socket
   {
      
      internal static const TYPE_ANCHOR:String = "Anchor";
      
      internal static const TYPE_BOUNDING:String = "Bounding";
      
      internal var type:String;
      
      internal var width:int;
      
      internal var height:int;
      
      internal var x:int;
      
      internal var y:int;
      
      internal var id:String;
      
      private var preparer:Function;
      
      public function Socket(param1:String)
      {
         super();
         this.id = param1;
         this.width = 0;
         this.height = 0;
         this.x = 0;
         this.y = 0;
      }
      
      internal function bounds() : Rectangle
      {
         return new Rectangle(this.x,this.y,this.width,this.height);
      }
   }
}

