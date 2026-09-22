package gearcalc.card
{
   import gearcalc.*;
   
   public class CardFactory
   {
      
      public static const MAX_LINES:int = 5;
      
      public static const MAX_LINE_LENGTH:int = 39;
      
      private var substrate:Weapon;
      
      private var stats:StatSet;
      
      private var base:StatSet;
      
      private var card:WeaponCard;
      
      private var allText:Vector.<CardLine>;
      
      public function CardFactory(param1:Weapon, param2:StatSet)
      {
         super();
         this.substrate = param1;
         this.base = param2;
         this.stats = param1.stats;
         this.card = new WeaponCard(param1.getGearType());
         this.card.name = param1.label;
         this.card.nameColor = GearCalcUtil.resolveRarityColor(this.stats.getStat(GearCalcUtil.ATTR_RARITY));
         this.card.elemental = param1.elemental;
         this.card.manufacturer = param1.getPart(GearCalcUtil.PART_TYPE_MANUFACT).getDisplayName();
         this.card.techLevel = this.stats.getStat(GearCalcUtil.ATTR_TECH);
         this.card.projectiles = Math.floor(this.stats.getStat(GearCalcUtil.ATTR_PROJECTILE_COUNT));
         this.card.level = param1.getExpLevel() - 2;
         this.card.clapTrap = this.resolveClaptrap();
         this.card.ammoType = this.card.clapTrap;
         this.card.rof = (1 / this.stats.getStat(GearCalcUtil.ATTR_FIRERATE)).toFixed(1);
         this.card.accuracy = (100 - 25 / 3 * this.stats.getStat(GearCalcUtil.ATTR_SPREAD)).toFixed(1);
         this.card.clip = Math.floor(this.stats.getStat(GearCalcUtil.ATTR_CLIP)).toString();
         this.card.damage = Math.ceil(this.stats.getStat(GearCalcUtil.ATTR_DAMAGE)).toString();
         this.card.parts = param1.getParts();
         this.card.cost = Math.floor(this.stats.getStat(GearCalcUtil.ATTR_COST));
         this.card.capacity = Math.ceil(this.stats.getStat(GearCalcUtil.ATTR_SHIELD_CAP)).toFixed(0);
         this.card.recharge = Math.round(this.stats.getStat(GearCalcUtil.ATTR_SHIELD_RATE)).toFixed(0);
         this.allText = this.toText(this.processCardMods());
         var _loc3_:Vector.<CardLine> = new Vector.<CardLine>();
         var _loc4_:int = 0;
         while(_loc4_ < MAX_LINES)
         {
            if(_loc4_ < this.allText.length)
            {
               _loc3_.push(this.allText[_loc4_]);
            }
            _loc4_++;
         }
         this.card.text = _loc3_;
      }
      
      public static function splitLines(param1:CardLine, param2:CardLine, param3:int) : void
      {
         var _loc4_:String = param1.text.substr(0,param3);
         var _loc5_:int = _loc4_.lastIndexOf(" ");
         var _loc6_:int = _loc5_ + 1;
         if(_loc5_ == -1)
         {
            _loc6_ = _loc5_ = _loc4_.length;
         }
         param2.text = param1.text.substring(_loc6_);
         param1.text = param1.text.substring(0,_loc5_);
         param2.color = param1.color;
      }
      
      public static function generate(param1:Weapon, param2:StatSet) : CardPainter
      {
         var _loc3_:CardFactory = new CardFactory(param1,param2);
         var _loc4_:CardPainter = new CardPainter();
         _loc4_.setCardBase(_loc3_.card);
         return _loc4_;
      }
      
      private function toText(param1:Vector.<AttributeModifier>) : Vector.<CardLine>
      {
         var lines:Vector.<CardLine> = null;
         var single:CardLine = null;
         var i:int = 0;
         var split:CardLine = null;
         var mods:Vector.<AttributeModifier> = param1;
         var insertAfter:Function = function(param1:CardLine, param2:int):void
         {
            var _loc3_:Vector.<CardLine> = new Vector.<CardLine>();
            var _loc4_:int = 0;
            while(_loc4_ < lines.length)
            {
               _loc3_.push(lines[_loc4_]);
               if(_loc4_ == param2)
               {
                  _loc3_.push(param1);
               }
               _loc4_++;
            }
            lines = _loc3_;
         };
         lines = new Vector.<CardLine>();
         i = 0;
         while(i < mods.length)
         {
            single = new CardLine();
            if(mods[i].getAttrToMod() == GearCalcUtil.CARD_MOD_TEXT)
            {
               single.text = mods[i].getText();
               single.color = mods[i].variable;
            }
            else
            {
               single.text = this.formatStat(mods[i]);
            }
            lines.push(single);
            i++;
         }
         i = 0;
         while(i < lines.length)
         {
            if(lines[i].text.length > MAX_LINE_LENGTH)
            {
               split = new CardLine();
               splitLines(lines[i],split,MAX_LINE_LENGTH);
               insertAfter(split,i);
            }
            i++;
         }
         return lines;
      }
      
      private function formatStat(param1:AttributeModifier) : String
      {
         var diff:Number = NaN;
         var num:Number = NaN;
         var check:Number = NaN;
         var mod:AttributeModifier = param1;
         var ceilOrFloor:Function = function(param1:Number):Number
         {
            if(param1 > 0)
            {
               return Math.floor(param1);
            }
            return Math.ceil(param1);
         };
         diff = this.stats.getStat(mod.getAttrToMod()) - this.base.getStat(mod.getAttrToMod());
         num = this.base.getStat(mod.getAttrToMod());
         var sign:String = "";
         var str:String = "";
         var signageNormal:Boolean = true;
         switch(mod.getAttrToMod())
         {
            case GearCalcUtil.ATTR_CLIP:
               str = ceilOrFloor(diff).toFixed(0) + " Magazine Size";
               break;
            case GearCalcUtil.ATTR_RECOIL:
               str = Math.abs(diff / num * 100).toFixed(0) + "% Recoil Reduction";
               break;
            case GearCalcUtil.ATTR_FIRERATE:
               str = Math.abs(diff / num * 100).toFixed(0) + "% " + mod.getAttrToMod();
               break;
            case GearCalcUtil.ATTR_ZOOM:
               str = ((num - Math.round(this.stats.getStat(GearCalcUtil.ATTR_ZOOM))) / 10).toFixed(1) + "x Zoom";
               break;
            case GearCalcUtil.ATTR_RELOAD:
               str = Math.abs(diff / num * 100).toFixed(0) + "% " + mod.getAttrToMod();
               break;
            case GearCalcUtil.ATTR_BURST_COUNT:
               str = Math.floor(diff).toFixed(0) + " " + mod.getAttrToMod();
               break;
            case GearCalcUtil.ATTR_SPREAD:
               check = Math.abs(Math.floor(diff / num * 100));
               check = check >= 0 ? check : 0;
               str = check.toFixed(0) + "% Accuracy";
               break;
            case GearCalcUtil.ATTR_PROJECTILE_COUNT:
               str = ceilOrFloor(diff).toFixed(0) + " Projectiles Fired";
               break;
            case GearCalcUtil.ATTR_AMMO_REGEN:
               str = Math.floor(diff).toFixed(0) + " Ammo Regeneration";
               break;
            case GearCalcUtil.ATTR_CRIT:
               str = (diff * 100).toFixed(0) + "% Critical Damage";
               break;
            case GearCalcUtil.ATTR_MELEE:
               str = (diff * 100).toFixed(0) + "% Melee Damage";
               break;
            default:
               str = (diff / num * 100).toFixed(0) + "% " + mod.getAttrToMod();
         }
         if(GearCalcUtil.isBiggerBetter(mod.getAttrToMod()))
         {
            if(diff > 0)
            {
               sign = "+";
            }
         }
         else if(mod.getAttrToMod() != GearCalcUtil.ATTR_ZOOM)
         {
            if(diff < 0)
            {
               sign = "+";
            }
            else
            {
               sign = "-";
            }
         }
         return sign + str;
      }
      
      private function resolveClaptrap() : String
      {
         var _loc1_:Part = this.substrate.getPart(GearCalcUtil.PART_TYPE_TYPE);
         if(_loc1_ != null)
         {
            if(_loc1_.getTrueName().indexOf("machinegun") != -1 || _loc1_.getTrueName().indexOf("combat_rifle") != -1)
            {
               return WeaponCard.CLAPTRAP_RIFLE;
            }
            if(_loc1_.getTrueName().indexOf("Eridan") != -1)
            {
               return WeaponCard.CLAPTRAP_ERIDIAN;
            }
            if(_loc1_.getTrueName().indexOf("revolver") != -1)
            {
               return WeaponCard.CLAPTRAP_REVOLVER;
            }
            if(_loc1_.getTrueName().indexOf("repeater") != -1 || _loc1_.getTrueName().indexOf("machine_pistol") != -1)
            {
               return WeaponCard.CLAPTRAP_REPEATER;
            }
            if(_loc1_.getTrueName().indexOf("shotgun") != -1)
            {
               return WeaponCard.CLAPTRAP_SHOTGUN;
            }
            if(_loc1_.getTrueName().indexOf("sniper") != -1)
            {
               return WeaponCard.CLAPTRAP_SNIPER;
            }
            if(_loc1_.getTrueName().indexOf("smg") != -1)
            {
               return WeaponCard.CLAPTRAP_SMG;
            }
            if(_loc1_.getTrueName().indexOf("launcher") != -1)
            {
               return WeaponCard.CLAPTRAP_LAUNCHER;
            }
            if(_loc1_.getTrueName().indexOf("shield") != -1)
            {
               return WeaponCard.CLAPTRAP_SHIELD;
            }
         }
         return "";
      }
      
      private function processCardMods() : Vector.<AttributeModifier>
      {
         var _loc3_:Vector.<AttributeModifier> = null;
         var _loc4_:Part = null;
         var _loc5_:Vector.<AttributeModifier> = null;
         var _loc6_:Vector.<AttributeModifier> = null;
         var _loc7_:AttributeModifier = null;
         var _loc8_:Boolean = false;
         var _loc9_:AttributeModifier = null;
         var _loc10_:int = 0;
         var _loc1_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         var _loc2_:Vector.<Part> = this.substrate.getParts();
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = _loc4_.getCardMods();
            for each(_loc7_ in _loc3_)
            {
               _loc1_.push(_loc7_);
            }
         }
         _loc5_ = this.sumLikeMods(_loc1_);
         _loc5_ = this.removeLessThanTreshold(_loc5_,0.05);
         _loc6_ = this.getAllCardText(_loc1_,this.card.elemental);
         _loc1_ = new Vector.<AttributeModifier>();
         for each(_loc7_ in _loc5_)
         {
            _loc1_.push(_loc7_);
         }
         for each(_loc7_ in _loc6_)
         {
            _loc1_.push(_loc7_);
         }
         _loc8_ = false;
         while(!_loc8_)
         {
            _loc8_ = true;
            _loc10_ = 0;
            while(_loc10_ < _loc1_.length - 1)
            {
               if(_loc1_[_loc10_].getValue() < _loc1_[_loc10_ + 1].getValue())
               {
                  _loc9_ = _loc1_[_loc10_];
                  _loc1_[_loc10_] = _loc1_[_loc10_ + 1];
                  _loc1_[_loc10_ + 1] = _loc9_;
                  _loc8_ = false;
               }
               _loc10_++;
            }
         }
         return _loc1_;
      }
      
      private function removeLessThanTreshold(param1:Vector.<AttributeModifier>, param2:Number) : Vector.<AttributeModifier>
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:AttributeModifier = null;
         var _loc5_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         for each(_loc6_ in param1)
         {
            _loc3_ = this.base.getStat(_loc6_.getAttrToMod());
            _loc4_ = this.stats.getStat(_loc6_.getAttrToMod());
            if(_loc6_.getAttrToMod() == GearCalcUtil.ATTR_CLIP || _loc6_.getAttrToMod() == GearCalcUtil.ATTR_BURST_COUNT || _loc6_.getAttrToMod() == GearCalcUtil.ATTR_PROJECTILE_COUNT)
            {
               if(Math.abs(Math.floor(_loc3_) - Math.floor(_loc4_)) / _loc4_ >= param2)
               {
                  if(GearCalcUtil.isBiggerBetter(_loc6_.getAttrToMod()) && _loc4_ > _loc3_)
                  {
                     _loc5_.push(_loc6_);
                  }
                  else if(!GearCalcUtil.isBiggerBetter(_loc6_.getAttrToMod()) && _loc4_ < _loc3_)
                  {
                     _loc5_.push(_loc6_);
                  }
               }
            }
            else if(_loc6_.getAttrToMod() == GearCalcUtil.ATTR_MELEE && _loc4_ > _loc3_)
            {
               _loc5_.push(_loc6_);
            }
            else if(Math.abs(_loc3_ - _loc4_) / _loc4_ >= param2)
            {
               if(GearCalcUtil.isBiggerBetter(_loc6_.getAttrToMod()) && _loc4_ > _loc3_)
               {
                  _loc5_.push(_loc6_);
               }
               else if(!GearCalcUtil.isBiggerBetter(_loc6_.getAttrToMod()) && _loc4_ < _loc3_)
               {
                  _loc5_.push(_loc6_);
               }
            }
         }
         return _loc5_;
      }
      
      private function sumLikeMods(param1:Vector.<AttributeModifier>) : Vector.<AttributeModifier>
      {
         var temp:AttributeModifier = null;
         var mod:AttributeModifier = null;
         var unproc:AttributeModifier = null;
         var raw:Vector.<AttributeModifier> = param1;
         var isInVector:Function = function(param1:AttributeModifier, param2:Vector.<AttributeModifier>):Boolean
         {
            var _loc3_:AttributeModifier = null;
            for each(_loc3_ in param2)
            {
               if(_loc3_.getAttrToMod() == param1.getAttrToMod())
               {
                  return true;
               }
            }
            return false;
         };
         var sums:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         for each(mod in raw)
         {
            if(!isInVector(mod,sums) && mod.getAttrToMod() != GearCalcUtil.CARD_MOD_TEXT)
            {
               temp = new AttributeModifier(null,mod.getAttrToMod(),mod.getModType());
               temp.setValue(0);
               sums.push(temp);
            }
         }
         for each(mod in sums)
         {
            for each(unproc in raw)
            {
               if(mod.getAttrToMod() == unproc.getAttrToMod())
               {
                  mod.setValue(mod.getValue() + unproc.getValue());
               }
            }
         }
         return sums;
      }
      
      private function getAllCardText(param1:Vector.<AttributeModifier>, param2:String) : Vector.<AttributeModifier>
      {
         var text:Vector.<AttributeModifier> = null;
         var mod:AttributeModifier = null;
         var tempMod:AttributeModifier = null;
         var anotherMod:AttributeModifier = null;
         var vec:Vector.<AttributeModifier> = param1;
         var eleStr:String = param2;
         var isInVector:Function = function(param1:AttributeModifier):Boolean
         {
            var _loc2_:AttributeModifier = null;
            for each(_loc2_ in text)
            {
               if(_loc2_.getText() == param1.getText())
               {
                  return true;
               }
            }
            return false;
         };
         text = new Vector.<AttributeModifier>();
         for each(mod in vec)
         {
            if(mod.getModType() == GearCalcUtil.CARD_MOD_TEXT && mod.getAttrToMod() == GearCalcUtil.CARD_MOD_TEXT && !isInVector(mod))
            {
               text.push(mod);
            }
         }
         tempMod = new AttributeModifier(null,GearCalcUtil.CARD_MOD_TEXT,GearCalcUtil.CARD_MOD_TEXT);
         anotherMod = new AttributeModifier(null,GearCalcUtil.CARD_MOD_TEXT,GearCalcUtil.CARD_MOD_TEXT);
         tempMod.setValue(100);
         anotherMod.setValue(99);
         switch(eleStr)
         {
            case GearCalcUtil.TECH_SHOCK:
               tempMod.variable = WeaponCard.COLOR_SHOCK;
               tempMod.setText("Highly effective vs Shields");
               anotherMod.variable = WeaponCard.COLOR_SHOCK;
               anotherMod.setText("Chance to electrocute enemies");
               break;
            case GearCalcUtil.TECH_CORROSIVE:
               tempMod.variable = WeaponCard.COLOR_CORROSIVE;
               tempMod.setText("Highly effective vs Armor");
               anotherMod.variable = WeaponCard.COLOR_CORROSIVE;
               anotherMod.setText("Chance to Corrode enemies");
               break;
            case GearCalcUtil.TECH_INCENDIARY:
               tempMod.variable = WeaponCard.COLOR_INCENDIARY;
               tempMod.setText("Highly effective vs Flesh");
               anotherMod.variable = WeaponCard.COLOR_INCENDIARY;
               anotherMod.setText("Chance to light enemies on fire");
               break;
            case GearCalcUtil.TECH_EXPLOSIVE:
               tempMod.variable = WeaponCard.COLOR_EXPLOSIVE;
               tempMod.setText("Chance to cause explosions");
               anotherMod = null;
               break;
            default:
               return text;
         }
         text.push(tempMod);
         if(anotherMod != null)
         {
            text.push(anotherMod);
         }
         return text;
      }
   }
}

