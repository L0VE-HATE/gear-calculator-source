package gearcalc
{
   public class StatFormatter
   {
      
      private var stats:StatSet;
      
      public var attrs:Vector.<Attribute>;
      
      public var color:uint;
      
      public function StatFormatter(param1:StatSet)
      {
         super();
         this.stats = param1;
         this.color = 16777215;
         this.attrs = new Vector.<Attribute>();
      }
      
      public function formatDisplay(param1:String) : Attribute
      {
         var _loc2_:Attribute = null;
         _loc2_ = new Attribute(param1);
         this.helpFormat(_loc2_);
         this.attrs.push(_loc2_);
         return _loc2_;
      }
      
      private function helpFormat(param1:Attribute) : void
      {
         if(this.stats.getStatType(param1.name) == GearCalcUtil.STAT_TYPE_NUM)
         {
            param1.value = this.stats.getStat(param1.name);
            if(param1.value < 0)
            {
               param1.value = 0;
            }
            switch(param1.name)
            {
               case GearCalcUtil.ATTR_COST:
                  param1.text = "$" + this.commafy(param1.value);
                  break;
               case GearCalcUtil.ATTR_RARITY:
                  param1.text = Math.round(param1.value).toString() + " (" + this.resolveRarity(Math.round(param1.value)) + ")";
                  break;
               case GearCalcUtil.ATTR_FIRERATE:
                  param1.text = (1 / param1.value).toFixed(2);
                  break;
               case GearCalcUtil.ATTR_AMMO_REGEN:
                  param1.text = Math.floor(param1.value).toFixed(0);
                  break;
               case GearCalcUtil.ATTR_HEALTH_REGEN:
                  param1.name += this.stats.getTextStat(Shield.ATTR_ROSE_STR);
                  param1.text = param1.value.toFixed(1);
                  break;
               case GearCalcUtil.ATTR_DAMAGE:
                  if(this.stats.getStat(GearCalcUtil.ATTR_PROJECTILE_COUNT) > 1)
                  {
                     param1.text = (Math.round(param1.value * 100) / 100).toString() + " x " + Math.floor(this.stats.getStat(GearCalcUtil.ATTR_PROJECTILE_COUNT)).toString();
                  }
                  else
                  {
                     param1.text = (Math.round(param1.value * 100) / 100).toString();
                  }
                  break;
               case GearCalcUtil.ATTR_RELOAD:
                  param1.name = "Reload";
                  param1.text = param1.value.toFixed(2) + " sec.";
                  break;
               case GearCalcUtil.ATTR_CRIT:
                  param1.name = "Critical Dmg";
                  param1.text = "+" + Math.round(param1.value * 10000) / 100 + "%";
                  break;
               case GearCalcUtil.ATTR_ZOOM:
                  param1.name = "Zoom FOV";
                  param1.text = param1.value.toFixed(1);
                  break;
               case GearCalcUtil.ATTR_CARD_ACCURACY:
                  param1.text = param1.value.toFixed(2) + "%";
                  break;
               default:
                  param1.text = param1.value.toFixed(2);
            }
         }
         else if(this.stats.getStatType(param1.name) == GearCalcUtil.STAT_TYPE_TEXT)
         {
            param1.text = this.stats.getTextStat(param1.name);
         }
      }
      
      public function commafy(param1:Number) : String
      {
         var _loc2_:String = Math.round(param1).toString();
         var _loc3_:int = _loc2_.length % 3;
         var _loc4_:String = "";
         if(_loc3_ == 0)
         {
            _loc3_ = 3;
         }
         _loc4_ = _loc2_.substring(0,_loc3_);
         while(_loc3_ + 3 <= _loc2_.length)
         {
            _loc4_ = _loc4_ + "," + _loc2_.substr(_loc3_,3);
            _loc3_ += 3;
         }
         return _loc4_;
      }
      
      public function resolveRarity(param1:int) : String
      {
         if(param1 < GearCalcUtil.RARITY_GREEN)
         {
            this.color = GearCalcUtil.COLOR_WHITE;
            return "White";
         }
         if(param1 < GearCalcUtil.RARITY_BLUE)
         {
            this.color = GearCalcUtil.COLOR_GREEN;
            return "Green";
         }
         if(param1 < GearCalcUtil.RARITY_PURPLE)
         {
            this.color = GearCalcUtil.COLOR_BLUE;
            return "Blue";
         }
         if(param1 < GearCalcUtil.RARITY_L_ORANGE)
         {
            this.color = GearCalcUtil.COLOR_PURPLE;
            return "Purple";
         }
         if(param1 < GearCalcUtil.RARITY_ORANGE)
         {
            this.color = GearCalcUtil.COLOR_L_ORANGE;
            return "Light Orange";
         }
         if(param1 < GearCalcUtil.RARITY_D_ORANGE)
         {
            this.color = GearCalcUtil.COLOR_ORANGE;
            return "Orange";
         }
         if(param1 < GearCalcUtil.RARITY_PEARL)
         {
            this.color = GearCalcUtil.COLOR_D_ORANGE;
            return "Dark Orange";
         }
         this.color = GearCalcUtil.COLOR_PEARL;
         return "Pearl";
      }
      
      public function formatText(param1:String) : String
      {
         var _loc2_:Attribute = null;
         var _loc4_:Attribute = null;
         var _loc3_:String = param1 + GearCalcUtil.NEWLINE_STRING + "------------------------------" + GearCalcUtil.NEWLINE_STRING;
         for each(_loc4_ in this.attrs)
         {
            _loc3_ += GearCalcUtil.addSpacesToText(_loc4_.name.toUpperCase() + ": ",18) + _loc4_.text + GearCalcUtil.NEWLINE_STRING;
         }
         return _loc3_;
      }
   }
}

