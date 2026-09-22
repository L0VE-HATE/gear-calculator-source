package gearcalc
{
   public class Shield extends Weapon
   {
      
      public static const ATTR_ROSE_STR:String = "Rose String";
      
      public function Shield()
      {
         super();
         parts = new Vector.<Part>();
         slotReqs = Slot.createSlotTemplate(this.getGearType());
      }
      
      override public function getGearType() : int
      {
         return GearCalcUtil.GEAR_SHIELD;
      }
      
      override public function calculateBase(param1:StatSet) : StatSet
      {
         var _loc2_:Number = Calculator.calcStandardFormula(1,this.getExpLevel(),1.7,49);
         param1.addNumericalStat(GearCalcUtil.ATTR_SHIELD_CAP,_loc2_);
         param1.addNumericalStat("BaseCapacity",_loc2_);
         _loc2_ = Calculator.calcStandardFormula(1,1.16,this.getExpLevel(),0);
         param1.addNumericalStat(GearCalcUtil.ATTR_COST,Math.round(_loc2_ * 10) / 10);
         param1.addNumericalStat(GearCalcUtil.ATTR_INCEN_I_RESIST,1);
         param1.addNumericalStat(GearCalcUtil.ATTR_INCEN_P_RESIST,1);
         param1.addNumericalStat(GearCalcUtil.ATTR_SHOCK_I_RESIST,1);
         param1.addNumericalStat(GearCalcUtil.ATTR_SHOCK_P_RESIST,1);
         param1.addNumericalStat(GearCalcUtil.ATTR_CORR_I_RESIST,1);
         param1.addNumericalStat(GearCalcUtil.ATTR_CORR_P_RESIST,1);
         return param1;
      }
      
      override public function postCalculate(param1:StatSet) : void
      {
         var _loc2_:Number = param1.getStat(GearCalcUtil.ATTR_SHIELD_CAP);
         var _loc3_:Number = param1.getStat(GearCalcUtil.ATTR_SHIELD_RATE);
         var _loc4_:Number = param1.getStat(GearCalcUtil.ATTR_SHIELD_DELAY);
         param1.addNumericalStat(GearCalcUtil.ATTR_SHIELD_TIME,_loc2_ / _loc3_ + _loc4_);
         var _loc5_:Number = param1.getStat(GearCalcUtil.ATTR_HEALTH_REGEN);
         if(this.getParts().length > 0 && this.getSlottedPart(GearCalcUtil.PART_TYPE_GRADE).getTrueName().indexOf("CustomItem_Shield_Anshin_Rose") != -1)
         {
            param1.addNumericalStat(GearCalcUtil.ATTR_HEALTH_REGEN,11 * _loc5_);
            param1.addTextStat(ATTR_ROSE_STR," Rate (for 3 sec.)");
         }
         else
         {
            _loc5_ *= 1 + this.getExpLevel() + 9;
            param1.addNumericalStat(GearCalcUtil.ATTR_HEALTH_REGEN,_loc5_);
            param1.addTextStat(ATTR_ROSE_STR," Rate");
         }
      }
   }
}

