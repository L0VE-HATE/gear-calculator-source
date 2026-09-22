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
   import mx.core.IStateClient2;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.graphics.SolidColor;
   import mx.graphics.SolidColorStroke;
   import mx.states.AddItems;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.*;
   import spark.components.Button;
   import spark.components.Group;
   import spark.components.Label;
   import spark.components.TitleWindow;
   import spark.components.supportClasses.Skin;
   import spark.layouts.HorizontalLayout;
   import spark.layouts.VerticalLayout;
   import spark.primitives.Rect;
   import zen.skins.TitleWindowCloseButtonSkin;
   
   use namespace mx_internal;
   
   public class FixSkin extends Skin implements IBindingClient, IStateClient2
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      public var _FixSkin_Group8:Group;
      
      private var _1332194002background:Rect;
      
      private var _1427077073backgroundFill:SolidColor;
      
      private var _1383304148border:Rect;
      
      private var _631173356bottomGroup:Group;
      
      private var _1770004448bottomGroupMask:Group;
      
      private var _149872069bottomMaskRect:Rect;
      
      private var _312699062closeButton:Button;
      
      private var _809612678contentGroup:Group;
      
      private var _567321830contents:Group;
      
      private var _139410089controlBarGroup:Group;
      
      private var _104976386moveArea:Group;
      
      private var _110116675tbDiv:Rect;
      
      private var _881290991tbFill:Rect;
      
      private var _1893287094titleDisplay:Label;
      
      private var _988229078topGroup:Group;
      
      private var _181676086topGroupMask:Group;
      
      private var _1437106021topMaskRect:Rect;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _213507019hostComponent:TitleWindow;
      
      public function FixSkin()
      {
         var bindings:Array;
         var watchers:Array;
         var _FixSkin_Group2_factory:DeferredInstanceFromFunction;
         var _FixSkin_Group7_factory:DeferredInstanceFromFunction;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         bindings = this._FixSkin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_FixSkinWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return FixSkin[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.blendMode = "normal";
         this.mouseEnabled = true;
         this.minWidth = 76;
         this.minHeight = 76;
         this.mxmlContent = [this._FixSkin_Group1_i(),this._FixSkin_Rect3_i(),this._FixSkin_Rect4_i(),this._FixSkin_Group3_i()];
         this.currentState = "normal";
         _FixSkin_Group2_factory = new DeferredInstanceFromFunction(this._FixSkin_Group2_i);
         _FixSkin_Group7_factory = new DeferredInstanceFromFunction(this._FixSkin_Group7_i);
         states = [new State({
            "name":"normal",
            "stateGroups":["normalGroup"],
            "overrides":[]
         }),new State({
            "name":"active",
            "overrides":[]
         }),new State({
            "name":"inactive",
            "overrides":[]
         }),new State({
            "name":"disabled",
            "overrides":[new SetProperty().initializeFromObject({
               "name":"alpha",
               "value":0.5
            })]
         }),new State({
            "name":"normalWithControlBar",
            "stateGroups":["withControls","normalGroup"],
            "overrides":[new AddItems().initializeFromObject({
               "itemsFactory":_FixSkin_Group7_factory,
               "destination":"contents",
               "propertyName":"mxmlContent",
               "position":"after",
               "relativeTo":["contentGroup"]
            }),new AddItems().initializeFromObject({
               "itemsFactory":_FixSkin_Group2_factory,
               "destination":null,
               "propertyName":"mxmlContent",
               "position":"after",
               "relativeTo":["topGroupMask"]
            })]
         }),new State({
            "name":"activeWithControlBar",
            "stateGroups":["withControls"],
            "overrides":[new AddItems().initializeFromObject({
               "itemsFactory":_FixSkin_Group7_factory,
               "destination":"contents",
               "propertyName":"mxmlContent",
               "position":"after",
               "relativeTo":["contentGroup"]
            }),new AddItems().initializeFromObject({
               "itemsFactory":_FixSkin_Group2_factory,
               "destination":null,
               "propertyName":"mxmlContent",
               "position":"after",
               "relativeTo":["topGroupMask"]
            })]
         }),new State({
            "name":"inactiveWithControlBar",
            "overrides":[]
         }),new State({
            "name":"disabledWithControlBar",
            "stateGroups":["withControls"],
            "overrides":[new AddItems().initializeFromObject({
               "itemsFactory":_FixSkin_Group7_factory,
               "destination":"contents",
               "propertyName":"mxmlContent",
               "position":"after",
               "relativeTo":["contentGroup"]
            }),new AddItems().initializeFromObject({
               "itemsFactory":_FixSkin_Group2_factory,
               "destination":null,
               "propertyName":"mxmlContent",
               "position":"after",
               "relativeTo":["topGroupMask"]
            }),new SetProperty().initializeFromObject({
               "name":"alpha",
               "value":0.5
            })]
         })];
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         FixSkin._watcherSetupUtil = param1;
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
      
      private function _FixSkin_Group1_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.left = 1;
         _loc1_.top = 1;
         _loc1_.right = 1;
         _loc1_.bottom = 1;
         _loc1_.mxmlContent = [this._FixSkin_Rect1_i()];
         _loc1_.id = "topGroupMask";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.topGroupMask = _loc1_;
         BindingManager.executeBindings(this,"topGroupMask",this.topGroupMask);
         return _loc1_;
      }
      
      private function _FixSkin_Rect1_i() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.left = 0;
         _loc1_.top = 0;
         _loc1_.right = 0;
         _loc1_.bottom = 0;
         _loc1_.topLeftRadiusX = 10;
         _loc1_.topRightRadiusX = 10;
         _loc1_.bottomLeftRadiusX = 0;
         _loc1_.bottomRightRadiusX = 0;
         _loc1_.fill = this._FixSkin_SolidColor1_c();
         _loc1_.initialized(this,"topMaskRect");
         this.topMaskRect = _loc1_;
         BindingManager.executeBindings(this,"topMaskRect",this.topMaskRect);
         return _loc1_;
      }
      
      private function _FixSkin_SolidColor1_c() : SolidColor
      {
         var _loc1_:SolidColor = new SolidColor();
         _loc1_.alpha = 0;
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_Group2_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.left = 1;
         _loc1_.top = 1;
         _loc1_.right = 1;
         _loc1_.bottom = 1;
         _loc1_.mxmlContent = [this._FixSkin_Rect2_i()];
         _loc1_.id = "bottomGroupMask";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bottomGroupMask = _loc1_;
         BindingManager.executeBindings(this,"bottomGroupMask",this.bottomGroupMask);
         return _loc1_;
      }
      
      private function _FixSkin_Rect2_i() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.left = 0;
         _loc1_.top = 0;
         _loc1_.right = 0;
         _loc1_.bottom = 0;
         _loc1_.topLeftRadiusX = 10;
         _loc1_.topRightRadiusX = 10;
         _loc1_.bottomLeftRadiusX = 0;
         _loc1_.bottomRightRadiusX = 0;
         _loc1_.fill = this._FixSkin_SolidColor2_c();
         _loc1_.initialized(this,"bottomMaskRect");
         this.bottomMaskRect = _loc1_;
         BindingManager.executeBindings(this,"bottomMaskRect",this.bottomMaskRect);
         return _loc1_;
      }
      
      private function _FixSkin_SolidColor2_c() : SolidColor
      {
         var _loc1_:SolidColor = new SolidColor();
         _loc1_.alpha = 0;
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_Rect3_i() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.left = 0;
         _loc1_.right = 0;
         _loc1_.top = 0;
         _loc1_.bottom = 0;
         _loc1_.topLeftRadiusX = 10;
         _loc1_.topRightRadiusX = 10;
         _loc1_.bottomLeftRadiusX = 0;
         _loc1_.bottomRightRadiusX = 0;
         _loc1_.stroke = this._FixSkin_SolidColorStroke1_c();
         _loc1_.initialized(this,"border");
         this.border = _loc1_;
         BindingManager.executeBindings(this,"border",this.border);
         return _loc1_;
      }
      
      private function _FixSkin_SolidColorStroke1_c() : SolidColorStroke
      {
         var _loc1_:SolidColorStroke = new SolidColorStroke();
         _loc1_.color = 8553067;
         _loc1_.weight = 1;
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_Rect4_i() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.left = 1;
         _loc1_.top = 1;
         _loc1_.right = 1;
         _loc1_.bottom = 1;
         _loc1_.topLeftRadiusX = 10;
         _loc1_.topRightRadiusX = 10;
         _loc1_.bottomLeftRadiusX = 0;
         _loc1_.bottomRightRadiusX = 0;
         _loc1_.fill = this._FixSkin_SolidColor3_i();
         _loc1_.initialized(this,"background");
         this.background = _loc1_;
         BindingManager.executeBindings(this,"background",this.background);
         return _loc1_;
      }
      
      private function _FixSkin_SolidColor3_i() : SolidColor
      {
         var _loc1_:SolidColor = new SolidColor();
         _loc1_.color = 11184777;
         this.backgroundFill = _loc1_;
         BindingManager.executeBindings(this,"backgroundFill",this.backgroundFill);
         return _loc1_;
      }
      
      private function _FixSkin_Group3_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.left = 1;
         _loc1_.right = 1;
         _loc1_.top = 1;
         _loc1_.bottom = 1;
         _loc1_.layout = this._FixSkin_VerticalLayout1_c();
         _loc1_.mxmlContent = [this._FixSkin_Group4_i(),this._FixSkin_Group6_i()];
         _loc1_.id = "contents";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.contents = _loc1_;
         BindingManager.executeBindings(this,"contents",this.contents);
         return _loc1_;
      }
      
      private function _FixSkin_VerticalLayout1_c() : VerticalLayout
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.gap = 0;
         _loc1_.horizontalAlign = "justify";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_Group4_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.mxmlContent = [this._FixSkin_Rect5_i(),this._FixSkin_Rect6_i(),this._FixSkin_Label1_i(),this._FixSkin_Group5_i(),this._FixSkin_Button1_i()];
         _loc1_.id = "topGroup";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.topGroup = _loc1_;
         BindingManager.executeBindings(this,"topGroup",this.topGroup);
         return _loc1_;
      }
      
      private function _FixSkin_Rect5_i() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.left = 0;
         _loc1_.right = 0;
         _loc1_.top = 0;
         _loc1_.bottom = 1;
         _loc1_.fill = this._FixSkin_SolidColor4_c();
         _loc1_.initialized(this,"tbFill");
         this.tbFill = _loc1_;
         BindingManager.executeBindings(this,"tbFill",this.tbFill);
         return _loc1_;
      }
      
      private function _FixSkin_SolidColor4_c() : SolidColor
      {
         var _loc1_:SolidColor = new SolidColor();
         _loc1_.color = 11184777;
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_Rect6_i() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.left = 0;
         _loc1_.right = 0;
         _loc1_.height = 1;
         _loc1_.bottom = 0;
         _loc1_.fill = this._FixSkin_SolidColor5_c();
         _loc1_.initialized(this,"tbDiv");
         this.tbDiv = _loc1_;
         BindingManager.executeBindings(this,"tbDiv",this.tbDiv);
         return _loc1_;
      }
      
      private function _FixSkin_SolidColor5_c() : SolidColor
      {
         var _loc1_:SolidColor = new SolidColor();
         _loc1_.color = 8553067;
         _loc1_.alpha = 0.75;
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_Label1_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.maxDisplayedLines = 1;
         _loc1_.left = 9;
         _loc1_.right = 24;
         _loc1_.top = 1;
         _loc1_.bottom = 0;
         _loc1_.minHeight = 30;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("color",4990464);
         _loc1_.id = "titleDisplay";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.titleDisplay = _loc1_;
         BindingManager.executeBindings(this,"titleDisplay",this.titleDisplay);
         return _loc1_;
      }
      
      private function _FixSkin_Group5_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.left = 0;
         _loc1_.right = 0;
         _loc1_.top = 0;
         _loc1_.bottom = 0;
         _loc1_.id = "moveArea";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.moveArea = _loc1_;
         BindingManager.executeBindings(this,"moveArea",this.moveArea);
         return _loc1_;
      }
      
      private function _FixSkin_Button1_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.width = 15;
         _loc1_.height = 15;
         _loc1_.right = 2;
         _loc1_.top = 7;
         _loc1_.setStyle("skinClass",TitleWindowCloseButtonSkin);
         _loc1_.id = "closeButton";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.closeButton = _loc1_;
         BindingManager.executeBindings(this,"closeButton",this.closeButton);
         return _loc1_;
      }
      
      private function _FixSkin_Group6_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         _loc1_.minWidth = 0;
         _loc1_.minHeight = 0;
         _loc1_.id = "contentGroup";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.contentGroup = _loc1_;
         BindingManager.executeBindings(this,"contentGroup",this.contentGroup);
         return _loc1_;
      }
      
      private function _FixSkin_Group7_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.minWidth = 0;
         _loc1_.minHeight = 0;
         _loc1_.mxmlContent = [this._FixSkin_Group8_i(),this._FixSkin_Group9_i()];
         _loc1_.id = "bottomGroup";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.bottomGroup = _loc1_;
         BindingManager.executeBindings(this,"bottomGroup",this.bottomGroup);
         return _loc1_;
      }
      
      private function _FixSkin_Group8_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.left = 0;
         _loc1_.right = 0;
         _loc1_.top = 0;
         _loc1_.bottom = 0;
         _loc1_.mxmlContent = [this._FixSkin_Rect7_c(),this._FixSkin_Rect8_c()];
         _loc1_.id = "_FixSkin_Group8";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._FixSkin_Group8 = _loc1_;
         BindingManager.executeBindings(this,"_FixSkin_Group8",this._FixSkin_Group8);
         return _loc1_;
      }
      
      private function _FixSkin_Rect7_c() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.left = 0;
         _loc1_.right = 0;
         _loc1_.top = 0;
         _loc1_.height = 1;
         _loc1_.alpha = 0.22;
         _loc1_.fill = this._FixSkin_SolidColor6_c();
         _loc1_.initialized(this,null);
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_SolidColor6_c() : SolidColor
      {
         var _loc1_:SolidColor = new SolidColor();
         _loc1_.color = 8553067;
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_Rect8_c() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.left = 1;
         _loc1_.right = 1;
         _loc1_.top = 2;
         _loc1_.bottom = 1;
         _loc1_.fill = this._FixSkin_SolidColor7_c();
         _loc1_.initialized(this,null);
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_SolidColor7_c() : SolidColor
      {
         var _loc1_:SolidColor = new SolidColor();
         _loc1_.color = 11184777;
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_Group9_i() : Group
      {
         var _loc1_:Group = new Group();
         _loc1_.left = 0;
         _loc1_.right = 0;
         _loc1_.top = 1;
         _loc1_.bottom = 1;
         _loc1_.minWidth = 0;
         _loc1_.minHeight = 0;
         _loc1_.layout = this._FixSkin_HorizontalLayout1_c();
         _loc1_.id = "controlBarGroup";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.controlBarGroup = _loc1_;
         BindingManager.executeBindings(this,"controlBarGroup",this.controlBarGroup);
         return _loc1_;
      }
      
      private function _FixSkin_HorizontalLayout1_c() : HorizontalLayout
      {
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.paddingLeft = 10;
         _loc1_.paddingRight = 10;
         _loc1_.paddingTop = 7;
         _loc1_.paddingBottom = 7;
         _loc1_.gap = 10;
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _FixSkin_bindingsSetup() : Array
      {
         var _loc1_:Array = [];
         _loc1_[0] = new Binding(this,null,null,"topGroup.mask","topGroupMask");
         _loc1_[1] = new Binding(this,null,null,"_FixSkin_Group8.mask","bottomGroupMask");
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get background() : Rect
      {
         return this._1332194002background;
      }
      
      public function set background(param1:Rect) : void
      {
         var _loc2_:Object = this._1332194002background;
         if(_loc2_ !== param1)
         {
            this._1332194002background = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"background",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get backgroundFill() : SolidColor
      {
         return this._1427077073backgroundFill;
      }
      
      public function set backgroundFill(param1:SolidColor) : void
      {
         var _loc2_:Object = this._1427077073backgroundFill;
         if(_loc2_ !== param1)
         {
            this._1427077073backgroundFill = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"backgroundFill",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get border() : Rect
      {
         return this._1383304148border;
      }
      
      public function set border(param1:Rect) : void
      {
         var _loc2_:Object = this._1383304148border;
         if(_loc2_ !== param1)
         {
            this._1383304148border = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"border",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bottomGroup() : Group
      {
         return this._631173356bottomGroup;
      }
      
      public function set bottomGroup(param1:Group) : void
      {
         var _loc2_:Object = this._631173356bottomGroup;
         if(_loc2_ !== param1)
         {
            this._631173356bottomGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bottomGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bottomGroupMask() : Group
      {
         return this._1770004448bottomGroupMask;
      }
      
      public function set bottomGroupMask(param1:Group) : void
      {
         var _loc2_:Object = this._1770004448bottomGroupMask;
         if(_loc2_ !== param1)
         {
            this._1770004448bottomGroupMask = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bottomGroupMask",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bottomMaskRect() : Rect
      {
         return this._149872069bottomMaskRect;
      }
      
      public function set bottomMaskRect(param1:Rect) : void
      {
         var _loc2_:Object = this._149872069bottomMaskRect;
         if(_loc2_ !== param1)
         {
            this._149872069bottomMaskRect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bottomMaskRect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get closeButton() : Button
      {
         return this._312699062closeButton;
      }
      
      public function set closeButton(param1:Button) : void
      {
         var _loc2_:Object = this._312699062closeButton;
         if(_loc2_ !== param1)
         {
            this._312699062closeButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"closeButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get contentGroup() : Group
      {
         return this._809612678contentGroup;
      }
      
      public function set contentGroup(param1:Group) : void
      {
         var _loc2_:Object = this._809612678contentGroup;
         if(_loc2_ !== param1)
         {
            this._809612678contentGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"contentGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get contents() : Group
      {
         return this._567321830contents;
      }
      
      public function set contents(param1:Group) : void
      {
         var _loc2_:Object = this._567321830contents;
         if(_loc2_ !== param1)
         {
            this._567321830contents = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"contents",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get controlBarGroup() : Group
      {
         return this._139410089controlBarGroup;
      }
      
      public function set controlBarGroup(param1:Group) : void
      {
         var _loc2_:Object = this._139410089controlBarGroup;
         if(_loc2_ !== param1)
         {
            this._139410089controlBarGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"controlBarGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get moveArea() : Group
      {
         return this._104976386moveArea;
      }
      
      public function set moveArea(param1:Group) : void
      {
         var _loc2_:Object = this._104976386moveArea;
         if(_loc2_ !== param1)
         {
            this._104976386moveArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"moveArea",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tbDiv() : Rect
      {
         return this._110116675tbDiv;
      }
      
      public function set tbDiv(param1:Rect) : void
      {
         var _loc2_:Object = this._110116675tbDiv;
         if(_loc2_ !== param1)
         {
            this._110116675tbDiv = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tbDiv",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tbFill() : Rect
      {
         return this._881290991tbFill;
      }
      
      public function set tbFill(param1:Rect) : void
      {
         var _loc2_:Object = this._881290991tbFill;
         if(_loc2_ !== param1)
         {
            this._881290991tbFill = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tbFill",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleDisplay() : Label
      {
         return this._1893287094titleDisplay;
      }
      
      public function set titleDisplay(param1:Label) : void
      {
         var _loc2_:Object = this._1893287094titleDisplay;
         if(_loc2_ !== param1)
         {
            this._1893287094titleDisplay = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleDisplay",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get topGroup() : Group
      {
         return this._988229078topGroup;
      }
      
      public function set topGroup(param1:Group) : void
      {
         var _loc2_:Object = this._988229078topGroup;
         if(_loc2_ !== param1)
         {
            this._988229078topGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get topGroupMask() : Group
      {
         return this._181676086topGroupMask;
      }
      
      public function set topGroupMask(param1:Group) : void
      {
         var _loc2_:Object = this._181676086topGroupMask;
         if(_loc2_ !== param1)
         {
            this._181676086topGroupMask = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topGroupMask",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get topMaskRect() : Rect
      {
         return this._1437106021topMaskRect;
      }
      
      public function set topMaskRect(param1:Rect) : void
      {
         var _loc2_:Object = this._1437106021topMaskRect;
         if(_loc2_ !== param1)
         {
            this._1437106021topMaskRect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topMaskRect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get hostComponent() : TitleWindow
      {
         return this._213507019hostComponent;
      }
      
      public function set hostComponent(param1:TitleWindow) : void
      {
         var _loc2_:Object = this._213507019hostComponent;
         if(_loc2_ !== param1)
         {
            this._213507019hostComponent = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hostComponent",_loc2_,param1));
            }
         }
      }
   }
}

