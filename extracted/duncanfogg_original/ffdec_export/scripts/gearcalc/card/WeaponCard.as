package gearcalc.card
{
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import gearcalc.Attribute;
   import gearcalc.ElementalImage;
   import gearcalc.GearCalcUtil;
   import gearcalc.Part;
   import mx.core.BitmapAsset;
   import mx.events.PropertyChangeEvent;
   
   public class WeaponCard implements IEventDispatcher
   {
      
      public static const COLOR_SHOCK:uint = 25855;
      
      public static const COLOR_EXPLOSIVE:uint = 16776960;
      
      public static const COLOR_INCENDIARY:uint = 16744448;
      
      public static const COLOR_CORROSIVE:uint = 65280;
      
      public static const CLAPTRAP_SHIELD:String = "shield";
      
      public static const CLAPTRAP_REPEATER:String = "repeater";
      
      public static const CLAPTRAP_LAUNCHER:String = "launcher";
      
      public static const CLAPTRAP_REVOLVER:String = "revolver";
      
      public static const CLAPTRAP_RIFLE:String = "rifle";
      
      public static const CLAPTRAP_SHOTGUN:String = "shotgun";
      
      public static const CLAPTRAP_SMG:String = "smg";
      
      public static const CLAPTRAP_SNIPER:String = "sniper";
      
      public static const CLAPTRAP_ERIDIAN:String = "eridian";
      
      public static const MAKE_ATLAS:String = "Atlas";
      
      public static const MAKE_DAHL:String = "Dahl";
      
      public static const MAKE_TEDIORE:String = "Tediore";
      
      public static const MAKE_SANDS:String = "SandS Munitions";
      
      public static const MAKE_MALIWAN:String = "Maliwan";
      
      public static const MAKE_TORGUE:String = "Torgue";
      
      public static const MAKE_VLADOF:String = "Vladof";
      
      public static const MAKE_JAKOBS:String = "Jakobs";
      
      public static const MAKE_ERIDIAN:String = "Eridian";
      
      public static const MAKE_HYPERION:String = "Hyperion";
      
      public static const MAKE_GEARBOX:String = "Gearbox";
      
      public static const MAKE_PANGOLIN:String = "Pangolin";
      
      public static const MAKE_ANSHIN:String = "Anshin";
      
      private var _93697979claptrapLauncher:Class = WeaponCard_claptrapLauncher;
      
      private var _876771373claptrapRepeater:Class = WeaponCard_claptrapRepeater;
      
      private var _1058111112claptrapRevolver:Class = WeaponCard_claptrapRevolver;
      
      private var _113168451claptrapRifle:Class = WeaponCard_claptrapRifle;
      
      private var _2046838079claptrapShotgun:Class = WeaponCard_claptrapShotgun;
      
      private var _753405228claptrapSniper:Class = WeaponCard_claptrapSniper;
      
      private var _71627144claptrapSmg:Class = WeaponCard_claptrapSmg;
      
      private var _1306712695claptrapEridian:Class = WeaponCard_claptrapEridian;
      
      private var _758956722claptrapShield:Class = WeaponCard_claptrapShield;
      
      private var _868306511logoGearbox:Class = WeaponCard_logoGearbox;
      
      private var _1588108896logoAtlas:Class = WeaponCard_logoAtlas;
      
      private var _2027051660logoDahl:Class = WeaponCard_logoDahl;
      
      private var _2030809763logoEridian:Class = WeaponCard_logoEridian;
      
      private var _1583218919logoHyperion:Class = WeaponCard_logoHyperion;
      
      private var _1746636809logoJakobs:Class = WeaponCard_logoJakobs;
      
      private var _57142024logoMaliwan:Class = WeaponCard_logoMaliwan;
      
      private var _2081821761logoTediore:Class = WeaponCard_logoTediore;
      
      private var _1572049564logoSandS:Class = WeaponCard_logoSandS;
      
      private var _1447214581logoTorgue:Class = WeaponCard_logoTorgue;
      
      private var _1393236357logoVladof:Class = WeaponCard_logoVladof;
      
      private var _1534917385logoPangolin:Class = WeaponCard_logoPangolin;
      
      private var _1992061582logoAnshin:Class = WeaponCard_logoAnshin;
      
      private var _2039303050ammoRepeater:Class = WeaponCard_ammoRepeater;
      
      private var _1326178150ammoRifle:Class = WeaponCard_ammoRifle;
      
      private var _1857963311ammoRevolver:Class = WeaponCard_ammoRevolver;
      
      private var _1285194894ammoLauncher:Class = WeaponCard_ammoLauncher;
      
      private var _881825889ammoSMG:Class = WeaponCard_ammoSMG;
      
      private var _1871490397ammoSniper:Class = WeaponCard_ammoSniper;
      
      private var _2015514968ammoShotgun:Class = WeaponCard_ammoShotgun;
      
      private var _1539326944ammoEridian:Class = WeaponCard_ammoEridian;
      
      public var name:String;
      
      public var text:Vector.<CardLine>;
      
      public var accuracy:String;
      
      public var damage:String;
      
      public var rof:String;
      
      public var manufacturer:String;
      
      public var clapTrap:String;
      
      public var clip:String;
      
      public var cost:int;
      
      public var projectiles:int;
      
      public var elemental:String;
      
      public var image:Bitmap;
      
      public var parts:Vector.<Part>;
      
      public var nameColor:uint;
      
      public var ammoType:String;
      
      public var capacity:String;
      
      public var recharge:String;
      
      public var techLevel:int;
      
      public var level:int;
      
      public var gearType:int;
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      public function WeaponCard(param1:int)
      {
         super();
         this.gearType = param1;
      }
      
      public function line(param1:int) : Attribute
      {
         var _loc2_:Attribute = null;
         if(param1 == 1)
         {
            if(this.gearType == GearCalcUtil.GEAR_WEAPON)
            {
               _loc2_ = new Attribute("Damage");
               _loc2_.text = this.damage;
            }
            else if(this.gearType == GearCalcUtil.GEAR_SHIELD)
            {
               _loc2_ = new Attribute("Capacity");
               _loc2_.text = this.capacity;
            }
         }
         else if(param1 == 2)
         {
            if(this.gearType == GearCalcUtil.GEAR_WEAPON)
            {
               _loc2_ = new Attribute("Accuracy");
               _loc2_.text = this.accuracy;
            }
            else if(this.gearType == GearCalcUtil.GEAR_SHIELD)
            {
               _loc2_ = new Attribute("Recharge Rate");
               _loc2_.text = this.recharge;
            }
         }
         else if(param1 == 3 && this.gearType == GearCalcUtil.GEAR_WEAPON)
         {
            _loc2_ = new Attribute("Fire Rate");
            _loc2_.text = this.rof;
         }
         return _loc2_;
      }
      
      public function getTechDecoratedString() : CardLine
      {
         if(this.elemental == null || this.elemental == "")
         {
            return null;
         }
         var _loc1_:ElementalImage = new ElementalImage();
         var _loc2_:* = [0,0,0,0];
         if(this.clapTrap == CLAPTRAP_LAUNCHER)
         {
            _loc2_ = GearCalcUtil.scalersLaunchers;
         }
         var _loc3_:int = 0;
         if(this.techLevel >= 15 + _loc2_[3])
         {
            _loc3_ = 4;
         }
         else if(this.techLevel >= 12 + _loc2_[2])
         {
            _loc3_ = 3;
         }
         else if(this.techLevel >= 9 + _loc2_[1])
         {
            _loc3_ = 2;
         }
         else
         {
            _loc3_ = 1;
         }
         var _loc4_:CardLine = new CardLine();
         _loc4_.text = this.elemental + " X" + _loc3_.toString();
         switch(this.elemental)
         {
            case GearCalcUtil.TECH_CORROSIVE:
               _loc4_.color = COLOR_CORROSIVE;
               break;
            case GearCalcUtil.TECH_EXPLOSIVE:
               _loc4_.color = COLOR_EXPLOSIVE;
               break;
            case GearCalcUtil.TECH_SHOCK:
               _loc4_.color = COLOR_SHOCK;
               break;
            case GearCalcUtil.TECH_INCENDIARY:
               _loc4_.color = COLOR_INCENDIARY;
               break;
            default:
               _loc4_.color = 16777215;
         }
         return _loc4_;
      }
      
      public function getElementalImage() : BitmapAsset
      {
         if(this.elemental == null || this.elemental == "")
         {
            return null;
         }
         var _loc1_:ElementalImage = new ElementalImage();
         var _loc2_:* = [0,0,0,0];
         if(this.clapTrap == CLAPTRAP_LAUNCHER)
         {
            _loc2_ = GearCalcUtil.scalersLaunchers;
         }
         return _loc1_.retrieveImage(this.elemental,this.techLevel,_loc2_) as BitmapAsset;
      }
      
      public function getManufacturerLogo() : BitmapAsset
      {
         switch(this.manufacturer)
         {
            case MAKE_ATLAS:
               return new this.logoAtlas() as BitmapAsset;
            case MAKE_DAHL:
               return new this.logoDahl() as BitmapAsset;
            case MAKE_MALIWAN:
               return new this.logoMaliwan() as BitmapAsset;
            case MAKE_JAKOBS:
               return new this.logoJakobs() as BitmapAsset;
            case MAKE_HYPERION:
               return new this.logoHyperion() as BitmapAsset;
            case MAKE_TEDIORE:
               return new this.logoTediore() as BitmapAsset;
            case MAKE_TORGUE:
               return new this.logoTorgue() as BitmapAsset;
            case MAKE_VLADOF:
               return new this.logoVladof() as BitmapAsset;
            case MAKE_SANDS:
               return new this.logoSandS() as BitmapAsset;
            case MAKE_ERIDIAN:
               return new this.logoEridian() as BitmapAsset;
            case MAKE_GEARBOX:
               return new this.logoGearbox() as BitmapAsset;
            case MAKE_PANGOLIN:
               return new this.logoPangolin() as BitmapAsset;
            case MAKE_ANSHIN:
               return new this.logoAnshin() as BitmapAsset;
            default:
               return null;
         }
      }
      
      public function getAmmoIcon() : BitmapAsset
      {
         switch(this.ammoType)
         {
            case CLAPTRAP_REPEATER:
               return new this.ammoRepeater() as BitmapAsset;
            case CLAPTRAP_REVOLVER:
               return new this.ammoRevolver() as BitmapAsset;
            case CLAPTRAP_SMG:
               return new this.ammoSMG() as BitmapAsset;
            case CLAPTRAP_RIFLE:
               return new this.ammoRifle() as BitmapAsset;
            case CLAPTRAP_SHOTGUN:
               return new this.ammoShotgun() as BitmapAsset;
            case CLAPTRAP_SNIPER:
               return new this.ammoSniper() as BitmapAsset;
            case CLAPTRAP_LAUNCHER:
               return new this.ammoLauncher() as BitmapAsset;
            case CLAPTRAP_ERIDIAN:
               return new this.ammoEridian() as BitmapAsset;
            default:
               return null;
         }
      }
      
      public function isEridian() : Boolean
      {
         if(this.clapTrap == CLAPTRAP_ERIDIAN)
         {
            return true;
         }
         return false;
      }
      
      public function getClaptrapImage() : BitmapAsset
      {
         switch(this.clapTrap)
         {
            case CLAPTRAP_SHIELD:
               return new this.claptrapShield() as BitmapAsset;
            case CLAPTRAP_REPEATER:
               return new this.claptrapRepeater() as BitmapAsset;
            case CLAPTRAP_REVOLVER:
               return new this.claptrapRevolver() as BitmapAsset;
            case CLAPTRAP_SMG:
               return new this.claptrapSmg() as BitmapAsset;
            case CLAPTRAP_RIFLE:
               return new this.claptrapRifle() as BitmapAsset;
            case CLAPTRAP_SHOTGUN:
               return new this.claptrapShotgun() as BitmapAsset;
            case CLAPTRAP_SNIPER:
               return new this.claptrapSniper() as BitmapAsset;
            case CLAPTRAP_LAUNCHER:
               return new this.claptrapLauncher() as BitmapAsset;
            case CLAPTRAP_ERIDIAN:
               return new this.claptrapEridian() as BitmapAsset;
            default:
               return null;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get claptrapLauncher() : Class
      {
         return this._93697979claptrapLauncher;
      }
      
      public function set claptrapLauncher(param1:Class) : void
      {
         var _loc2_:Object = this._93697979claptrapLauncher;
         if(_loc2_ !== param1)
         {
            this._93697979claptrapLauncher = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claptrapLauncher",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get claptrapRepeater() : Class
      {
         return this._876771373claptrapRepeater;
      }
      
      public function set claptrapRepeater(param1:Class) : void
      {
         var _loc2_:Object = this._876771373claptrapRepeater;
         if(_loc2_ !== param1)
         {
            this._876771373claptrapRepeater = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claptrapRepeater",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get claptrapRevolver() : Class
      {
         return this._1058111112claptrapRevolver;
      }
      
      public function set claptrapRevolver(param1:Class) : void
      {
         var _loc2_:Object = this._1058111112claptrapRevolver;
         if(_loc2_ !== param1)
         {
            this._1058111112claptrapRevolver = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claptrapRevolver",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get claptrapRifle() : Class
      {
         return this._113168451claptrapRifle;
      }
      
      public function set claptrapRifle(param1:Class) : void
      {
         var _loc2_:Object = this._113168451claptrapRifle;
         if(_loc2_ !== param1)
         {
            this._113168451claptrapRifle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claptrapRifle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get claptrapShotgun() : Class
      {
         return this._2046838079claptrapShotgun;
      }
      
      public function set claptrapShotgun(param1:Class) : void
      {
         var _loc2_:Object = this._2046838079claptrapShotgun;
         if(_loc2_ !== param1)
         {
            this._2046838079claptrapShotgun = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claptrapShotgun",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get claptrapSniper() : Class
      {
         return this._753405228claptrapSniper;
      }
      
      public function set claptrapSniper(param1:Class) : void
      {
         var _loc2_:Object = this._753405228claptrapSniper;
         if(_loc2_ !== param1)
         {
            this._753405228claptrapSniper = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claptrapSniper",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get claptrapSmg() : Class
      {
         return this._71627144claptrapSmg;
      }
      
      public function set claptrapSmg(param1:Class) : void
      {
         var _loc2_:Object = this._71627144claptrapSmg;
         if(_loc2_ !== param1)
         {
            this._71627144claptrapSmg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claptrapSmg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get claptrapEridian() : Class
      {
         return this._1306712695claptrapEridian;
      }
      
      public function set claptrapEridian(param1:Class) : void
      {
         var _loc2_:Object = this._1306712695claptrapEridian;
         if(_loc2_ !== param1)
         {
            this._1306712695claptrapEridian = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claptrapEridian",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get claptrapShield() : Class
      {
         return this._758956722claptrapShield;
      }
      
      public function set claptrapShield(param1:Class) : void
      {
         var _loc2_:Object = this._758956722claptrapShield;
         if(_loc2_ !== param1)
         {
            this._758956722claptrapShield = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"claptrapShield",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoGearbox() : Class
      {
         return this._868306511logoGearbox;
      }
      
      public function set logoGearbox(param1:Class) : void
      {
         var _loc2_:Object = this._868306511logoGearbox;
         if(_loc2_ !== param1)
         {
            this._868306511logoGearbox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoGearbox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoAtlas() : Class
      {
         return this._1588108896logoAtlas;
      }
      
      public function set logoAtlas(param1:Class) : void
      {
         var _loc2_:Object = this._1588108896logoAtlas;
         if(_loc2_ !== param1)
         {
            this._1588108896logoAtlas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoAtlas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoDahl() : Class
      {
         return this._2027051660logoDahl;
      }
      
      public function set logoDahl(param1:Class) : void
      {
         var _loc2_:Object = this._2027051660logoDahl;
         if(_loc2_ !== param1)
         {
            this._2027051660logoDahl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoDahl",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoEridian() : Class
      {
         return this._2030809763logoEridian;
      }
      
      public function set logoEridian(param1:Class) : void
      {
         var _loc2_:Object = this._2030809763logoEridian;
         if(_loc2_ !== param1)
         {
            this._2030809763logoEridian = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoEridian",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoHyperion() : Class
      {
         return this._1583218919logoHyperion;
      }
      
      public function set logoHyperion(param1:Class) : void
      {
         var _loc2_:Object = this._1583218919logoHyperion;
         if(_loc2_ !== param1)
         {
            this._1583218919logoHyperion = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoHyperion",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoJakobs() : Class
      {
         return this._1746636809logoJakobs;
      }
      
      public function set logoJakobs(param1:Class) : void
      {
         var _loc2_:Object = this._1746636809logoJakobs;
         if(_loc2_ !== param1)
         {
            this._1746636809logoJakobs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoJakobs",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoMaliwan() : Class
      {
         return this._57142024logoMaliwan;
      }
      
      public function set logoMaliwan(param1:Class) : void
      {
         var _loc2_:Object = this._57142024logoMaliwan;
         if(_loc2_ !== param1)
         {
            this._57142024logoMaliwan = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoMaliwan",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoTediore() : Class
      {
         return this._2081821761logoTediore;
      }
      
      public function set logoTediore(param1:Class) : void
      {
         var _loc2_:Object = this._2081821761logoTediore;
         if(_loc2_ !== param1)
         {
            this._2081821761logoTediore = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoTediore",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoSandS() : Class
      {
         return this._1572049564logoSandS;
      }
      
      public function set logoSandS(param1:Class) : void
      {
         var _loc2_:Object = this._1572049564logoSandS;
         if(_loc2_ !== param1)
         {
            this._1572049564logoSandS = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoSandS",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoTorgue() : Class
      {
         return this._1447214581logoTorgue;
      }
      
      public function set logoTorgue(param1:Class) : void
      {
         var _loc2_:Object = this._1447214581logoTorgue;
         if(_loc2_ !== param1)
         {
            this._1447214581logoTorgue = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoTorgue",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoVladof() : Class
      {
         return this._1393236357logoVladof;
      }
      
      public function set logoVladof(param1:Class) : void
      {
         var _loc2_:Object = this._1393236357logoVladof;
         if(_loc2_ !== param1)
         {
            this._1393236357logoVladof = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoVladof",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoPangolin() : Class
      {
         return this._1534917385logoPangolin;
      }
      
      public function set logoPangolin(param1:Class) : void
      {
         var _loc2_:Object = this._1534917385logoPangolin;
         if(_loc2_ !== param1)
         {
            this._1534917385logoPangolin = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoPangolin",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logoAnshin() : Class
      {
         return this._1992061582logoAnshin;
      }
      
      public function set logoAnshin(param1:Class) : void
      {
         var _loc2_:Object = this._1992061582logoAnshin;
         if(_loc2_ !== param1)
         {
            this._1992061582logoAnshin = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoAnshin",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ammoRepeater() : Class
      {
         return this._2039303050ammoRepeater;
      }
      
      public function set ammoRepeater(param1:Class) : void
      {
         var _loc2_:Object = this._2039303050ammoRepeater;
         if(_loc2_ !== param1)
         {
            this._2039303050ammoRepeater = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ammoRepeater",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ammoRifle() : Class
      {
         return this._1326178150ammoRifle;
      }
      
      public function set ammoRifle(param1:Class) : void
      {
         var _loc2_:Object = this._1326178150ammoRifle;
         if(_loc2_ !== param1)
         {
            this._1326178150ammoRifle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ammoRifle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ammoRevolver() : Class
      {
         return this._1857963311ammoRevolver;
      }
      
      public function set ammoRevolver(param1:Class) : void
      {
         var _loc2_:Object = this._1857963311ammoRevolver;
         if(_loc2_ !== param1)
         {
            this._1857963311ammoRevolver = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ammoRevolver",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ammoLauncher() : Class
      {
         return this._1285194894ammoLauncher;
      }
      
      public function set ammoLauncher(param1:Class) : void
      {
         var _loc2_:Object = this._1285194894ammoLauncher;
         if(_loc2_ !== param1)
         {
            this._1285194894ammoLauncher = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ammoLauncher",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ammoSMG() : Class
      {
         return this._881825889ammoSMG;
      }
      
      public function set ammoSMG(param1:Class) : void
      {
         var _loc2_:Object = this._881825889ammoSMG;
         if(_loc2_ !== param1)
         {
            this._881825889ammoSMG = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ammoSMG",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ammoSniper() : Class
      {
         return this._1871490397ammoSniper;
      }
      
      public function set ammoSniper(param1:Class) : void
      {
         var _loc2_:Object = this._1871490397ammoSniper;
         if(_loc2_ !== param1)
         {
            this._1871490397ammoSniper = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ammoSniper",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ammoShotgun() : Class
      {
         return this._2015514968ammoShotgun;
      }
      
      public function set ammoShotgun(param1:Class) : void
      {
         var _loc2_:Object = this._2015514968ammoShotgun;
         if(_loc2_ !== param1)
         {
            this._2015514968ammoShotgun = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ammoShotgun",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ammoEridian() : Class
      {
         return this._1539326944ammoEridian;
      }
      
      public function set ammoEridian(param1:Class) : void
      {
         var _loc2_:Object = this._1539326944ammoEridian;
         if(_loc2_ !== param1)
         {
            this._1539326944ammoEridian = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ammoEridian",_loc2_,param1));
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

