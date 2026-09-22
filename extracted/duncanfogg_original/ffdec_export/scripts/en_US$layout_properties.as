package
{
   import mx.resources.ResourceBundle;
   
   public class en_US$layout_properties extends ResourceBundle
   {
      
      public function en_US$layout_properties()
      {
         super("en_US","layout");
      }
      
      override protected function getContent() : Object
      {
         return {
            "basicLayoutNotVirtualized":"BasicLayout doesn\'t support virtualization.",
            "invalidIndex":"invalidIndex"
         };
      }
   }
}

