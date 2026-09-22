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
   import mx.containers.Form;
   import mx.containers.FormItem;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.CloseEvent;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   import spark.components.Button;
   import spark.components.CheckBox;
   import spark.components.Label;
   import spark.components.TitleWindow;
   
   public class SettingsWindow extends TitleWindow
   {
      
      private static var _skinParts:Object = {
         "contentGroup":false,
         "moveArea":false,
         "closeButton":false,
         "titleDisplay":false,
         "controlBarGroup":false
      };
      
      private var _476548482cancelBtn:Button;
      
      private var _1684552454histCheck:CheckBox;
      
      private var _105765600okBtn:Button;
      
      private var _1320914907preCheck:CheckBox;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var backer:GearCalcAppUtil;
      
      public function SettingsWindow()
      {
         super();
         this.width = 300;
         this.height = 190;
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._SettingsWindow_Array1_c);
         this.addEventListener("close",this.___SettingsWindow_TitleWindow1_close);
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
      
      public function init(param1:GearCalcAppUtil) : void
      {
         this.backer = param1;
         this.histCheck.selected = param1.isHistory;
         this.preCheck.selected = param1.isZippy;
      }
      
      private function onClose(param1:Boolean) : void
      {
         if(param1)
         {
            this.backer.isHistory = this.histCheck.selected;
            this.backer.isZippy = this.preCheck.selected;
            this.backer.writeStandardPrefs();
            this.backer.commitPreferences();
         }
         PopUpManager.removePopUp(this);
      }
      
      private function _SettingsWindow_Array1_c() : Array
      {
         var _loc1_:Array = [this._SettingsWindow_Form1_c(),this._SettingsWindow_Button1_i(),this._SettingsWindow_Button2_i(),this._SettingsWindow_Label1_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _SettingsWindow_Form1_c() : Form
      {
         var temp:Form = new Form();
         temp.percentWidth = 90;
         temp.height = 88;
         temp.horizontalCenter = 0;
         temp.verticalCenter = -20;
         temp.setStyle("fontSize",17);
         if(!temp.document)
         {
            temp.document = this;
         }
         temp.mx_internal::_documentDescriptor = new UIComponentDescriptor({
            "type":Form,
            "stylesFactory":function():void
            {
               this.fontSize = 17;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Load last build on startup: ",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"histCheck",
                           "stylesFactory":function():void
                           {
                              this.textAlign = "center";
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Pre-load part images: ",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"preCheck",
                           "propertiesFactory":function():Object
                           {
                              return {"enabled":false};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         temp.mx_internal::_documentDescriptor.document = this;
         BindingManager.executeBindings(this,"temp",temp);
         return temp;
      }
      
      private function _SettingsWindow_Button1_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.y = 125;
         _loc1_.label = "OK";
         _loc1_.horizontalCenter = -45;
         _loc1_.addEventListener("click",this.__okBtn_click);
         _loc1_.id = "okBtn";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.okBtn = _loc1_;
         BindingManager.executeBindings(this,"okBtn",this.okBtn);
         return _loc1_;
      }
      
      public function __okBtn_click(param1:MouseEvent) : void
      {
         this.onClose(true);
      }
      
      private function _SettingsWindow_Button2_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.y = 125;
         _loc1_.label = "Cancel";
         _loc1_.horizontalCenter = 45;
         _loc1_.addEventListener("click",this.__cancelBtn_click);
         _loc1_.id = "cancelBtn";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.cancelBtn = _loc1_;
         BindingManager.executeBindings(this,"cancelBtn",this.cancelBtn);
         return _loc1_;
      }
      
      public function __cancelBtn_click(param1:MouseEvent) : void
      {
         this.onClose(false);
      }
      
      private function _SettingsWindow_Label1_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.y = -23;
         _loc1_.text = "Settings";
         _loc1_.horizontalCenter = -2;
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function ___SettingsWindow_TitleWindow1_close(param1:CloseEvent) : void
      {
         this.onClose(false);
      }
      
      [Bindable(event="propertyChange")]
      public function get cancelBtn() : Button
      {
         return this._476548482cancelBtn;
      }
      
      public function set cancelBtn(param1:Button) : void
      {
         var _loc2_:Object = this._476548482cancelBtn;
         if(_loc2_ !== param1)
         {
            this._476548482cancelBtn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cancelBtn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get histCheck() : CheckBox
      {
         return this._1684552454histCheck;
      }
      
      public function set histCheck(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1684552454histCheck;
         if(_loc2_ !== param1)
         {
            this._1684552454histCheck = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"histCheck",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get okBtn() : Button
      {
         return this._105765600okBtn;
      }
      
      public function set okBtn(param1:Button) : void
      {
         var _loc2_:Object = this._105765600okBtn;
         if(_loc2_ !== param1)
         {
            this._105765600okBtn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"okBtn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get preCheck() : CheckBox
      {
         return this._1320914907preCheck;
      }
      
      public function set preCheck(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1320914907preCheck;
         if(_loc2_ !== param1)
         {
            this._1320914907preCheck = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"preCheck",_loc2_,param1));
            }
         }
      }
   }
}

