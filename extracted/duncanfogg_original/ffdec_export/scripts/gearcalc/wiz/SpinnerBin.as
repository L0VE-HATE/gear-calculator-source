package gearcalc.wiz
{
   import gearcalc.AttributeModifier;
   import gearcalc.Part;
   import gearcalc.PartCollection;
   
   public class SpinnerBin
   {
      
      internal static var SIMPLE_NULL:SimplePart = new SimplePart(PartCollection.NULL_PART);
      
      internal var type:*;
      
      internal var nextBin:SpinnerBin;
      
      private var allParts:Vector.<SimplePart>;
      
      private var active:Vector.<SimplePart>;
      
      private var index:int;
      
      private var curAttr:String;
      
      public function SpinnerBin(param1:String)
      {
         super();
         this.allParts = new Vector.<SimplePart>();
         this.type = param1;
         this.index = 0;
      }
      
      internal function initPivot(param1:Part) : void
      {
         this.allParts = new Vector.<SimplePart>();
         var _loc2_:SimplePart = new SimplePart(param1);
         this.allParts.push(param1);
      }
      
      internal function init(param1:Vector.<Part>) : void
      {
         var _loc2_:Part = null;
         var _loc3_:SimplePart = null;
         this.active = new Vector.<SimplePart>();
         for each(_loc2_ in param1)
         {
            _loc3_ = new SimplePart(_loc2_);
            this.allParts.push(_loc3_);
            this.active.push(_loc3_);
         }
      }
      
      internal function filterFor(param1:String) : void
      {
         var _loc2_:SimplePart = null;
         this.active = new Vector.<SimplePart>();
         this.curAttr = param1;
         for each(_loc2_ in this.allParts)
         {
            if(_loc2_.isModifierOf(param1))
            {
               _loc2_.prep(param1);
               this.active.push(_loc2_);
            }
            else
            {
               this.active.push(SIMPLE_NULL);
            }
         }
         this.index = 0;
      }
      
      internal function spin() : Boolean
      {
         if(this.nextBin != null && this.nextBin.spin())
         {
            return true;
         }
         if(this.index + 1 >= this.active.length)
         {
            this.resetSpinner();
            return false;
         }
         ++this.index;
         return true;
      }
      
      internal function resetSpinner() : void
      {
         this.index = 0;
         if(this.nextBin != null)
         {
            this.nextBin.resetSpinner();
         }
      }
      
      internal function spec() : Vector.<Part>
      {
         var _loc2_:SimplePart = null;
         var _loc1_:Vector.<Part> = new Vector.<Part>();
         if(this.current().id == PartCollection.NULL_PART.getID())
         {
            for each(_loc2_ in this.allParts)
            {
               if(!_loc2_.isModifierOf(this.curAttr))
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         else
         {
            _loc1_.push(this.current());
         }
         return _loc1_;
      }
      
      internal function addToBuild(param1:Vector.<Part>) : void
      {
         param1.push(this.current());
         if(this.nextBin != null)
         {
            this.addToBuild(param1);
         }
      }
      
      internal function current() : SimplePart
      {
         return this.active[this.index];
      }
      
      internal function collectActiveMods() : Vector.<AttributeModifier>
      {
         if(this.active == null || this.index >= this.active.length)
         {
            return null;
         }
         return this.current().curMods;
      }
      
      internal function doesTypeModify(param1:String) : Boolean
      {
         var _loc2_:SimplePart = null;
         if(this.active != null)
         {
            return this.active.length > 0 ? true : false;
         }
         for each(_loc2_ in this.allParts)
         {
            if(_loc2_.isModifierOf(param1))
            {
               return true;
            }
         }
         return false;
      }
   }
}

