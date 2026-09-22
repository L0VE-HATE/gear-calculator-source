package gearcalc
{
   public class Slot
   {
      
      public var part:Part;
      
      public var name:String;
      
      public var isRequired:Boolean;
      
      public var acceptableTypes:String;
      
      public function Slot(param1:String)
      {
         super();
         this.name = param1;
         this.isRequired = true;
         this.acceptableTypes = param1;
      }
      
      public static function getSlot(param1:String, param2:Vector.<Slot>) : Slot
      {
         var _loc3_:Slot = null;
         for each(_loc3_ in param2)
         {
            if(param1 == _loc3_.name)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function removeSlot(param1:String, param2:Vector.<Slot>) : Vector.<Slot>
      {
         var _loc4_:Slot = null;
         var _loc3_:Vector.<Slot> = new Vector.<Slot>();
         for each(_loc4_ in param2)
         {
            if(param1 != _loc4_.name)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public static function createSlotTemplate(param1:int) : Vector.<Slot>
      {
         var _loc4_:Slot = null;
         var _loc5_:String = null;
         var _loc2_:Vector.<String> = new Vector.<String>();
         _loc2_.push(GearCalcUtil.PART_TYPE_GRADE);
         if(param1 == GearCalcUtil.GEAR_WEAPON)
         {
            _loc2_.push(GearCalcUtil.PART_TYPE_MANUFACT);
            _loc2_.push(GearCalcUtil.PART_TYPE_TYPE);
            _loc2_.push(GearCalcUtil.PART_TYPE_BODY);
            _loc2_.push(GearCalcUtil.PART_TYPE_GRIP);
            _loc2_.push(GearCalcUtil.PART_TYPE_MAG);
            _loc2_.push(GearCalcUtil.PART_TYPE_BARREL);
            _loc2_.push(GearCalcUtil.PART_TYPE_SIGHT);
            _loc2_.push(GearCalcUtil.PART_TYPE_STOCK);
            _loc2_.push(GearCalcUtil.PART_TYPE_ACTION);
            _loc2_.push(GearCalcUtil.PART_TYPE_ACCESSORY);
            _loc2_.push(GearCalcUtil.PART_TYPE_MATERIAL);
         }
         else if(param1 == GearCalcUtil.GEAR_SHIELD)
         {
            _loc2_.push(GearCalcUtil.PART_TYPE_TYPE);
            _loc2_.push(GearCalcUtil.PART_TYPE_SHIELD_BODY);
            _loc2_.push(GearCalcUtil.PART_TYPE_SHIELD_LEFT);
            _loc2_.push(GearCalcUtil.PART_TYPE_SHIELD_RIGHT);
            _loc2_.push(GearCalcUtil.PART_TYPE_MATERIAL);
            _loc2_.push(GearCalcUtil.PART_TYPE_MANUFACT);
         }
         else
         {
            _loc2_.push(GearCalcUtil.PART_TYPE_TYPE);
            _loc2_.push(GearCalcUtil.PART_TYPE_COM_BODY);
            _loc2_.push(GearCalcUtil.PART_TYPE_COM_LEFT);
            _loc2_.push(GearCalcUtil.PART_TYPE_COM_RIGHT);
            _loc2_.push(GearCalcUtil.PART_TYPE_MATERIAL);
            _loc2_.push(GearCalcUtil.PART_TYPE_MANUFACT);
         }
         var _loc3_:Vector.<Slot> = new Vector.<Slot>();
         for each(_loc5_ in _loc2_)
         {
            _loc3_.push(new Slot(_loc5_));
         }
         _loc4_ = new Slot(GearCalcUtil.PART_TYPE_PREFIX);
         _loc4_.addAcceptableType(GearCalcUtil.PART_TYPE_TITLE);
         _loc3_.push(_loc4_);
         _loc4_ = new Slot(GearCalcUtil.PART_TYPE_TITLE);
         _loc4_.addAcceptableType(GearCalcUtil.PART_TYPE_PREFIX);
         _loc3_.push(_loc4_);
         return _loc3_;
      }
      
      public function addAcceptableType(param1:String) : void
      {
         this.acceptableTypes += param1;
      }
      
      public function removeAcceptableType(param1:String) : void
      {
         this.acceptableTypes = this.acceptableTypes.replace(param1,"");
      }
      
      public function isAcceptable(param1:String) : Boolean
      {
         if(this.acceptableTypes.indexOf(param1) > -1)
         {
            return true;
         }
         return false;
      }
   }
}

