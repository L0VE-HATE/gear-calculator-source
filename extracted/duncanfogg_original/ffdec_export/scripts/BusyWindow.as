package
{
   import mx.binding.BindingManager;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.events.PropertyChangeEvent;
   import spark.components.Label;
   import spark.components.TitleWindow;
   
   public class BusyWindow extends TitleWindow
   {
      
      private static var _skinParts:Object = {
         "contentGroup":false,
         "moveArea":false,
         "closeButton":false,
         "titleDisplay":false,
         "controlBarGroup":false
      };
      
      private var _269142853mainLabel:Label;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function BusyWindow()
      {
         super();
         this.width = 200;
         this.height = 110;
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._BusyWindow_Array1_c);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      public function changeText(param1:String) : void
      {
         this.mainLabel.text = param1;
      }
      
      private function _BusyWindow_Array1_c() : Array
      {
         var _loc1_:Array = [this._BusyWindow_Label1_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _BusyWindow_Label1_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.text = "Calculating...";
         _loc1_.x = 36;
         _loc1_.y = 24;
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.id = "mainLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.mainLabel = _loc1_;
         BindingManager.executeBindings(this,"mainLabel",this.mainLabel);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get mainLabel() : Label
      {
         return this._269142853mainLabel;
      }
      
      public function set mainLabel(param1:Label) : void
      {
         var _loc2_:Object = this._269142853mainLabel;
         if(_loc2_ !== param1)
         {
            this._269142853mainLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainLabel",_loc2_,param1));
            }
         }
      }
   }
}

