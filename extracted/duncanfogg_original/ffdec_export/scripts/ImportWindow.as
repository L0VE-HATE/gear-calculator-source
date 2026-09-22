package
{
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.styles.*;
   import spark.components.Button;
   import spark.components.Label;
   import spark.components.TextArea;
   import spark.components.TitleWindow;
   
   public class ImportWindow extends TitleWindow
   {
      
      private static var _skinParts:Object = {
         "contentGroup":false,
         "moveArea":false,
         "closeButton":false,
         "titleDisplay":false,
         "controlBarGroup":false
      };
      
      private var _917511744pasteArea:TextArea;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var goAhead:Boolean = true;
      
      public function ImportWindow()
      {
         super();
         this.width = 500;
         this.height = 300;
         this.mouseEnabled = true;
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._ImportWindow_Array1_c);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.skinClass = FixSkin;
         };
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      public function getCode() : String
      {
         return this.pasteArea.text;
      }
      
      public function isProceed() : Boolean
      {
         return this.goAhead;
      }
      
      private function doClose(param1:Boolean) : void
      {
         this.goAhead = param1;
         this.dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function _ImportWindow_Array1_c() : Array
      {
         var _loc1_:Array = [this._ImportWindow_TextArea1_i(),this._ImportWindow_Button1_c(),this._ImportWindow_Button2_c(),this._ImportWindow_Button3_c(),this._ImportWindow_Label1_c(),this._ImportWindow_Label2_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _ImportWindow_TextArea1_i() : TextArea
      {
         var _loc1_:TextArea = new TextArea();
         _loc1_.y = 10;
         _loc1_.percentWidth = 96;
         _loc1_.height = 209;
         _loc1_.editable = true;
         _loc1_.mouseEnabled = true;
         _loc1_.horizontalCenter = 0;
         _loc1_.setStyle("fontSize",12);
         _loc1_.id = "pasteArea";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.pasteArea = _loc1_;
         BindingManager.executeBindings(this,"pasteArea",this.pasteArea);
         return _loc1_;
      }
      
      private function _ImportWindow_Button1_c() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.y = 235;
         _loc1_.label = "Clear";
         _loc1_.horizontalCenter = 0;
         _loc1_.percentWidth = 20;
         _loc1_.addEventListener("click",this.___ImportWindow_Button1_click);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function ___ImportWindow_Button1_click(param1:MouseEvent) : void
      {
         this.pasteArea.text = "";
      }
      
      private function _ImportWindow_Button2_c() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.y = 235;
         _loc1_.label = "Cancel";
         _loc1_.horizontalCenter = -170;
         _loc1_.percentWidth = 20;
         _loc1_.addEventListener("click",this.___ImportWindow_Button2_click);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function ___ImportWindow_Button2_click(param1:MouseEvent) : void
      {
         this.doClose(false);
      }
      
      private function _ImportWindow_Button3_c() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.y = 235;
         _loc1_.label = "Accept";
         _loc1_.horizontalCenter = 170;
         _loc1_.percentWidth = 20;
         _loc1_.addEventListener("click",this.___ImportWindow_Button3_click);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function ___ImportWindow_Button3_click(param1:MouseEvent) : void
      {
         this.doClose(true);
      }
      
      private function _ImportWindow_Label1_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 31;
         _loc1_.y = -22;
         _loc1_.text = "Import Gear:";
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("fontWeight","bold");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _ImportWindow_Label2_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 140;
         _loc1_.y = -22;
         _loc1_.text = "Paste code into text area below";
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("fontSize",14);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get pasteArea() : TextArea
      {
         return this._917511744pasteArea;
      }
      
      public function set pasteArea(param1:TextArea) : void
      {
         var _loc2_:Object = this._917511744pasteArea;
         if(_loc2_ !== param1)
         {
            this._917511744pasteArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pasteArea",_loc2_,param1));
            }
         }
      }
   }
}

