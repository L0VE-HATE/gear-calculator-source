package gearcalc
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.core.BitmapAsset;
   import mx.events.PropertyChangeEvent;
   
   public class ElementalImage implements IEventDispatcher
   {
      
      private var _94848517corr1:Class = ElementalImage_corr1;
      
      private var _94848518corr2:Class = ElementalImage_corr2;
      
      private var _94848519corr3:Class = ElementalImage_corr3;
      
      private var _94848520corr4:Class = ElementalImage_corr4;
      
      private var _1289156655explo1:Class = ElementalImage_explo1;
      
      private var _1289156654explo2:Class = ElementalImage_explo2;
      
      private var _1289156653explo3:Class = ElementalImage_explo3;
      
      private var _1289156652explo4:Class = ElementalImage_explo4;
      
      private var _1184269302incen1:Class = ElementalImage_incen1;
      
      private var _1184269301incen2:Class = ElementalImage_incen2;
      
      private var _1184269300incen3:Class = ElementalImage_incen3;
      
      private var _1184269299incen4:Class = ElementalImage_incen4;
      
      private var _903163441shock1:Class = ElementalImage_shock1;
      
      private var _903163440shock2:Class = ElementalImage_shock2;
      
      private var _903163439shock3:Class = ElementalImage_shock3;
      
      private var _903163438shock4:Class = ElementalImage_shock4;
      
      public var images:Vector.<BitmapAsset>;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function ElementalImage()
      {
         super();
         this.images = new Vector.<BitmapAsset>();
         this.images.push(new this.corr1() as BitmapAsset);
         this.images.push(new this.corr2() as BitmapAsset);
         this.images.push(new this.corr3() as BitmapAsset);
         this.images.push(new this.corr4() as BitmapAsset);
         this.images.push(new this.explo1() as BitmapAsset);
         this.images.push(new this.explo2() as BitmapAsset);
         this.images.push(new this.explo3() as BitmapAsset);
         this.images.push(new this.explo4() as BitmapAsset);
         this.images.push(new this.incen1() as BitmapAsset);
         this.images.push(new this.incen2() as BitmapAsset);
         this.images.push(new this.incen3() as BitmapAsset);
         this.images.push(new this.incen4() as BitmapAsset);
         this.images.push(new this.shock1() as BitmapAsset);
         this.images.push(new this.shock2() as BitmapAsset);
         this.images.push(new this.shock3() as BitmapAsset);
         this.images.push(new this.shock4() as BitmapAsset);
      }
      
      public function retrieveImage(param1:String, param2:int, param3:Array) : BitmapAsset
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param2 >= 15 + param3[3])
         {
            _loc5_ = 4;
         }
         else if(param2 >= 12 + param3[2])
         {
            _loc5_ = 3;
         }
         else if(param2 >= 9 + param3[1])
         {
            _loc5_ = 2;
         }
         else if(param2 >= 6 + param3[0])
         {
            _loc5_ = 1;
         }
         else
         {
            _loc5_ = 1;
         }
         switch(param1)
         {
            case GearCalcUtil.TECH_CORROSIVE:
               _loc4_ = 0;
               break;
            case GearCalcUtil.TECH_EXPLOSIVE:
               _loc4_ = 4;
               break;
            case GearCalcUtil.TECH_INCENDIARY:
               _loc4_ = 8;
               break;
            case GearCalcUtil.TECH_SHOCK:
               _loc4_ = 12;
               break;
            default:
               _loc4_ = 4;
         }
         return this.images[_loc4_ + _loc5_ - 1];
      }
      
      [Bindable(event="propertyChange")]
      private function get corr1() : Class
      {
         return this._94848517corr1;
      }
      
      private function set corr1(param1:Class) : void
      {
         var _loc2_:Object = this._94848517corr1;
         if(_loc2_ !== param1)
         {
            this._94848517corr1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"corr1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get corr2() : Class
      {
         return this._94848518corr2;
      }
      
      private function set corr2(param1:Class) : void
      {
         var _loc2_:Object = this._94848518corr2;
         if(_loc2_ !== param1)
         {
            this._94848518corr2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"corr2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get corr3() : Class
      {
         return this._94848519corr3;
      }
      
      private function set corr3(param1:Class) : void
      {
         var _loc2_:Object = this._94848519corr3;
         if(_loc2_ !== param1)
         {
            this._94848519corr3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"corr3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get corr4() : Class
      {
         return this._94848520corr4;
      }
      
      private function set corr4(param1:Class) : void
      {
         var _loc2_:Object = this._94848520corr4;
         if(_loc2_ !== param1)
         {
            this._94848520corr4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"corr4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get explo1() : Class
      {
         return this._1289156655explo1;
      }
      
      private function set explo1(param1:Class) : void
      {
         var _loc2_:Object = this._1289156655explo1;
         if(_loc2_ !== param1)
         {
            this._1289156655explo1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"explo1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get explo2() : Class
      {
         return this._1289156654explo2;
      }
      
      private function set explo2(param1:Class) : void
      {
         var _loc2_:Object = this._1289156654explo2;
         if(_loc2_ !== param1)
         {
            this._1289156654explo2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"explo2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get explo3() : Class
      {
         return this._1289156653explo3;
      }
      
      private function set explo3(param1:Class) : void
      {
         var _loc2_:Object = this._1289156653explo3;
         if(_loc2_ !== param1)
         {
            this._1289156653explo3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"explo3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get explo4() : Class
      {
         return this._1289156652explo4;
      }
      
      private function set explo4(param1:Class) : void
      {
         var _loc2_:Object = this._1289156652explo4;
         if(_loc2_ !== param1)
         {
            this._1289156652explo4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"explo4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get incen1() : Class
      {
         return this._1184269302incen1;
      }
      
      private function set incen1(param1:Class) : void
      {
         var _loc2_:Object = this._1184269302incen1;
         if(_loc2_ !== param1)
         {
            this._1184269302incen1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"incen1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get incen2() : Class
      {
         return this._1184269301incen2;
      }
      
      private function set incen2(param1:Class) : void
      {
         var _loc2_:Object = this._1184269301incen2;
         if(_loc2_ !== param1)
         {
            this._1184269301incen2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"incen2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get incen3() : Class
      {
         return this._1184269300incen3;
      }
      
      private function set incen3(param1:Class) : void
      {
         var _loc2_:Object = this._1184269300incen3;
         if(_loc2_ !== param1)
         {
            this._1184269300incen3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"incen3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get incen4() : Class
      {
         return this._1184269299incen4;
      }
      
      private function set incen4(param1:Class) : void
      {
         var _loc2_:Object = this._1184269299incen4;
         if(_loc2_ !== param1)
         {
            this._1184269299incen4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"incen4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get shock1() : Class
      {
         return this._903163441shock1;
      }
      
      private function set shock1(param1:Class) : void
      {
         var _loc2_:Object = this._903163441shock1;
         if(_loc2_ !== param1)
         {
            this._903163441shock1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shock1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get shock2() : Class
      {
         return this._903163440shock2;
      }
      
      private function set shock2(param1:Class) : void
      {
         var _loc2_:Object = this._903163440shock2;
         if(_loc2_ !== param1)
         {
            this._903163440shock2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shock2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get shock3() : Class
      {
         return this._903163439shock3;
      }
      
      private function set shock3(param1:Class) : void
      {
         var _loc2_:Object = this._903163439shock3;
         if(_loc2_ !== param1)
         {
            this._903163439shock3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shock3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get shock4() : Class
      {
         return this._903163438shock4;
      }
      
      private function set shock4(param1:Class) : void
      {
         var _loc2_:Object = this._903163438shock4;
         if(_loc2_ !== param1)
         {
            this._903163438shock4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shock4",_loc2_,param1));
            }
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
   }
}

