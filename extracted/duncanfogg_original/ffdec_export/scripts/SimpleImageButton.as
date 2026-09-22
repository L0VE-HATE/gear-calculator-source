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
   import mx.controls.Image;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.styles.*;
   import spark.filters.BlurFilter;
   import spark.filters.DropShadowFilter;
   import spark.filters.GlowFilter;
   
   use namespace mx_internal;
   
   public class SimpleImageButton extends Image implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private var _407812607blackShadow:DropShadowFilter;
      
      private var _15443240blurrer:BlurFilter;
      
      private var _1243000070glower:GlowFilter;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var isOver:Boolean;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SimpleImageButton()
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
         bindings = this._SimpleImageButton_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_SimpleImageButtonWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SimpleImageButton[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.buttonMode = true;
         this._SimpleImageButton_DropShadowFilter1_i();
         this._SimpleImageButton_BlurFilter1_i();
         this._SimpleImageButton_GlowFilter1_i();
         this.addEventListener("rollOver",this.___SimpleImageButton_Image1_rollOver);
         this.addEventListener("rollOut",this.___SimpleImageButton_Image1_rollOut);
         this.addEventListener("mouseDown",this.___SimpleImageButton_Image1_mouseDown);
         this.addEventListener("mouseUp",this.___SimpleImageButton_Image1_mouseUp);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SimpleImageButton._watcherSetupUtil = param1;
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
      
      private function onOver() : void
      {
         this.isOver = true;
         filters = [this.glower];
      }
      
      private function onOff() : void
      {
         this.isOver = false;
         filters = [this.blackShadow];
      }
      
      private function onDown() : void
      {
         filters = [this.glower,this.blurrer];
      }
      
      private function onUp() : void
      {
         if(this.isOver)
         {
            filters = [this.glower];
         }
         else
         {
            this.onOff();
         }
      }
      
      private function _SimpleImageButton_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.distance = 1;
         _loc1_.angle = 45;
         _loc1_.alpha = 0.7;
         _loc1_.color = 1118481;
         _loc1_.strength = 1;
         _loc1_.blurX = 4;
         _loc1_.blurY = 4;
         this.blackShadow = _loc1_;
         BindingManager.executeBindings(this,"blackShadow",this.blackShadow);
         return _loc1_;
      }
      
      private function _SimpleImageButton_BlurFilter1_i() : BlurFilter
      {
         var _loc1_:BlurFilter = new BlurFilter();
         _loc1_.blurX = 9;
         _loc1_.blurY = 5;
         this.blurrer = _loc1_;
         BindingManager.executeBindings(this,"blurrer",this.blurrer);
         return _loc1_;
      }
      
      private function _SimpleImageButton_GlowFilter1_i() : GlowFilter
      {
         var _loc1_:GlowFilter = new GlowFilter();
         _loc1_.alpha = 0.75;
         _loc1_.color = 16777045;
         _loc1_.strength = 3;
         _loc1_.blurX = 7;
         _loc1_.blurY = 7;
         this.glower = _loc1_;
         BindingManager.executeBindings(this,"glower",this.glower);
         return _loc1_;
      }
      
      public function ___SimpleImageButton_Image1_rollOver(param1:MouseEvent) : void
      {
         this.onOver();
      }
      
      public function ___SimpleImageButton_Image1_rollOut(param1:MouseEvent) : void
      {
         this.onOff();
      }
      
      public function ___SimpleImageButton_Image1_mouseDown(param1:MouseEvent) : void
      {
         this.onDown();
      }
      
      public function ___SimpleImageButton_Image1_mouseUp(param1:MouseEvent) : void
      {
         this.onUp();
      }
      
      private function _SimpleImageButton_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Array
         {
            var _loc1_:* = blackShadow;
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"this.filters","blackShadow");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get blackShadow() : DropShadowFilter
      {
         return this._407812607blackShadow;
      }
      
      public function set blackShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._407812607blackShadow;
         if(_loc2_ !== param1)
         {
            this._407812607blackShadow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blackShadow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get blurrer() : BlurFilter
      {
         return this._15443240blurrer;
      }
      
      public function set blurrer(param1:BlurFilter) : void
      {
         var _loc2_:Object = this._15443240blurrer;
         if(_loc2_ !== param1)
         {
            this._15443240blurrer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blurrer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get glower() : GlowFilter
      {
         return this._1243000070glower;
      }
      
      public function set glower(param1:GlowFilter) : void
      {
         var _loc2_:Object = this._1243000070glower;
         if(_loc2_ !== param1)
         {
            this._1243000070glower = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"glower",_loc2_,param1));
            }
         }
      }
   }
}

