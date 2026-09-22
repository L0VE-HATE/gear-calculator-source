package gearcalc
{
   import flash.utils.Dictionary;
   
   public class PartCollection
   {
      
      public static var ID_OFFSET_SHIELD:int = 300;
      
      public static var NULL_PART:Part = new Part("xxxx",GearCalcUtil.PART_NONE);
      
      public static var global:PartCollection = null;
      
      NULL_PART.setDisplayName("");
      
      private var parts:Dictionary = null;
      
      private var lookup:Dictionary = null;
      
      public function PartCollection()
      {
         super();
         this.parts = new Dictionary();
         this.lookup = new Dictionary();
         if(global == null)
         {
            global = this;
         }
      }
      
      public static function getPartType(param1:String) : String
      {
         var _loc2_:Part = null;
         if(global != null)
         {
            _loc2_ = global.retrieve(param1);
            if(_loc2_ != null)
            {
               return _loc2_.getType();
            }
         }
         return null;
      }
      
      public function insert(param1:Part) : void
      {
         this.parts[param1.getID()] = param1;
         this.lookup[param1.getTrueName()] = param1;
      }
      
      public function retrieve(param1:String) : Part
      {
         return this.parts[param1];
      }
      
      public function getAllPartsOfType(param1:String, param2:int) : Vector.<Part>
      {
         var _loc4_:Part = null;
         var _loc5_:Object = null;
         var _loc3_:Vector.<Part> = new Vector.<Part>();
         for each(_loc5_ in this.parts)
         {
            _loc4_ = Part(_loc5_);
            if(_loc4_.getType() == param1 && (_loc4_.getGearType() == param2 || _loc4_.getGearType() == GearCalcUtil.GEAR_GLOBAL))
            {
               _loc3_.push(Part(_loc5_));
            }
         }
         return _loc3_;
      }
      
      public function matchTrueName(param1:String) : Part
      {
         if(param1 == NULL_PART.getTrueName())
         {
            return NULL_PART;
         }
         return this.lookup[param1];
      }
      
      public function getFilteredParts(param1:String, param2:String) : Vector.<Part>
      {
         var _loc4_:Part = null;
         var _loc5_:Object = null;
         var _loc3_:Vector.<Part> = new Vector.<Part>();
         for each(_loc5_ in this.parts)
         {
            _loc4_ = Part(_loc5_);
            if(_loc4_.getType() == param2 && _loc4_.getTrueName().indexOf(param1) != -1)
            {
               _loc3_.push(Part(_loc5_));
            }
         }
         return _loc3_;
      }
      
      public function searchForName(param1:String, param2:String, param3:String) : Part
      {
         var matches:Vector.<Part> = null;
         var temp:Part = null;
         var testStr:String = null;
         var testBase:String = null;
         var opDispName:Function = null;
         var vec:Vector.<Part> = null;
         var item:Part = null;
         var arg:String = param1;
         var acceptTypes:String = param2;
         var bias:String = param3;
         var matchCondition:Function = function(param1:Function):void
         {
            var _loc2_:Object = null;
            for(_loc2_ in parts)
            {
               temp = retrieve(_loc2_ as String);
               if(acceptTypes.indexOf(temp.getType()) != -1)
               {
                  testStr = readyString(arg);
                  testBase = readyString(temp.getDisplayName());
                  if(param1())
                  {
                     matches.push(temp);
                  }
               }
            }
         };
         opDispName = function():Boolean
         {
            if(testBase.indexOf(testStr) != -1)
            {
               return true;
            }
            return false;
         };
         var readyString:Function = function(param1:String):String
         {
            var _loc2_:RegExp = new RegExp("/[a-zA-Z0-9-s]/","g");
            var _loc3_:String = param1.replace(_loc2_,"");
            return _loc3_.toLowerCase();
         };
         matches = new Vector.<Part>();
         matchCondition(opDispName);
         if(matches.length > 1)
         {
            vec = new Vector.<Part>();
            for each(item in matches)
            {
               if(readyString(item.getTrueName()).indexOf(readyString(bias)) != -1)
               {
                  vec.push(item);
               }
            }
            if(vec.length == 1)
            {
               matches = vec;
            }
         }
         if(matches.length == 0 || matches.length > 1)
         {
            return null;
         }
         return matches[0];
      }
      
      public function revealPartType(param1:String) : String
      {
         var _loc2_:String = null;
         if(param1.length == GearCalcUtil.XML_ID_LENGTH)
         {
            _loc2_ = param1.substr(0,1);
            switch(_loc2_)
            {
               case "a":
                  return GearCalcUtil.PART_TYPE_ACCESSORY;
               case "f":
                  return GearCalcUtil.PART_TYPE_BODY;
               case "z":
                  return GearCalcUtil.PART_TYPE_SIGHT;
               case "s":
                  return GearCalcUtil.PART_TYPE_STOCK;
               case "g":
                  return GearCalcUtil.PART_TYPE_GRIP;
               case "m":
                  return GearCalcUtil.PART_TYPE_MAG;
               case "e":
                  return GearCalcUtil.PART_TYPE_ACTION;
               case "b":
                  return GearCalcUtil.PART_TYPE_BARREL;
               case "k":
                  return GearCalcUtil.PART_TYPE_GRADE;
               case "j":
                  return GearCalcUtil.PART_TYPE_TYPE;
               case "p":
                  return GearCalcUtil.PART_TYPE_PREFIX;
               case "t":
                  return GearCalcUtil.PART_TYPE_TITLE;
               case "u":
                  return GearCalcUtil.PART_UNIQUE;
               case "x":
                  return GearCalcUtil.PART_TYPE_MATERIAL;
            }
         }
         return NULL_PART.getType();
      }
   }
}

