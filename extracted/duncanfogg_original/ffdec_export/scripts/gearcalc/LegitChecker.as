package gearcalc
{
   public class LegitChecker
   {
      
      public var isLegit:Boolean;
      
      private var gear:Gearable;
      
      private var stats:StatSet;
      
      private var coll:PartCollection;
      
      private var template:GearTemplate;
      
      private var gearPrefix:Part;
      
      private var gearTitle:Part;
      
      public var highPrefix:Part;
      
      public var highTitle:Part;
      
      private var constraints:Vector.<Constraint>;
      
      private var allPrefixes:Vector.<Part>;
      
      private var allTitles:Vector.<Part>;
      
      public function LegitChecker()
      {
         super();
         this.constraints = new Vector.<Constraint>();
         this.allPrefixes = new Vector.<Part>();
         this.allTitles = new Vector.<Part>();
      }
      
      public static function isInVector(param1:Part, param2:Vector.<Part>) : Boolean
      {
         var _loc3_:Part = null;
         for each(_loc3_ in param2)
         {
            if(param1.equals(_loc3_))
            {
               return true;
            }
         }
         return false;
      }
      
      public function evaluate(param1:Gearable, param2:StatSet, param3:PartCollection, param4:GearTemplate) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         this.commonInit(param1,param2,param3,param4);
         this.gearPrefix = param1.getSlottedPart(GearCalcUtil.PART_TYPE_PREFIX);
         this.gearTitle = param1.getSlottedPart(GearCalcUtil.PART_TYPE_TITLE);
         if(!isInVector(this.gearPrefix,this.allPrefixes))
         {
            this.isLegit = false;
            GearCalcEngine.addErrorCode("Chosen PREFIX is not in the pool of possible prefixes.");
         }
         else
         {
            GearCalcEngine.addErrorCode("Selected prefix \'" + this.gearPrefix.label + "\' is in possible pool of prefixes.");
         }
         if(!isInVector(this.gearTitle,this.allTitles))
         {
            this.isLegit = false;
            GearCalcEngine.addErrorCode("Chosen TITLE is not in the pool of possible titles.");
         }
         else
         {
            GearCalcEngine.addErrorCode("Selected title \'" + this.gearTitle.label + "\' is in possible pool of titles.");
         }
         if(this.isLegit)
         {
            this.isLegit = this.evaluateConstraints(this.gearPrefix,this.gearTitle);
         }
         if(this.isLegit)
         {
            _loc5_ = this.filterPriorities(this.gearPrefix,this.allPrefixes,GearCalcUtil.PART_TYPE_PREFIX).equals(this.gearPrefix);
            _loc6_ = this.filterPriorities(this.gearTitle,this.allTitles,GearCalcUtil.PART_TYPE_TITLE).equals(this.gearTitle);
            this.isLegit = _loc5_ && _loc6_;
         }
         return this.isLegit;
      }
      
      public function autoName(param1:Gearable, param2:StatSet, param3:PartCollection, param4:GearTemplate) : Vector.<Part>
      {
         this.commonInit(param1,param2,param3,param4);
         var _loc5_:Vector.<Part> = new Vector.<Part>();
         this.evaluateConstraints(null,null);
         _loc5_.push(this.filterPriorities(null,this.allPrefixes,GearCalcUtil.PART_TYPE_PREFIX));
         _loc5_.push(this.filterPriorities(null,this.allTitles,GearCalcUtil.PART_TYPE_TITLE));
         GearCalcEngine.addErrorCode("\n");
         return _loc5_;
      }
      
      private function commonInit(param1:Gearable, param2:StatSet, param3:PartCollection, param4:GearTemplate) : void
      {
         this.gear = param1;
         this.stats = param2;
         this.coll = param3;
         this.template = param4;
         this.isLegit = true;
         this.combinePools();
         this.initTemplateConstraints(param4);
      }
      
      private function initTemplateConstraints(param1:GearTemplate) : void
      {
         var _loc3_:Constraint = null;
         var _loc2_:Vector.<Constraint> = param1.getConstraints();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.getTarget().getType() == GearCalcUtil.PART_TYPE_PREFIX && isInVector(_loc3_.getTarget(),this.allPrefixes))
            {
               this.constraints.push(_loc3_);
            }
            else if(_loc3_.getTarget().getType() == GearCalcUtil.PART_TYPE_TITLE && isInVector(_loc3_.getTarget(),this.allTitles))
            {
               this.constraints.push(_loc3_);
            }
         }
      }
      
      private function filterPriorities(param1:Part, param2:Vector.<Part>, param3:String) : Part
      {
         var _loc6_:Vector.<Part> = null;
         var _loc7_:Part = null;
         var _loc8_:String = null;
         var _loc4_:Part = param1;
         var _loc5_:Number = 0;
         if(_loc4_ != null)
         {
            _loc6_ = this.helpFilterPriorities(_loc4_.getPriority(),param2);
         }
         else
         {
            _loc6_ = this.helpFilterPriorities(0,param2);
         }
         for each(_loc7_ in _loc6_)
         {
            if(_loc4_ == null || _loc4_.getPriority() < _loc7_.getPriority())
            {
               _loc4_ = _loc7_;
            }
            if(param1 != null)
            {
               GearCalcEngine.addErrorCode(param3.toUpperCase() + ": \'" + _loc7_.getDisplayName() + "\' has higher priority than " + param1.getDisplayName() + " (" + _loc7_.getPriority() + " vs " + param1.getPriority() + ")");
            }
         }
         if(param1 == null && _loc4_ != null)
         {
            _loc8_ = _loc4_.getDisplayName().toUpperCase() + " (" + _loc4_.getPriority() + ") selected over: ";
            for each(_loc7_ in _loc6_)
            {
               if(!_loc4_.equals(_loc7_))
               {
                  _loc8_ += _loc7_.label + " (" + _loc7_.getPriority() + "), ";
               }
            }
            GearCalcEngine.addErrorCode(_loc8_.substring(0,_loc8_.length - 2));
         }
         else if(_loc4_ == null)
         {
            GearCalcEngine.addErrorCode("No eligible " + param3);
         }
         return _loc4_;
      }
      
      private function helpFilterPriorities(param1:Number, param2:Vector.<Part>) : Vector.<Part>
      {
         var _loc4_:Part = null;
         var _loc3_:Vector.<Part> = new Vector.<Part>();
         for each(_loc4_ in param2)
         {
            if(_loc4_.getPriority() > param1)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      private function getHighestPriority(param1:Vector.<Part>) : Part
      {
         var _loc2_:Part = null;
         var _loc3_:Part = null;
         for each(_loc3_ in param1)
         {
            if(_loc2_ == null || _loc3_.getPriority() > _loc2_.getPriority())
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
      
      private function evaluateConstraints(param1:Part, param2:Part) : Boolean
      {
         var _loc5_:String = null;
         var _loc6_:Constraint = null;
         var _loc3_:Boolean = true;
         var _loc4_:Boolean = true;
         if(param1 != null && param2 != null)
         {
            GearCalcEngine.addErrorCode("\nChecking for legitness:\n-----------------------------------");
         }
         else
         {
            GearCalcEngine.addErrorCode("\nAuto-naming:\n-----------------------------------");
         }
         for each(_loc6_ in this.constraints)
         {
            _loc4_ = _loc6_.evaluate(this.stats);
            if(_loc6_.getTarget().getType() == GearCalcUtil.PART_TYPE_PREFIX)
            {
               if(param1 != null)
               {
                  _loc5_ = "Test for prefix \'" + _loc6_.getTarget().getDisplayName() + "\' ";
                  if(_loc4_)
                  {
                     _loc5_ += "PASSED: " + this.stats.getStat(_loc6_.getAttr()).toFixed(2) + " (";
                     _loc5_ = _loc5_ + (_loc6_.getAttr() + ") is " + _loc6_.getOperator() + " --> " + _loc6_.getOperandTwo());
                     GearCalcEngine.addErrorCode(_loc5_);
                  }
                  else
                  {
                     _loc5_ += "NOT passed: " + this.stats.getStat(_loc6_.getAttr()).toFixed(2) + " (";
                     _loc5_ = _loc5_ + (_loc6_.getAttr() + ") is not " + _loc6_.getOperator() + " --> " + _loc6_.getOperandTwo());
                     GearCalcEngine.addErrorCode(_loc5_);
                     this.allPrefixes = this.removePart(_loc6_.getTarget(),this.allPrefixes);
                     if(_loc6_.getTarget().equals(param1))
                     {
                        _loc3_ = false;
                        break;
                     }
                  }
               }
               else if(param1 == null)
               {
                  _loc5_ = "\'" + _loc6_.getTarget().getDisplayName() + "\' is ";
                  if(!_loc4_)
                  {
                     this.allPrefixes = this.removePart(_loc6_.getTarget(),this.allPrefixes);
                     _loc5_ += "NOT compatible: " + this.stats.getStat(_loc6_.getAttr()).toFixed(2) + " (";
                     _loc5_ = _loc5_ + (_loc6_.getAttr() + ") is not " + _loc6_.getOperator() + " --> " + _loc6_.getOperandTwo());
                  }
                  else
                  {
                     _loc5_ += "COMPATIBLE: " + this.stats.getStat(_loc6_.getAttr()).toFixed(2) + " (";
                     _loc5_ = _loc5_ + (_loc6_.getAttr() + ") is " + _loc6_.getOperator() + " --> " + _loc6_.getOperandTwo());
                  }
                  GearCalcEngine.addErrorCode(_loc5_);
               }
            }
            else if(_loc6_.getTarget().getType() == GearCalcUtil.PART_TYPE_TITLE)
            {
               if(param2 != null)
               {
                  _loc5_ = "Test for title \'" + _loc6_.getTarget().getDisplayName() + "\' ";
                  if(_loc4_)
                  {
                     _loc5_ += "PASSED: " + this.stats.getStat(_loc6_.getAttr()).toFixed(2) + " (";
                     _loc5_ = _loc5_ + (_loc6_.getAttr() + ") is " + _loc6_.getOperator() + " --> " + _loc6_.getOperandTwo());
                     GearCalcEngine.addErrorCode(_loc5_);
                  }
                  else
                  {
                     _loc5_ += "NOT passed: " + this.stats.getStat(_loc6_.getAttr()).toFixed(2) + " (";
                     _loc5_ = _loc5_ + (_loc6_.getAttr() + ") is not " + _loc6_.getOperator() + " --> " + _loc6_.getOperandTwo());
                     GearCalcEngine.addErrorCode(_loc5_);
                     this.allTitles = this.removePart(_loc6_.getTarget(),this.allTitles);
                     if(_loc6_.getTarget().equals(param2))
                     {
                        _loc3_ = false;
                        break;
                     }
                  }
               }
               else if(param2 == null)
               {
                  _loc5_ = "\'" + _loc6_.getTarget().getDisplayName() + "\' is ";
                  if(!_loc4_)
                  {
                     this.allTitles = this.removePart(_loc6_.getTarget(),this.allTitles);
                     _loc5_ += "NOT compatible: " + this.stats.getStat(_loc6_.getAttr()).toFixed(2) + " (";
                     _loc5_ = _loc5_ + (_loc6_.getAttr() + ") is not " + _loc6_.getOperator() + " --> " + _loc6_.getOperandTwo());
                  }
                  else
                  {
                     _loc5_ += "COMPATIBLE: " + this.stats.getStat(_loc6_.getAttr()).toFixed(2) + " (";
                     _loc5_ = _loc5_ + (_loc6_.getAttr() + ") is " + _loc6_.getOperator() + " --> " + _loc6_.getOperandTwo());
                  }
                  GearCalcEngine.addErrorCode(_loc5_);
               }
            }
         }
         return _loc3_;
      }
      
      private function removePart(param1:Part, param2:Vector.<Part>) : Vector.<Part>
      {
         var _loc4_:Part = null;
         var _loc3_:Vector.<Part> = new Vector.<Part>();
         for each(_loc4_ in param2)
         {
            if(!_loc4_.equals(param1))
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      private function combinePools() : void
      {
         var _loc3_:Part = null;
         var _loc4_:Part = null;
         var _loc5_:Vector.<String> = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc1_:Vector.<String> = new Vector.<String>();
         var _loc2_:Vector.<Part> = this.gear.getParts();
         for each(_loc4_ in _loc2_)
         {
            _loc1_ = _loc4_.getLinkedPartRefs();
            for each(_loc7_ in _loc1_)
            {
               _loc3_ = this.coll.retrieve(_loc7_);
               if(_loc3_.getType() == GearCalcUtil.PART_TYPE_PREFIX)
               {
                  this.allPrefixes.push(_loc3_);
               }
               else if(_loc3_.getType() == GearCalcUtil.PART_TYPE_TITLE)
               {
                  this.allTitles.push(_loc3_);
               }
            }
            if(_loc4_.getTechAbilities().length > 0)
            {
               this.handleTechPrefixes(_loc4_);
            }
         }
         _loc5_ = this.template.getGeneralPool() != null ? this.template.getGeneralPool() : new Vector.<String>();
         for each(_loc6_ in _loc5_)
         {
            _loc4_ = this.coll.retrieve(_loc6_);
            if(_loc4_.getType() == GearCalcUtil.PART_TYPE_PREFIX)
            {
               this.allPrefixes.push(_loc4_);
            }
            else if(_loc4_.getType() == GearCalcUtil.PART_TYPE_TITLE)
            {
               this.allTitles.push(_loc4_);
            }
         }
      }
      
      private function handleTechPrefixes(param1:Part) : void
      {
         var _loc3_:Part = null;
         var _loc4_:Constraint = null;
         var _loc5_:TechAbility = null;
         var _loc2_:Vector.<TechAbility> = param1.getTechAbilities();
         for each(_loc5_ in _loc2_)
         {
            if(_loc5_.getLinkedID() != null)
            {
               _loc3_ = this.coll.retrieve(_loc5_.getLinkedID());
               _loc4_ = new Constraint(_loc3_,Constraint.RULE_GREATER_EQUAL);
               _loc4_.setAttributeOperand(GearCalcUtil.ATTR_TECH);
               if(_loc3_.label.indexOf("1_") != -1)
               {
                  _loc4_.setOperandTwo(1);
               }
               else if(_loc3_.label.indexOf("2_") != -1)
               {
                  _loc4_.setOperandTwo(6);
               }
               else if(_loc3_.label.indexOf("3_") != -1)
               {
                  _loc4_.setOperandTwo(12);
               }
               else if(_loc3_.label.indexOf("4_") != -1)
               {
                  _loc4_.setOperandTwo(16);
               }
               this.constraints.push(_loc4_);
               this.allPrefixes.push(_loc3_);
            }
         }
      }
   }
}

