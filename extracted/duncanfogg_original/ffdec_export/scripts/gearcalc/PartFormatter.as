package gearcalc
{
   import flash.text.engine.FontWeight;
   import flashx.textLayout.elements.BreakElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TextFlow;
   
   public class PartFormatter
   {
      
      public var part:Part = null;
      
      public var fontSize:int = 11;
      
      private var source:PartCollection;
      
      public function PartFormatter(param1:Part, param2:PartCollection)
      {
         super();
         this.part = param1;
         this.source = param2;
      }
      
      public function formatTLF() : TextFlow
      {
         var _loc5_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Part = null;
         var _loc9_:Number = NaN;
         var _loc1_:Vector.<AttributeModifier> = this.part.getAttrModifiers();
         var _loc2_:TextFlow = new TextFlow();
         var _loc3_:ParagraphElement = new ParagraphElement();
         var _loc4_:SpanElement = new SpanElement();
         _loc4_.fontWeight = FontWeight.BOLD;
         _loc4_.fontSize = this.fontSize + 1;
         _loc4_.text = this.part.getTrueName();
         _loc3_.fontSize = this.fontSize;
         _loc3_.addChild(_loc4_);
         _loc3_.addChild(new BreakElement());
         _loc3_.addChild(new BreakElement());
         _loc2_.addChild(_loc3_);
         if(this.part.getManufacturer() != null)
         {
            _loc4_ = new SpanElement();
            _loc4_.text = "Manufacturer:  ";
            _loc4_.fontWeight = FontWeight.BOLD;
            _loc3_.addChild(_loc4_);
            _loc4_ = new SpanElement();
            _loc4_.text = this.part.getManufacturer();
            _loc3_.addChild(_loc4_);
            _loc3_.addChild(new BreakElement());
         }
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            if(_loc1_[_loc5_].getAttrToMod() != GearCalcUtil.ATTR_DMG_IS_ELEMENTAL)
            {
               _loc4_ = new SpanElement();
               _loc4_.text = _loc1_[_loc5_].getAttrToMod() + ":  ";
               _loc4_.fontWeight = FontWeight.BOLD;
               _loc3_.addChild(_loc4_);
               _loc4_ = new SpanElement();
               if(_loc1_[_loc5_].getValue() > 0 && _loc1_[_loc5_].getAttrToMod() != GearCalcUtil.ATTR_FIRERATE)
               {
                  _loc4_.text += "+";
               }
               if(_loc1_[_loc5_].getValue() < 0 && (GearCalcUtil.isBiggerBetter(_loc1_[_loc5_].getAttrToMod()) || !_loc1_[_loc5_].getAttrToMod() == GearCalcUtil.ATTR_FIRERATE))
               {
                  _loc4_.color = 16711680;
               }
               else if(_loc1_[_loc5_].getValue() > 0 && (!GearCalcUtil.isBiggerBetter(_loc1_[_loc5_].getAttrToMod()) || _loc1_[_loc5_].getAttrToMod() == GearCalcUtil.ATTR_FIRERATE))
               {
                  _loc4_.color = 16711680;
               }
               if(_loc1_[_loc5_].getModType() == GearCalcUtil.MOD_PREADD)
               {
                  _loc4_.text += (Math.round(_loc1_[_loc5_].getValue() * 100) / 100).toString();
                  if(_loc1_[_loc5_].getAttrToMod() != GearCalcUtil.ATTR_RARITY)
                  {
                     _loc4_.text += "  (Pre Add)";
                  }
               }
               else if(_loc1_[_loc5_].getModType() == GearCalcUtil.MOD_SCALE)
               {
                  _loc4_.text = _loc4_.text + (Math.round(_loc1_[_loc5_].getValue() * 10000) / 100).toString() + "%";
               }
               else if(_loc1_[_loc5_].getAttrToMod() == GearCalcUtil.ATTR_COST)
               {
                  _loc4_.text = _loc4_.text + (Math.round(_loc1_[_loc5_].getValue() * 100) / 100).toString() + "  (Multiplier)";
               }
               else if(_loc1_[_loc5_].getModType() == GearCalcUtil.MOD_POSTADD)
               {
                  _loc4_.text = _loc4_.text + (Math.round(_loc1_[_loc5_].getValue() * 100) / 100).toString() + "  (Post Add)";
               }
               if(_loc1_[_loc5_].getActiveState() == GearCalcUtil.MOD_STATE_ZOOM)
               {
                  _loc4_.text += " (Zoomed)";
               }
               if(_loc1_[_loc5_].getAttrToMod() == GearCalcUtil.ATTR_FIRERATE)
               {
                  _loc7_ = -1;
                  if(_loc1_[_loc5_].getValue() > 0)
                  {
                     _loc4_.text = "-";
                  }
                  else
                  {
                     _loc4_.text = "+";
                     _loc7_ = 1;
                  }
                  if(_loc1_[_loc5_].getModType() == GearCalcUtil.MOD_SCALE)
                  {
                     _loc4_.text = _loc4_.text + Math.abs((Math.pow(Math.abs(_loc1_[_loc5_].getValue()) + 1,_loc7_) - 1) * 100).toFixed(0) + "%";
                  }
                  else if(_loc1_[_loc5_].getModType() == GearCalcUtil.MOD_PREADD)
                  {
                     _loc4_.text = _loc4_.text + 1 / Math.abs(_loc1_[_loc5_].getValue()) + " (Pre Add)";
                  }
                  else if(_loc1_[_loc5_].getModType() == GearCalcUtil.MOD_POSTADD)
                  {
                     _loc4_.text = _loc4_.text + 1 / Math.abs(_loc1_[_loc5_].getValue()) + " (Post Add)";
                  }
               }
               _loc3_.addChild(_loc4_);
               _loc3_.addChild(new BreakElement());
            }
            _loc5_++;
         }
         var _loc6_:Vector.<TechAbility> = this.part.getTechAbilities();
         if(_loc6_.length > 0)
         {
            _loc3_.addChild(new BreakElement());
            _loc4_ = new SpanElement();
            _loc4_.text = "Elemental Abilities";
            _loc4_.fontWeight = FontWeight.BOLD;
            _loc3_.addChild(_loc4_);
            _loc3_.addChild(new BreakElement());
         }
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc4_ = new SpanElement();
            _loc4_.fontWeight = FontWeight.BOLD;
            switch(_loc6_[_loc5_].getType())
            {
               case GearCalcUtil.TECH_CORROSIVE:
                  _loc4_.color = 3403264;
                  break;
               case GearCalcUtil.TECH_EXPLOSIVE:
                  _loc4_.color = 16776994;
                  break;
               case GearCalcUtil.TECH_SHOCK:
                  _loc4_.color = 255;
                  break;
               case GearCalcUtil.TECH_INCENDIARY:
                  _loc4_.color = 16742144;
                  break;
               case GearCalcUtil.TECH_CHIMERA:
                  _loc4_.color = 5592405;
            }
            _loc4_.text = "(" + _loc6_[_loc5_].getRelativeGrade() + ") " + _loc6_[_loc5_].getType() + ":  ";
            _loc3_.addChild(_loc4_);
            _loc8_ = this.source.retrieve(_loc6_[_loc5_].bullet);
            _loc9_ = 1;
            if(_loc8_ != null)
            {
               _loc9_ = GearCalcUtil.getAttrMod(GearCalcUtil.ATTR_DAMAGE,_loc8_.getAttrModifiers()).getValue();
            }
            _loc4_ = new SpanElement();
            _loc4_.text = (Math.round(_loc6_[_loc5_].getProcChance() * 100) / 100).toString() + "% chance to proc at tech level ";
            _loc4_.text = _loc4_.text + _loc6_[_loc5_].getLevel() + " costing " + _loc6_[_loc5_].getCost() + " for " + _loc9_.toFixed(1) + "X damage";
            _loc3_.addChild(_loc4_);
            _loc3_.addChild(new BreakElement());
            _loc5_++;
         }
         return _loc2_;
      }
   }
}

