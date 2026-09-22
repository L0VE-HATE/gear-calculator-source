package gearcalc.card
{
   import flash.utils.Dictionary;
   import gearcalc.*;
   
   public class DrawPriorityManager
   {
      
      public static const STANDARD_MANAGER:String = "Standard";
      
      private static var managers:Dictionary = new Dictionary();
      
      internal var entries:Vector.<Attribute>;
      
      internal var source:PartCollection;
      
      internal var target:String;
      
      public function DrawPriorityManager(param1:String, param2:PartCollection)
      {
         super();
         this.target = param1;
         this.source = param2;
         this.entries = new Vector.<Attribute>();
      }
      
      private static function convertToParts(param1:Vector.<String>, param2:PartCollection) : Vector.<Part>
      {
         var _loc4_:Part = null;
         var _loc5_:String = null;
         var _loc3_:Vector.<Part> = new Vector.<Part>();
         for each(_loc5_ in param1)
         {
            _loc4_ = param2.retrieve(_loc5_);
            if(_loc4_ != null)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public static function prioritize(param1:String, param2:Vector.<String>) : Vector.<String>
      {
         var _loc6_:Attribute = null;
         var _loc7_:Part = null;
         var _loc8_:int = 0;
         var _loc3_:DrawPriorityManager = getManager(param1);
         var _loc4_:Vector.<String> = new Vector.<String>();
         var _loc5_:Vector.<Part> = convertToParts(param2,_loc3_.source);
         for each(_loc6_ in _loc3_.entries)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_.length)
            {
               if(_loc5_[_loc8_] != null && _loc6_.name == _loc5_[_loc8_].getType())
               {
                  _loc4_.push(_loc5_[_loc8_].getID());
                  _loc5_[_loc8_] = null;
                  break;
               }
               _loc8_++;
            }
         }
         for each(_loc7_ in _loc5_)
         {
            if(_loc7_ != null)
            {
               _loc4_.push(_loc7_.getID());
            }
         }
         return _loc4_;
      }
      
      public static function getManager(param1:String) : DrawPriorityManager
      {
         if(managers[param1] != null)
         {
            return managers[param1] as DrawPriorityManager;
         }
         return managers[STANDARD_MANAGER];
      }
      
      public static function initManagers(param1:XML, param2:PartCollection) : void
      {
         var _loc3_:XMLList = null;
         var _loc4_:Attribute = null;
         var _loc7_:int = 0;
         var _loc5_:DrawPriorityManager = new DrawPriorityManager(STANDARD_MANAGER,param2);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_STOCK);
         _loc4_.value = 10;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_BARREL);
         _loc4_.value = 35;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_MAG);
         _loc4_.value = 30;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_BODY);
         _loc4_.value = 25;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_SIGHT);
         _loc4_.value = 8;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_ACCESSORY);
         _loc4_.value = 5;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_GRIP);
         _loc4_.value = 26;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_STOCK);
         _loc4_.value = 27;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_ACTION);
         _loc4_.value = 23;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_SHIELD_BODY);
         _loc4_.value = 50;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_SHIELD_LEFT);
         _loc4_.value = 40;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_SHIELD_RIGHT);
         _loc4_.value = 42;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_COM_BODY);
         _loc4_.value = 60;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_COM_LEFT);
         _loc4_.value = 54;
         _loc5_.entries.push(_loc4_);
         _loc4_ = new Attribute(GearCalcUtil.PART_TYPE_COM_RIGHT);
         _loc4_.value = 52;
         _loc5_.entries.push(_loc4_);
         _loc5_.sortPriorities();
         managers[_loc5_.target] = _loc5_;
         var _loc6_:int = 0;
         while(_loc6_ < param1.PriorityManager.length())
         {
            _loc5_ = new DrawPriorityManager(param1.PriorityManager[_loc6_].Target,param2);
            _loc3_ = param1.PriorityManager[_loc6_].Rule;
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length())
            {
               _loc4_ = new Attribute(_loc3_[_loc7_].PartType);
               _loc4_.value = _loc3_[_loc7_].Priority;
               _loc5_.entries.push(_loc4_);
               _loc7_++;
            }
            _loc5_.sortPriorities();
            managers[_loc5_.target] = _loc5_;
            _loc6_++;
         }
      }
      
      private function sortPriorities() : void
      {
         var _loc2_:Attribute = null;
         var _loc3_:int = 0;
         var _loc1_:Boolean = false;
         while(!_loc1_)
         {
            _loc1_ = true;
            _loc3_ = 0;
            while(_loc3_ < this.entries.length - 1)
            {
               if(this.entries[_loc3_].value > this.entries[_loc3_ + 1].value)
               {
                  _loc2_ = this.entries[_loc3_];
                  this.entries[_loc3_] = this.entries[_loc3_ + 1];
                  this.entries[_loc3_ + 1] = _loc2_;
                  _loc1_ = false;
               }
               _loc3_++;
            }
         }
      }
   }
}

