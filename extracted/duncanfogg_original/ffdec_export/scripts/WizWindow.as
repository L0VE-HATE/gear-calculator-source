package
{
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import gearcalc.*;
   import gearcalc.wiz.*;
   import mx.binding.*;
   import mx.collections.ArrayCollection;
   import mx.collections.IList;
   import mx.containers.Form;
   import mx.containers.FormItem;
   import mx.controls.DataGrid;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.styles.*;
   import spark.components.Button;
   import spark.components.DropDownList;
   import spark.components.HGroup;
   import spark.components.HSlider;
   import spark.components.Label;
   import spark.components.TextInput;
   import spark.components.TitleWindow;
   import spark.components.VGroup;
   import spark.events.IndexChangeEvent;
   
   use namespace mx_internal;
   
   public class WizWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      private static var _skinParts:Object = {
         "contentGroup":false,
         "moveArea":false,
         "closeButton":false,
         "titleDisplay":false,
         "controlBarGroup":false
      };
      
      private var _2122520521accInput:TextInput;
      
      private var _1623501222clipInput:TextInput;
      
      private var _839364244dmgInput:TextInput;
      
      private var _1520230123gradeList:DropDownList;
      
      private var _1774013829levelSlider:HSlider;
      
      private var _1390837848prefixInput:TextInput;
      
      private var _463445119rofInput:TextInput;
      
      private var _1616171948techList:DropDownList;
      
      private var _1793852334titleInput:TextInput;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var eleColl:ArrayCollection;
      
      private var coll:ArrayCollection;
      
      private var engine:GearCalcEngine;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function WizWindow()
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this.eleColl = new ArrayCollection();
         this.coll = new ArrayCollection();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         bindings = this._WizWindow_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_WizWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return WizWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 530;
         this.height = 346;
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._WizWindow_Array1_c);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         WizWindow._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      public function init(param1:GearCalcEngine) : void
      {
         var _loc3_:Part = null;
         this.engine = param1;
         var _loc2_:Vector.<Part> = param1.getAllPartsOfType(GearCalcUtil.PART_TYPE_GRADE);
         this.coll.removeAll();
         for each(_loc3_ in _loc2_)
         {
            this.coll.addItem(_loc3_);
         }
      }
      
      private function onGradeChange() : void
      {
         var _loc5_:String = null;
         var _loc6_:Part = null;
         if(this.gradeList.selectedIndex == -1)
         {
            return;
         }
         var _loc1_:Part = this.gradeList.selectedItem as Part;
         var _loc2_:GearTemplate = this.engine.filter.getSuitableTemplate(_loc1_);
         var _loc3_:Vector.<Part> = _loc2_.getAcceptableParts(GearCalcUtil.PART_TYPE_ACCESSORY);
         var _loc4_:Vector.<String> = new Vector.<String>();
         _loc4_.push(GearCalcUtil.TECH_NONE);
         _loc4_.push(GearCalcUtil.TECH_CORROSIVE);
         _loc4_.push(GearCalcUtil.TECH_EXPLOSIVE);
         _loc4_.push(GearCalcUtil.TECH_INCENDIARY);
         _loc4_.push(GearCalcUtil.TECH_SHOCK);
         this.eleColl.removeAll();
         for each(_loc5_ in _loc4_)
         {
            for each(_loc6_ in _loc3_)
            {
               if(_loc6_.getTechAbilities().length > 0 && _loc6_.getTechAbilities()[0].getType() == _loc5_)
               {
                  this.eleColl.addItem(_loc5_);
                  break;
               }
               if(_loc6_.getTechAbilities().length == 0 && _loc5_ == GearCalcUtil.TECH_NONE)
               {
                  this.eleColl.addItem(_loc5_);
                  break;
               }
            }
         }
         this.techList.selectedIndex = 0;
      }
      
      private function onClose() : void
      {
         this.dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function resolveAccessory() : Vector.<Part>
      {
         var _loc6_:Part = null;
         if(this.gradeList.selectedIndex == -1)
         {
            return null;
         }
         var _loc1_:Part = this.gradeList.selectedItem as Part;
         var _loc2_:GearTemplate = this.engine.filter.getSuitableTemplate(_loc1_);
         var _loc3_:Vector.<Part> = _loc2_.getAcceptableParts(GearCalcUtil.PART_TYPE_ACCESSORY);
         var _loc4_:String = this.techList.selectedItem as String;
         var _loc5_:Vector.<Part> = new Vector.<Part>();
         for each(_loc6_ in _loc3_)
         {
            if(_loc6_.getTechAbilities().length > 0 && _loc6_.getTechAbilities()[0].getType() == _loc4_)
            {
               _loc5_.push(_loc6_);
            }
            else if(_loc6_.getTechAbilities().length == 0 && _loc4_ == GearCalcUtil.TECH_NONE)
            {
               _loc5_.push(_loc6_);
            }
         }
         return _loc5_;
      }
      
      private function tryExecute() : void
      {
         var _loc6_:Part = null;
         var _loc7_:Part = null;
         if(this.gradeList.selectedIndex == -1)
         {
            return;
         }
         var _loc1_:Part = this.gradeList.selectedItem as Part;
         var _loc2_:GearTemplate = this.engine.filter.getSuitableTemplate(_loc1_);
         var _loc3_:Part = _loc2_.getAcceptableParts(GearCalcUtil.PART_TYPE_TYPE)[0];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:WizEngine = new WizEngine(_loc2_,this.levelSlider.value + 2);
         var _loc5_:int = 0;
         if(!isNaN(Number(this.dmgInput.text)))
         {
            _loc5_++;
            _loc4_.addCriterion(GearCalcUtil.ATTR_DAMAGE,Number(this.dmgInput.text),Constraint.RULE_EQUAL);
         }
         if(!isNaN(Number(this.accInput.text)))
         {
            _loc5_++;
            _loc4_.addCriterion(GearCalcUtil.ATTR_CARD_ACCURACY,Number(this.accInput.text),Constraint.RULE_EQUAL);
         }
         if(!isNaN(Number(this.rofInput.text)))
         {
            _loc5_++;
            _loc4_.addCriterion(GearCalcUtil.ATTR_FIRERATE,Number(this.rofInput.text),Constraint.RULE_EQUAL);
         }
         if(!isNaN(Number(this.clipInput.text)))
         {
            _loc5_++;
            _loc4_.addCriterion(GearCalcUtil.ATTR_CLIP,Number(this.clipInput.text),Constraint.RULE_EQUAL);
         }
         if(_loc5_ < WizEngine.MIN_MATCH_ARGS)
         {
            return;
         }
         _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_BODY,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_BODY);
         _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_GRIP,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_GRIP);
         _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_MAG,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_MAG);
         _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_BARREL,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_BARREL);
         _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_SIGHT,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_SIGHT);
         _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_STOCK,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_STOCK);
         _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_ACTION,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_ACTION);
         _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_MATERIAL,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_MATERIAL);
         _loc4_.addParts(this.resolveAccessory(),GearCalcUtil.PART_TYPE_ACCESSORY);
         if(this.prefixInput.text.length > 0)
         {
            _loc6_ = this.engine.parts.searchForName(this.prefixInput.text,GearCalcUtil.PART_TYPE_PREFIX,_loc3_.label);
            if(_loc6_ != null)
            {
               _loc4_.addPivot(_loc6_,GearCalcUtil.PART_TYPE_PREFIX);
            }
         }
         else
         {
            _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_PREFIX,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_PREFIX);
         }
         if(this.titleInput.text.length > 0)
         {
            _loc7_ = this.engine.parts.searchForName(this.titleInput.text,GearCalcUtil.PART_TYPE_TITLE,_loc3_.label);
            if(_loc7_ != null)
            {
               _loc4_.addPivot(_loc7_,GearCalcUtil.PART_TYPE_TITLE);
            }
         }
         else
         {
            _loc4_.addParts(this.engine.filter.filterAndMatch(_loc1_,_loc3_,GearCalcUtil.PART_TYPE_TITLE,GearCalcUtil.GEAR_WEAPON),GearCalcUtil.PART_TYPE_TITLE);
         }
         _loc4_.execute();
      }
      
      private function _WizWindow_Array1_c() : Array
      {
         var _loc1_:Array = [this._WizWindow_HGroup1_c(),this._WizWindow_Label2_c(),this._WizWindow_Button1_c(),this._WizWindow_Button2_c(),this._WizWindow_Button3_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _WizWindow_HGroup1_c() : HGroup
      {
         var _loc1_:HGroup = new HGroup();
         _loc1_.y = 10;
         _loc1_.percentWidth = 97;
         _loc1_.percentHeight = 85;
         _loc1_.requestedColumnCount = 2;
         _loc1_.paddingLeft = 4;
         _loc1_.paddingRight = 4;
         _loc1_.paddingBottom = 2;
         _loc1_.paddingTop = 2;
         _loc1_.horizontalCenter = 0;
         _loc1_.mxmlContent = [this._WizWindow_VGroup1_c(),this._WizWindow_DataGrid1_c()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _WizWindow_VGroup1_c() : VGroup
      {
         var _loc1_:VGroup = new VGroup();
         _loc1_.percentWidth = 50;
         _loc1_.percentHeight = 100;
         _loc1_.requestedRowCount = 2;
         _loc1_.paddingTop = 0;
         _loc1_.paddingBottom = 0;
         _loc1_.paddingRight = 1;
         _loc1_.paddingLeft = 1;
         _loc1_.mxmlContent = [this._WizWindow_Label1_c(),this._WizWindow_Form1_c()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _WizWindow_Label1_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.text = "Select a weapon type, level, and enter at least two stats.  Names and Tech are optional.";
         _loc1_.percentWidth = 100;
         _loc1_.setStyle("fontSize",12);
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textAlign","left");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _WizWindow_Form1_c() : Form
      {
         var temp:Form = new Form();
         temp.percentWidth = 100;
         temp.percentHeight = 100;
         temp.setStyle("paddingLeft",2);
         temp.setStyle("paddingRight",2);
         temp.setStyle("paddingTop",4);
         temp.setStyle("paddingBottom",4);
         temp.setStyle("indicatorGap",6);
         temp.setStyle("verticalGap",2);
         if(!temp.document)
         {
            temp.document = this;
         }
         temp.mx_internal::_documentDescriptor = new UIComponentDescriptor({
            "type":Form,
            "stylesFactory":function():void
            {
               this.paddingLeft = 2;
               this.paddingRight = 2;
               this.paddingTop = 4;
               this.paddingBottom = 4;
               this.indicatorGap = 6;
               this.verticalGap = 2;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":FormItem,
                  "stylesFactory":function():void
                  {
                     this.fontWeight = "normal";
                     this.textDecoration = "none";
                     this.fontStyle = "normal";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Type",
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":DropDownList,
                           "id":"gradeList",
                           "events":{"change":"__gradeList_change"},
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Req. Level",
                        "percentWidth":100,
                        "height":17,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HSlider,
                           "id":"levelSlider",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":50,
                                 "minimum":0,
                                 "maximum":61,
                                 "stepSize":1,
                                 "value":0
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "stylesFactory":function():void
                  {
                     this.color = 7500402;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Tech",
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":DropDownList,
                           "id":"techList",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Damage",
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"dmgInput",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "maxChars":9,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Accuracy",
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"accInput",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "maxChars":9,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Fire Rate",
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"rofInput",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "maxChars":9,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Clip Size",
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"clipInput",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "maxChars":4,
                                 "restrict":".0-9"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "stylesFactory":function():void
                  {
                     this.color = 7368816;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Prefix",
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"prefixInput",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":FormItem,
                  "stylesFactory":function():void
                  {
                     this.color = 7368816;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Title",
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"titleInput",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         temp.mx_internal::_documentDescriptor.document = this;
         BindingManager.executeBindings(this,"temp",temp);
         return temp;
      }
      
      public function __gradeList_change(param1:IndexChangeEvent) : void
      {
         this.onGradeChange();
      }
      
      private function _WizWindow_DataGrid1_c() : DataGrid
      {
         var _loc1_:DataGrid = new DataGrid();
         _loc1_.percentHeight = 100;
         _loc1_.percentWidth = 66;
         _loc1_.editable = false;
         _loc1_.enabled = false;
         _loc1_.columns = [this._WizWindow_DataGridColumn1_c(),this._WizWindow_DataGridColumn2_c()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _WizWindow_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "#";
         _loc1_.dataField = "col1";
         _loc1_.width = 30;
         _loc1_.setStyle("textAlign","center");
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _WizWindow_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Match";
         _loc1_.dataField = "col2";
         _loc1_.setStyle("textAlign","center");
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _WizWindow_Label2_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.y = -26;
         _loc1_.text = "Gear Deconstruction";
         _loc1_.width = 271;
         _loc1_.height = 23;
         _loc1_.horizontalCenter = 0;
         _loc1_.setStyle("fontSize",17);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("verticalAlign","middle");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _WizWindow_Button1_c() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.label = "Select";
         _loc1_.width = 104;
         _loc1_.enabled = false;
         _loc1_.horizontalCenter = 150;
         _loc1_.bottom = 8;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _WizWindow_Button2_c() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.label = "Cancel";
         _loc1_.width = 104;
         _loc1_.horizontalCenter = -150;
         _loc1_.bottom = 8;
         _loc1_.addEventListener("click",this.___WizWindow_Button2_click);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function ___WizWindow_Button2_click(param1:MouseEvent) : void
      {
         this.onClose();
      }
      
      private function _WizWindow_Button3_c() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.label = "Calculate";
         _loc1_.width = 104;
         _loc1_.horizontalCenter = 0;
         _loc1_.bottom = 8;
         _loc1_.addEventListener("click",this.___WizWindow_Button3_click);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      public function ___WizWindow_Button3_click(param1:MouseEvent) : void
      {
         this.tryExecute();
      }
      
      private function _WizWindow_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():IList
         {
            return coll;
         },null,"gradeList.dataProvider");
         result[1] = new Binding(this,function():IList
         {
            return eleColl;
         },null,"techList.dataProvider");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get accInput() : TextInput
      {
         return this._2122520521accInput;
      }
      
      public function set accInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._2122520521accInput;
         if(_loc2_ !== param1)
         {
            this._2122520521accInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"accInput",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get clipInput() : TextInput
      {
         return this._1623501222clipInput;
      }
      
      public function set clipInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1623501222clipInput;
         if(_loc2_ !== param1)
         {
            this._1623501222clipInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"clipInput",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dmgInput() : TextInput
      {
         return this._839364244dmgInput;
      }
      
      public function set dmgInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._839364244dmgInput;
         if(_loc2_ !== param1)
         {
            this._839364244dmgInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dmgInput",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gradeList() : DropDownList
      {
         return this._1520230123gradeList;
      }
      
      public function set gradeList(param1:DropDownList) : void
      {
         var _loc2_:Object = this._1520230123gradeList;
         if(_loc2_ !== param1)
         {
            this._1520230123gradeList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gradeList",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get levelSlider() : HSlider
      {
         return this._1774013829levelSlider;
      }
      
      public function set levelSlider(param1:HSlider) : void
      {
         var _loc2_:Object = this._1774013829levelSlider;
         if(_loc2_ !== param1)
         {
            this._1774013829levelSlider = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"levelSlider",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get prefixInput() : TextInput
      {
         return this._1390837848prefixInput;
      }
      
      public function set prefixInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1390837848prefixInput;
         if(_loc2_ !== param1)
         {
            this._1390837848prefixInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"prefixInput",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rofInput() : TextInput
      {
         return this._463445119rofInput;
      }
      
      public function set rofInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._463445119rofInput;
         if(_loc2_ !== param1)
         {
            this._463445119rofInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rofInput",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get techList() : DropDownList
      {
         return this._1616171948techList;
      }
      
      public function set techList(param1:DropDownList) : void
      {
         var _loc2_:Object = this._1616171948techList;
         if(_loc2_ !== param1)
         {
            this._1616171948techList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"techList",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleInput() : TextInput
      {
         return this._1793852334titleInput;
      }
      
      public function set titleInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1793852334titleInput;
         if(_loc2_ !== param1)
         {
            this._1793852334titleInput = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleInput",_loc2_,param1));
            }
         }
      }
   }
}

