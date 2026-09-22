package
{
   import flash.events.MouseEvent;
   import gearcalc.GearCalcEngine;
   import gearcalc.GearCalcUtil;
   import gearcalc.Part;
   import gearcalc.PartCollection;
   import gearcalc.PartFormatter;
   import mx.binding.BindingManager;
   import mx.collections.ArrayCollection;
   import mx.controls.Tree;
   import mx.controls.VRule;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import spark.components.Button;
   import spark.components.Label;
   import spark.components.TextArea;
   import spark.components.TitleWindow;
   import spark.filters.DropShadowFilter;
   
   public class NamingTitleWindow extends TitleWindow
   {
      
      public static const NODE_MAT_PREFIX:String = "gd_weap_shared_materialparts.Prefix";
      
      public static const NODE_SHARED_PREFIX:String = "gd_weap_names_shared.Prefix";
      
      public static const NODE_ASSAULT_SHOTTY:String = "gd_weap_assault_shotgun";
      
      public static const NODE_COMBAT_SHOTTY:String = "gd_weap_combat_shotgun";
      
      public static const NODE_RIFLES:String = "gd_weap_combat_rifle";
      
      public static const NODE_MG:String = "gd_weap_support_machinegun";
      
      public static const NODE_MACHINE_PISTOL:String = "gd_weap_machine_pistol";
      
      public static const NODE_SMG:String = "gd_weap_patrol_smg";
      
      public static const NODE_REPEATER:String = "gd_weap_repeater_pistol";
      
      public static const NODE_REVOLVER:String = "gd_weap_revolver_pistol";
      
      public static const NODE_ROCKET:String = "gd_weap_rocket_launcher";
      
      public static const NODE_SNIPER:String = "gd_weap_sniper_rifle.";
      
      public static const NODE_SNIPER_SEMIAUTO:String = "gd_weap_sniper_rifle_semiauto";
      
      public static const NODE_SHIELD:String = "gd_shields";
      
      public static const NODE_SHIELD_KNOXX:String = "dlc3_gd_item_UniqueParts";
      
      private static var _skinParts:Object = {
         "contentGroup":false,
         "moveArea":false,
         "closeButton":false,
         "titleDisplay":false,
         "controlBarGroup":false
      };
      
      private var _407812607blackShadow:DropShadowFilter;
      
      private var _1990131276cancelButton:Button;
      
      private var _792940987clrButton:Button;
      
      private var _1641788370okButton:Button;
      
      private var _1290168494prefixLog:TextArea;
      
      private var _1340276400prefixTree:Tree;
      
      private var _1870018100titleLog:TextArea;
      
      private var _2135745002titleTree:Tree;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var dpPrefix:ArrayCollection;
      
      private var dpTitle:ArrayCollection;
      
      private var update:Function;
      
      private var parts:PartCollection;
      
      public var selectedPrefix:Part;
      
      public var selectedTitle:Part;
      
      public function NamingTitleWindow()
      {
         super();
         this.width = 560;
         this.height = 430;
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._NamingTitleWindow_Array1_c);
         this._NamingTitleWindow_DropShadowFilter1_i();
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
      
      public function init(param1:GearCalcEngine, param2:Function, param3:Boolean) : void
      {
         var _loc4_:Array = null;
         this.parts = param1.parts;
         this.update = param2;
         this.selectedPrefix = null;
         this.selectedTitle = null;
         this.dpPrefix = new ArrayCollection();
         this.dpTitle = new ArrayCollection();
         this.prefixTree.dataProvider = this.dpPrefix;
         this.titleTree.dataProvider = this.dpTitle;
         this.prefixTree.filters = [this.blackShadow];
         this.titleTree.filters = [this.blackShadow];
         if(param3)
         {
            _loc4_ = [GearCalcUtil.PART_TYPE_PREFIX,GearCalcUtil.PART_TYPE_TITLE];
         }
         else
         {
            _loc4_ = [GearCalcUtil.PART_TYPE_PREFIX];
         }
         this.initTreeProviders(this.dpPrefix,_loc4_,param1.gearType);
         if(!param3)
         {
            _loc4_ = [GearCalcUtil.PART_TYPE_TITLE];
         }
         this.initTreeProviders(this.dpTitle,_loc4_,param1.gearType);
      }
      
      private function initTreeProviders(param1:ArrayCollection, param2:Array, param3:int) : void
      {
         if(param3 == GearCalcUtil.GEAR_WEAPON)
         {
            param1.addItem(this.createFolder("Shared Prefixes",[NODE_SHARED_PREFIX,NODE_MAT_PREFIX],param2));
            param1.addItem(this.createFolder("Assault Shotgun",[NODE_ASSAULT_SHOTTY],param2));
            param1.addItem(this.createFolder("Combat Shotgun",[NODE_COMBAT_SHOTTY],param2));
            param1.addItem(this.createFolder("Patrol SMG",[NODE_SMG],param2));
            param1.addItem(this.createFolder("Combat Rifles",[NODE_RIFLES],param2));
            param1.addItem(this.createFolder("Support MG",[NODE_MG],param2));
            param1.addItem(this.createFolder("Machine Pistol",[NODE_MACHINE_PISTOL],param2));
            param1.addItem(this.createFolder("Repeater Pistol",[NODE_REPEATER],param2));
            param1.addItem(this.createFolder("Revolver",[NODE_REVOLVER],param2));
            param1.addItem(this.createFolder("Rocket Launcher",[NODE_ROCKET],param2));
            param1.addItem(this.createFolder("Sniper Rifle",[NODE_SNIPER],param2));
            param1.addItem(this.createFolder("Semi-Auto Sniper",[NODE_SNIPER_SEMIAUTO],param2));
         }
         else if(param3 == GearCalcUtil.GEAR_SHIELD)
         {
            param1.addItem(this.createFolder("Original Shields",[NODE_SHIELD],param2));
            param1.addItem(this.createFolder("Knoxx Items",[NODE_SHIELD_KNOXX],param2));
         }
      }
      
      private function createFolder(param1:String, param2:Array, param3:Array) : NameFolder
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:NameFolder = new NameFolder(param1);
         for each(_loc5_ in param2)
         {
            for each(_loc6_ in param3)
            {
               _loc4_.addNames(GearCalcUtil.bubbleSortParts(this.parts.getFilteredParts(_loc5_,_loc6_)));
            }
         }
         return _loc4_;
      }
      
      private function onTreeChange(param1:Tree, param2:TextArea) : void
      {
         var _loc3_:PartFormatter = null;
         if(param1.selectedIndex != -1 && !param1.dataDescriptor.isBranch(param1.selectedItem))
         {
            _loc3_ = new PartFormatter(param1.selectedItem as Part,null);
            _loc3_.fontSize = 9;
            param2.textFlow = _loc3_.formatTLF();
         }
      }
      
      private function onTreeClick(param1:Tree) : void
      {
         if(param1.dataDescriptor.isBranch(param1.selectedItem))
         {
            if(param1.isItemOpen(param1.selectedItem))
            {
               param1.expandChildrenOf(param1.selectedItem,false);
            }
            else
            {
               param1.expandChildrenOf(param1.selectedItem,true);
            }
            param1.selectedIndex = -1;
         }
      }
      
      private function onOkClick() : void
      {
         this.selectedPrefix = this.prefixTree.selectedItem as Part;
         this.selectedTitle = this.titleTree.selectedItem as Part;
         PopUpManager.removePopUp(this);
         this.update(this.selectedPrefix,this.selectedTitle);
      }
      
      private function onCancelClick() : void
      {
         this.selectedPrefix = null;
         this.selectedTitle = null;
         PopUpManager.removePopUp(this);
         this.update(this.selectedPrefix,this.selectedTitle);
      }
      
      private function onClearClick() : void
      {
         this.prefixTree.selectedItem = null;
         this.titleTree.selectedItem = null;
      }
      
      private function _NamingTitleWindow_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.distance = 1;
         _loc1_.angle = 45;
         _loc1_.alpha = 0.75;
         _loc1_.color = 1118481;
         this.blackShadow = _loc1_;
         BindingManager.executeBindings(this,"blackShadow",this.blackShadow);
         return _loc1_;
      }
      
      private function _NamingTitleWindow_Array1_c() : Array
      {
         var _loc1_:Array = [this._NamingTitleWindow_TextArea1_i(),this._NamingTitleWindow_VRule1_c(),this._NamingTitleWindow_Tree1_i(),this._NamingTitleWindow_Tree2_i(),this._NamingTitleWindow_TextArea2_i(),this._NamingTitleWindow_Button1_i(),this._NamingTitleWindow_Label1_c(),this._NamingTitleWindow_Label2_c(),this._NamingTitleWindow_Button2_i(),this._NamingTitleWindow_Button3_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _NamingTitleWindow_TextArea1_i() : TextArea
      {
         var _loc1_:TextArea = new TextArea();
         _loc1_.x = 10;
         _loc1_.y = 280;
         _loc1_.width = 262;
         _loc1_.height = 77;
         _loc1_.editable = false;
         _loc1_.id = "prefixLog";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.prefixLog = _loc1_;
         BindingManager.executeBindings(this,"prefixLog",this.prefixLog);
         return _loc1_;
      }
      
      private function _NamingTitleWindow_VRule1_c() : VRule
      {
         var _loc1_:VRule = new VRule();
         _loc1_.x = 280;
         _loc1_.y = 10;
         _loc1_.height = 347;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _NamingTitleWindow_Tree1_i() : Tree
      {
         var _loc1_:Tree = new Tree();
         _loc1_.x = 10;
         _loc1_.y = 21;
         _loc1_.width = 262;
         _loc1_.height = 251;
         _loc1_.addEventListener("itemClick",this.__prefixTree_itemClick);
         _loc1_.addEventListener("change",this.__prefixTree_change);
         _loc1_.id = "prefixTree";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.prefixTree = _loc1_;
         BindingManager.executeBindings(this,"prefixTree",this.prefixTree);
         return _loc1_;
      }
      
      public function __prefixTree_itemClick(param1:ListEvent) : void
      {
         this.onTreeClick(this.prefixTree);
      }
      
      public function __prefixTree_change(param1:ListEvent) : void
      {
         this.onTreeChange(this.prefixTree,this.prefixLog);
      }
      
      private function _NamingTitleWindow_Tree2_i() : Tree
      {
         var _loc1_:Tree = new Tree();
         _loc1_.x = 290;
         _loc1_.y = 20;
         _loc1_.width = 258;
         _loc1_.height = 251;
         _loc1_.addEventListener("itemClick",this.__titleTree_itemClick);
         _loc1_.addEventListener("change",this.__titleTree_change);
         _loc1_.id = "titleTree";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.titleTree = _loc1_;
         BindingManager.executeBindings(this,"titleTree",this.titleTree);
         return _loc1_;
      }
      
      public function __titleTree_itemClick(param1:ListEvent) : void
      {
         this.onTreeClick(this.titleTree);
      }
      
      public function __titleTree_change(param1:ListEvent) : void
      {
         this.onTreeChange(this.titleTree,this.titleLog);
      }
      
      private function _NamingTitleWindow_TextArea2_i() : TextArea
      {
         var _loc1_:TextArea = new TextArea();
         _loc1_.x = 290;
         _loc1_.y = 279;
         _loc1_.width = 258;
         _loc1_.height = 77;
         _loc1_.editable = false;
         _loc1_.id = "titleLog";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.titleLog = _loc1_;
         BindingManager.executeBindings(this,"titleLog",this.titleLog);
         return _loc1_;
      }
      
      private function _NamingTitleWindow_Button1_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.x = 80;
         _loc1_.y = 366;
         _loc1_.label = "OK";
         _loc1_.width = 115;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__okButton_click);
         _loc1_.id = "okButton";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.okButton = _loc1_;
         BindingManager.executeBindings(this,"okButton",this.okButton);
         return _loc1_;
      }
      
      public function __okButton_click(param1:MouseEvent) : void
      {
         this.onOkClick();
      }
      
      private function _NamingTitleWindow_Label1_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 121;
         _loc1_.y = 4;
         _loc1_.text = "Prefix";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _NamingTitleWindow_Label2_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 402;
         _loc1_.y = 4;
         _loc1_.text = "Title";
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontStyle","italic");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _NamingTitleWindow_Button2_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.x = 370;
         _loc1_.y = 365;
         _loc1_.label = "Cancel";
         _loc1_.width = 115;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__cancelButton_click);
         _loc1_.id = "cancelButton";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.cancelButton = _loc1_;
         BindingManager.executeBindings(this,"cancelButton",this.cancelButton);
         return _loc1_;
      }
      
      public function __cancelButton_click(param1:MouseEvent) : void
      {
         this.onCancelClick();
      }
      
      private function _NamingTitleWindow_Button3_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.x = 223;
         _loc1_.y = 365;
         _loc1_.label = "Clear Selection";
         _loc1_.height = 25;
         _loc1_.width = 115;
         _loc1_.addEventListener("click",this.__clrButton_click);
         _loc1_.id = "clrButton";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.clrButton = _loc1_;
         BindingManager.executeBindings(this,"clrButton",this.clrButton);
         return _loc1_;
      }
      
      public function __clrButton_click(param1:MouseEvent) : void
      {
         this.onClearClick();
      }
      
      [Bindable(event="propertyChange")]
      public function get blackShadow() : DropShadowFilter
      {
         return this._407812607blackShadow;
      }
      
      public function set blackShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._407812607blackShadow;
         if(_loc2_ !== param1)
         {
            this._407812607blackShadow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blackShadow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cancelButton() : Button
      {
         return this._1990131276cancelButton;
      }
      
      public function set cancelButton(param1:Button) : void
      {
         var _loc2_:Object = this._1990131276cancelButton;
         if(_loc2_ !== param1)
         {
            this._1990131276cancelButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cancelButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get clrButton() : Button
      {
         return this._792940987clrButton;
      }
      
      public function set clrButton(param1:Button) : void
      {
         var _loc2_:Object = this._792940987clrButton;
         if(_loc2_ !== param1)
         {
            this._792940987clrButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"clrButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get okButton() : Button
      {
         return this._1641788370okButton;
      }
      
      public function set okButton(param1:Button) : void
      {
         var _loc2_:Object = this._1641788370okButton;
         if(_loc2_ !== param1)
         {
            this._1641788370okButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"okButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get prefixLog() : TextArea
      {
         return this._1290168494prefixLog;
      }
      
      public function set prefixLog(param1:TextArea) : void
      {
         var _loc2_:Object = this._1290168494prefixLog;
         if(_loc2_ !== param1)
         {
            this._1290168494prefixLog = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"prefixLog",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get prefixTree() : Tree
      {
         return this._1340276400prefixTree;
      }
      
      public function set prefixTree(param1:Tree) : void
      {
         var _loc2_:Object = this._1340276400prefixTree;
         if(_loc2_ !== param1)
         {
            this._1340276400prefixTree = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"prefixTree",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleLog() : TextArea
      {
         return this._1870018100titleLog;
      }
      
      public function set titleLog(param1:TextArea) : void
      {
         var _loc2_:Object = this._1870018100titleLog;
         if(_loc2_ !== param1)
         {
            this._1870018100titleLog = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleLog",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleTree() : Tree
      {
         return this._2135745002titleTree;
      }
      
      public function set titleTree(param1:Tree) : void
      {
         var _loc2_:Object = this._2135745002titleTree;
         if(_loc2_ !== param1)
         {
            this._2135745002titleTree = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleTree",_loc2_,param1));
            }
         }
      }
   }
}

