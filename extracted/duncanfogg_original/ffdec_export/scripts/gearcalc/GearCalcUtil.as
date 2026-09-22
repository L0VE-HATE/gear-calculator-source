package gearcalc
{
   import flash.errors.IOError;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   
   public class GearCalcUtil
   {
      
      public static var NEWLINE_STRING:String;
      
      internal static var attrLookup:Vector.<Attribute>;
      
      public static const GEAR_WEAPON:int = 3;
      
      public static const GEAR_COM:int = 6;
      
      public static const GEAR_SHIELD:int = 9;
      
      public static const GEAR_GLOBAL:int = 12;
      
      public static const TECH_NONE:String = "None";
      
      public static const TECH_INCENDIARY:String = "Incendiary";
      
      public static const TECH_CORROSIVE:String = "Corrosive";
      
      public static const TECH_SHOCK:String = "Shock";
      
      public static const TECH_EXPLOSIVE:String = "Explosive";
      
      public static const TECH_CHIMERA:String = "Chimera";
      
      public static const PART_TYPE_GENERAL_NAME:String = "Prefix/Title";
      
      public static const PART_TYPE_SHIELD_BODY:String = "Shield Body";
      
      public static const PART_TYPE_SHIELD_LEFT:String = "Shield Left Side";
      
      public static const PART_TYPE_SHIELD_RIGHT:String = "Shield Right Side";
      
      public static const PART_TYPE_COM_BODY:String = "COM Body";
      
      public static const PART_TYPE_COM_LEFT:String = "COM Left Side";
      
      public static const PART_TYPE_COM_RIGHT:String = "COM Right Side";
      
      public static const PART_TYPE_NULL:String = "None";
      
      public static const PART_TYPE_TITLE:String = "Title";
      
      public static const PART_TYPE_PREFIX:String = "Prefix";
      
      public static const PART_TYPE_BARREL:String = "Barrel";
      
      public static const PART_TYPE_ACCESSORY:String = "Accessory";
      
      public static const PART_TYPE_BODY:String = "Body";
      
      public static const PART_TYPE_GRIP:String = "Grip";
      
      public static const PART_TYPE_STOCK:String = "Stock";
      
      public static const PART_TYPE_SIGHT:String = "Sight";
      
      public static const PART_TYPE_MAG:String = "Magazine";
      
      public static const PART_TYPE_ACTION:String = "Action";
      
      public static const PART_TYPE_TYPE:String = "Gear Type";
      
      public static const PART_TYPE_GRADE:String = "Item Grade";
      
      public static const PART_TYPE_MANUFACT:String = "Manufacturer";
      
      public static const PART_TYPE_MATERIAL:String = "Material";
      
      public static const PART_TYPE_LEFT:String = "Left Side";
      
      public static const PART_TYPE_RIGHT:String = "Right";
      
      public static const PART_UNIQUE:String = "u";
      
      public static const PART_NONE:String = "None";
      
      public static const PART_BULLET:String = "Bullet";
      
      public static const ATTR_COOL_RATE:String = "Cooldown Rate";
      
      public static const ATTR_COOL_DELAY:String = "Cooldown Delay";
      
      public static const ATTR_COOL_FIRE:String = "Fire Regen Delay";
      
      public static const ATTR_FIRING_CONE:String = "Firing Cone Angle";
      
      public static const ATTR_TECH_REGEN:String = "Tech Regen";
      
      public static const ATTR_DPS:String = "DPS";
      
      public static const ATTR_DMG_IS_ELEMENTAL:String = "Elemental Flag";
      
      public static const ATTR_BURST_COUNT:String = "Burst Count";
      
      public static const ATTR_SHOT_COST:String = "Shot Cost";
      
      public static const ATTR_ZOOM:String = "Zoom End FOV";
      
      public static const ATTR_DAMAGE:String = "Damage";
      
      public static const ATTR_FIRERATE:String = "Fire Rate";
      
      public static const ATTR_CLIP:String = "Clip Size";
      
      public static const ATTR_RELOAD:String = "Reload Speed";
      
      public static const ATTR_AMMO_REGEN:String = "Ammo Regen";
      
      public static const ATTR_EXPLEVEL:String = "Weapon Level";
      
      public static const ATTR_RECOIL:String = "Recoil";
      
      public static const ATTR_CRIT:String = "Critical Damage";
      
      public static const ATTR_SPREAD:String = "Spread";
      
      public static const ATTR_CARD_ACCURACY:String = "Accuracy";
      
      public static const ATTR_TECH_POOL:String = "Tech Pool";
      
      public static const ATTR_ACC_REGEN:String = "Accuracy Regen Rate";
      
      public static const ATTR_ACC_MIN:String = "Accuracy Minimum";
      
      public static const ATTR_ACC_MAX:String = "Accuracy Maximum";
      
      public static const ATTR_TECH:String = "Tech Level";
      
      public static const ATTR_MELEE:String = "Melee Damage";
      
      public static const ATTR_PRIORITY:String = "Priority";
      
      public static const ATTR_COST:String = "Cost";
      
      public static const ATTR_RARITY:String = "Rarity";
      
      public static const ATTR_DAMAGE_NORMAL:String = "Normalized Damage";
      
      public static const ATTR_PROJECTILE_COUNT:String = "Projectile Count";
      
      public static const ATTR_HEALTH_REGEN:String = "Health Regen";
      
      public static const ATTR_BLAST_RADIUS:String = "Blast Radius";
      
      public static const ATTR_DPS_ACC_NORM:String = "DPS/Cone2";
      
      public static const ATTR_SHIELD_CAP:String = "Capacity";
      
      public static const ATTR_SHIELD_RATE:String = "Recharge Rate";
      
      public static const ATTR_SHIELD_DELAY:String = "Recharge Delay";
      
      public static const ATTR_INCEN_I_RESIST:String = "Incendiary Impact Multiplier";
      
      public static const ATTR_INCEN_P_RESIST:String = "Incendiary Passive Multiplier";
      
      public static const ATTR_SHOCK_I_RESIST:String = "Shock Impact Multiplier";
      
      public static const ATTR_SHOCK_P_RESIST:String = "Shock Passive Multiplier";
      
      public static const ATTR_CORR_I_RESIST:String = "Corrosive Impact Multiplier";
      
      public static const ATTR_CORR_P_RESIST:String = "Corrosive Passive Multiplier";
      
      public static const ATTR_SHIELD_TIME:String = "Recharge Time";
      
      public static const MOD_STATE_ZOOM:String = "Zoom";
      
      public static const MOD_STATE_ALL:String = "General";
      
      public static const CARD_MOD_TEXT:String = "Card Text";
      
      public static const MOD_PREADD:String = "PreAdd";
      
      public static const MOD_SCALE:String = "Scale";
      
      public static const MOD_POSTADD:String = "PostAdd";
      
      public static const MOD_MULTIPLIER:String = "Multiplier";
      
      public static const OBJ_PART_NULL:Part = new Part("xxxx",PART_NONE);
      
      public static const ON_WEAPON_CHANGED:String = "Weapon Changed";
      
      public static const XML_RULE_DELIMITER:String = ",";
      
      public static const XML_RULE_RANGE_DELIMITER:String = "-";
      
      public static const XML_ID_LENGTH:int = 4;
      
      public static const STAT_TYPE_NUM:String = "Numerical Stat";
      
      public static const STAT_TYPE_TEXT:String = "String Stat";
      
      public static const NUM_WEAPON_SLOTS:int = 14;
      
      public static var scalersLaunchers:Array = [-6,-8,-11,-13];
      
      public static const NAME_TITLE_TEXT:String = "_TT";
      
      public static const NAME_TITLE_ADDEND:String = "_TA";
      
      public static const RARITY_GREEN:int = 5;
      
      public static const RARITY_BLUE:int = 11;
      
      public static const RARITY_PURPLE:int = 16;
      
      public static const RARITY_L_ORANGE:int = 50;
      
      public static const RARITY_ORANGE:int = 61;
      
      public static const RARITY_D_ORANGE:int = 66;
      
      public static const RARITY_PEARL:int = 101;
      
      public static const COLOR_WHITE:uint = 16777215;
      
      public static const COLOR_GREEN:uint = 3407616;
      
      public static const COLOR_BLUE:uint = 3111167;
      
      public static const COLOR_PURPLE:uint = 9515720;
      
      public static const COLOR_L_ORANGE:uint = 16776960;
      
      public static const COLOR_ORANGE:uint = 16750080;
      
      public static const COLOR_D_ORANGE:uint = 14448640;
      
      public static const COLOR_PEARL:uint = 65480;
      
      public static var slotReqs:Vector.<String> = new Vector.<String>();
      
      slotReqs.push(GearCalcUtil.PART_TYPE_GRADE);
      slotReqs.push(GearCalcUtil.PART_TYPE_MANUFACT);
      slotReqs.push(GearCalcUtil.PART_TYPE_TYPE);
      slotReqs.push(GearCalcUtil.PART_TYPE_BODY);
      slotReqs.push(GearCalcUtil.PART_TYPE_GRIP);
      slotReqs.push(GearCalcUtil.PART_TYPE_MAG);
      slotReqs.push(GearCalcUtil.PART_TYPE_BARREL);
      slotReqs.push(GearCalcUtil.PART_TYPE_SIGHT);
      slotReqs.push(GearCalcUtil.PART_TYPE_STOCK);
      slotReqs.push(GearCalcUtil.PART_TYPE_ACTION);
      slotReqs.push(GearCalcUtil.PART_TYPE_ACCESSORY);
      slotReqs.push(GearCalcUtil.PART_TYPE_MATERIAL);
      slotReqs.push(GearCalcUtil.PART_TYPE_PREFIX);
      slotReqs.push(GearCalcUtil.PART_TYPE_TITLE);
      
      internal static var active:Vector.<URLLoader> = new Vector.<URLLoader>();
      
      if(Capabilities.os.indexOf("Windows") != -1)
      {
         NEWLINE_STRING = "\r\n";
      }
      else
      {
         NEWLINE_STRING = "\n";
      }
      
      public function GearCalcUtil()
      {
         super();
      }
      
      public static function addSpacesToText(param1:String, param2:int) : String
      {
         var _loc3_:String = param1;
         while(_loc3_.length < param2)
         {
            _loc3_ += " ";
         }
         return _loc3_;
      }
      
      public static function loadXMLFile(param1:String, param2:Function) : void
      {
         var xml:XML = null;
         var updateQueue:Function = null;
         var urlLoader:URLLoader = null;
         var file:String = param1;
         var listener:Function = param2;
         updateQueue = function(param1:Event):void
         {
            var _loc3_:URLLoader = null;
            var _loc2_:Vector.<URLLoader> = new Vector.<URLLoader>();
            for each(_loc3_ in active)
            {
               if(_loc3_ != urlLoader)
               {
                  _loc2_.push(_loc3_);
               }
            }
         };
         try
         {
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,listener);
            urlLoader.addEventListener(Event.COMPLETE,updateQueue);
            urlLoader.load(new URLRequest(file));
         }
         catch(err:IOError)
         {
            trace(err.toString());
         }
      }
      
      public static function abortAllLoading() : void
      {
         var loader:URLLoader = null;
         for each(loader in active)
         {
            try
            {
               loader.close();
            }
            catch(e:Error)
            {
               trace(e.toString());
            }
         }
         active = new Vector.<URLLoader>();
      }
      
      public static function parseCardModsFromXML(param1:Part, param2:XMLList) : Vector.<AttributeModifier>
      {
         var _loc5_:int = 0;
         var _loc3_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         var _loc4_:AttributeModifier = null;
         _loc5_ = 0;
         while(_loc5_ < param2.Damage.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_DAMAGE,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.Damage[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.AccMin.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_ACC_MIN,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.AccMin[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.AccMax.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_ACC_MAX,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.AccMax[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.AccRegen.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_ACC_REGEN,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.AccRegen[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.FireRate.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_FIRERATE,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.FireRate[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ClipSize.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_CLIP,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.ClipSize[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.Recoil.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_RECOIL,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.Recoil[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ZoomEndFOV.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_ZOOM,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.ZoomEndFOV[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.AmmoRegen.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_AMMO_REGEN,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.AmmoRegen[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ReloadSpeed.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_RELOAD,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.ReloadSpeed[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.Spread.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_SPREAD,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.Spread[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.WeaponLevel.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_EXPLEVEL,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.WeaponLevel[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.CritBonus.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_CRIT,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.CritBonus[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.BurstCount.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_BURST_COUNT,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.BurstCount[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ProjectileCount.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_PROJECTILE_COUNT,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.ProjectileCount[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ShotCost.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_SHOT_COST,CARD_MOD_TEXT);
            _loc4_.setValue(new Number(param2.ShotCost[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         return _loc3_;
      }
      
      private static function checkModState(param1:XML, param2:AttributeModifier) : void
      {
         if(param1.@state == MOD_STATE_ZOOM)
         {
            param2.setActiveState(MOD_STATE_ZOOM);
         }
         else
         {
            param2.setActiveState(MOD_STATE_ALL);
         }
      }
      
      public static function parseMods(param1:Part, param2:XMLList, param3:Boolean) : Vector.<AttributeModifier>
      {
         var _loc7_:String = null;
         var _loc4_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         var _loc5_:AttributeModifier = null;
         var _loc6_:XMLList = param2.children();
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.length())
         {
            if(_loc6_[_loc8_].nodeKind() == "element")
            {
               _loc7_ = isInLookup(_loc6_[_loc8_].localName());
               _loc7_ = _loc7_ != null ? _loc7_ : _loc6_[_loc8_].localName();
               if(param3)
               {
                  _loc5_ = new AttributeModifier(param1,_loc7_,_loc6_[_loc8_].@modType);
                  checkModState(_loc6_[_loc8_],_loc5_);
                  if(_loc6_[_loc8_].@init.length() == 1)
                  {
                     _loc5_.setInitDefinition(_loc6_[_loc8_].@init);
                  }
               }
               else
               {
                  _loc5_ = new AttributeModifier(param1,_loc7_,CARD_MOD_TEXT);
               }
               _loc5_.setValue(new Number(_loc6_[_loc8_]));
               _loc4_.push(_loc5_);
            }
            _loc8_++;
         }
         return _loc4_;
      }
      
      public static function parseAttrModsFromXML(param1:Part, param2:XMLList) : Vector.<AttributeModifier>
      {
         var _loc5_:int = 0;
         var _loc3_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         var _loc4_:AttributeModifier = null;
         _loc5_ = 0;
         while(_loc5_ < param2.Damage.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_DAMAGE,param2.Damage[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.Damage[_loc5_]));
            checkModState(param2.Damage[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.AccMin.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_ACC_MIN,param2.AccMin[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.AccMin[_loc5_]));
            checkModState(param2.AccMin[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.AccMax.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_ACC_MAX,param2.AccMax[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.AccMax[_loc5_]));
            checkModState(param2.AccMax[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.AccRegen.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_ACC_REGEN,param2.AccRegen[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.AccRegen[_loc5_]));
            checkModState(param2.AccRegen[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.FireRate.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_FIRERATE,param2.FireRate[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.FireRate[_loc5_]));
            checkModState(param2.FireRate[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ClipSize.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_CLIP,param2.ClipSize[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.ClipSize[_loc5_]));
            checkModState(param2.ClipSize[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.Recoil.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_RECOIL,param2.Recoil[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.Recoil[_loc5_]));
            checkModState(param2.Recoil[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ZoomEndFOV.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_ZOOM,param2.ZoomEndFOV[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.ZoomEndFOV[_loc5_]));
            checkModState(param2.ZoomEndFOV[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.AmmoRegen.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_AMMO_REGEN,param2.AmmoRegen[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.AmmoRegen[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ReloadSpeed.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_RELOAD,param2.ReloadSpeed[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.ReloadSpeed[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.Spread.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_SPREAD,param2.Spread[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.Spread[_loc5_]));
            checkModState(param2.Spread[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.WeaponLevel.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_EXPLEVEL,param2.WeaponLevel[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.WeaponLevel[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.CritBonus.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_CRIT,param2.CritBonus[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.CritBonus[_loc5_]));
            checkModState(param2.CritBonus[_loc5_],_loc4_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.HealthRegen.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_HEALTH_REGEN,param2.HealthRegen[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.HealthRegen[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.BurstCount.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_BURST_COUNT,param2.BurstCount[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.BurstCount[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ShotCost.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_SHOT_COST,param2.ShotCost[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.ShotCost[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.ProjectileCount.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_PROJECTILE_COUNT,param2.ProjectileCount[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.ProjectileCount[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.CostMod.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_COST,param2.CostMod[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.CostMod[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.Radius.length())
         {
            _loc4_ = new AttributeModifier(param1,ATTR_BLAST_RADIUS,param2.Radius[_loc5_].@modType);
            _loc4_.setValue(new Number(param2.Radius[_loc5_]));
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function parseAndAddIdRange(param1:String, param2:Vector.<Part>, param3:PartCollection) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         if(param1.indexOf(XML_RULE_RANGE_DELIMITER) != -1 && param1.length == 2 * XML_ID_LENGTH + 1)
         {
            _loc4_ = param1.substr(0,1);
            _loc5_ = parseInt(param1.substr(1,3));
            _loc6_ = parseInt(param1.substr(param1.indexOf(XML_RULE_RANGE_DELIMITER) + 2,3));
            while(_loc5_ <= _loc6_)
            {
               _loc7_ = _loc5_.toString();
               while(_loc7_.length < XML_ID_LENGTH - 1)
               {
                  _loc7_ = "0" + _loc7_;
               }
               param2.push(param3.retrieve(_loc4_ + _loc7_));
               _loc5_++;
            }
         }
      }
      
      public static function bubbleSortParts(param1:Vector.<Part>) : Vector.<Part>
      {
         var _loc3_:Part = null;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         while(!_loc2_)
         {
            _loc2_ = true;
            _loc4_ = 0;
            while(_loc4_ < param1.length - 1)
            {
               if(!stringCompare(param1[_loc4_].label,param1[_loc4_ + 1].label))
               {
                  _loc3_ = param1[_loc4_];
                  param1[_loc4_] = param1[_loc4_ + 1];
                  param1[_loc4_ + 1] = _loc3_;
                  _loc2_ = false;
               }
               _loc4_++;
            }
         }
         return param1;
      }
      
      public static function stringCompare(param1:String, param2:String) : Boolean
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ >= param2.length)
            {
               return false;
            }
            if(param1.charAt(_loc3_) < param2.charAt(_loc3_))
            {
               return true;
            }
            if(param1.charAt(_loc3_) > param2.charAt(_loc3_))
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public static function resolveCostRarity(param1:String) : Number
      {
         var _loc2_:Number = 0;
         switch(param1)
         {
            case "WeaponPartCost0_Cheap":
               _loc2_ = 0.75;
               break;
            case "WeaponPartCost0_Cheap_TedioreBonus":
               _loc2_ = 0.8;
               break;
            case "WeaponPartCost1_Common":
               _loc2_ = 1;
               break;
            case "WeaponPartCost2_Uncommon":
               _loc2_ = 1.1;
               break;
            case "WeaponPartCost3_Uncommoner":
               _loc2_ = 1.3;
               break;
            case "WeaponPartCost4_Rare":
               _loc2_ = 1.5;
               break;
            case "WeaponPartCost5_VeryRare":
               _loc2_ = 2.2;
               break;
            case "WeaponPartCost6_Legendary":
               _loc2_ = 1.8;
               break;
            case "ShieldPartCost0_Cheap":
               _loc2_ = 0.8;
               break;
            case "ShieldPartCost1_Common":
               _loc2_ = 1;
               break;
            case "ShieldPartCost2_Uncommon":
               _loc2_ = 1.2;
               break;
            case "ShieldPartCost3_Uncommoner":
               _loc2_ = 1.4;
               break;
            case "ShieldPartCost4_Rare":
               _loc2_ = 1.6;
               break;
            case "ShieldPartCost5_VeryRare":
               _loc2_ = 1.8;
               break;
            case "ShieldPartCost6_Legendary":
               _loc2_ = 2.2;
               break;
            case "WeaponPartRarity1_Common":
               _loc2_ = 0;
               break;
            case "WeaponPartRarity2_Uncommon":
               _loc2_ = 1;
               break;
            case "WeaponPartRarity3_Uncommoner":
               _loc2_ = 3;
               break;
            case "WeaponPartRarity4_Rare":
               _loc2_ = 5;
               break;
            case "WeaponPartRarity5_VeryRare":
               _loc2_ = 8;
               break;
            case "WeaponPartRarity6_Legendary":
               _loc2_ = 50;
               break;
            case "ShieldPartRarity1_Common":
               _loc2_ = 0;
               break;
            case "ShieldPartRarity2_Uncommon":
               _loc2_ = 2;
               break;
            case "ShieldPartRarity3_Uncommoner":
               _loc2_ = 4;
               break;
            case "ShieldPartRarity4_Rare":
               _loc2_ = 6;
               break;
            case "ShieldPartRarity5_VeryRare":
               _loc2_ = 8;
               break;
            case "ShieldPartRarity6_Legendary":
               _loc2_ = 10;
               break;
            default:
               _loc2_ = 0;
         }
         return _loc2_;
      }
      
      internal static function accomodateShields(param1:Vector.<AttributeModifier>) : Vector.<AttributeModifier>
      {
         var _loc3_:AttributeModifier = null;
         var _loc2_:Vector.<AttributeModifier> = new Vector.<AttributeModifier>();
         for each(_loc3_ in param1)
         {
            if(_loc3_.getValue() >= 0 || _loc3_.getAttrToMod() != ATTR_SHIELD_CAP && _loc3_.getAttrToMod() != ATTR_SHIELD_RATE)
            {
               _loc2_.push(_loc3_);
            }
            else if(_loc3_.getModType() != GearCalcUtil.MOD_PREADD)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function getAttrMod(param1:String, param2:Vector.<AttributeModifier>) : AttributeModifier
      {
         var _loc3_:AttributeModifier = null;
         for each(_loc3_ in param2)
         {
            if(_loc3_.getAttrToMod() == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function isBiggerBetter(param1:String) : Boolean
      {
         if(param1 == ATTR_FIRERATE || param1 == ATTR_RELOAD || param1 == ATTR_RECOIL || param1 == ATTR_SPREAD || param1 == ATTR_ACC_MIN || param1 == ATTR_ACC_MAX || param1 == ATTR_ZOOM)
         {
            return false;
         }
         if(param1 == ATTR_SHIELD_DELAY || param1.indexOf("Impact Multiplier") != -1 || param1.indexOf("Passive Multiplier") != -1)
         {
            return false;
         }
         return true;
      }
      
      public static function isBaseless(param1:String) : Boolean
      {
         if(param1 == ATTR_MELEE || param1 == ATTR_CRIT)
         {
            return false;
         }
         return true;
      }
      
      public static function statify(param1:String, param2:String) : String
      {
         if(param2 != MOD_STATE_ALL)
         {
            return param1 + " " + param2;
         }
         return param1;
      }
      
      public static function getPartFromVector(param1:Vector.<Part>, param2:String) : Part
      {
         var _loc3_:Part = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_.getType() == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function getTime() : Number
      {
         return getTimer() / 1000;
      }
      
      internal static function isInLookup(param1:String) : String
      {
         var _loc2_:Attribute = null;
         if(attrLookup != null)
         {
            for each(_loc2_ in attrLookup)
            {
               if(_loc2_.name == param1)
               {
                  return _loc2_.text;
               }
            }
         }
         return null;
      }
      
      public static function resolveRarityColor(param1:int) : uint
      {
         var _loc2_:uint = 0;
         if(param1 < GearCalcUtil.RARITY_GREEN)
         {
            _loc2_ = GearCalcUtil.COLOR_WHITE;
         }
         else if(param1 < GearCalcUtil.RARITY_BLUE)
         {
            _loc2_ = GearCalcUtil.COLOR_GREEN;
         }
         else if(param1 < GearCalcUtil.RARITY_PURPLE)
         {
            _loc2_ = GearCalcUtil.COLOR_BLUE;
         }
         else if(param1 < GearCalcUtil.RARITY_L_ORANGE)
         {
            _loc2_ = GearCalcUtil.COLOR_PURPLE;
         }
         else if(param1 < GearCalcUtil.RARITY_ORANGE)
         {
            _loc2_ = GearCalcUtil.COLOR_L_ORANGE;
         }
         else if(param1 < GearCalcUtil.RARITY_D_ORANGE)
         {
            _loc2_ = GearCalcUtil.COLOR_ORANGE;
         }
         else if(param1 < GearCalcUtil.RARITY_PEARL)
         {
            _loc2_ = GearCalcUtil.COLOR_D_ORANGE;
         }
         else
         {
            _loc2_ = GearCalcUtil.COLOR_PEARL;
         }
         return _loc2_;
      }
   }
}

