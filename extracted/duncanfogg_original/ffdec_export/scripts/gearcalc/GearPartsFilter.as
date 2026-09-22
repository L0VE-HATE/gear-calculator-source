package gearcalc
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class GearPartsFilter extends EventDispatcher
   {
      
      private var regTemplates:Dictionary = null;
      
      public var template:GearTemplate = null;
      
      private var slots:Vector.<String>;
      
      public function GearPartsFilter()
      {
         super();
         this.slots = new Vector.<String>();
         this.regTemplates = new Dictionary();
      }
      
      internal function duplicate() : GearPartsFilter
      {
         var _loc1_:GearPartsFilter = new GearPartsFilter();
         _loc1_.regTemplates = this.regTemplates;
         _loc1_.slots = this.slots;
         return _loc1_;
      }
      
      public function initDerivedTemplates() : void
      {
         var _loc5_:Object = null;
         var _loc6_:PartList = null;
         var _loc1_:GearTemplate = null;
         var _loc2_:GearTemplate = null;
         var _loc3_:Vector.<PartList> = null;
         var _loc4_:String = null;
         for each(_loc5_ in this.regTemplates)
         {
            _loc1_ = GearTemplate(_loc5_);
            if(_loc1_.getBaseTemplateName() != null)
            {
               _loc2_ = GearTemplate(this.regTemplates[_loc1_.getBaseTemplateName()]);
               _loc3_ = _loc2_.getPartLists();
               for each(_loc6_ in _loc3_)
               {
                  if(_loc1_.findPartList(_loc6_.type) == null || _loc1_.findPartList(_loc6_.type).length == 0)
                  {
                     _loc1_.addPartList(_loc6_.list,_loc6_.type);
                  }
               }
               if(_loc1_.getBaseModifiers().length == 0)
               {
                  _loc1_.setStats(_loc2_.getBaseModifiers());
               }
               if(_loc1_.getAttrModifiers().length == 0)
               {
                  _loc1_.setAttrMods(_loc2_.getAttrModifiers());
               }
               if(_loc1_.getConstraints().length == 0)
               {
                  _loc1_.setConstraints(_loc2_.getConstraints());
               }
               if(_loc1_.getGeneralPool().length == 0)
               {
                  _loc1_.setGeneralPool(_loc2_.getGeneralPool());
               }
               if(_loc1_.naming == null)
               {
                  _loc1_.naming = _loc2_.naming;
               }
               if(_loc1_.basePartStr.length == 0)
               {
                  _loc1_.basePartStr = _loc2_.basePartStr;
               }
            }
            _loc1_.initSlotReqs();
         }
      }
      
      public function setActiveTemplate(param1:GearTemplate) : void
      {
         this.template = param1;
      }
      
      public function registerTemplate(param1:GearTemplate) : void
      {
         this.regTemplates[param1.getType()] = param1;
      }
      
      public function getSlots() : Vector.<String>
      {
         return this.slots;
      }
      
      public function getSuitableTemplate(param1:Part) : GearTemplate
      {
         var _loc2_:GearTemplate = null;
         var _loc3_:Object = null;
         for each(_loc3_ in this.regTemplates)
         {
            _loc2_ = _loc3_ as GearTemplate;
            if(_loc2_.isCompatible(param1))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function filterAndMatch(param1:Part, param2:Part, param3:String, param4:int) : Vector.<Part>
      {
         var _loc6_:Object = null;
         var _loc5_:GearTemplate = null;
         if(this.template == null && param2 != null && param1 != null)
         {
            for each(_loc6_ in this.regTemplates)
            {
               _loc5_ = GearTemplate(_loc6_);
               if(_loc5_.isCompatible(param1) && _loc5_.isCompatible(param2))
               {
                  this.setActiveTemplate(_loc5_);
                  return _loc5_.getAcceptableParts(param3);
               }
            }
         }
         else if(this.template != null && param1 != null && param2 != null)
         {
            if(this.template.isCompatible(param1) && this.template.isCompatible(param2))
            {
               return this.template.getAcceptableParts(param3);
            }
         }
         this.setActiveTemplate(null);
         return null;
      }
      
      public function calc(param1:Gearable) : StatSet
      {
         var _loc2_:Calculator = new Calculator(param1,this.template);
         _loc2_.calculate();
         return _loc2_.getResults();
      }
      
      public function acceptsPartOfType(param1:String, param2:int) : Boolean
      {
         if(this.template != null && this.template.getAcceptableParts(param1).length > 0)
         {
            return true;
         }
         return false;
      }
      
      public function matchTypeToGrade(param1:Part) : Part
      {
         var _loc3_:GearTemplate = null;
         var _loc2_:Part = null;
         for each(_loc3_ in this.regTemplates)
         {
            if(_loc3_.isCompatible(param1))
            {
               return _loc3_.getAcceptableParts(GearCalcUtil.PART_TYPE_TYPE)[0];
            }
         }
         return _loc2_;
      }
      
      public function checkLegitness(param1:Gearable, param2:StatSet, param3:PartCollection) : Boolean
      {
         var _loc4_:LegitChecker = null;
         if(this.template != null)
         {
            _loc4_ = new LegitChecker();
            return _loc4_.evaluate(param1,param2,param3,this.template);
         }
         return false;
      }
      
      public function verifyManufacturer(param1:Gearable) : Boolean
      {
         var _loc4_:Part = null;
         var _loc2_:String = param1.getPart(GearCalcUtil.PART_TYPE_MANUFACT).getManufacturer();
         var _loc3_:Vector.<Part> = param1.getParts();
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.getManufacturer() != null && _loc4_.getManufacturer() != _loc2_)
            {
               return false;
            }
         }
         return true;
      }
      
      public function evalNamingPriority(param1:Gearable) : Boolean
      {
         return true;
      }
      
      public function reset() : void
      {
         this.setActiveTemplate(null);
      }
      
      public function matchQuality(param1:String, param2:int) : int
      {
         if(this.template != null)
         {
            return this.template.matchManufacturerQuality(param1,param2);
         }
         return 0;
      }
      
      public function getSlotTotal() : int
      {
         if(this.template != null)
         {
            return this.template.getSlots().length;
         }
         return this.slots.length;
      }
      
      public function getSlotRequirements() : Vector.<Slot>
      {
         if(this.template != null)
         {
            return this.template.getSlots();
         }
         return null;
      }
      
      public function isPartTypeSlotted(param1:String) : Boolean
      {
         var _loc2_:Vector.<Slot> = null;
         var _loc3_:Slot = null;
         if(this.template != null)
         {
            _loc2_ = this.template.getSlots();
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_.isAcceptable(param1))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function verifyImport(param1:int, param2:Vector.<Part>) : Vector.<Part>
      {
         var grade:Part = null;
         var type:Part = null;
         var reqs:Vector.<Slot> = null;
         var temp:Vector.<Part> = null;
         var i:int = 0;
         var gearType:int = param1;
         var unproc:Vector.<Part> = param2;
         var isInVector:Function = function(param1:Part, param2:Vector.<Part>):Boolean
         {
            var _loc3_:Part = null;
            for each(_loc3_ in param2)
            {
               if(param1.getID() == _loc3_.getID())
               {
                  return true;
               }
            }
            return false;
         };
         var fixed:Vector.<Part> = new Vector.<Part>();
         this.setActiveTemplate(null);
         if(unproc.length > 6)
         {
            if(unproc[0].getType() != GearCalcUtil.PART_TYPE_GRADE)
            {
               return null;
            }
            grade = unproc[0];
            if(gearType == GearCalcUtil.GEAR_WEAPON)
            {
               if(unproc[2].getType() != GearCalcUtil.PART_TYPE_TYPE)
               {
                  return null;
               }
               type = unproc[2];
            }
            else
            {
               if(unproc[1].getType() != GearCalcUtil.PART_TYPE_TYPE)
               {
                  return null;
               }
               type = unproc[1];
            }
            this.filterAndMatch(grade,type,GearCalcUtil.PART_NONE,gearType);
            if(this.template == null)
            {
               return null;
            }
            reqs = this.template.getSlots();
            i = 0;
            while(i < reqs.length)
            {
               if(i <= unproc.length)
               {
                  temp = this.filterAndMatch(grade,type,reqs[i].name,gearType);
                  if(reqs[i].acceptableTypes.indexOf(GearCalcUtil.PART_TYPE_PREFIX) == -1)
                  {
                     if(isInVector(unproc[i],temp))
                     {
                        fixed.push(unproc[i]);
                     }
                     else
                     {
                        fixed.push(PartCollection.NULL_PART);
                     }
                  }
                  else if(unproc[i].getType() == GearCalcUtil.PART_TYPE_PREFIX || unproc[i].getType() == GearCalcUtil.PART_TYPE_TITLE)
                  {
                     fixed.push(unproc[i]);
                  }
               }
               i++;
            }
         }
         return fixed;
      }
   }
}

