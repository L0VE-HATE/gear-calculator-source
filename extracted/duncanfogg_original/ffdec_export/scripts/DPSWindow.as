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
   import gearcalc.*;
   import mx.binding.*;
   import mx.containers.Form;
   import mx.containers.FormHeading;
   import mx.containers.FormItem;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.styles.*;
   import spark.components.Button;
   import spark.components.Label;
   import spark.components.TextInput;
   import spark.components.TitleWindow;
   import spark.components.VGroup;
   
   use namespace mx_internal;
   
   public class DPSWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static var _skinParts:Object = {
         "contentGroup":false,
         "moveArea":false,
         "closeButton":false,
         "titleDisplay":false,
         "controlBarGroup":false
      };
      
      public var _DPSWindow_Form1:Form;
      
      private var _1705228775calcButton:Button;
      
      private var _1328242396dmgMod:TextInput;
      
      private var _3184369gun1:Label;
      
      private var _3184370gun2:Label;
      
      private var _3184371gun3:Label;
      
      private var _3184372gun4:Label;
      
      private var _108280125range:TextInput;
      
      private var _925617031rofMod:TextInput;
      
      private var _1302783119spreadMod:TextInput;
      
      private var _869614056targetHeight:TextInput;
      
      private var _2092294475targetWidth:TextInput;
      
      private var _823812896value1:Label;
      
      private var _823812895value2:Label;
      
      private var _823812894value3:Label;
      
      private var _823812893value4:Label;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var guns:Vector.<Weapon>;
      
      private var computer:DPSCalculator;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function DPSWindow()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         bindings = this._DPSWindow_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_DPSWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return DPSWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 600;
         this.height = 330;
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._DPSWindow_Array1_c);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         DPSWindow._watcherSetupUtil = param1;
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
      
      public function initParams(param1:Vector.<Weapon>) : void
      {
         this.guns = new Vector.<Weapon>();
         var _loc2_:* = int(param1.length - 1);
         while(_loc2_ >= 0)
         {
            this.guns.push(param1[_loc2_]);
            _loc2_--;
         }
         trace(this.gun1.text);
         if(param1.length >= 1)
         {
            this.gun1.text = this.guns[0].label + ": ";
         }
         if(param1.length >= 2)
         {
            this.gun2.text = this.guns[1].label + ": ";
         }
         if(param1.length >= 3)
         {
            this.gun3.text = this.guns[2].label + ": ";
         }
         if(param1.length >= 4)
         {
            this.gun4.text = this.guns[3].label + ": ";
         }
         this.rofMod.enabled = false;
         this.spreadMod.enabled = false;
         this.dmgMod.enabled = false;
         this.range.text = "10";
         this.targetWidth.text = "5";
         this.targetHeight.text = "7";
      }
      
      public function calculate() : void
      {
         this.computer = new DPSCalculator();
         if(this.targetHeight.text.length > 0)
         {
            this.computer.targetHeight = Number(this.targetHeight.text);
         }
         else
         {
            this.computer.targetHeight = 5;
         }
         if(this.targetWidth.text.length > 0)
         {
            this.computer.targetWidth = Number(this.targetWidth.text);
         }
         else
         {
            this.computer.targetWidth = 7;
         }
         if(this.range.text.length > 0)
         {
            this.computer.range = 3 * Number(this.range.text);
         }
         else
         {
            this.computer.range = 30;
         }
         if(this.guns.length >= 1)
         {
            this.value1.text = this.computer.calculate(this.guns[0]).toFixed(2);
         }
         if(this.guns.length >= 2)
         {
            this.value2.text = this.computer.calculate(this.guns[1]).toFixed(2);
         }
         if(this.guns.length >= 3)
         {
            this.value3.text = this.computer.calculate(this.guns[2]).toFixed(2);
         }
         if(this.guns.length >= 4)
         {
            this.value4.text = this.computer.calculate(this.guns[3]).toFixed(2);
         }
         trace(this.value1.text);
      }
      
      private function _DPSWindow_Array1_c() : Array
      {
         var _loc1_:Array = [this._DPSWindow_Form1_i(),this._DPSWindow_Label1_c(),this._DPSWindow_VGroup1_c(),this._DPSWindow_VGroup2_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _DPSWindow_Form1_i() : Form
      {
         var temp:Form = new Form();
         temp.x = 10;
         temp.y = 10;
         temp.width = 287;
         temp.height = 277;
         temp.id = "_DPSWindow_Form1";
         if(!temp.document)
         {
            temp.document = this;
         }
         temp.mx_internal::_documentDescriptor = new UIComponentDescriptor({
            "type":Form,
            "id":"_DPSWindow_Form1",
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":FormHeading,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Parameters",
                        "percentWidth":50
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Target Range (yd)",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"range",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "widthInChars":10,
                                 "maxChars":6,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Hit Zone Width (ft)",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"targetWidth",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "widthInChars":10,
                                 "maxChars":6,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Hit Zone Height (ft)",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"targetHeight",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "widthInChars":10,
                                 "maxChars":6,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormHeading,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Skill/COM Effects",
                        "percentWidth":50
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Fire Rate (%)",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"rofMod",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "widthInChars":10,
                                 "maxChars":6,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Damage (%)",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"dmgMod",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "widthInChars":10,
                                 "maxChars":6,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Spread (%)",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"spreadMod",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "widthInChars":10,
                                 "maxChars":6,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "id":"calcButton",
                           "events":{"click":"__calcButton_click"},
                           "propertiesFactory":function():Object
                           {
                              return {"label":"Calculate"};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         temp.mx_internal::_documentDescriptor.document = this;
         this._DPSWindow_Form1 = temp;
         BindingManager.executeBindings(this,"_DPSWindow_Form1",this._DPSWindow_Form1);
         return temp;
      }
      
      public function __calcButton_click(param1:MouseEvent) : void
      {
         this.calculate();
      }
      
      private function _DPSWindow_Label1_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 210;
         _loc1_.y = -26;
         _loc1_.text = "Enhanced DPS Calculator";
         _loc1_.width = 191;
         _loc1_.height = 23;
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontSize",13);
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _DPSWindow_VGroup1_c() : VGroup
      {
         var _loc1_:VGroup = new VGroup();
         _loc1_.x = 315;
         _loc1_.y = 10;
         _loc1_.width = 167;
         _loc1_.height = 277;
         _loc1_.mxmlContent = [this._DPSWindow_Label2_i(),this._DPSWindow_Label3_i(),this._DPSWindow_Label4_i(),this._DPSWindow_Label5_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _DPSWindow_Label2_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.percentHeight = 25;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontSize",15);
         _loc1_.id = "gun1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.gun1 = _loc1_;
         BindingManager.executeBindings(this,"gun1",this.gun1);
         return _loc1_;
      }
      
      private function _DPSWindow_Label3_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.percentHeight = 25;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontSize",15);
         _loc1_.id = "gun2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.gun2 = _loc1_;
         BindingManager.executeBindings(this,"gun2",this.gun2);
         return _loc1_;
      }
      
      private function _DPSWindow_Label4_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.percentHeight = 25;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontSize",15);
         _loc1_.id = "gun3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.gun3 = _loc1_;
         BindingManager.executeBindings(this,"gun3",this.gun3);
         return _loc1_;
      }
      
      private function _DPSWindow_Label5_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.percentHeight = 25;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontSize",15);
         _loc1_.id = "gun4";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.gun4 = _loc1_;
         BindingManager.executeBindings(this,"gun4",this.gun4);
         return _loc1_;
      }
      
      private function _DPSWindow_VGroup2_c() : VGroup
      {
         var _loc1_:VGroup = new VGroup();
         _loc1_.width = 99;
         _loc1_.height = 277;
         _loc1_.x = 490;
         _loc1_.y = 10;
         _loc1_.mxmlContent = [this._DPSWindow_Label6_i(),this._DPSWindow_Label7_i(),this._DPSWindow_Label8_i(),this._DPSWindow_Label9_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _DPSWindow_Label6_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.percentHeight = 25;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "value1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.value1 = _loc1_;
         BindingManager.executeBindings(this,"value1",this.value1);
         return _loc1_;
      }
      
      private function _DPSWindow_Label7_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.percentHeight = 25;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "value2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.value2 = _loc1_;
         BindingManager.executeBindings(this,"value2",this.value2);
         return _loc1_;
      }
      
      private function _DPSWindow_Label8_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.percentHeight = 25;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "value3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.value3 = _loc1_;
         BindingManager.executeBindings(this,"value3",this.value3);
         return _loc1_;
      }
      
      private function _DPSWindow_Label9_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.percentHeight = 25;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontSize",18);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("textAlign","right");
         _loc1_.id = "value4";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.value4 = _loc1_;
         BindingManager.executeBindings(this,"value4",this.value4);
         return _loc1_;
      }
      
      private function _DPSWindow_bindingsSetup() : Array
      {
         var _loc1_:Array = [];
         _loc1_[0] = new Binding(this,null,null,"_DPSWindow_Form1.defaultButton","calcButton");
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get calcButton() : Button
      {
         return this._1705228775calcButton;
      }
      
      public function set calcButton(param1:Button) : void
      {
         var _loc2_:Object = this._1705228775calcButton;
         if(_loc2_ !== param1)
         {
            this._1705228775calcButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"calcButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dmgMod() : TextInput
      {
         return this._1328242396dmgMod;
      }
      
      public function set dmgMod(param1:TextInput) : void
      {
         var _loc2_:Object = this._1328242396dmgMod;
         if(_loc2_ !== param1)
         {
            this._1328242396dmgMod = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dmgMod",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gun1() : Label
      {
         return this._3184369gun1;
      }
      
      public function set gun1(param1:Label) : void
      {
         var _loc2_:Object = this._3184369gun1;
         if(_loc2_ !== param1)
         {
            this._3184369gun1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gun1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gun2() : Label
      {
         return this._3184370gun2;
      }
      
      public function set gun2(param1:Label) : void
      {
         var _loc2_:Object = this._3184370gun2;
         if(_loc2_ !== param1)
         {
            this._3184370gun2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gun2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gun3() : Label
      {
         return this._3184371gun3;
      }
      
      public function set gun3(param1:Label) : void
      {
         var _loc2_:Object = this._3184371gun3;
         if(_loc2_ !== param1)
         {
            this._3184371gun3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gun3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gun4() : Label
      {
         return this._3184372gun4;
      }
      
      public function set gun4(param1:Label) : void
      {
         var _loc2_:Object = this._3184372gun4;
         if(_loc2_ !== param1)
         {
            this._3184372gun4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gun4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get range() : TextInput
      {
         return this._108280125range;
      }
      
      public function set range(param1:TextInput) : void
      {
         var _loc2_:Object = this._108280125range;
         if(_loc2_ !== param1)
         {
            this._108280125range = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"range",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rofMod() : TextInput
      {
         return this._925617031rofMod;
      }
      
      public function set rofMod(param1:TextInput) : void
      {
         var _loc2_:Object = this._925617031rofMod;
         if(_loc2_ !== param1)
         {
            this._925617031rofMod = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rofMod",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get spreadMod() : TextInput
      {
         return this._1302783119spreadMod;
      }
      
      public function set spreadMod(param1:TextInput) : void
      {
         var _loc2_:Object = this._1302783119spreadMod;
         if(_loc2_ !== param1)
         {
            this._1302783119spreadMod = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"spreadMod",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get targetHeight() : TextInput
      {
         return this._869614056targetHeight;
      }
      
      public function set targetHeight(param1:TextInput) : void
      {
         var _loc2_:Object = this._869614056targetHeight;
         if(_loc2_ !== param1)
         {
            this._869614056targetHeight = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"targetHeight",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get targetWidth() : TextInput
      {
         return this._2092294475targetWidth;
      }
      
      public function set targetWidth(param1:TextInput) : void
      {
         var _loc2_:Object = this._2092294475targetWidth;
         if(_loc2_ !== param1)
         {
            this._2092294475targetWidth = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"targetWidth",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get value1() : Label
      {
         return this._823812896value1;
      }
      
      public function set value1(param1:Label) : void
      {
         var _loc2_:Object = this._823812896value1;
         if(_loc2_ !== param1)
         {
            this._823812896value1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"value1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get value2() : Label
      {
         return this._823812895value2;
      }
      
      public function set value2(param1:Label) : void
      {
         var _loc2_:Object = this._823812895value2;
         if(_loc2_ !== param1)
         {
            this._823812895value2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"value2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get value3() : Label
      {
         return this._823812894value3;
      }
      
      public function set value3(param1:Label) : void
      {
         var _loc2_:Object = this._823812894value3;
         if(_loc2_ !== param1)
         {
            this._823812894value3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"value3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get value4() : Label
      {
         return this._823812893value4;
      }
      
      public function set value4(param1:Label) : void
      {
         var _loc2_:Object = this._823812893value4;
         if(_loc2_ !== param1)
         {
            this._823812893value4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"value4",_loc2_,param1));
            }
         }
      }
   }
}

