package gearcalc.card
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.PixelSnapping;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   import flash.text.engine.CFFHinting;
   import flash.text.engine.ElementFormat;
   import flash.text.engine.FontDescription;
   import flash.text.engine.FontLookup;
   import flash.text.engine.FontWeight;
   import flash.text.engine.RenderingMode;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextElement;
   import flash.text.engine.TextLine;
   import gearcalc.Attribute;
   import gearcalc.GearCalcUtil;
   import gearcalc.Part;
   import mx.core.BitmapAsset;
   import mx.events.PropertyChangeEvent;
   
   public class CardPainter implements IEventDispatcher
   {
      
      public static const MAX_COST_DIGITS:int = 7;
      
      public static var bound_x:int = 280;
      
      public static var bound_y:int = 188;
      
      private var _2092791124blankCardClass:Class = CardPainter_blankCardClass;
      
      private var _1743438373symbols:Class = CardPainter_symbols;
      
      private var _739230158shieldSymbols:Class = CardPainter_shieldSymbols;
      
      private var _820799229shieldLine:Class = CardPainter_shieldLine;
      
      public var willowFontCaps:Class = CardPainter_willowFontCaps;
      
      public var projectile_color:uint = 14661125;
      
      public var projectile_size:int;
      
      public var main_font:String = "Prototype";
      
      public var line_font:String = "Prototype";
      
      public var cost_font:String = "Prototype";
      
      public var title_size:int = 21;
      
      public var title_line_offset:int = 1;
      
      public var title_x:int = 12;
      
      public var title_y:int = 31;
      
      public var line_text_size:int = 15;
      
      public var line_line_offset_y:int = this.line_text_size + 4;
      
      public var line_section_offset_x:int = 20;
      
      public var line_section_offset_y:int = 143;
      
      public var level_text_size:int = 14;
      
      public var level_offset_x:int = 39;
      
      public var level_offset_y:int = 19;
      
      public var ammo_x:int = 320;
      
      public var ammo_y:int = 154;
      
      public var symbols_x:int = 32;
      
      public var symbols_y_abs:int = 75;
      
      public var shield_line_x:int = 19;
      
      public var shield_line_y_1:int = 97;
      
      public var shield_line_offset:int = 21;
      
      public var shield_line_len:int = 244;
      
      public var shield_line_width:int = 2;
      
      public var manufact_x:int = 338;
      
      public var manufact_y:int = 172;
      
      public var ele_x:int = 336;
      
      public var ele_y:int = 199;
      
      public var claptrap_center_x:int = 327;
      
      public var claptrap_center_y:int = 56;
      
      public var shield_pic_factor:* = 0.5;
      
      public var gun_pic_factor:* = 0.71;
      
      public var pic_center_x:int = 283;
      
      public var pic_center_y:int = 264;
      
      public var shield_center_y_adjust:int = 20;
      
      public var levelColor:uint = 11058896;
      
      public var level_x:int = 90;
      
      public var level_y:int = 27;
      
      public var level_size:int = 14;
      
      public var attr_x:int = 55;
      
      public var attr_y:int = 94;
      
      public var attr_offset:int = 6;
      
      public var attr_size:int = 16;
      
      public var stat_x_right:int = 255;
      
      public var clip_x:int = 335;
      
      public var clip_y:int = 160;
      
      public var max_name_length:int = 23;
      
      public var cost_origin_x:int = 29;
      
      public var cost_digit_size:int = 26;
      
      public var cost_digit_bound_x:int = 16;
      
      public var cost_origin_y:int = 244 + this.cost_digit_size;
      
      public var cost_digit_offset:int = 19;
      
      private var cardBmp:Bitmap;
      
      private var card:WeaponCard = null;
      
      private var imageSource:GraphicsRepository;
      
      public var unscaledImg:BitmapData;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function CardPainter()
      {
         this.projectile_size = this.line_text_size - 1;
         super();
      }
      
      public static function scaleBitmap(param1:BitmapData, param2:int, param3:int, param4:Boolean = true, param5:Boolean = false) : BitmapData
      {
         var _loc11_:Matrix = null;
         var _loc12_:int = 0;
         var _loc6_:InterpolatedBitmapData = new InterpolatedBitmapData(param1.width,param1.height);
         _loc6_.draw(param1);
         var _loc7_:BitmapData = new BitmapData(param2,param3);
         var _loc8_:Number = param2 / param1.width;
         var _loc9_:Number = param3 / param1.height;
         if(param4)
         {
            _loc9_ = _loc8_ = _loc8_ < _loc9_ ? _loc8_ : _loc9_;
         }
         if(!param5)
         {
            _loc11_ = new Matrix();
            _loc11_.scale(_loc8_,_loc9_);
            _loc7_.draw(param1,_loc11_);
            return _loc7_;
         }
         var _loc10_:int = 0;
         while(_loc10_ < param2)
         {
            _loc12_ = 0;
            while(_loc12_ < param3)
            {
               _loc7_.setPixel(_loc10_,_loc12_,_loc6_.getPixelBilinear(_loc10_ * _loc8_,_loc12_ * _loc9_));
               _loc12_++;
            }
            _loc10_++;
         }
         return _loc7_;
      }
      
      public static function textIt(param1:String, param2:String, param3:int, param4:uint, param5:String, param6:Array) : TextLine
      {
         var _loc7_:FontDescription = new FontDescription();
         _loc7_.fontLookup = FontLookup.EMBEDDED_CFF;
         _loc7_.cffHinting = CFFHinting.HORIZONTAL_STEM;
         _loc7_.renderingMode = RenderingMode.CFF;
         _loc7_.fontName = param2;
         if(param5 != null)
         {
            _loc7_.fontWeight = param5;
         }
         var _loc8_:ElementFormat = new ElementFormat(_loc7_);
         _loc8_.fontSize = param3;
         _loc8_.color = param4;
         var _loc9_:TextElement = new TextElement(param1,_loc8_);
         var _loc10_:TextBlock = new TextBlock();
         _loc10_.content = _loc9_;
         var _loc11_:TextLine = _loc10_.createTextLine();
         if(param6 != null)
         {
            _loc11_.filters = param6;
         }
         return _loc11_;
      }
      
      private function initEmbeddedAssets() : void
      {
         this.cardBmp = new this.blankCardClass() as BitmapAsset;
      }
      
      private function createMatrix(param1:int, param2:int, param3:Number) : Matrix
      {
         var _loc4_:Matrix = new Matrix(1,0,0,1,param1,param2);
         if(param3 != 1)
         {
            _loc4_.scale(param3,param3);
         }
         return _loc4_;
      }
      
      public function paint(param1:Function) : void
      {
         var canvas:BitmapData = null;
         var gunPic:BitmapData = null;
         var updateProgress:Function = null;
         var listener:Function = param1;
         updateProgress = function():void
         {
            var _loc1_:Number = bound_x / canvas.width;
            var _loc2_:Number = bound_y / canvas.height;
            if(_loc1_ < _loc2_)
            {
               _loc2_ = _loc1_;
            }
            else
            {
               _loc1_ = _loc2_;
            }
            gunPic = GraphicsRepository.trim(imageSource.draw(card.clapTrap,card.elemental));
            unscaledImg = canvas;
            var _loc3_:int = card.gearType == GearCalcUtil.GEAR_SHIELD ? shield_center_y_adjust : 0;
            var _loc4_:Number = card.gearType == GearCalcUtil.GEAR_WEAPON ? Number(gun_pic_factor) : Number(shield_pic_factor);
            if(_loc4_ == gun_pic_factor && card.isEridian())
            {
               _loc4_ = gun_pic_factor * 1.1;
            }
            var _loc5_:Matrix = createMatrix(0,0,_loc4_);
            var _loc6_:BitmapData = new BitmapData(gunPic.width * _loc4_,gunPic.height,true,0);
            _loc6_.draw(gunPic,_loc5_);
            canvas.draw(_loc6_,createMatrix(pic_center_x - _loc6_.width / 2,pic_center_y - _loc6_.height / 2 + _loc3_,1));
            var _loc7_:Bitmap = new Bitmap(canvas,PixelSnapping.NEVER,true);
            _loc7_.smoothing = true;
            _loc7_.width = canvas.width * _loc1_;
            _loc7_.height = canvas.height * _loc2_;
            listener(_loc7_);
         };
         this.initEmbeddedAssets();
         canvas = new BitmapData(this.cardBmp.width,this.cardBmp.height,true,0);
         canvas.draw(this.cardBmp);
         this.drawTextLines(canvas);
         this.drawDecorations(canvas);
         this.drawStatText(canvas);
         this.drawGearPic(updateProgress);
         this.drawCost(canvas);
      }
      
      private function drawCost(param1:BitmapData) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc2_:String = this.card.cost.toFixed(0);
         if(_loc2_.length > MAX_COST_DIGITS)
         {
            _loc2_ = "";
            _loc4_ = 0;
            while(_loc4_ < MAX_COST_DIGITS)
            {
               _loc2_ += "9";
               _loc4_++;
            }
         }
         else if(_loc2_.length < MAX_COST_DIGITS)
         {
            _loc4_ = _loc2_.length;
            while(_loc4_ < MAX_COST_DIGITS)
            {
               _loc2_ = "0" + _loc2_;
               _loc4_++;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = textIt(_loc2_.substr(_loc4_,1),this.cost_font,this.cost_digit_size,15658734,FontWeight.BOLD,null);
            _loc5_ = this.cost_origin_x + _loc4_ * this.cost_digit_offset + Math.ceil(this.cost_digit_bound_x / 2 - _loc3_.width / 2);
            param1.draw(_loc3_,this.createMatrix(Math.round(_loc5_),this.cost_origin_y,1));
            _loc4_++;
         }
      }
      
      public function setCardBase(param1:WeaponCard) : void
      {
         this.card = param1;
      }
      
      public function getCardBase() : WeaponCard
      {
         return this.card;
      }
      
      public function drawGearPic(param1:Function) : GraphicsRepository
      {
         var _loc2_:Part = null;
         this.imageSource = new GraphicsRepository();
         for each(_loc2_ in this.card.parts)
         {
            this.imageSource.addRequest(_loc2_.getID());
         }
         this.imageSource.process(param1);
         return this.imageSource;
      }
      
      private function drawStatText(param1:BitmapData) : void
      {
         var _loc7_:Number = NaN;
         var _loc2_:DropShadowFilter = new DropShadowFilter();
         _loc2_.angle = 0;
         _loc2_.blurX = 4;
         _loc2_.blurY = 4;
         _loc2_.color = 3342336;
         _loc2_.distance = 1;
         _loc2_.strength = 2;
         var _loc3_:CardLine = new CardLine();
         _loc3_.text = this.card.name.toUpperCase();
         var _loc4_:CardLine = null;
         if(_loc3_.text.length > this.max_name_length)
         {
            _loc4_ = new CardLine();
            CardFactory.splitLines(_loc3_,_loc4_,this.max_name_length);
         }
         var _loc5_:DisplayObject = textIt(_loc3_.text,this.main_font,this.title_size,this.card.nameColor,null,[_loc2_]);
         param1.draw(_loc5_,this.createMatrix(this.title_x,this.title_y + this.title_size,1));
         if(_loc4_ != null)
         {
            _loc5_ = textIt(_loc4_.text,this.main_font,this.title_size,this.card.nameColor,null,[_loc2_]);
            param1.draw(_loc5_,this.createMatrix(this.title_x,this.title_y + 2 * this.title_size + this.title_line_offset,1));
         }
         _loc5_ = textIt("LEVEL REQUIREMENT: " + this.card.level.toString(),this.line_font,this.level_text_size,this.levelColor,null,[_loc2_]);
         param1.draw(_loc5_,this.createMatrix(this.level_x,this.level_y,1));
         var _loc6_:Attribute = this.card.line(1);
         if(_loc6_ != null)
         {
            _loc5_ = textIt(_loc6_.name,this.line_font,this.attr_size,15658734,null,[_loc2_]);
            param1.draw(_loc5_,this.createMatrix(this.attr_x,this.attr_y,1));
            _loc5_ = textIt(_loc6_.text,this.line_font,this.attr_size,15658734,null,[_loc2_]);
            _loc7_ = this.stat_x_right - _loc5_.width;
            param1.draw(_loc5_,this.createMatrix(_loc7_,this.attr_y,1));
            if(this.card.projectiles > 1)
            {
               _loc5_ = textIt(this.card.projectiles + "x",this.line_font,this.projectile_size,this.projectile_color,null,[_loc2_]);
               param1.draw(_loc5_,this.createMatrix(_loc7_ - _loc5_.width - 1,this.attr_y,1));
            }
         }
         _loc6_ = this.card.line(2);
         if(_loc6_ != null)
         {
            _loc5_ = textIt(_loc6_.name,this.line_font,this.attr_size,15658734,null,[_loc2_]);
            param1.draw(_loc5_,this.createMatrix(this.attr_x,this.attr_y + this.attr_offset + this.attr_size,1));
            _loc5_ = textIt(_loc6_.text,this.line_font,this.attr_size,15658734,null,[_loc2_]);
            param1.draw(_loc5_,this.createMatrix(this.stat_x_right - _loc5_.width,this.attr_y + this.attr_offset + this.attr_size,1));
         }
         _loc6_ = this.card.line(3);
         if(_loc6_ != null)
         {
            _loc5_ = textIt(_loc6_.name,this.line_font,this.attr_size,15658734,null,[_loc2_]);
            param1.draw(_loc5_,this.createMatrix(this.attr_x,this.attr_y + 2 * this.attr_offset + 2 * this.attr_size,1));
            _loc5_ = textIt(_loc6_.text,this.line_font,this.attr_size,15658734,null,[_loc2_]);
            param1.draw(_loc5_,this.createMatrix(this.stat_x_right - _loc5_.width,this.attr_y + 2 * this.attr_offset + 2 * this.attr_size,1));
         }
         if(this.card.gearType == GearCalcUtil.GEAR_WEAPON)
         {
            _loc5_ = textIt(this.card.clip,this.line_font,this.attr_size,15658734,null,[_loc2_]);
            param1.draw(_loc5_,this.createMatrix(this.clip_x,this.clip_y,1));
         }
      }
      
      private function drawTextLines(param1:BitmapData) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:Matrix = null;
         var _loc5_:CardLine = null;
         var _loc2_:int = this.line_section_offset_y + this.line_text_size;
         for each(_loc5_ in this.card.text)
         {
            _loc3_ = textIt(_loc5_.text,this.line_font,this.line_text_size,_loc5_.color,null,null);
            _loc4_ = new Matrix(1,0,0,1,this.line_section_offset_x,_loc2_);
            param1.draw(_loc3_,_loc4_);
            _loc2_ += this.line_line_offset_y;
         }
      }
      
      private function drawDecorations(param1:BitmapData) : void
      {
         var _loc6_:Matrix = null;
         var _loc2_:Number = this.card.gearType == GearCalcUtil.GEAR_WEAPON ? this.claptrap_center_x : this.claptrap_center_x + 9;
         var _loc3_:Number = this.card.gearType == GearCalcUtil.GEAR_WEAPON ? this.claptrap_center_y : this.claptrap_center_y - 1;
         var _loc4_:BitmapData = this.card.getClaptrapImage().bitmapData;
         param1.draw(_loc4_,this.createMatrix(_loc2_ - _loc4_.width / 2,_loc3_ - _loc4_.height / 2,1));
         _loc4_ = this.card.getManufacturerLogo().bitmapData;
         param1.draw(_loc4_,this.createMatrix(this.manufact_x - _loc4_.width / 2,this.manufact_y / 2,1));
         if(this.card.gearType == GearCalcUtil.GEAR_WEAPON)
         {
            _loc4_ = this.card.getAmmoIcon().bitmapData;
            param1.draw(_loc4_,this.createMatrix(this.ammo_x - _loc4_.width / 2,this.ammo_y - _loc4_.height / 2,1));
            _loc4_ = (new this.symbols() as BitmapAsset).bitmapData;
            param1.draw(_loc4_,this.createMatrix(this.symbols_x - _loc4_.width / 2,this.symbols_y_abs,1));
         }
         else if(this.card.gearType == GearCalcUtil.GEAR_SHIELD)
         {
            _loc4_ = (new this.shieldLine() as BitmapAsset).bitmapData;
            _loc6_ = new Matrix();
            _loc6_.scale(this.shield_line_len / _loc4_.width,this.shield_line_width / _loc4_.height);
            _loc6_.translate(this.shield_line_x,this.shield_line_y_1);
            param1.draw(_loc4_,_loc6_);
            _loc4_ = (new this.shieldLine() as BitmapAsset).bitmapData;
            _loc6_.translate(0,this.shield_line_offset);
            param1.draw(_loc4_,_loc6_);
            _loc4_ = (new this.shieldSymbols() as BitmapAsset).bitmapData;
            param1.draw(_loc4_,this.createMatrix(this.symbols_x - _loc4_.width / 2,this.symbols_y_abs,1));
         }
         var _loc5_:BitmapAsset = this.card.getElementalImage();
         if(_loc5_ != null)
         {
            param1.draw(_loc5_.bitmapData,this.createMatrix(this.ele_x - _loc5_.width / 2,this.ele_y - _loc5_.height / 2,1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get blankCardClass() : Class
      {
         return this._2092791124blankCardClass;
      }
      
      public function set blankCardClass(param1:Class) : void
      {
         var _loc2_:Object = this._2092791124blankCardClass;
         if(_loc2_ !== param1)
         {
            this._2092791124blankCardClass = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blankCardClass",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get symbols() : Class
      {
         return this._1743438373symbols;
      }
      
      public function set symbols(param1:Class) : void
      {
         var _loc2_:Object = this._1743438373symbols;
         if(_loc2_ !== param1)
         {
            this._1743438373symbols = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"symbols",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shieldSymbols() : Class
      {
         return this._739230158shieldSymbols;
      }
      
      public function set shieldSymbols(param1:Class) : void
      {
         var _loc2_:Object = this._739230158shieldSymbols;
         if(_loc2_ !== param1)
         {
            this._739230158shieldSymbols = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shieldSymbols",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shieldLine() : Class
      {
         return this._820799229shieldLine;
      }
      
      public function set shieldLine(param1:Class) : void
      {
         var _loc2_:Object = this._820799229shieldLine;
         if(_loc2_ !== param1)
         {
            this._820799229shieldLine = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shieldLine",_loc2_,param1));
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

