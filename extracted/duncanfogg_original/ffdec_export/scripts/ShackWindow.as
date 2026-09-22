package
{
   import flash.events.MouseEvent;
   import flash.system.System;
   import mx.binding.BindingManager;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import spark.components.Button;
   import spark.components.HGroup;
   import spark.components.Label;
   import spark.components.TextInput;
   import spark.components.TitleWindow;
   import spark.components.VGroup;
   import spark.layouts.HorizontalLayout;
   
   public class ShackWindow extends TitleWindow
   {
      
      private static var _skinParts:Object = {
         "contentGroup":false,
         "moveArea":false,
         "closeButton":false,
         "titleDisplay":false,
         "controlBarGroup":false
      };
      
      private var _1092797764closeBtn:Button;
      
      private var _1644780560linkInput:TextInput;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function ShackWindow()
      {
         super();
         this.width = 330;
         this.height = 120;
         this.title = "ImageShack";
         this.layout = this._ShackWindow_HorizontalLayout1_c();
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._ShackWindow_Array1_c);
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
      
      public function setLink(param1:String) : void
      {
         this.linkInput.text = param1;
      }
      
      private function close() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function _ShackWindow_HorizontalLayout1_c() : HorizontalLayout
      {
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "center";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _ShackWindow_Array1_c() : Array
      {
         var _loc1_:Array = [this._ShackWindow_VGroup1_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _ShackWindow_VGroup1_c() : VGroup
      {
         var _loc1_:VGroup = new VGroup();
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         _loc1_.horizontalAlign = "center";
         _loc1_.verticalAlign = "middle";
         _loc1_.paddingBottom = 6;
         _loc1_.mxmlContent = [this._ShackWindow_HGroup1_c(),this._ShackWindow_Button2_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _ShackWindow_HGroup1_c() : HGroup
      {
         var _loc1_:HGroup = new HGroup();
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         _loc1_.paddingLeft = 10;
         _loc1_.paddingRight = 10;
         _loc1_.paddingTop = 6;
         _loc1_.paddingBottom = 8;
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "center";
         _loc1_.mxmlContent = [this._ShackWindow_Label1_c(),this._ShackWindow_TextInput1_i(),this._ShackWindow_Button1_c()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _ShackWindow_Label1_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.text = "Link: ";
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontSize",12);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _ShackWindow_TextInput1_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.toolTip = "Click To Copy";
         _loc1_.percentWidth = 100;
         _loc1_.text = "Link";
         _loc1_.editable = false;
         _loc1_.buttonMode = false;
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.addEventListener("click",this.__linkInput_click);
         _loc1_.id = "linkInput";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.linkInput = _loc1_;
         BindingManager.executeBindings(this,"linkInput",this.linkInput);
         return _loc1_;
      }
      
      public function __linkInput_click(param1:MouseEvent) : void
      {
         System.setClipboard(this.linkInput.text);
      }
      
      private function _ShackWindow_Button1_c() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.label = "Copy";
         _loc1_.addEventListener("click",this.___ShackWindow_Button1_click);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function ___ShackWindow_Button1_click(param1:MouseEvent) : void
      {
         System.setClipboard(this.linkInput.text);
      }
      
      private function _ShackWindow_Button2_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.percentWidth = 20;
         _loc1_.label = "Close";
         _loc1_.addEventListener("click",this.__closeBtn_click);
         _loc1_.id = "closeBtn";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.closeBtn = _loc1_;
         BindingManager.executeBindings(this,"closeBtn",this.closeBtn);
         return _loc1_;
      }
      
      public function __closeBtn_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      [Bindable(event="propertyChange")]
      public function get closeBtn() : Button
      {
         return this._1092797764closeBtn;
      }
      
      public function set closeBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1092797764closeBtn;
         if(_loc2_ !== param1)
         {
            this._1092797764closeBtn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"closeBtn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get linkInput() : TextInput
      {
         return this._1644780560linkInput;
      }
      
      public function set linkInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1644780560linkInput;
         if(_loc2_ !== param1)
         {
            this._1644780560linkInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"linkInput",_loc2_,param1));
            }
         }
      }
   }
}

