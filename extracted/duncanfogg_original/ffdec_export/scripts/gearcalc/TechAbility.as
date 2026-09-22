package gearcalc
{
   public class TechAbility
   {
      
      public static const LEVEL_ONE:int = 6;
      
      public static const LEVEL_TWO:int = 9;
      
      public static const LEVEL_THREE:int = 12;
      
      public static const LEVEL_FOUR:int = 15;
      
      private var relativeGrade:int = 0;
      
      private var techType:String = null;
      
      private var techLevel:uint = 0;
      
      private var techCost:Number = 0;
      
      private var procChance:Number = 0;
      
      private var linkedPrefix:String = null;
      
      public var bullet:String = "";
      
      public function TechAbility(param1:int)
      {
         super();
         this.relativeGrade = param1;
      }
      
      public function linkPrefix(param1:String) : void
      {
         this.linkedPrefix = param1;
      }
      
      public function getLinkedID() : String
      {
         return this.linkedPrefix;
      }
      
      public function getType() : String
      {
         return this.techType;
      }
      
      public function getLevel() : uint
      {
         return this.techLevel;
      }
      
      public function getCost() : Number
      {
         return this.techCost;
      }
      
      public function getProcChance() : Number
      {
         return this.procChance;
      }
      
      public function setType(param1:String) : void
      {
         this.techType = param1;
      }
      
      public function setLevel(param1:uint) : void
      {
         this.techLevel = param1;
      }
      
      public function setCost(param1:Number) : void
      {
         this.techCost = param1;
      }
      
      public function setProcChance(param1:Number) : void
      {
         this.procChance = param1;
      }
      
      public function getRelativeGrade() : int
      {
         return this.relativeGrade;
      }
      
      public function getAllBullets(param1:PartCollection) : Vector.<Part>
      {
         var _loc5_:String = null;
         var _loc2_:Vector.<Part> = new Vector.<Part>();
         var _loc3_:Part = param1.retrieve(this.bullet);
         var _loc4_:Vector.<String> = _loc3_.getLinkedPartRefs();
         if(_loc3_ != null)
         {
            _loc2_.push(_loc3_);
            for each(_loc5_ in _loc4_)
            {
               _loc3_ = param1.retrieve(_loc5_);
               if(_loc3_ != null)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getBulletTypeDamage(param1:String, param2:PartCollection) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Vector.<Part> = null;
         var _loc6_:Part = null;
         var _loc7_:Part = null;
         var _loc3_:Vector.<Part> = this.getAllBullets(param2);
         if(_loc3_.length > 0)
         {
            _loc4_ = 0;
            _loc5_ = new Vector.<Part>();
            for each(_loc6_ in _loc3_)
            {
               if(_loc6_ != null && param1.indexOf(_loc6_.getHelpText()) != -1)
               {
                  _loc5_.push(_loc6_);
               }
            }
            for each(_loc7_ in _loc5_)
            {
               _loc4_ += GearCalcUtil.getAttrMod(GearCalcUtil.ATTR_DAMAGE,_loc7_.getAttrModifiers()).getValue();
            }
            return _loc4_;
         }
         return 0;
      }
      
      public function getBulletDamage(param1:PartCollection) : Number
      {
         var _loc2_:Number = this.getBulletTypeDamage(GearCalcUtil.TECH_CORROSIVE + GearCalcUtil.TECH_EXPLOSIVE + GearCalcUtil.TECH_INCENDIARY + GearCalcUtil.TECH_SHOCK,param1);
         if(_loc2_ == 0)
         {
            return 1;
         }
         return _loc2_;
      }
   }
}

