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
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.formats.TextAlign;
   import gearcalc.*;
   import gearcalc.card.*;
   import gearcalc.export.ImageEntry;
   import gearcalc.export.ImageShackExporter;
   import mx.binding.*;
   import mx.collections.ArrayCollection;
   import mx.containers.TabNavigator;
   import mx.controls.Alert;
   import mx.controls.DataGrid;
   import mx.controls.HRule;
   import mx.controls.Image;
   import mx.controls.Menu;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.BitmapAsset;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.core.IStateClient2;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.CloseEvent;
   import mx.events.FlexEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   import mx.filters.*;
   import mx.graphics.BitmapFill;
   import mx.graphics.codec.PNGEncoder;
   import mx.managers.PopUpManager;
   import mx.states.AddItems;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.*;
   import mx.utils.URLUtil;
   import spark.components.Application;
   import spark.components.Button;
   import spark.components.CheckBox;
   import spark.components.DropDownList;
   import spark.components.HGroup;
   import spark.components.HSlider;
   import spark.components.Label;
   import spark.components.NavigatorContent;
   import spark.components.NumericStepper;
   import spark.components.Panel;
   import spark.components.RadioButton;
   import spark.components.RadioButtonGroup;
   import spark.components.TextArea;
   import spark.components.TextInput;
   import spark.components.TitleWindow;
   import spark.effects.Rotate;
   import spark.events.IndexChangeEvent;
   import spark.filters.DropShadowFilter;
   import spark.filters.GlowFilter;
   import spark.layouts.BasicLayout;
   import spark.layouts.VerticalLayout;
   import spark.primitives.Rect;
   
   use namespace mx_internal;
   
   public class GearCalcApp extends Application implements IBindingClient, IStateClient2
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
      
      public static const HOST_SERVER_STRING:String = "gearcalc.50webs.com";
      
      public static const RUN_LOCATION:String = ExternalInterface.call("window.location.href.toString");
      
      public static const TO_EMBED_XML:Boolean = false;
      
      private static var _skinParts:Object = {
         "contentGroup":false,
         "controlBarGroup":false
      };
      
      public var _GearCalcApp_BitmapFill1:BitmapFill;
      
      public var _GearCalcApp_DataGrid3:DataGrid;
      
      public var _GearCalcApp_HRule1:HRule;
      
      public var _GearCalcApp_Label13:Label;
      
      public var _GearCalcApp_Label15:Label;
      
      public var _GearCalcApp_Label21:Label;
      
      private var _61136625_GearCalcApp_Panel2:Panel;
      
      public var _GearCalcApp_SimpleImageButton3:SimpleImageButton;
      
      private var _1407287521attCol:DataGridColumn;
      
      private var _1635077273autoCheck:CheckBox;
      
      private var _407812607blackShadow:DropShadowFilter;
      
      private var _1780282780blankWindow:TitleWindow;
      
      private var _482987475buildRadio:RadioButton;
      
      private var _1705228775calcButton:Button;
      
      private var _553912979cardImg:Image;
      
      private var _553923173cardTab:NavigatorContent;
      
      private var _868535270codeArea:TextArea;
      
      private var _939639014deconRadio:RadioButton;
      
      private var _1282176907eleImage2:Image;
      
      private var _1449074381gearList:DropDownList;
      
      private var _1243000070glower:GlowFilter;
      
      private var _1330863392histList:DropDownList;
      
      private var _738251545iconImg1:SimpleImageButton;
      
      private var _738251544iconImg2:SimpleImageButton;
      
      private var _1456418646importRadio:RadioButton;
      
      private var _1110417475label1:Label;
      
      private var _63203309label10:Label;
      
      private var _63203308label11:Label;
      
      private var _63203307label12:Label;
      
      private var _63203306label13:Label;
      
      private var _63203305label14:Label;
      
      private var _1110417474label2:Label;
      
      private var _1110417473label3:Label;
      
      private var _1110417472label4:Label;
      
      private var _1110417471label5:Label;
      
      private var _1110417470label6:Label;
      
      private var _1110417469label7:Label;
      
      private var _1110417468label8:Label;
      
      private var _1110417467label9:Label;
      
      private var _157087467levelIndicator:Label;
      
      private var _1774013829levelSlider:HSlider;
      
      private var _341157361logArea:TextArea;
      
      private var _2043913572modeGroup:RadioButtonGroup;
      
      private var _792957801partPic:Image;
      
      private var _1261429194qualSpinner:NumericStepper;
      
      private var _1384173485rotator:Rotate;
      
      private var _109532659slot1:DropDownList;
      
      private var _899454819slot10:DropDownList;
      
      private var _899454818slot11:DropDownList;
      
      private var _899454817slot12:DropDownList;
      
      private var _899454816slot13:DropDownList;
      
      private var _899454815slot14:DropDownList;
      
      private var _109532660slot2:DropDownList;
      
      private var _109532661slot3:DropDownList;
      
      private var _109532662slot4:DropDownList;
      
      private var _109532663slot5:DropDownList;
      
      private var _109532664slot6:DropDownList;
      
      private var _109532665slot7:DropDownList;
      
      private var _109532666slot8:DropDownList;
      
      private var _109532667slot9:DropDownList;
      
      private var _1317321658statGrid:DataGrid;
      
      private var _2108596992statLabel:Label;
      
      private var _3552126tabs:TabNavigator;
      
      private var _1429921810techCheck:CheckBox;
      
      private var _1616312580techGrid:DataGrid;
      
      private var _1437600481techTab:NavigatorContent;
      
      private var _1870021045titleImg:Image;
      
      private var _980425297topPanel:Panel;
      
      private var _993593141urlField:TextInput;
      
      private var _823860577valCol:DataGridColumn;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _1870028133titleBar:Class;
      
      private var _1391998104bgFill:Bitmap;
      
      private var isLocked:Boolean = true;
      
      private var main:GearCalcEngine;
      
      private var bgLink:String = "../assets/clapBg.png";
      
      private var shieldFile:String = "../assets/ShieldParts.xml";
      
      private var partFile:String = "../assets/WeaponParts.xml";
      
      private var ruleFile:String = "../assets/GearTemplates.xml";
      
      private var imageZipFile:String = "../assets/ImageBinCombinedZip.xml";
      
      private var imageFile:String = "../assets/ImageBinCombined.xml";
      
      private const MAX_HISTORY:int = 5;
      
      private var combos:Vector.<DropDownList>;
      
      private var _1317216286statData:ArrayCollection;
      
      private var _2115968044statData2:ArrayCollection;
      
      private var _1616417952techData:ArrayCollection;
      
      private var backer:GearCalcAppUtil;
      
      private var mStats:StatSet = null;
      
      private var sFormer:StatFormatter = null;
      
      private var history:Vector.<Weapon>;
      
      private var curCard:CardPainter;
      
      private var isLoaded:Boolean = false;
      
      private var _113769724isWillow:Boolean = false;
      
      private var loadWindow:BusyWindow = null;
      
      private var images:ElementalImage;
      
      private const IS_ONLINE:Boolean = true;
      
      private const FULL_NAME_POOL_SELECT:String = "<SELECT FROM GLOBAL POOL>";
      
      mx_internal var _GearCalcApp_StylesInit_done:Boolean = false;
      
      private var _embed_mxml_assets_export_icon_png_773417480:Class;
      
      private var _embed_mxml_assets_blackgear_png_239058856:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function GearCalcApp()
      {
         var bindings:Array;
         var watchers:Array;
         var _GearCalcApp_Button1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_CheckBox1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_CheckBox2_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList10_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList11_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList12_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList13_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList14_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList15_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList16_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList2_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList3_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList4_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList5_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList6_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList7_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList8_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_DropDownList9_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_HRule1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_HSlider1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Image2_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Image3_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Image4_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label10_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label11_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label12_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label13_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label14_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label15_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label16_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label17_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label18_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label19_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label2_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label21_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label4_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label5_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label6_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label7_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label8_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Label9_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_NumericStepper1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Panel1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_Panel2_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_RadioButton1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_RadioButton2_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_RadioButton3_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_SimpleImageButton1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_SimpleImageButton3_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_TabNavigator1_factory:DeferredInstanceFromFunction;
         var _GearCalcApp_TextArea2_factory:DeferredInstanceFromFunction;
         var i:uint;
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._1870028133titleBar = GearCalcApp_titleBar;
         this.main = new GearCalcEngine();
         this.images = new ElementalImage();
         this._embed_mxml_assets_export_icon_png_773417480 = GearCalcApp__embed_mxml_assets_export_icon_png_773417480;
         this._embed_mxml_assets_blackgear_png_239058856 = GearCalcApp__embed_mxml_assets_blackgear_png_239058856;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         bindings = this._GearCalcApp_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_GearCalcAppWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return GearCalcApp[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.currentState = "cruncher";
         this.layout = this._GearCalcApp_BasicLayout1_c();
         this.mxmlContentFactory = new DeferredInstanceFromFunction(this._GearCalcApp_Array3_c);
         this._GearCalcApp_DropShadowFilter1_i();
         this._GearCalcApp_TitleWindow1_i();
         this._GearCalcApp_GlowFilter1_i();
         this._GearCalcApp_RadioButtonGroup1_i();
         this._GearCalcApp_Rotate1_i();
         this.addEventListener("applicationComplete",this.___GearCalcApp_Application1_applicationComplete);
         _GearCalcApp_Button1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Button1_i);
         _GearCalcApp_CheckBox1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_CheckBox1_i);
         _GearCalcApp_CheckBox2_factory = new DeferredInstanceFromFunction(this._GearCalcApp_CheckBox2_i);
         _GearCalcApp_DropDownList1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList1_i);
         _GearCalcApp_DropDownList10_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList10_i);
         _GearCalcApp_DropDownList11_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList11_i);
         _GearCalcApp_DropDownList12_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList12_i);
         _GearCalcApp_DropDownList13_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList13_i);
         _GearCalcApp_DropDownList14_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList14_i);
         _GearCalcApp_DropDownList15_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList15_i);
         _GearCalcApp_DropDownList16_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList16_i);
         _GearCalcApp_DropDownList2_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList2_i);
         _GearCalcApp_DropDownList3_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList3_i);
         _GearCalcApp_DropDownList4_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList4_i);
         _GearCalcApp_DropDownList5_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList5_i);
         _GearCalcApp_DropDownList6_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList6_i);
         _GearCalcApp_DropDownList7_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList7_i);
         _GearCalcApp_DropDownList8_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList8_i);
         _GearCalcApp_DropDownList9_factory = new DeferredInstanceFromFunction(this._GearCalcApp_DropDownList9_i);
         _GearCalcApp_HRule1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_HRule1_i);
         _GearCalcApp_HSlider1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_HSlider1_i);
         _GearCalcApp_Image2_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Image2_i);
         _GearCalcApp_Image3_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Image3_i);
         _GearCalcApp_Image4_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Image4_i);
         _GearCalcApp_Label10_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label10_i);
         _GearCalcApp_Label11_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label11_i);
         _GearCalcApp_Label12_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label12_i);
         _GearCalcApp_Label13_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label13_i);
         _GearCalcApp_Label14_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label14_i);
         _GearCalcApp_Label15_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label15_i);
         _GearCalcApp_Label16_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label16_i);
         _GearCalcApp_Label17_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label17_i);
         _GearCalcApp_Label18_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label18_i);
         _GearCalcApp_Label19_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label19_i);
         _GearCalcApp_Label2_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label2_i);
         _GearCalcApp_Label21_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label21_i);
         _GearCalcApp_Label4_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label4_i);
         _GearCalcApp_Label5_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label5_i);
         _GearCalcApp_Label6_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label6_i);
         _GearCalcApp_Label7_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label7_i);
         _GearCalcApp_Label8_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label8_i);
         _GearCalcApp_Label9_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Label9_i);
         _GearCalcApp_NumericStepper1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_NumericStepper1_i);
         _GearCalcApp_Panel1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Panel1_i);
         _GearCalcApp_Panel2_factory = new DeferredInstanceFromFunction(this._GearCalcApp_Panel2_i);
         _GearCalcApp_RadioButton1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_RadioButton1_i);
         _GearCalcApp_RadioButton2_factory = new DeferredInstanceFromFunction(this._GearCalcApp_RadioButton2_i);
         _GearCalcApp_RadioButton3_factory = new DeferredInstanceFromFunction(this._GearCalcApp_RadioButton3_i);
         _GearCalcApp_SimpleImageButton1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_SimpleImageButton1_i);
         _GearCalcApp_SimpleImageButton3_factory = new DeferredInstanceFromFunction(this._GearCalcApp_SimpleImageButton3_i);
         _GearCalcApp_TabNavigator1_factory = new DeferredInstanceFromFunction(this._GearCalcApp_TabNavigator1_i);
         _GearCalcApp_TextArea2_factory = new DeferredInstanceFromFunction(this._GearCalcApp_TextArea2_i);
         states = [new State({
            "name":"cruncher",
            "overrides":[new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label21_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList16_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Image4_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_SimpleImageButton3_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_HRule1_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_RadioButton3_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_RadioButton2_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_RadioButton1_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_CheckBox2_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_CheckBox1_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList15_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Image3_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_TextArea2_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_HSlider1_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList14_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList13_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList12_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList11_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Button1_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Image2_factory,
               "destination":"_GearCalcApp_Panel2",
               "position":"after",
               "relativeTo":["statLabel"]
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Panel2_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_NumericStepper1_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label19_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label18_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label17_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label16_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label15_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label14_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label13_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label12_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label11_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label10_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label9_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label8_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label7_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label6_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label5_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label4_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_SimpleImageButton1_factory,
               "destination":"topPanel",
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_TabNavigator1_factory,
               "destination":"topPanel",
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Panel1_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList10_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList9_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_Label2_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList8_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList7_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList6_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList5_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList4_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList3_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList2_factory,
               "destination":null,
               "position":"first"
            }),new AddItems().initializeFromObject({
               "itemsFactory":_GearCalcApp_DropDownList1_factory,
               "destination":null,
               "position":"first"
            }),new SetProperty().initializeFromObject({
               "name":"minWidth",
               "value":900
            }),new SetProperty().initializeFromObject({
               "name":"width",
               "value":940
            }),new SetProperty().initializeFromObject({
               "name":"minHeight",
               "value":590
            }),new SetProperty().initializeFromObject({
               "name":"height",
               "value":610
            }),new SetProperty().initializeFromObject({
               "target":"codeArea",
               "name":"x",
               "value":409
            }),new SetProperty().initializeFromObject({
               "target":"codeArea",
               "name":"y",
               "value":607.45
            })]
         }),new State({
            "name":"loadState",
            "overrides":[]
         })];
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         GearCalcApp._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_GearCalcApp_StylesInit();
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      private function loadData() : void
      {
         var date:Date;
         var xml:XML = null;
         var avoidCache:String = null;
         var time:Number = NaN;
         var imgLoader:Loader = null;
         var onPartXMLLoaded:Function = null;
         var onShieldXMLLoaded:Function = null;
         var onRuleXMLLoaded:Function = null;
         var onImageXMLLoaded:Function = null;
         var onBgLoaded:Function = null;
         var onZipLoaded:Function = null;
         var statCounter:URLLoader = null;
         var link:String = null;
         var msg:String = null;
         var alert:Alert = null;
         onPartXMLLoaded = function(param1:Event):void
         {
            xml = new XML(param1.target.data);
            var _loc2_:Boolean = main.initPartCollection(xml,GearCalcUtil.GEAR_WEAPON);
            GearCalcUtil.loadXMLFile(shieldFile + avoidCache,onShieldXMLLoaded);
         };
         onShieldXMLLoaded = function(param1:Event):void
         {
            xml = new XML(param1.target.data);
            var _loc2_:Boolean = main.initPartCollection(xml,GearCalcUtil.GEAR_SHIELD);
            GearCalcUtil.loadXMLFile(ruleFile + avoidCache,onRuleXMLLoaded);
         };
         onRuleXMLLoaded = function(param1:Event):void
         {
            xml = new XML(param1.target.data);
            var _loc2_:Boolean = main.initRuleCollection(xml);
            GearCalcUtil.loadXMLFile(imageFile + avoidCache,onImageXMLLoaded);
         };
         onImageXMLLoaded = function(param1:Event):void
         {
            xml = new XML(param1.target.data);
            GraphicsRepository.init(xml,main.parts);
            imgLoader = new Loader();
            imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onBgLoaded);
            imgLoader.load(new URLRequest(bgLink));
         };
         onBgLoaded = function(param1:Event):void
         {
            bgFill = imgLoader.content as Bitmap;
            GraphicsRepository.loadArchive(onZipLoaded,backer.isZippy);
         };
         onZipLoaded = function():void
         {
            trace("Total Load Time: " + (GearCalcUtil.getTime() - time).toFixed(2));
            isLoaded = true;
            if(loadWindow != null)
            {
               PopUpManager.removePopUp(loadWindow);
            }
            initInterface();
            loadViableParts();
            if(isWillow)
            {
               backer.notifyStatus(GearCalcAppUtil.STATUS_READY);
               return;
            }
            if(backer.checkUrlForGear())
            {
               setGear(main.build);
               onCalcClick();
            }
            else if(backer.getPreference(GearCalcAppUtil.PREF_HISTORY) != null)
            {
               if(backer.loadHistoryBuild() != null)
               {
                  setGear(main.build);
                  onCalcClick();
               }
               backer.addHistoryPref(null);
            }
         };
         if(this.parameters.mode == "WillowTreeBridge")
         {
            trace("Activating WillowTree Bridge");
            this.isWillow = true;
            this.isLocked = false;
            ExternalInterface.addCallback("loadFromWillow",this.loadFromWillow);
            statCounter = new URLLoader();
            link = "http://myborderlands.com/ProxyUtil.ashx?dest=";
            link += escape("http://c.statcounter.com/6011257/0/3e7f45a2/1/");
            statCounter.load(new URLRequest(link));
         }
         stage.quality = StageQuality.BEST;
         this.backer = new GearCalcAppUtil(this.main,this.isWillow);
         this.mirrorPrefs(true);
         this.main.typeChangeListener = this.onEngineChange;
         if(!this.testStatus())
         {
            msg = "Unauthorized access or use of Gear Calculator\n\n";
            alert = Alert.show(msg,"Warning");
            alert.setStyle("color","#CC0000");
            alert.setStyle("fontSize","16");
            return;
         }
         XML.ignoreWhitespace = false;
         date = new Date();
         if(this.IS_ONLINE)
         {
            avoidCache = "?" + date.getUTCSeconds();
         }
         else
         {
            avoidCache = "";
         }
         GearCalcUtil.loadXMLFile(this.partFile + avoidCache,onPartXMLLoaded);
         time = GearCalcUtil.getTime();
         if(!this.isLoaded)
         {
            this.loadWindow = new BusyWindow();
            this.loadWindow.width = 200;
            this.loadWindow.height = 110;
            PopUpManager.addPopUp(this.loadWindow,this,true);
            PopUpManager.centerPopUp(this.loadWindow);
            this.loadWindow.changeText("Loading...");
         }
      }
      
      private function onImgComplete(param1:Event) : void
      {
         var _loc2_:Bitmap = (param1.target as Image).content as Bitmap;
         if(_loc2_ != null)
         {
            _loc2_.smoothing = true;
         }
      }
      
      private function testStatus() : Boolean
      {
         var v:String = null;
         var isSupported:Function = function(param1:String):Boolean
         {
            var _loc3_:String = null;
            var _loc2_:Vector.<String> = new Vector.<String>();
            _loc2_.push("Firefox");
            _loc2_.push("Netscape");
            _loc2_.push("Chrome");
            _loc2_.push("Safari");
            _loc2_.push("Internet Explorer");
            _loc2_.push("Opera");
            for each(_loc3_ in _loc2_)
            {
               if(param1.indexOf(_loc3_) != -1)
               {
                  return true;
               }
            }
            return false;
         };
         var boo:Boolean = true;
         if(this.isLocked)
         {
            v = URLUtil.getServerName(this.loaderInfo.url);
            if(v != null && Boolean(v.indexOf(HOST_SERVER_STRING)))
            {
               this.alpha = 0;
               this.enabled = false;
               boo = false;
            }
            if(boo)
            {
               v = ExternalInterface.call("function(){return navigator.appName;}");
               if(v == null || !isSupported(v))
               {
                  this.alpha = 0;
                  this.enabled = false;
                  boo = false;
               }
            }
         }
         return boo;
      }
      
      private function initInterface() : void
      {
         var triggerManufChange:Function = null;
         triggerManufChange = function(param1:Event):void
         {
            if(param1.target is DropDownList)
            {
               onManufacturerChange(param1.target as DropDownList);
            }
         };
         var typeProv:ArrayCollection = new ArrayCollection();
         typeProv.addItem(GearCalcAppUtil.DISP_WEAPON);
         typeProv.addItem(GearCalcAppUtil.DISP_SHIELD);
         this.gearList.dataProvider = typeProv;
         this.gearList.selectedIndex = 0;
         this.combos = new Vector.<DropDownList>();
         this.combos.push(this.slot1);
         this.combos.push(this.slot2);
         this.combos.push(this.slot3);
         this.combos.push(this.slot4);
         this.combos.push(this.slot5);
         this.combos.push(this.slot6);
         this.combos.push(this.slot7);
         this.combos.push(this.slot8);
         this.combos.push(this.slot9);
         this.combos.push(this.slot10);
         this.combos.push(this.slot11);
         this.combos.push(this.slot12);
         this.combos.push(this.slot13);
         this.combos.push(this.slot14);
         this.slot2.addEventListener(IndexChangeEvent.CHANGE,triggerManufChange);
         this.slot5.addEventListener(IndexChangeEvent.CHANGE,triggerManufChange);
         this.slot12.addEventListener(IndexChangeEvent.CHANGE,triggerManufChange);
         this.statData = new ArrayCollection([]);
         this.statGrid.dataProvider = this.statData;
         this.statData2 = new ArrayCollection([]);
         this.techData = new ArrayCollection([]);
         this.logArea.text = Version.notes;
         this.statLabel.filters = [this.blackShadow];
         this.history = new Vector.<Weapon>();
         this.histList.dataProvider = new ArrayCollection([]);
         CardPainter.bound_x = this.cardImg.width - 2;
         CardPainter.bound_y = this.cardImg.height - 2;
         this.eleImage2.filters = [this.blackShadow];
         this.loadViableParts();
      }
      
      private function loadViableParts() : void
      {
         var _loc1_:DropDownList = null;
         var _loc2_:Vector.<Part> = null;
         var _loc3_:int = 0;
         for each(_loc1_ in this.combos)
         {
            _loc1_.dataProvider = new ArrayCollection();
         }
         _loc2_ = this.main.getAllPartsOfType(GearCalcUtil.PART_TYPE_GRADE);
         this.loadHelp(this.slot1,GearCalcUtil.bubbleSortParts(_loc2_));
         _loc2_ = this.main.getAllPartsOfType(GearCalcUtil.PART_TYPE_TYPE);
         this.loadHelp(this.slot3,GearCalcUtil.bubbleSortParts(_loc2_));
         _loc3_ = 0;
         while(_loc3_ < this.combos.length)
         {
            if(_loc3_ != 0 && _loc3_ != 2)
            {
               this.combos[_loc3_].enabled = false;
            }
            _loc3_++;
         }
      }
      
      public function loadFromWillow(param1:Array, param2:int, param3:int) : Boolean
      {
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:Part = null;
         var _loc4_:Vector.<Part> = new Vector.<Part>();
         for each(_loc5_ in param1)
         {
            _loc7_ = this.main.parts.matchTrueName(_loc5_);
            if(_loc7_ != null)
            {
               _loc4_.push(_loc7_);
            }
            else
            {
               _loc4_.push(PartCollection.NULL_PART);
            }
         }
         _loc6_ = this.main.construct(_loc4_,param3,param2);
         if(_loc6_)
         {
            this.setGear(this.main.build);
         }
         return _loc6_;
      }
      
      private function setGear(param1:Gearable) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.getGearType() == GearCalcUtil.GEAR_WEAPON)
         {
            this.gearList.selectedItem = GearCalcAppUtil.DISP_WEAPON;
         }
         else if(param1.getGearType() == GearCalcUtil.GEAR_SHIELD)
         {
            this.gearList.selectedItem = GearCalcAppUtil.DISP_SHIELD;
         }
         else if(param1.getGearType() == GearCalcUtil.GEAR_COM)
         {
            this.gearList.selectedItem = GearCalcAppUtil.DISP_COM;
         }
         this.onGearChange();
         var _loc2_:Vector.<Part> = param1.getParts();
         this.slot1.selectedItem = _loc2_[0];
         this.onGradeChange();
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return;
         }
         if(this.main.gearType == GearCalcUtil.GEAR_WEAPON)
         {
            this.slot3.selectedItem = _loc2_[2];
            this.onComboChange(null);
            this.slot2.selectedItem = _loc2_[1];
            this.slot4.selectedItem = _loc2_[3];
            this.slot6.selectedItem = _loc2_[5];
            this.slot7.selectedItem = _loc2_[6];
            this.slot8.selectedItem = _loc2_[7];
            this.slot9.selectedItem = _loc2_[8];
            this.slot10.selectedItem = _loc2_[9];
            this.slot11.selectedItem = _loc2_[10];
            this.slot12.selectedItem = _loc2_[11];
            this.addAndSelect(this.slot13,_loc2_[12],true);
            this.addAndSelect(this.slot14,_loc2_[13],true);
         }
         else
         {
            this.slot3.selectedItem = _loc2_[1];
            this.onComboChange(null);
            this.slot4.selectedItem = _loc2_[2];
            this.slot5.selectedItem = _loc2_[3];
            this.slot6.selectedItem = _loc2_[4];
            this.slot12.selectedItem = _loc2_[5];
            this.slot2.selectedItem = _loc2_[6];
            this.addAndSelect(this.slot13,_loc2_[7],true);
            this.addAndSelect(this.slot14,_loc2_[8],true);
         }
         this.onManufacturerChange();
         if(param1.getQualityLevel() >= 0 && param1.getQualityLevel() <= 5)
         {
            this.qualSpinner.value = param1.getQualityLevel();
         }
         else if(param1.getQualityLevel() <= 0)
         {
            this.qualSpinner.value = 0;
         }
         else
         {
            this.qualSpinner.value = 5;
         }
         if(param1.getExpLevel() >= 0 && param1.getExpLevel() <= 63)
         {
            this.levelSlider.value = param1.getExpLevel() - 2;
         }
         else
         {
            this.onSpinnerAction();
         }
      }
      
      private function tryImport() : void
      {
         var wndw:ImportWindow = null;
         var onClose:Function = null;
         onClose = function(param1:Event):void
         {
            var _loc2_:Weapon = null;
            PopUpManager.removePopUp(wndw);
            importRadio.selected = false;
            buildRadio.selected = true;
            if(wndw.isProceed())
            {
               _loc2_ = main.importGear(removeBlanks(wndw.getCode()));
               setGear(_loc2_);
               autoCheck.enabled = true;
               onCalcClick();
            }
         };
         var removeBlanks:Function = function(param1:String):String
         {
            var _loc2_:int = 0;
            var _loc3_:String = param1;
            while(_loc2_ != -1)
            {
               _loc3_ = _loc3_.replace(" ","");
               _loc2_ = _loc3_.indexOf(" ");
            }
            return _loc3_;
         };
         wndw = new ImportWindow();
         wndw.width = 500;
         wndw.height = 300;
         wndw.addEventListener(CloseEvent.CLOSE,onClose);
         PopUpManager.addPopUp(wndw,this,true);
         PopUpManager.centerPopUp(wndw);
      }
      
      private function onDeconClick() : void
      {
         var wndw:WizWindow = null;
         var onClose:Function = null;
         onClose = function(param1:Event):void
         {
            PopUpManager.removePopUp(wndw);
            buildRadio.selected = true;
         };
         wndw = new WizWindow();
         wndw.init(this.main);
         wndw.addEventListener(CloseEvent.CLOSE,onClose);
         PopUpManager.addPopUp(wndw,this,true);
         PopUpManager.centerPopUp(wndw);
      }
      
      private function loadHelp(param1:DropDownList, param2:Vector.<Part>) : void
      {
         param1.dataProvider.removeAll();
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            param1.dataProvider.addItem(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      private function loadHelpFiltered(param1:DropDownList, param2:String) : void
      {
         var _loc3_:Part = Part(this.slot1.selectedItem);
         var _loc4_:Part = Part(this.slot3.selectedItem);
         var _loc5_:Vector.<Part> = this.main.filter.filterAndMatch(_loc3_,_loc4_,param2,this.main.gearType);
         if(_loc5_ != null)
         {
            param1.enabled = true;
            this.loadHelp(param1,_loc5_);
            if(param1.dataProvider.length > 0)
            {
               param1.selectedIndex = 0;
            }
         }
         else
         {
            param1.selectedIndex = -1;
            param1.dataProvider.removeAll();
            param1.enabled = false;
         }
      }
      
      private function onDPSClick() : void
      {
         var dpsWindow:DPSWindow = null;
         var onPopUpClose:Function = null;
         onPopUpClose = function(param1:CloseEvent):void
         {
            PopUpManager.removePopUp(dpsWindow);
         };
         dpsWindow = new DPSWindow();
         dpsWindow.width = 600;
         dpsWindow.height = 330;
         dpsWindow.addEventListener(CloseEvent.CLOSE,onPopUpClose);
         PopUpManager.addPopUp(dpsWindow,this,true);
         PopUpManager.centerPopUp(dpsWindow);
         dpsWindow.initParams(this.history);
      }
      
      private function addHistoryItem(param1:Gearable) : void
      {
         var _loc2_:* = 0;
         if(param1 != null)
         {
            if(this.history.length == this.MAX_HISTORY)
            {
               this.history.shift();
            }
            this.history.push(param1);
            this.histList.dataProvider.removeAll();
            _loc2_ = int(this.history.length - 1);
            while(_loc2_ >= 0)
            {
               this.histList.dataProvider.addItem(this.history[_loc2_]);
               _loc2_--;
            }
         }
         this.histList.selectedIndex = 0;
      }
      
      private function onGradeChange() : void
      {
         var _loc3_:Part = null;
         var _loc4_:int = 0;
         var _loc1_:Part = Part(this.slot1.selectedItem);
         var _loc2_:Part = this.main.filter.matchTypeToGrade(_loc1_);
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < this.slot3.dataProvider.length)
            {
               _loc3_ = Part(this.slot3.dataProvider.getItemAt(_loc4_));
               if(_loc3_.getID() == _loc2_.getID())
               {
                  this.slot3.selectedIndex = _loc4_;
               }
               _loc4_++;
            }
            this.loadHelpFiltered(this.slot2,GearCalcUtil.PART_TYPE_MANUFACT);
            this.onComboChange(null);
         }
         this.autoCheck.enabled = true;
      }
      
      private function onEngineChange(param1:int) : void
      {
         if(param1 == GearCalcUtil.GEAR_WEAPON)
         {
            this.label5.text = "Grip";
            this.label6.text = "Magazine";
         }
         else
         {
            this.label5.text = "Left Side";
            this.label6.text = "Right Side";
         }
         this.loadViableParts();
      }
      
      private function onComboChange(param1:Event) : void
      {
         if(this.main.gearType == GearCalcUtil.GEAR_WEAPON)
         {
            this.loadHelpFiltered(this.slot4,GearCalcUtil.PART_TYPE_BODY);
            this.loadHelpFiltered(this.slot5,GearCalcUtil.PART_TYPE_GRIP);
            this.loadHelpFiltered(this.slot6,GearCalcUtil.PART_TYPE_MAG);
            this.loadHelpFiltered(this.slot7,GearCalcUtil.PART_TYPE_BARREL);
            this.loadHelpFiltered(this.slot8,GearCalcUtil.PART_TYPE_SIGHT);
            this.loadHelpFiltered(this.slot9,GearCalcUtil.PART_TYPE_STOCK);
            this.loadHelpFiltered(this.slot10,GearCalcUtil.PART_TYPE_ACTION);
            this.loadHelpFiltered(this.slot11,GearCalcUtil.PART_TYPE_ACCESSORY);
         }
         else if(this.main.gearType == GearCalcUtil.GEAR_SHIELD)
         {
            this.loadHelpFiltered(this.slot4,GearCalcUtil.PART_TYPE_SHIELD_BODY);
            this.loadHelpFiltered(this.slot6,GearCalcUtil.PART_TYPE_SHIELD_RIGHT);
            this.loadHelpFiltered(this.slot5,GearCalcUtil.PART_TYPE_SHIELD_LEFT);
         }
         else if(this.main.gearType == GearCalcUtil.GEAR_COM)
         {
            this.loadHelpFiltered(this.slot4,GearCalcUtil.PART_TYPE_COM_BODY);
            this.loadHelpFiltered(this.slot6,GearCalcUtil.PART_TYPE_COM_RIGHT);
            this.loadHelpFiltered(this.slot5,GearCalcUtil.PART_TYPE_COM_LEFT);
         }
         this.loadHelpFiltered(this.slot2,GearCalcUtil.PART_TYPE_MANUFACT);
         this.loadHelpFiltered(this.slot12,GearCalcUtil.PART_TYPE_MATERIAL);
         this.loadHelpFiltered(this.slot13,GearCalcUtil.PART_TYPE_PREFIX);
         this.loadHelpFiltered(this.slot14,GearCalcUtil.PART_TYPE_TITLE);
         this.slot13.dataProvider.addItem(this.FULL_NAME_POOL_SELECT);
         this.slot14.dataProvider.addItem(this.FULL_NAME_POOL_SELECT);
         this.onManufacturerChange();
      }
      
      private function addAndSelect(param1:DropDownList, param2:Part, param3:Boolean, param4:Boolean = true) : void
      {
         var _loc6_:int = 0;
         var _loc5_:Boolean = false;
         if(param4 || Boolean(param1.enabled))
         {
            _loc6_ = 0;
            while(_loc6_ < param1.dataProvider.length)
            {
               if(param1.dataProvider.getItemAt(_loc6_) is Part && (param1.dataProvider.getItemAt(_loc6_) as Part).equals(param2))
               {
                  param1.selectedIndex = _loc6_;
                  _loc5_ = true;
                  break;
               }
               _loc6_++;
            }
            if(!_loc5_ && param3)
            {
               param1.dataProvider.addItemAt(param2,param1.dataProvider.length - 1);
               param1.selectedItem = param2;
            }
         }
      }
      
      private function onNameComboChange() : void
      {
         var onPopUpClose:Function;
         var onSelected:Function;
         var namingWndw:NamingTitleWindow = null;
         if(this.slot13.selectedItem == this.FULL_NAME_POOL_SELECT || this.slot14.selectedItem == this.FULL_NAME_POOL_SELECT)
         {
            onPopUpClose = function(param1:CloseEvent):void
            {
               slot13.selectedIndex = 0;
               slot14.selectedIndex = 0;
               PopUpManager.removePopUp(namingWndw);
            };
            onSelected = function(param1:Part, param2:Part):void
            {
               if(param1 != null)
               {
                  addAndSelect(slot13,param1,true);
               }
               else
               {
                  slot13.selectedIndex = 0;
               }
               if(param2 != null)
               {
                  addAndSelect(slot14,param2,true);
               }
               else
               {
                  slot14.selectedIndex = 0;
               }
            };
            namingWndw = new NamingTitleWindow();
            namingWndw.addEventListener(CloseEvent.CLOSE,onPopUpClose);
            PopUpManager.addPopUp(namingWndw,this,true);
            PopUpManager.centerPopUp(namingWndw);
            namingWndw.init(this.main,onSelected,true);
         }
         else
         {
            this.revealPart(this.slot13);
            this.revealPart(this.slot14);
         }
      }
      
      private function onGripChange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Part = null;
         var _loc4_:Part = null;
         if(this.main.gearType == GearCalcUtil.GEAR_WEAPON && this.slot5.selectedItem != null)
         {
            _loc1_ = 0;
            _loc2_ = int(this.slot2.selectedIndex);
            this.slot2.selectedIndex = _loc1_;
            _loc3_ = Part(this.slot5.selectedItem);
            _loc4_ = Part(this.slot2.selectedItem);
            while(_loc1_ < this.slot2.dataProvider.length && _loc4_.getManufacturer() != _loc3_.getManufacturer())
            {
               this.slot2.selectedIndex = _loc1_;
               _loc4_ = Part(this.slot2.selectedItem);
               _loc1_++;
            }
            if(_loc4_.getManufacturer() != _loc3_.getManufacturer())
            {
               this.slot2.selectedIndex = _loc2_;
            }
         }
         this.revealPart(this.slot5);
      }
      
      private function onManufacturerChange(param1:DropDownList = null) : void
      {
         var _loc5_:Part = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:Part = param1 != null ? param1.selectedItem as Part : Part(this.slot2.selectedItem);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.main.gearType == GearCalcUtil.GEAR_WEAPON && param1 != this.slot5)
         {
            _loc4_ = int(this.slot5.selectedIndex);
            this.slot5.selectedIndex = _loc3_;
            _loc5_ = Part(this.slot5.selectedItem);
            while(_loc3_ < this.slot5.dataProvider.length && _loc5_.getManufacturer() != _loc2_.getManufacturer())
            {
               this.slot5.selectedIndex = _loc3_;
               _loc5_ = Part(this.slot5.selectedItem);
               _loc3_++;
            }
            if(_loc5_.getManufacturer() != _loc2_.getManufacturer())
            {
               this.slot5.selectedIndex = _loc4_;
            }
         }
         if(param1 != this.slot12)
         {
            _loc3_ = 0;
            _loc4_ = int(this.slot12.selectedIndex);
            _loc6_ = Part(this.slot12.selectedItem);
            while(_loc3_ < this.slot12.dataProvider.length && _loc6_.getManufacturer() != _loc2_.getManufacturer())
            {
               this.slot12.selectedIndex = _loc3_;
               _loc6_ = Part(this.slot12.selectedItem);
               _loc3_++;
            }
            if(_loc6_.getManufacturer() != _loc2_.getManufacturer())
            {
               this.slot12.selectedIndex = _loc4_;
            }
         }
         if(param1 == null || param1 != this.slot2)
         {
            _loc3_ = 0;
            _loc4_ = int(this.slot2.selectedIndex);
            _loc7_ = Part(this.slot2.selectedItem);
            while(_loc3_ < this.slot2.dataProvider.length && _loc7_.getManufacturer() != _loc2_.getManufacturer())
            {
               this.slot2.selectedIndex = _loc3_;
               _loc7_ = Part(this.slot2.selectedItem);
               _loc3_++;
            }
            if(_loc7_.getManufacturer() != _loc2_.getManufacturer())
            {
               this.slot2.selectedIndex = _loc4_;
            }
         }
         this.revealPart(this.slot2);
      }
      
      private function revealPart(param1:DropDownList) : void
      {
         var painter:GraphicsRepository = null;
         var part:Part = null;
         var onReady:Function = null;
         var texter:PartFormatter = null;
         var comp:DropDownList = param1;
         onReady = function():void
         {
            var _loc1_:BitmapData = painter.draw("",null);
            var _loc2_:Point = new Point(475,470);
            var _loc3_:int = main.gearType == GearCalcUtil.GEAR_WEAPON ? GearCalcAppUtil.DESIRED_HEIGHT_GUN : GearCalcAppUtil.DESIRED_HEIGHT_SHIELD;
            backer.positionImage(partPic,_loc2_,_loc1_,_loc3_);
         };
         if(comp.selectedItem != null)
         {
            part = comp.selectedItem as Part;
            texter = new PartFormatter(part,this.main.parts);
            this.logArea.textFlow = texter.formatTLF();
            painter = new GraphicsRepository();
            painter.addRequest(part.getID());
            if(comp != this.slot12 && this.slot12.selectedIndex > -1)
            {
               part = this.slot12.selectedItem as Part;
               painter.addRequest(part.getID());
            }
            painter.process(onReady);
         }
      }
      
      private function onHistoryChange() : void
      {
         var gear:Weapon = null;
         var checkAndChange:Function = function(param1:DropDownList, param2:String):void
         {
            if(param1.enabled)
            {
               param1.selectedItem = gear.getSlottedPart(param2);
            }
         };
         gear = Weapon(this.histList.selectedItem);
         var temp:Vector.<Weapon> = new Vector.<Weapon>();
         var i:int = 0;
         while(i < this.history.length)
         {
            if(this.history[i] != gear)
            {
               temp.push(this.history[i]);
            }
            i++;
         }
         this.history = temp;
         this.setGear(gear);
         this.onCalcClick();
      }
      
      private function onCalcClick() : void
      {
         this.addHistoryItem(this.calculate());
      }
      
      private function calculate() : Weapon
      {
         var workable:Boolean;
         var bmp:Bitmap = null;
         var msg:TitleWindow = null;
         var timer:Timer = null;
         var onImgGenerated:Function = null;
         var popupShown:Function = null;
         var i:int = 0;
         var nameVec:Vector.<Part> = null;
         var stats:StatSet = null;
         var former:StatFormatter = null;
         var name:String = null;
         var fSize:Number = NaN;
         var flow:TextFlow = null;
         var pgh:ParagraphElement = null;
         var span:SpanElement = null;
         var temp:Weapon = null;
         var baseCalc:Calculator = null;
         var painter:CardPainter = null;
         var hash:String = null;
         var acc:Part = null;
         var vec:Vector.<TechAbility> = null;
         var scalers:Array = null;
         var img:BitmapAsset = null;
         onImgGenerated = function(param1:Bitmap):void
         {
            cardImg.source = param1;
            cardTab.enabled = true;
            tabs.selectedIndex = 0;
            if(isWillow)
            {
               backer.notifyWillowTree(main.build);
            }
         };
         popupShown = function(param1:Event):void
         {
            timer.stop();
            var _loc2_:Boolean = runTechSims(main.build as Weapon,stats);
            PopUpManager.removePopUp(msg);
            techTab.enabled = true;
         };
         var terminatePopup:Function = function(param1:Event):void
         {
            timer.stop();
            PopUpManager.removePopUp(msg);
         };
         var parts:Vector.<Part> = new Vector.<Part>();
         var length:int = 0;
         if(this.main.gearType == GearCalcUtil.GEAR_WEAPON)
         {
            if(this.autoCheck.selected)
            {
               length = 12;
            }
            else
            {
               length = 14;
            }
            i = 0;
            while(i < length)
            {
               if(this.combos[i].selectedItem != null)
               {
                  parts.push(Part(this.combos[i].selectedItem));
               }
               else
               {
                  parts.push(PartCollection.NULL_PART);
               }
               i++;
            }
         }
         else
         {
            if(this.slot1.selectedItem != null)
            {
               parts.push(Part(this.slot1.selectedItem));
            }
            if(this.slot3.selectedItem != null)
            {
               parts.push(Part(this.slot3.selectedItem));
            }
            if(this.slot4.selectedItem != null)
            {
               parts.push(Part(this.slot4.selectedItem));
            }
            if(this.slot5.selectedItem != null)
            {
               parts.push(Part(this.slot5.selectedItem));
            }
            if(this.slot6.selectedItem != null)
            {
               parts.push(Part(this.slot6.selectedItem));
            }
            if(this.slot12.selectedItem != null)
            {
               parts.push(Part(this.slot12.selectedItem));
            }
            if(this.slot2.selectedItem != null)
            {
               parts.push(Part(this.slot2.selectedItem));
            }
            if(!this.autoCheck.selected && this.slot13.selectedItem != null)
            {
               parts.push(Part(this.slot13.selectedItem));
            }
            if(!this.autoCheck.selected && this.slot14.selectedItem != null)
            {
               parts.push(Part(this.slot14.selectedItem));
            }
         }
         if(this.autoCheck.selected)
         {
            nameVec = this.main.autoName(parts,this.qualSpinner.value,this.levelSlider.value + 2);
            if(nameVec[0] == null)
            {
               nameVec[0] = PartCollection.NULL_PART;
            }
            else
            {
               this.addAndSelect(this.slot13,nameVec[0],true);
            }
            if(nameVec[1] == null)
            {
               nameVec[1] = PartCollection.NULL_PART;
            }
            else
            {
               this.addAndSelect(this.slot14,nameVec[1],true);
            }
            parts.push(nameVec[0]);
            parts.push(nameVec[1]);
         }
         workable = this.main.construct(parts,this.qualSpinner.value,this.levelSlider.value + 2);
         if(workable)
         {
            this.autoCheck.enabled = true;
            this.main.build.setQualityLevel(this.qualSpinner.value);
            this.attCol.dataField = "name";
            this.valCol.dataField = "text";
            stats = this.main.calculate(true);
            former = new StatFormatter(stats);
            if(this.main.gearType == GearCalcUtil.GEAR_WEAPON)
            {
               this.statData.removeAll();
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_DAMAGE));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_CLIP));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_FIRERATE));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_SPREAD));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_RECOIL));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_COST));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_RARITY));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_ACC_MIN));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_ACC_MAX));
               this.statData2.removeAll();
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_CRIT));
               if((this.main.build as Weapon).isEridian())
               {
                  this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_COOL_DELAY));
                  this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_COOL_RATE));
                  this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_COOL_FIRE));
                  this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_SHOT_COST));
               }
               else
               {
                  this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_RELOAD));
                  this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_TECH));
                  this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_TECH_POOL));
                  this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_ZOOM));
               }
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_DPS));
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_AMMO_REGEN));
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_BURST_COUNT));
            }
            else if(this.main.gearType == GearCalcUtil.GEAR_SHIELD)
            {
               this.statData.removeAll();
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_SHIELD_CAP));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_SHIELD_RATE));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_SHIELD_DELAY));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_COST));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_RARITY));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_SHIELD_TIME));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_HEALTH_REGEN));
               this.statData.addItem(former.formatDisplay(GearCalcUtil.ATTR_BLAST_RADIUS));
               this.statData2.removeAll();
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_SHOCK_I_RESIST));
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_SHOCK_P_RESIST));
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_INCEN_I_RESIST));
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_INCEN_P_RESIST));
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_CORR_I_RESIST));
               this.statData2.addItem(former.formatDisplay(GearCalcUtil.ATTR_CORR_P_RESIST));
            }
            this.formatGearCode();
            name = this.main.nameGear();
            fSize = 16;
            if(name.length > 28)
            {
               fSize = 12;
            }
            else if(name.length > 20)
            {
               fSize = 14;
            }
            this.main.build.setStats(stats);
            this.main.build.setLabel(name);
            this.statLabel.text = name;
            this.statLabel.setStyle("fontSize",fSize);
            this.statLabel.setStyle("color",former.color);
            flow = new TextFlow();
            pgh = new ParagraphElement();
            span = new SpanElement();
            span.fontSize = 18;
            if(!stats.isGearLegit())
            {
               span.text = "Gear is NOT legit.";
               span.color = 13369344;
            }
            else
            {
               span.text = "Gear is LEGIT";
               span.color = 3394560;
            }
            pgh.textAlign = TextAlign.CENTER;
            pgh.addChild(span);
            flow.addChild(pgh);
            pgh = new ParagraphElement();
            pgh.textAlign = TextAlign.LEFT;
            span = new SpanElement();
            span.text = GearCalcEngine.getErrorCode();
            pgh.addChild(span);
            flow.addChild(pgh);
            this.logArea.textFlow = flow;
            this.partPic.source = null;
            this.mStats = stats;
            this.sFormer = former;
            if(stats.getStat(GearCalcUtil.ATTR_DMG_IS_ELEMENTAL) >= 1)
            {
               acc = this.main.build.getPart(GearCalcUtil.PART_TYPE_ACCESSORY);
               vec = acc.getTechAbilities();
               if(vec.length > 0)
               {
                  scalers = [0,0,0,0];
                  if((this.slot1.selectedItem as Part).getTrueName().indexOf("auncher") > -1)
                  {
                     scalers = GearCalcUtil.scalersLaunchers;
                  }
                  img = this.images.retrieveImage(vec[0].getType(),stats.getStat(GearCalcUtil.ATTR_TECH),scalers);
                  this.eleImage2.visible = true;
                  this.eleImage2.maintainAspectRatio = true;
                  this.eleImage2.source = img;
                  this.eleImage2.height = 30;
               }
               if(Boolean(this.techCheck.selected) && this.main.build.getPart(GearCalcUtil.PART_TYPE_ACCESSORY).getTrueName().indexOf("ocket") == -1 && this.main.build.getPart(GearCalcUtil.PART_TYPE_BARREL).label.indexOf("arnage") == -1 && this.main.build.getPart(GearCalcUtil.PART_TYPE_GRADE).label.indexOf("ackal") == -1 && this.main.build.getPart(GearCalcUtil.PART_TYPE_GRADE).getTrueName().indexOf("oaster") == -1)
               {
                  msg = new BusyWindow();
                  msg.width = 250;
                  msg.height = 120;
                  PopUpManager.addPopUp(msg,this,true);
                  PopUpManager.centerPopUp(msg);
                  timer = new Timer(220,0);
                  timer.addEventListener(TimerEvent.TIMER,popupShown);
                  timer.start();
               }
               else
               {
                  this.techTab.enabled = false;
                  this.tabs.selectedIndex = 0;
               }
            }
            else
            {
               this.eleImage2.visible = false;
               this.techTab.enabled = false;
               this.backer.addHistoryPref(null);
            }
            temp = new Weapon();
            temp.setExpLevel(this.main.build.getExpLevel());
            baseCalc = new Calculator(temp,this.main.filter.template);
            baseCalc.calculate();
            painter = CardFactory.generate(this.main.build as Weapon,baseCalc.stats);
            painter.paint(onImgGenerated);
            this.curCard = painter;
            hash = this.backer.linkifyGear(this.main.build);
            this.backer.addHistoryPref(this.main.build);
            this.backer.writeStandardPrefs();
            this.backer.commitPreferences();
            if(hash != null)
            {
               this.urlField.enabled = true;
               this.urlField.text = "...#" + hash;
            }
            return Weapon(this.main.build);
         }
         this.mStats = null;
         this.sFormer = null;
         this.logArea.text = GearCalcEngine.getErrorCode();
         return null;
      }
      
      private function copyDirectLink() : void
      {
         if(this.urlField.enabled)
         {
            System.setClipboard(RUN_LOCATION + this.urlField.text.replace("...",""));
         }
      }
      
      private function runTechSims(param1:Weapon, param2:StatSet) : Boolean
      {
         var techLevel:Number;
         var sim:TechSim = null;
         var results:SimResultSet = null;
         var abilities:Vector.<TechAbility> = null;
         var ability:TechAbility = null;
         var att:Attribute = null;
         var num:Number = NaN;
         var gun:Weapon = param1;
         var stats:StatSet = param2;
         var calcDamage:Function = function(param1:SimResultSet, param2:String):Number
         {
            var _loc3_:Number = 0;
            var _loc4_:int = 0;
            while(_loc4_ < param1.floatTotals.length)
            {
               if(param2 != null)
               {
                  _loc3_ += abilities[_loc4_].getBulletTypeDamage(param2,main.parts) * param1.floatTotals[_loc4_];
               }
               else
               {
                  _loc3_ += abilities[_loc4_].getBulletDamage(main.parts) * param1.floatTotals[_loc4_];
               }
               _loc4_++;
            }
            if(_loc3_ > 0)
            {
               return stats.getStat(GearCalcUtil.ATTR_DAMAGE) * (_loc3_ + param1.shotCount - param1.netProcs) / param1.shotCount;
            }
            return 0;
         };
         var doTypeDPS:Function = function(param1:SimResultSet, param2:String, param3:String):void
         {
            var _loc4_:Number = Number(calcDamage(param1,param2));
            if(_loc4_ > 0)
            {
               att = new Attribute(param3);
               att.text = (_loc4_ * sim.clip / (sim.clip / sim.rof + sim.reload)).toFixed(1);
               techData.addItem(att);
            }
         };
         this.techData.removeAll();
         sim = new TechSim();
         techLevel = stats.getStat(GearCalcUtil.ATTR_TECH);
         sim.clip = stats.getStat(GearCalcUtil.ATTR_CLIP);
         sim.reload = stats.getStat(GearCalcUtil.ATTR_RELOAD);
         sim.rof = 1 / stats.getStat(GearCalcUtil.ATTR_FIRERATE);
         sim.techPool = stats.getStat(GearCalcUtil.ATTR_TECH_POOL);
         abilities = gun.getTechAbilities();
         for each(ability in abilities)
         {
            if(ability.getRelativeGrade() == 1)
            {
               sim.addTechAbility(ability.getCost(),ability.getProcChance());
            }
            else if(ability.getRelativeGrade() == 2 && techLevel >= 9)
            {
               sim.addTechAbility(ability.getCost(),ability.getProcChance());
            }
            else if(ability.getRelativeGrade() == 3 && techLevel >= 12)
            {
               sim.addTechAbility(ability.getCost(),ability.getProcChance());
            }
            else if(ability.getRelativeGrade() == 4 && techLevel >= 15)
            {
               sim.addTechAbility(ability.getCost(),ability.getProcChance());
            }
         }
         if(sim.getTestableLength() == 0)
         {
            return false;
         }
         att = new Attribute("Elemental Impact DPS");
         sim.termType = TechSim.TERMINATION_BULLETS;
         sim.isAuto = true;
         sim.runLength = 1000;
         sim.trialTotal = 1000;
         results = sim.runElementalSim();
         num = calcDamage(results,null);
         num = num * sim.clip / (sim.clip / sim.rof + sim.reload);
         att.text = num.toFixed(1);
         this.techData.addItem(att);
         att = new Attribute("Procs Per Second");
         num = results.netProcs / results.elapsedTime;
         att.text = num.toFixed(2);
         this.techData.addItem(att);
         doTypeDPS(results,GearCalcUtil.TECH_CORROSIVE,"Corrosive Impact DPS");
         doTypeDPS(results,GearCalcUtil.TECH_EXPLOSIVE,"Explosive Impact DPS");
         doTypeDPS(results,GearCalcUtil.TECH_INCENDIARY,"Incendiary Impact DPS");
         doTypeDPS(results,GearCalcUtil.TECH_SHOCK,"Shock Impact DPS");
         att = new Attribute("Avg. First Shot Damage");
         sim.runLength = 1;
         sim.trialTotal = 1200;
         results = sim.runElementalSim();
         att.text = calcDamage(results,null).toFixed(1);
         this.techData.addItem(att);
         sim.termType = TechSim.TERMINATION_PROC;
         sim.maxProcs = 10;
         sim.trialTotal = 1400;
         results = sim.runElementalSim();
         att = new Attribute("Shots to 10 Procs");
         att.text = results.shotCount.toFixed(1);
         this.techData.addItem(att);
         att = new Attribute("Time to 10 Procs");
         att.text = results.elapsedTime.toFixed(1) + " seconds";
         this.techData.addItem(att);
         if(abilities[0].getCost() > 0)
         {
            sim.termType = TechSim.TERMINATION_DEPLETION;
            sim.trialTotal = 1000;
            results = sim.runElementalSim();
            att = new Attribute("Avg. Shots to Depleted Tech");
            att.text = results.shotCount.toFixed(1);
            this.techData.addItem(att);
         }
         return true;
      }
      
      private function onAutoCheckChange() : void
      {
         if(this.autoCheck.selected)
         {
            this.slot13.enabled = false;
            this.slot14.enabled = false;
         }
         else
         {
            this.slot13.enabled = true;
            this.slot14.enabled = true;
         }
         this.mirrorPrefs(false);
      }
      
      private function mirrorPrefs(param1:Boolean) : void
      {
         if(param1)
         {
            this.autoCheck.selected = this.backer.isAutoName;
            this.techCheck.selected = this.backer.isTechie;
         }
         else
         {
            this.backer.isAutoName = this.autoCheck.selected;
            this.backer.isTechie = this.techCheck.selected;
            this.backer.writeStandardPrefs();
         }
      }
      
      private function formatLabel(param1:Label, param2:Boolean) : void
      {
         if(param2)
         {
            param1.setStyle("fontWeight","bold");
            param1.setStyle("backgroundColor","#FFCC00");
            param1.setStyle("backgroundAlpha","0.2");
         }
         else
         {
            param1.setStyle("fontWeight","normal");
            param1.setStyle("backgroundAlpha","0");
         }
      }
      
      private function formatGearCode() : void
      {
         var _loc4_:Part = null;
         var _loc1_:String = "";
         var _loc2_:int = 0;
         var _loc3_:Vector.<DropDownList> = this.combos;
         if(this.main.gearType != GearCalcUtil.GEAR_WEAPON)
         {
            _loc3_ = new Vector.<DropDownList>();
            _loc3_.push(this.slot1);
            _loc3_.push(this.slot3);
            _loc3_.push(this.slot4);
            _loc3_.push(this.slot5);
            _loc3_.push(this.slot6);
            _loc3_.push(this.slot12);
            _loc3_.push(this.slot2);
            _loc3_.push(this.slot13);
            _loc3_.push(this.slot14);
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_].selectedItem != null)
            {
               _loc1_ += Part(_loc3_[_loc5_].selectedItem).getTrueName();
            }
            else
            {
               _loc1_ += "None";
            }
            if(_loc5_ + 1 < _loc3_.length)
            {
               _loc1_ += GearCalcUtil.NEWLINE_STRING;
            }
            _loc5_++;
         }
         this.codeArea.text = _loc1_;
      }
      
      private function copyCode() : void
      {
         var str:String = null;
         var onEleMenuSelect:Function = null;
         var arrCol:ArrayCollection = null;
         onEleMenuSelect = function(param1:String):void
         {
            var _loc4_:StatFormatter = null;
            var _loc5_:String = null;
            var _loc2_:Vector.<Attribute> = new Vector.<Attribute>();
            var _loc3_:int = 0;
            while(_loc3_ < techData.length)
            {
               _loc2_.push(techData.getItemAt(_loc3_) as Attribute);
               _loc3_++;
            }
            if(param1 == GearCalcAppUtil.STATS_AS_TEXT)
            {
               _loc4_ = new StatFormatter(null);
               _loc4_.attrs = _loc2_;
               _loc5_ = _loc4_.formatText(statLabel.text + " Elemental Stats");
               System.setClipboard(_loc5_);
            }
            else if(param1 == GearCalcAppUtil.STATS_AS_BBCODE)
            {
               System.setClipboard(BBCoder.exportAttributesBB(_loc2_,statLabel.text,statLabel.getStyle("color") as uint));
            }
         };
         if(this.tabs.selectedIndex == 1 && this.main.build != null && this.codeArea.text.length > 1)
         {
            str = this.codeArea.text + GearCalcUtil.NEWLINE_STRING + "1" + GearCalcUtil.NEWLINE_STRING;
            str = str + this.main.build.getQualityLevel().toString() + GearCalcUtil.NEWLINE_STRING;
            str = str + "0" + GearCalcUtil.NEWLINE_STRING + this.main.build.getExpLevel();
            System.setClipboard(str);
         }
         else if(this.tabs.selectedIndex == 2 && this.main.build != null)
         {
            arrCol = new ArrayCollection();
            arrCol.addItem(GearCalcAppUtil.STATS_AS_TEXT);
            arrCol.addItem(GearCalcAppUtil.STATS_AS_BBCODE);
            this.createExportMenu(arrCol,778,24,onEleMenuSelect);
         }
         else if(this.tabs.selectedIndex == 0 && this.main.build != null && this.curCard != null)
         {
            arrCol = new ArrayCollection();
            arrCol.addItem(GearCalcAppUtil.CARD_AS_PNG);
            arrCol.addItem(GearCalcAppUtil.CARD_AS_BBCODE);
            arrCol.addItem(GearCalcAppUtil.CARD_TO_SHACK);
            this.createExportMenu(arrCol,778,24,this.onMenuSelect);
         }
      }
      
      private function prepName(param1:String) : String
      {
         var _loc2_:String = param1;
         while(_loc2_.indexOf("/") != -1)
         {
            _loc2_ = _loc2_.replace("/"," ");
         }
         while(_loc2_.indexOf(".") != -1)
         {
            _loc2_ = _loc2_.replace("."," ");
         }
         return _loc2_;
      }
      
      private function onMenuSelect(param1:String) : void
      {
         var enc:PNGEncoder;
         var bytes:ByteArray;
         var filename:String;
         var exporter:ImageShackExporter = null;
         var parent:DisplayObject = null;
         var app:Application = null;
         var onShacked:Function = null;
         var filer:FileReference = null;
         var entry:ImageEntry = null;
         var selection:String = param1;
         onShacked = function(param1:Event):void
         {
            app.enabled = true;
            var _loc2_:ShackWindow = new ShackWindow();
            PopUpManager.addPopUp(_loc2_,parent,true);
            PopUpManager.centerPopUp(_loc2_);
            _loc2_.setLink(exporter.getResult()[ImageShackExporter.KEY_LINK]);
         };
         if(selection == GearCalcAppUtil.CARD_AS_BBCODE)
         {
            System.setClipboard(BBCoder.exportCardToBB(this.curCard.getCardBase(),this.main.gearType));
            return;
         }
         enc = new PNGEncoder();
         bytes = enc.encode(this.curCard.unscaledImg);
         filename = this.prepName(this.main.build.getName()) + ".png";
         parent = this;
         app = this;
         if(selection == GearCalcAppUtil.CARD_AS_PNG)
         {
            filer = new FileReference();
            filer.save(bytes,filename);
         }
         else if(selection == GearCalcAppUtil.CARD_TO_SHACK)
         {
            exporter = new ImageShackExporter();
            entry = new ImageEntry();
            entry.data = this.curCard.unscaledImg;
            entry.filename = filename;
            exporter.addCompletionListener(onShacked);
            exporter.push(entry);
            exporter.export();
            this.enabled = false;
         }
      }
      
      private function copyStats() : void
      {
         var onMenuSelect:Function = null;
         var arrCol:ArrayCollection = null;
         onMenuSelect = function(param1:String):void
         {
            if(param1 == GearCalcAppUtil.STATS_AS_TEXT)
            {
               System.setClipboard(sFormer.formatText(statLabel.text));
            }
            else if(param1 == GearCalcAppUtil.STATS_AS_BBCODE)
            {
               System.setClipboard(BBCoder.exportAttributesBB(sFormer.attrs,statLabel.text,statLabel.getStyle("color") as uint));
            }
         };
         if(this.main.build != null && this.sFormer != null)
         {
            arrCol = new ArrayCollection();
            arrCol.addItem(GearCalcAppUtil.STATS_AS_TEXT);
            arrCol.addItem(GearCalcAppUtil.STATS_AS_BBCODE);
            this.createExportMenu(arrCol,778,375,onMenuSelect);
         }
      }
      
      private function onGearChange() : void
      {
         if(this.gearList.selectedIndex != -1)
         {
            if(this.gearList.selectedItem == GearCalcAppUtil.DISP_WEAPON)
            {
               this.main.setGearType(GearCalcUtil.GEAR_WEAPON);
            }
            else if(this.gearList.selectedItem == GearCalcAppUtil.DISP_SHIELD)
            {
               this.main.setGearType(GearCalcUtil.GEAR_SHIELD);
            }
            else if(this.gearList.selectedItem == GearCalcAppUtil.DISP_COM)
            {
               this.main.setGearType(GearCalcUtil.GEAR_COM);
            }
         }
      }
      
      private function onSpinnerAction() : void
      {
         var _loc1_:String = null;
         if(this.qualSpinner.value >= 0 && this.slot2.selectedItem != null)
         {
            _loc1_ = Part(this.slot2.selectedItem).getID();
            if(this.main.filter.matchQuality(_loc1_,this.qualSpinner.value) - 2 >= 0)
            {
               this.levelSlider.value = this.main.filter.matchQuality(_loc1_,this.qualSpinner.value) - 2;
            }
            else
            {
               this.levelSlider.value = 0;
            }
         }
      }
      
      private function createExportMenu(param1:ArrayCollection, param2:int, param3:int, param4:Function) : void
      {
         var expMenu:Menu = null;
         var onSelect:Function = null;
         var data:ArrayCollection = param1;
         var x:int = param2;
         var y:int = param3;
         var notify:Function = param4;
         onSelect = function(param1:Event):void
         {
            if(expMenu.selectedIndex != -1)
            {
               notify(expMenu.selectedItem as String);
            }
         };
         expMenu = Menu.createMenu(this,data);
         expMenu.addEventListener(MenuEvent.ITEM_CLICK,onSelect);
         expMenu.show(x,y);
      }
      
      private function onSettingsClick() : void
      {
         var _loc1_:SettingsWindow = new SettingsWindow();
         PopUpManager.addPopUp(_loc1_,this,true);
         PopUpManager.centerPopUp(_loc1_);
         _loc1_.init(this.backer);
      }
      
      private function _GearCalcApp_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.distance = 1;
         _loc1_.angle = 45;
         _loc1_.alpha = 0.76;
         _loc1_.color = 1118481;
         this.blackShadow = _loc1_;
         BindingManager.executeBindings(this,"blackShadow",this.blackShadow);
         return _loc1_;
      }
      
      private function _GearCalcApp_TitleWindow1_i() : TitleWindow
      {
         var _loc1_:TitleWindow = new TitleWindow();
         _loc1_.width = 140;
         _loc1_.height = 90;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._GearCalcApp_Array2_c);
         _loc1_.id = "blankWindow";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.blankWindow = _loc1_;
         BindingManager.executeBindings(this,"blankWindow",this.blankWindow);
         return _loc1_;
      }
      
      private function _GearCalcApp_Array2_c() : Array
      {
         var _loc1_:Array = [this._GearCalcApp_Label1_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_Label1_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.text = "Calculating...";
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_GlowFilter1_i() : GlowFilter
      {
         var _loc1_:GlowFilter = new GlowFilter();
         _loc1_.alpha = 0.6;
         _loc1_.color = 16777045;
         _loc1_.strength = 4;
         _loc1_.blurX = 22;
         _loc1_.blurY = 22;
         this.glower = _loc1_;
         BindingManager.executeBindings(this,"glower",this.glower);
         return _loc1_;
      }
      
      private function _GearCalcApp_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.initialized(this,"modeGroup");
         this.modeGroup = _loc1_;
         BindingManager.executeBindings(this,"modeGroup",this.modeGroup);
         return _loc1_;
      }
      
      private function _GearCalcApp_Rotate1_i() : Rotate
      {
         var _loc1_:Rotate = new Rotate();
         _loc1_.angleFrom = 0;
         _loc1_.angleTo = 34;
         _loc1_.duration = 1;
         this.rotator = _loc1_;
         BindingManager.executeBindings(this,"rotator",this.rotator);
         return _loc1_;
      }
      
      private function _GearCalcApp_BasicLayout1_c() : BasicLayout
      {
         var _loc1_:BasicLayout = new BasicLayout();
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_Array3_c() : Array
      {
         var _loc1_:Array = [];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_DropDownList1_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 28.6;
         _loc1_.y = 56;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("change",this.__slot1_change);
         _loc1_.addEventListener("click",this.__slot1_click);
         _loc1_.id = "slot1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot1 = _loc1_;
         BindingManager.executeBindings(this,"slot1",this.slot1);
         return _loc1_;
      }
      
      public function __slot1_change(param1:IndexChangeEvent) : void
      {
         this.onGradeChange();
      }
      
      public function __slot1_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot1);
      }
      
      private function _GearCalcApp_DropDownList2_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 275;
         _loc1_.y = 56;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("change",this.__slot3_change);
         _loc1_.addEventListener("click",this.__slot3_click);
         _loc1_.id = "slot3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot3 = _loc1_;
         BindingManager.executeBindings(this,"slot3",this.slot3);
         return _loc1_;
      }
      
      public function __slot3_change(param1:IndexChangeEvent) : void
      {
         this.onComboChange(param1);
      }
      
      public function __slot3_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot3);
      }
      
      private function _GearCalcApp_DropDownList3_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 29;
         _loc1_.y = 101;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot4_click);
         _loc1_.addEventListener("change",this.__slot4_change);
         _loc1_.id = "slot4";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot4 = _loc1_;
         BindingManager.executeBindings(this,"slot4",this.slot4);
         return _loc1_;
      }
      
      public function __slot4_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot4);
      }
      
      public function __slot4_change(param1:IndexChangeEvent) : void
      {
         this.revealPart(this.slot4);
      }
      
      private function _GearCalcApp_DropDownList4_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 29;
         _loc1_.y = 148.5;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot7_click);
         _loc1_.addEventListener("change",this.__slot7_change);
         _loc1_.id = "slot7";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot7 = _loc1_;
         BindingManager.executeBindings(this,"slot7",this.slot7);
         return _loc1_;
      }
      
      public function __slot7_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot7);
      }
      
      public function __slot7_change(param1:IndexChangeEvent) : void
      {
         this.revealPart(this.slot7);
      }
      
      private function _GearCalcApp_DropDownList5_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 274.6;
         _loc1_.y = 101;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot5_click);
         _loc1_.addEventListener("change",this.__slot5_change);
         _loc1_.id = "slot5";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot5 = _loc1_;
         BindingManager.executeBindings(this,"slot5",this.slot5);
         return _loc1_;
      }
      
      public function __slot5_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot5);
      }
      
      public function __slot5_change(param1:IndexChangeEvent) : void
      {
         this.onGripChange();
      }
      
      private function _GearCalcApp_DropDownList6_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 274.6;
         _loc1_.y = 148.5;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot6_click);
         _loc1_.addEventListener("change",this.__slot6_change);
         _loc1_.id = "slot6";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot6 = _loc1_;
         BindingManager.executeBindings(this,"slot6",this.slot6);
         return _loc1_;
      }
      
      public function __slot6_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot6);
      }
      
      public function __slot6_change(param1:IndexChangeEvent) : void
      {
         this.revealPart(this.slot6);
      }
      
      private function _GearCalcApp_DropDownList7_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 28;
         _loc1_.y = 197;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot8_click);
         _loc1_.addEventListener("change",this.__slot8_change);
         _loc1_.id = "slot8";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot8 = _loc1_;
         BindingManager.executeBindings(this,"slot8",this.slot8);
         return _loc1_;
      }
      
      public function __slot8_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot8);
      }
      
      public function __slot8_change(param1:IndexChangeEvent) : void
      {
         this.revealPart(this.slot8);
      }
      
      private function _GearCalcApp_DropDownList8_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 29;
         _loc1_.y = 242;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot10_click);
         _loc1_.addEventListener("change",this.__slot10_change);
         _loc1_.id = "slot10";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot10 = _loc1_;
         BindingManager.executeBindings(this,"slot10",this.slot10);
         return _loc1_;
      }
      
      public function __slot10_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot10);
      }
      
      public function __slot10_change(param1:IndexChangeEvent) : void
      {
         this.revealPart(this.slot10);
      }
      
      private function _GearCalcApp_Label2_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 30;
         _loc1_.y = 229;
         _loc1_.text = "Action";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label10_click);
         _loc1_.addEventListener("rollOver",this.__label10_rollOver);
         _loc1_.addEventListener("rollOut",this.__label10_rollOut);
         _loc1_.id = "label10";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label10 = _loc1_;
         BindingManager.executeBindings(this,"label10",this.label10);
         return _loc1_;
      }
      
      public function __label10_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot10);
      }
      
      public function __label10_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label10,true);
      }
      
      public function __label10_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label10,false);
      }
      
      private function _GearCalcApp_DropDownList9_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 274.6;
         _loc1_.y = 242;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot11_click);
         _loc1_.addEventListener("change",this.__slot11_change);
         _loc1_.id = "slot11";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot11 = _loc1_;
         BindingManager.executeBindings(this,"slot11",this.slot11);
         return _loc1_;
      }
      
      public function __slot11_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot11);
      }
      
      public function __slot11_change(param1:IndexChangeEvent) : void
      {
         this.revealPart(this.slot11);
      }
      
      private function _GearCalcApp_DropDownList10_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 274.6;
         _loc1_.y = 197;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot9_click);
         _loc1_.addEventListener("change",this.__slot9_change);
         _loc1_.id = "slot9";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot9 = _loc1_;
         BindingManager.executeBindings(this,"slot9",this.slot9);
         return _loc1_;
      }
      
      public function __slot9_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot9);
      }
      
      public function __slot9_change(param1:IndexChangeEvent) : void
      {
         this.revealPart(this.slot9);
      }
      
      private function _GearCalcApp_Panel1_i() : Panel
      {
         var _loc1_:Panel = new Panel();
         _loc1_.x = 517;
         _loc1_.width = 405.5;
         _loc1_.height = 297;
         _loc1_.y = 45.2;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._GearCalcApp_Array4_c);
         _loc1_.id = "topPanel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.topPanel = _loc1_;
         BindingManager.executeBindings(this,"topPanel",this.topPanel);
         return _loc1_;
      }
      
      private function _GearCalcApp_Array4_c() : Array
      {
         var _loc1_:Array = [];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_TabNavigator1_i() : TabNavigator
      {
         var temp:TabNavigator = new TabNavigator();
         temp.creationPolicy = "all";
         temp.width = 385.55;
         temp.height = 274;
         temp.x = 10.45;
         temp.y = -18.7;
         temp.id = "tabs";
         if(!temp.document)
         {
            temp.document = this;
         }
         temp.mx_internal::_documentDescriptor = new UIComponentDescriptor({
            "type":TabNavigator,
            "id":"tabs",
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":NavigatorContent,
                  "id":"cardTab",
                  "stylesFactory":function():void
                  {
                     this.color = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Card",
                        "percentWidth":100,
                        "percentHeight":100,
                        "enabled":true,
                        "mxmlContentFactory":new DeferredInstanceFromFunction(_GearCalcApp_Array5_c)
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":NavigatorContent,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Code",
                        "percentWidth":98,
                        "percentHeight":97,
                        "y":10,
                        "layout":_GearCalcApp_VerticalLayout1_c(),
                        "mxmlContentFactory":new DeferredInstanceFromFunction(_GearCalcApp_Array6_c)
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":NavigatorContent,
                  "id":"techTab",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Tech",
                        "percentWidth":100,
                        "percentHeight":100,
                        "enabled":true,
                        "mxmlContentFactory":new DeferredInstanceFromFunction(_GearCalcApp_Array8_c)
                     };
                  }
               })]};
            }
         });
         temp.mx_internal::_documentDescriptor.document = this;
         this.tabs = temp;
         BindingManager.executeBindings(this,"tabs",this.tabs);
         return temp;
      }
      
      private function _GearCalcApp_Array5_c() : Array
      {
         var _loc1_:Array = [this._GearCalcApp_Rect1_c(),this._GearCalcApp_Image1_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_Rect1_c() : Rect
      {
         var _loc1_:Rect = new Rect();
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 100;
         _loc1_.fill = this._GearCalcApp_BitmapFill1_i();
         _loc1_.initialized(this,null);
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_BitmapFill1_i() : BitmapFill
      {
         var _loc1_:BitmapFill = new BitmapFill();
         _loc1_.alpha = 0.7;
         this._GearCalcApp_BitmapFill1 = _loc1_;
         BindingManager.executeBindings(this,"_GearCalcApp_BitmapFill1",this._GearCalcApp_BitmapFill1);
         return _loc1_;
      }
      
      private function _GearCalcApp_Image1_i() : Image
      {
         var _loc1_:Image = new Image();
         _loc1_.width = 366;
         _loc1_.height = 245;
         _loc1_.maxWidth = 350;
         _loc1_.maxHeight = 220;
         _loc1_.verticalCenter = 0;
         _loc1_.horizontalCenter = 0;
         _loc1_.scaleContent = true;
         _loc1_.autoLoad = true;
         _loc1_.maintainAspectRatio = true;
         _loc1_.id = "cardImg";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.cardImg = _loc1_;
         BindingManager.executeBindings(this,"cardImg",this.cardImg);
         return _loc1_;
      }
      
      private function _GearCalcApp_VerticalLayout1_c() : VerticalLayout
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.gap = 2;
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_Array6_c() : Array
      {
         var _loc1_:Array = [this._GearCalcApp_TextArea1_i(),this._GearCalcApp_HGroup1_c()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_TextArea1_i() : TextArea
      {
         var _loc1_:TextArea = new TextArea();
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 90;
         _loc1_.toolTip = "Click anywhere to copy";
         _loc1_.editable = false;
         _loc1_.alpha = 0.8;
         _loc1_.buttonMode = true;
         _loc1_.setStyle("fontSize",10);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.addEventListener("mouseDown",this.__codeArea_mouseDown);
         _loc1_.addEventListener("mouseUp",this.__codeArea_mouseUp);
         _loc1_.addEventListener("click",this.__codeArea_click);
         _loc1_.id = "codeArea";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.codeArea = _loc1_;
         BindingManager.executeBindings(this,"codeArea",this.codeArea);
         return _loc1_;
      }
      
      public function __codeArea_mouseDown(param1:MouseEvent) : void
      {
         this.codeArea.alpha = 0.34;
      }
      
      public function __codeArea_mouseUp(param1:MouseEvent) : void
      {
         this.codeArea.alpha = 0.8;
      }
      
      public function __codeArea_click(param1:MouseEvent) : void
      {
         this.copyCode();
      }
      
      private function _GearCalcApp_HGroup1_c() : HGroup
      {
         var _loc1_:HGroup = new HGroup();
         _loc1_.percentWidth = 100;
         _loc1_.percentHeight = 10;
         _loc1_.gap = 4;
         _loc1_.verticalAlign = "middle";
         _loc1_.paddingLeft = 4;
         _loc1_.paddingRight = 4;
         _loc1_.paddingTop = 1;
         _loc1_.paddingBottom = 1;
         _loc1_.mxmlContent = [this._GearCalcApp_Label3_c(),this._GearCalcApp_TextInput1_i()];
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_Label3_c() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.text = "Build URL (click to copy):";
         _loc1_.width = 154;
         _loc1_.percentHeight = 90;
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("color",6579300);
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("textAlign","left");
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_TextInput1_i() : TextInput
      {
         var _loc1_:TextInput = new TextInput();
         _loc1_.percentHeight = 84;
         _loc1_.toolTip = "Click to copy";
         _loc1_.percentWidth = 90;
         _loc1_.editable = false;
         _loc1_.enabled = false;
         _loc1_.buttonMode = true;
         _loc1_.alpha = 0.9;
         _loc1_.setStyle("textAlign","center");
         _loc1_.setStyle("fontSize",10);
         _loc1_.addEventListener("mouseDown",this.__urlField_mouseDown);
         _loc1_.addEventListener("mouseUp",this.__urlField_mouseUp);
         _loc1_.addEventListener("click",this.__urlField_click);
         _loc1_.id = "urlField";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.urlField = _loc1_;
         BindingManager.executeBindings(this,"urlField",this.urlField);
         return _loc1_;
      }
      
      public function __urlField_mouseDown(param1:MouseEvent) : void
      {
         this.urlField.alpha = 0.34;
      }
      
      public function __urlField_mouseUp(param1:MouseEvent) : void
      {
         this.urlField.alpha = 0.9;
      }
      
      public function __urlField_click(param1:MouseEvent) : void
      {
         this.copyDirectLink();
      }
      
      private function _GearCalcApp_Array8_c() : Array
      {
         var _loc1_:Array = [this._GearCalcApp_DataGrid1_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_DataGrid1_i() : DataGrid
      {
         var _loc1_:DataGrid = new DataGrid();
         _loc1_.width = 376;
         _loc1_.height = 246;
         _loc1_.horizontalCenter = 0;
         _loc1_.verticalCenter = 0;
         _loc1_.columns = [this._GearCalcApp_DataGridColumn1_c(),this._GearCalcApp_DataGridColumn2_c()];
         _loc1_.id = "techGrid";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.techGrid = _loc1_;
         BindingManager.executeBindings(this,"techGrid",this.techGrid);
         return _loc1_;
      }
      
      private function _GearCalcApp_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Elemental Property";
         _loc1_.dataField = "name";
         _loc1_.setStyle("fontWeight","bold");
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Value";
         _loc1_.dataField = "text";
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_SimpleImageButton1_i() : SimpleImageButton
      {
         var _loc1_:SimpleImageButton = new SimpleImageButton();
         _loc1_.x = 368.35;
         _loc1_.y = -30;
         _loc1_.toolTip = "Export";
         _loc1_.source = this._embed_mxml_assets_export_icon_png_773417480;
         _loc1_.width = 35;
         _loc1_.height = 30;
         _loc1_.addEventListener("click",this.__iconImg1_click);
         _loc1_.id = "iconImg1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.iconImg1 = _loc1_;
         BindingManager.executeBindings(this,"iconImg1",this.iconImg1);
         return _loc1_;
      }
      
      public function __iconImg1_click(param1:MouseEvent) : void
      {
         this.copyCode();
      }
      
      private function _GearCalcApp_Label4_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 276;
         _loc1_.y = 42;
         _loc1_.text = "Type";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("click",this.__label3_click);
         _loc1_.id = "label3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label3 = _loc1_;
         BindingManager.executeBindings(this,"label3",this.label3);
         return _loc1_;
      }
      
      public function __label3_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot3);
      }
      
      private function _GearCalcApp_Label5_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 30;
         _loc1_.y = 42.5;
         _loc1_.text = "Item Grade";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.addEventListener("click",this.__label1_click);
         _loc1_.id = "label1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label1 = _loc1_;
         BindingManager.executeBindings(this,"label1",this.label1);
         return _loc1_;
      }
      
      public function __label1_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot1);
      }
      
      private function _GearCalcApp_Label6_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 30;
         _loc1_.y = 87;
         _loc1_.text = "Body";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label4_click);
         _loc1_.addEventListener("rollOver",this.__label4_rollOver);
         _loc1_.addEventListener("rollOut",this.__label4_rollOut);
         _loc1_.id = "label4";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label4 = _loc1_;
         BindingManager.executeBindings(this,"label4",this.label4);
         return _loc1_;
      }
      
      public function __label4_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot4);
      }
      
      public function __label4_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label4,true);
      }
      
      public function __label4_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label4,false);
      }
      
      private function _GearCalcApp_Label7_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 30;
         _loc1_.y = 135;
         _loc1_.text = "Barrel";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label7_click);
         _loc1_.addEventListener("rollOver",this.__label7_rollOver);
         _loc1_.addEventListener("rollOut",this.__label7_rollOut);
         _loc1_.id = "label7";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label7 = _loc1_;
         BindingManager.executeBindings(this,"label7",this.label7);
         return _loc1_;
      }
      
      public function __label7_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot7);
      }
      
      public function __label7_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label7,true);
      }
      
      public function __label7_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label7,false);
      }
      
      private function _GearCalcApp_Label8_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 274.6;
         _loc1_.y = 86.5;
         _loc1_.text = "Grip";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label5_click);
         _loc1_.addEventListener("rollOver",this.__label5_rollOver);
         _loc1_.addEventListener("rollOut",this.__label5_rollOut);
         _loc1_.id = "label5";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label5 = _loc1_;
         BindingManager.executeBindings(this,"label5",this.label5);
         return _loc1_;
      }
      
      public function __label5_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot5);
      }
      
      public function __label5_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label5,true);
      }
      
      public function __label5_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label5,false);
      }
      
      private function _GearCalcApp_Label9_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 274.6;
         _loc1_.y = 133.5;
         _loc1_.text = "Magazine";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label6_click);
         _loc1_.addEventListener("rollOver",this.__label6_rollOver);
         _loc1_.addEventListener("rollOut",this.__label6_rollOut);
         _loc1_.id = "label6";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label6 = _loc1_;
         BindingManager.executeBindings(this,"label6",this.label6);
         return _loc1_;
      }
      
      public function __label6_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot6);
      }
      
      public function __label6_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label6,true);
      }
      
      public function __label6_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label6,false);
      }
      
      private function _GearCalcApp_Label10_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 30;
         _loc1_.y = 183;
         _loc1_.text = "Sight";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label8_click);
         _loc1_.addEventListener("rollOver",this.__label8_rollOver);
         _loc1_.addEventListener("rollOut",this.__label8_rollOut);
         _loc1_.id = "label8";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label8 = _loc1_;
         BindingManager.executeBindings(this,"label8",this.label8);
         return _loc1_;
      }
      
      public function __label8_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot8);
      }
      
      public function __label8_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label8,true);
      }
      
      public function __label8_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label8,false);
      }
      
      private function _GearCalcApp_Label11_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 29;
         _loc1_.y = 278;
         _loc1_.text = "Manufacturer";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label2_click);
         _loc1_.addEventListener("rollOver",this.__label2_rollOver);
         _loc1_.addEventListener("rollOut",this.__label2_rollOut);
         _loc1_.id = "label2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label2 = _loc1_;
         BindingManager.executeBindings(this,"label2",this.label2);
         return _loc1_;
      }
      
      public function __label2_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot2);
      }
      
      public function __label2_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label2,true);
      }
      
      public function __label2_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label2,false);
      }
      
      private function _GearCalcApp_Label12_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 29;
         _loc1_.y = 324;
         _loc1_.text = "Prefix";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label13_click);
         _loc1_.addEventListener("rollOver",this.__label13_rollOver);
         _loc1_.addEventListener("rollOut",this.__label13_rollOut);
         _loc1_.id = "label13";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label13 = _loc1_;
         BindingManager.executeBindings(this,"label13",this.label13);
         return _loc1_;
      }
      
      public function __label13_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot13);
      }
      
      public function __label13_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label13,true);
      }
      
      public function __label13_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label13,false);
      }
      
      private function _GearCalcApp_Label13_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 29;
         _loc1_.y = 377;
         _loc1_.text = "Quality";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.id = "_GearCalcApp_Label13";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._GearCalcApp_Label13 = _loc1_;
         BindingManager.executeBindings(this,"_GearCalcApp_Label13",this._GearCalcApp_Label13);
         return _loc1_;
      }
      
      private function _GearCalcApp_Label14_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 160;
         _loc1_.y = 376;
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.id = "levelIndicator";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.levelIndicator = _loc1_;
         BindingManager.executeBindings(this,"levelIndicator",this.levelIndicator);
         return _loc1_;
      }
      
      private function _GearCalcApp_Label15_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 114;
         _loc1_.y = 377;
         _loc1_.text = "Level:";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.id = "_GearCalcApp_Label15";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._GearCalcApp_Label15 = _loc1_;
         BindingManager.executeBindings(this,"_GearCalcApp_Label15",this._GearCalcApp_Label15);
         return _loc1_;
      }
      
      private function _GearCalcApp_Label16_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 274.6;
         _loc1_.y = 323.5;
         _loc1_.text = "Title";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label14_click);
         _loc1_.addEventListener("rollOut",this.__label14_rollOut);
         _loc1_.addEventListener("rollOver",this.__label14_rollOver);
         _loc1_.id = "label14";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label14 = _loc1_;
         BindingManager.executeBindings(this,"label14",this.label14);
         return _loc1_;
      }
      
      public function __label14_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot14);
      }
      
      public function __label14_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label14,false);
      }
      
      public function __label14_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label14,true);
      }
      
      private function _GearCalcApp_Label17_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 275.6;
         _loc1_.y = 277.5;
         _loc1_.text = "Material";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label12_click);
         _loc1_.addEventListener("rollOver",this.__label12_rollOver);
         _loc1_.addEventListener("rollOut",this.__label12_rollOut);
         _loc1_.id = "label12";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label12 = _loc1_;
         BindingManager.executeBindings(this,"label12",this.label12);
         return _loc1_;
      }
      
      public function __label12_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot12);
      }
      
      public function __label12_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label12,true);
      }
      
      public function __label12_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label12,false);
      }
      
      private function _GearCalcApp_Label18_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 276.6;
         _loc1_.y = 229.5;
         _loc1_.text = "Accessory";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label11_click);
         _loc1_.addEventListener("rollOver",this.__label11_rollOver);
         _loc1_.addEventListener("rollOut",this.__label11_rollOut);
         _loc1_.id = "label11";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label11 = _loc1_;
         BindingManager.executeBindings(this,"label11",this.label11);
         return _loc1_;
      }
      
      public function __label11_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot11);
      }
      
      public function __label11_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label11,true);
      }
      
      public function __label11_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label11,false);
      }
      
      private function _GearCalcApp_Label19_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 276.6;
         _loc1_.y = 181.5;
         _loc1_.text = "Stock";
         _loc1_.setStyle("color",3223857);
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__label9_click);
         _loc1_.addEventListener("rollOver",this.__label9_rollOver);
         _loc1_.addEventListener("rollOut",this.__label9_rollOut);
         _loc1_.id = "label9";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.label9 = _loc1_;
         BindingManager.executeBindings(this,"label9",this.label9);
         return _loc1_;
      }
      
      public function __label9_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot9);
      }
      
      public function __label9_rollOver(param1:MouseEvent) : void
      {
         this.formatLabel(this.label9,true);
      }
      
      public function __label9_rollOut(param1:MouseEvent) : void
      {
         this.formatLabel(this.label9,false);
      }
      
      private function _GearCalcApp_NumericStepper1_i() : NumericStepper
      {
         var _loc1_:NumericStepper = new NumericStepper();
         _loc1_.x = 30;
         _loc1_.y = 392;
         _loc1_.minimum = 0;
         _loc1_.maximum = 5;
         _loc1_.stepSize = 1;
         _loc1_.enabled = true;
         _loc1_.value = 5;
         _loc1_.addEventListener("change",this.__qualSpinner_change);
         _loc1_.id = "qualSpinner";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.qualSpinner = _loc1_;
         BindingManager.executeBindings(this,"qualSpinner",this.qualSpinner);
         return _loc1_;
      }
      
      public function __qualSpinner_change(param1:Event) : void
      {
         this.onSpinnerAction();
      }
      
      private function _GearCalcApp_Panel2_i() : Panel
      {
         var _loc1_:Panel = new Panel();
         _loc1_.x = 517;
         _loc1_.y = 350.1;
         _loc1_.width = 405.5;
         _loc1_.height = 250;
         _loc1_.mxmlContentFactory = new DeferredInstanceFromFunction(this._GearCalcApp_Array10_c);
         _loc1_.id = "_GearCalcApp_Panel2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._GearCalcApp_Panel2 = _loc1_;
         BindingManager.executeBindings(this,"_GearCalcApp_Panel2",this._GearCalcApp_Panel2);
         return _loc1_;
      }
      
      private function _GearCalcApp_Array10_c() : Array
      {
         var _loc1_:Array = [this._GearCalcApp_DataGrid2_i(),this._GearCalcApp_SimpleImageButton2_i(),this._GearCalcApp_Label20_i(),this._GearCalcApp_DataGrid3_i()];
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_DataGrid2_i() : DataGrid
      {
         var _loc1_:DataGrid = new DataGrid();
         _loc1_.x = 11;
         _loc1_.y = 2;
         _loc1_.width = 190;
         _loc1_.height = 206;
         _loc1_.variableRowHeight = true;
         _loc1_.columns = [this._GearCalcApp_DataGridColumn3_i(),this._GearCalcApp_DataGridColumn4_i()];
         _loc1_.id = "statGrid";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.statGrid = _loc1_;
         BindingManager.executeBindings(this,"statGrid",this.statGrid);
         return _loc1_;
      }
      
      private function _GearCalcApp_DataGridColumn3_i() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.width = 108;
         _loc1_.wordWrap = true;
         _loc1_.headerText = "Attribute";
         _loc1_.draggable = false;
         _loc1_.sortable = false;
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("fontSize",10);
         this.attCol = _loc1_;
         BindingManager.executeBindings(this,"attCol",this.attCol);
         return _loc1_;
      }
      
      private function _GearCalcApp_DataGridColumn4_i() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Value";
         _loc1_.wordWrap = true;
         _loc1_.draggable = false;
         _loc1_.sortable = false;
         _loc1_.setStyle("fontSize",11);
         this.valCol = _loc1_;
         BindingManager.executeBindings(this,"valCol",this.valCol);
         return _loc1_;
      }
      
      private function _GearCalcApp_SimpleImageButton2_i() : SimpleImageButton
      {
         var _loc1_:SimpleImageButton = new SimpleImageButton();
         _loc1_.x = 368.35;
         _loc1_.y = -31.25;
         _loc1_.toolTip = "Export";
         _loc1_.source = this._embed_mxml_assets_export_icon_png_773417480;
         _loc1_.width = 35;
         _loc1_.height = 30;
         _loc1_.addEventListener("click",this.__iconImg2_click);
         _loc1_.id = "iconImg2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.iconImg2 = _loc1_;
         BindingManager.executeBindings(this,"iconImg2",this.iconImg2);
         return _loc1_;
      }
      
      public function __iconImg2_click(param1:MouseEvent) : void
      {
         this.copyStats();
      }
      
      private function _GearCalcApp_Label20_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.x = 21;
         _loc1_.y = -24.2;
         _loc1_.text = "Gear Stats";
         _loc1_.width = 277;
         _loc1_.height = 23;
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("verticalAlign","middle");
         _loc1_.setStyle("textAlign","left");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.setStyle("fontFamily","Verdana");
         _loc1_.id = "statLabel";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.statLabel = _loc1_;
         BindingManager.executeBindings(this,"statLabel",this.statLabel);
         return _loc1_;
      }
      
      private function _GearCalcApp_Image2_i() : Image
      {
         var _loc1_:Image = new Image();
         _loc1_.x = 325;
         _loc1_.y = -32.25;
         _loc1_.id = "eleImage2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.eleImage2 = _loc1_;
         BindingManager.executeBindings(this,"eleImage2",this.eleImage2);
         return _loc1_;
      }
      
      private function _GearCalcApp_DataGrid3_i() : DataGrid
      {
         var _loc1_:DataGrid = new DataGrid();
         _loc1_.x = 203;
         _loc1_.y = 2;
         _loc1_.width = 190;
         _loc1_.height = 206;
         _loc1_.variableRowHeight = true;
         _loc1_.columns = [this._GearCalcApp_DataGridColumn5_c(),this._GearCalcApp_DataGridColumn6_c()];
         _loc1_.id = "_GearCalcApp_DataGrid3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._GearCalcApp_DataGrid3 = _loc1_;
         BindingManager.executeBindings(this,"_GearCalcApp_DataGrid3",this._GearCalcApp_DataGrid3);
         return _loc1_;
      }
      
      private function _GearCalcApp_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.width = 115;
         _loc1_.wordWrap = true;
         _loc1_.headerText = "Attribute";
         _loc1_.dataField = "name";
         _loc1_.setStyle("fontSize",10);
         _loc1_.setStyle("fontWeight","normal");
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_DataGridColumn6_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Value";
         _loc1_.dataField = "text";
         _loc1_.setStyle("fontSize",11);
         BindingManager.executeBindings(this,"temp",_loc1_);
         return _loc1_;
      }
      
      private function _GearCalcApp_Button1_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.x = 328.7;
         _loc1_.y = 393;
         _loc1_.label = "Calculate";
         _loc1_.width = 167;
         _loc1_.height = 23;
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontSize",16);
         _loc1_.setStyle("color",4177989);
         _loc1_.setStyle("textAlpha",0.87);
         _loc1_.setStyle("fontFamily","Verdana");
         _loc1_.setStyle("fontStyle","italic");
         _loc1_.addEventListener("click",this.__calcButton_click);
         _loc1_.id = "calcButton";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.calcButton = _loc1_;
         BindingManager.executeBindings(this,"calcButton",this.calcButton);
         return _loc1_;
      }
      
      public function __calcButton_click(param1:MouseEvent) : void
      {
         this.onCalcClick();
      }
      
      private function _GearCalcApp_DropDownList11_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 28;
         _loc1_.y = 291;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot2_click);
         _loc1_.id = "slot2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot2 = _loc1_;
         BindingManager.executeBindings(this,"slot2",this.slot2);
         return _loc1_;
      }
      
      public function __slot2_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot2);
      }
      
      private function _GearCalcApp_DropDownList12_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 274.6;
         _loc1_.y = 291.5;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot12_click);
         _loc1_.addEventListener("change",this.__slot12_change);
         _loc1_.id = "slot12";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot12 = _loc1_;
         BindingManager.executeBindings(this,"slot12",this.slot12);
         return _loc1_;
      }
      
      public function __slot12_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot12);
      }
      
      public function __slot12_change(param1:IndexChangeEvent) : void
      {
         this.revealPart(this.slot12);
      }
      
      private function _GearCalcApp_DropDownList13_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 28;
         _loc1_.y = 337;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot13_click);
         _loc1_.addEventListener("change",this.__slot13_change);
         _loc1_.id = "slot13";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot13 = _loc1_;
         BindingManager.executeBindings(this,"slot13",this.slot13);
         return _loc1_;
      }
      
      public function __slot13_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot13);
      }
      
      public function __slot13_change(param1:IndexChangeEvent) : void
      {
         this.onNameComboChange();
      }
      
      private function _GearCalcApp_DropDownList14_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 275.6;
         _loc1_.y = 337;
         _loc1_.width = 225;
         _loc1_.height = 25;
         _loc1_.addEventListener("click",this.__slot14_click);
         _loc1_.addEventListener("change",this.__slot14_change);
         _loc1_.id = "slot14";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.slot14 = _loc1_;
         BindingManager.executeBindings(this,"slot14",this.slot14);
         return _loc1_;
      }
      
      public function __slot14_click(param1:MouseEvent) : void
      {
         this.revealPart(this.slot14);
      }
      
      public function __slot14_change(param1:IndexChangeEvent) : void
      {
         this.onNameComboChange();
      }
      
      private function _GearCalcApp_HSlider1_i() : HSlider
      {
         var _loc1_:HSlider = new HSlider();
         _loc1_.x = 89.65;
         _loc1_.y = 393.05;
         _loc1_.width = 218;
         _loc1_.height = 24;
         _loc1_.minimum = 0;
         _loc1_.maximum = 61;
         _loc1_.stepSize = 1;
         _loc1_.value = 0;
         _loc1_.id = "levelSlider";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.levelSlider = _loc1_;
         BindingManager.executeBindings(this,"levelSlider",this.levelSlider);
         return _loc1_;
      }
      
      private function _GearCalcApp_TextArea2_i() : TextArea
      {
         var _loc1_:TextArea = new TextArea();
         _loc1_.x = 28;
         _loc1_.y = 424;
         _loc1_.width = 469;
         _loc1_.height = 176;
         _loc1_.editable = false;
         _loc1_.alpha = 0.8;
         _loc1_.id = "logArea";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.logArea = _loc1_;
         BindingManager.executeBindings(this,"logArea",this.logArea);
         return _loc1_;
      }
      
      private function _GearCalcApp_Image3_i() : Image
      {
         var _loc1_:Image = new Image();
         _loc1_.x = 535;
         _loc1_.y = 2;
         _loc1_.height = 45;
         _loc1_.width = 400;
         _loc1_.id = "titleImg";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.titleImg = _loc1_;
         BindingManager.executeBindings(this,"titleImg",this.titleImg);
         return _loc1_;
      }
      
      private function _GearCalcApp_DropDownList15_i() : DropDownList
      {
         var _loc1_:DropDownList = new DropDownList();
         _loc1_.x = 700.15;
         _loc1_.y = 51.4;
         _loc1_.width = 176;
         _loc1_.setStyle("fontSize",10);
         _loc1_.addEventListener("change",this.__histList_change);
         _loc1_.id = "histList";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.histList = _loc1_;
         BindingManager.executeBindings(this,"histList",this.histList);
         return _loc1_;
      }
      
      public function __histList_change(param1:IndexChangeEvent) : void
      {
         this.onHistoryChange();
      }
      
      private function _GearCalcApp_CheckBox1_i() : CheckBox
      {
         var _loc1_:CheckBox = null;
         _loc1_ = new CheckBox();
         _loc1_.x = 322;
         _loc1_.y = 368;
         _loc1_.label = "Auto-Naming";
         _loc1_.width = 98;
         _loc1_.selected = false;
         _loc1_.enabled = false;
         _loc1_.setStyle("fontSize",12);
         _loc1_.addEventListener("click",this.__autoCheck_click);
         _loc1_.id = "autoCheck";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.autoCheck = _loc1_;
         BindingManager.executeBindings(this,"autoCheck",this.autoCheck);
         return _loc1_;
      }
      
      public function __autoCheck_click(param1:MouseEvent) : void
      {
         this.onAutoCheckChange();
      }
      
      private function _GearCalcApp_CheckBox2_i() : CheckBox
      {
         var _loc1_:CheckBox = null;
         _loc1_ = new CheckBox();
         _loc1_.x = 431;
         _loc1_.y = 368;
         _loc1_.label = "Tech Stats";
         _loc1_.enabled = true;
         _loc1_.selected = true;
         _loc1_.setStyle("fontSize",12);
         _loc1_.addEventListener("click",this.__techCheck_click);
         _loc1_.id = "techCheck";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.techCheck = _loc1_;
         BindingManager.executeBindings(this,"techCheck",this.techCheck);
         return _loc1_;
      }
      
      public function __techCheck_click(param1:MouseEvent) : void
      {
         this.mirrorPrefs(false);
      }
      
      private function _GearCalcApp_RadioButton1_i() : RadioButton
      {
         var _loc1_:RadioButton = null;
         _loc1_ = new RadioButton();
         _loc1_.x = 237;
         _loc1_.y = 10;
         _loc1_.label = "Build";
         _loc1_.selected = true;
         _loc1_.setStyle("fontSize",14);
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontStyle","normal");
         _loc1_.id = "buildRadio";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.buildRadio = _loc1_;
         BindingManager.executeBindings(this,"buildRadio",this.buildRadio);
         return _loc1_;
      }
      
      private function _GearCalcApp_RadioButton2_i() : RadioButton
      {
         var _loc1_:RadioButton = null;
         _loc1_ = new RadioButton();
         _loc1_.x = 310;
         _loc1_.y = 10;
         _loc1_.label = "Import";
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__importRadio_click);
         _loc1_.id = "importRadio";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.importRadio = _loc1_;
         BindingManager.executeBindings(this,"importRadio",this.importRadio);
         return _loc1_;
      }
      
      public function __importRadio_click(param1:MouseEvent) : void
      {
         this.tryImport();
      }
      
      private function _GearCalcApp_RadioButton3_i() : RadioButton
      {
         var _loc1_:RadioButton = null;
         _loc1_ = new RadioButton();
         _loc1_.x = 388;
         _loc1_.y = 10;
         _loc1_.label = "Deconstruct";
         _loc1_.enabled = false;
         _loc1_.setStyle("fontWeight","bold");
         _loc1_.setStyle("fontSize",14);
         _loc1_.addEventListener("click",this.__deconRadio_click);
         _loc1_.id = "deconRadio";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.deconRadio = _loc1_;
         BindingManager.executeBindings(this,"deconRadio",this.deconRadio);
         return _loc1_;
      }
      
      public function __deconRadio_click(param1:MouseEvent) : void
      {
         this.onDeconClick();
      }
      
      private function _GearCalcApp_HRule1_i() : HRule
      {
         var _loc1_:HRule = null;
         _loc1_ = new HRule();
         _loc1_.x = 41;
         _loc1_.y = 28;
         _loc1_.width = 455;
         _loc1_.height = 9;
         _loc1_.alpha = 0.5;
         _loc1_.id = "_GearCalcApp_HRule1";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._GearCalcApp_HRule1 = _loc1_;
         BindingManager.executeBindings(this,"_GearCalcApp_HRule1",this._GearCalcApp_HRule1);
         return _loc1_;
      }
      
      private function _GearCalcApp_SimpleImageButton3_i() : SimpleImageButton
      {
         var _loc1_:SimpleImageButton = null;
         _loc1_ = new SimpleImageButton();
         _loc1_.toolTip = "Settings";
         _loc1_.x = 5;
         _loc1_.y = 5;
         _loc1_.width = 28;
         _loc1_.height = 28;
         _loc1_.source = this._embed_mxml_assets_blackgear_png_239058856;
         _loc1_.addEventListener("click",this.___GearCalcApp_SimpleImageButton3_click);
         _loc1_.id = "_GearCalcApp_SimpleImageButton3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._GearCalcApp_SimpleImageButton3 = _loc1_;
         BindingManager.executeBindings(this,"_GearCalcApp_SimpleImageButton3",this._GearCalcApp_SimpleImageButton3);
         return _loc1_;
      }
      
      public function ___GearCalcApp_SimpleImageButton3_click(param1:MouseEvent) : void
      {
         this.onSettingsClick();
      }
      
      private function _GearCalcApp_Image4_i() : Image
      {
         var _loc1_:Image = null;
         _loc1_ = new Image();
         _loc1_.x = 408;
         _loc1_.y = 460;
         _loc1_.width = 75;
         _loc1_.height = 35;
         _loc1_.scaleContent = true;
         _loc1_.maintainAspectRatio = true;
         _loc1_.addEventListener("dataChange",this.__partPic_dataChange);
         _loc1_.addEventListener("complete",this.__partPic_complete);
         _loc1_.id = "partPic";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.partPic = _loc1_;
         BindingManager.executeBindings(this,"partPic",this.partPic);
         return _loc1_;
      }
      
      public function __partPic_dataChange(param1:FlexEvent) : void
      {
         this.onImgComplete(param1);
      }
      
      public function __partPic_complete(param1:Event) : void
      {
         this.onImgComplete(param1);
      }
      
      private function _GearCalcApp_DropDownList16_i() : DropDownList
      {
         var _loc1_:DropDownList = null;
         _loc1_ = new DropDownList();
         _loc1_.x = 67;
         _loc1_.y = 6;
         _loc1_.width = 145;
         _loc1_.setStyle("textAlign","center");
         _loc1_.addEventListener("change",this.__gearList_change);
         _loc1_.id = "gearList";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this.gearList = _loc1_;
         BindingManager.executeBindings(this,"gearList",this.gearList);
         return _loc1_;
      }
      
      public function __gearList_change(param1:IndexChangeEvent) : void
      {
         this.onGearChange();
      }
      
      private function _GearCalcApp_Label21_i() : Label
      {
         var _loc1_:Label = null;
         _loc1_ = new Label();
         _loc1_.x = 5;
         _loc1_.text = "W i l l o w   T r e e   M o d e";
         _loc1_.rotation = -90;
         _loc1_.alpha = 0.35;
         _loc1_.verticalCenter = 0;
         _loc1_.setStyle("fontSize",20);
         _loc1_.setStyle("fontWeight","normal");
         _loc1_.setStyle("color",12040119);
         _loc1_.setStyle("fontFamily","Prototype");
         _loc1_.id = "_GearCalcApp_Label21";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._GearCalcApp_Label21 = _loc1_;
         BindingManager.executeBindings(this,"_GearCalcApp_Label21",this._GearCalcApp_Label21);
         return _loc1_;
      }
      
      public function ___GearCalcApp_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.loadData();
      }
      
      private function _GearCalcApp_bindingsSetup() : Array
      {
         var result:Array = null;
         result = [];
         result[0] = new Binding(this,function():Object
         {
            return bgFill;
         },null,"_GearCalcApp_BitmapFill1.source");
         result[1] = new Binding(this,function():Object
         {
            return techData;
         },null,"techGrid.dataProvider");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = levelSlider.value;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"levelIndicator.text");
         result[3] = new Binding(this,function():Object
         {
            return statData2;
         },null,"_GearCalcApp_DataGrid3.dataProvider");
         result[4] = new Binding(this,null,null,"titleImg.source","titleBar");
         result[5] = new Binding(this,null,null,"buildRadio.group","modeGroup");
         result[6] = new Binding(this,null,null,"importRadio.group","modeGroup");
         result[7] = new Binding(this,null,null,"deconRadio.group","modeGroup");
         result[8] = new Binding(this,function():Array
         {
            var _loc1_:* = undefined;
            _loc1_ = blackShadow;
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"partPic.filters","blackShadow");
         result[9] = new Binding(this,function():Boolean
         {
            return isWillow;
         },null,"_GearCalcApp_Label21.visible");
         return result;
      }
      
      mx_internal function _GearCalcApp_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         var conditions:Array = null;
         var condition:CSSCondition = null;
         var selector:CSSSelector = null;
         if(mx_internal::_GearCalcApp_StylesInit_done)
         {
            return;
         }
         mx_internal::_GearCalcApp_StylesInit_done = true;
         selector = null;
         conditions = null;
         conditions = null;
         selector = new CSSSelector("global",conditions,selector);
         style = styleManager.getStyleDeclaration("global");
         if(!style)
         {
            style = new CSSStyleDeclaration(selector,styleManager);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "normal";
               this.color = 0;
            };
         }
         styleManager.initProtoChainRoots();
      }
      
      [Bindable(event="propertyChange")]
      public function get _GearCalcApp_Panel2() : Panel
      {
         return this._61136625_GearCalcApp_Panel2;
      }
      
      public function set _GearCalcApp_Panel2(param1:Panel) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._61136625_GearCalcApp_Panel2;
         if(_loc2_ !== param1)
         {
            this._61136625_GearCalcApp_Panel2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_GearCalcApp_Panel2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get attCol() : DataGridColumn
      {
         return this._1407287521attCol;
      }
      
      public function set attCol(param1:DataGridColumn) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1407287521attCol;
         if(_loc2_ !== param1)
         {
            this._1407287521attCol = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"attCol",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get autoCheck() : CheckBox
      {
         return this._1635077273autoCheck;
      }
      
      public function set autoCheck(param1:CheckBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1635077273autoCheck;
         if(_loc2_ !== param1)
         {
            this._1635077273autoCheck = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoCheck",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get blackShadow() : DropShadowFilter
      {
         return this._407812607blackShadow;
      }
      
      public function set blackShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._407812607blackShadow;
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
      public function get blankWindow() : TitleWindow
      {
         return this._1780282780blankWindow;
      }
      
      public function set blankWindow(param1:TitleWindow) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1780282780blankWindow;
         if(_loc2_ !== param1)
         {
            this._1780282780blankWindow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blankWindow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buildRadio() : RadioButton
      {
         return this._482987475buildRadio;
      }
      
      public function set buildRadio(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._482987475buildRadio;
         if(_loc2_ !== param1)
         {
            this._482987475buildRadio = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buildRadio",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get calcButton() : Button
      {
         return this._1705228775calcButton;
      }
      
      public function set calcButton(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1705228775calcButton;
         if(_loc2_ !== param1)
         {
            this._1705228775calcButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"calcButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cardImg() : Image
      {
         return this._553912979cardImg;
      }
      
      public function set cardImg(param1:Image) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._553912979cardImg;
         if(_loc2_ !== param1)
         {
            this._553912979cardImg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cardImg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cardTab() : NavigatorContent
      {
         return this._553923173cardTab;
      }
      
      public function set cardTab(param1:NavigatorContent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._553923173cardTab;
         if(_loc2_ !== param1)
         {
            this._553923173cardTab = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cardTab",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get codeArea() : TextArea
      {
         return this._868535270codeArea;
      }
      
      public function set codeArea(param1:TextArea) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._868535270codeArea;
         if(_loc2_ !== param1)
         {
            this._868535270codeArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"codeArea",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get deconRadio() : RadioButton
      {
         return this._939639014deconRadio;
      }
      
      public function set deconRadio(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._939639014deconRadio;
         if(_loc2_ !== param1)
         {
            this._939639014deconRadio = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"deconRadio",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get eleImage2() : Image
      {
         return this._1282176907eleImage2;
      }
      
      public function set eleImage2(param1:Image) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1282176907eleImage2;
         if(_loc2_ !== param1)
         {
            this._1282176907eleImage2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"eleImage2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get gearList() : DropDownList
      {
         return this._1449074381gearList;
      }
      
      public function set gearList(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1449074381gearList;
         if(_loc2_ !== param1)
         {
            this._1449074381gearList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gearList",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get glower() : GlowFilter
      {
         return this._1243000070glower;
      }
      
      public function set glower(param1:GlowFilter) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1243000070glower;
         if(_loc2_ !== param1)
         {
            this._1243000070glower = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"glower",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get histList() : DropDownList
      {
         return this._1330863392histList;
      }
      
      public function set histList(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1330863392histList;
         if(_loc2_ !== param1)
         {
            this._1330863392histList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"histList",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconImg1() : SimpleImageButton
      {
         return this._738251545iconImg1;
      }
      
      public function set iconImg1(param1:SimpleImageButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._738251545iconImg1;
         if(_loc2_ !== param1)
         {
            this._738251545iconImg1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconImg1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconImg2() : SimpleImageButton
      {
         return this._738251544iconImg2;
      }
      
      public function set iconImg2(param1:SimpleImageButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._738251544iconImg2;
         if(_loc2_ !== param1)
         {
            this._738251544iconImg2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconImg2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get importRadio() : RadioButton
      {
         return this._1456418646importRadio;
      }
      
      public function set importRadio(param1:RadioButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1456418646importRadio;
         if(_loc2_ !== param1)
         {
            this._1456418646importRadio = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"importRadio",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label1() : Label
      {
         return this._1110417475label1;
      }
      
      public function set label1(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1110417475label1;
         if(_loc2_ !== param1)
         {
            this._1110417475label1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label10() : Label
      {
         return this._63203309label10;
      }
      
      public function set label10(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._63203309label10;
         if(_loc2_ !== param1)
         {
            this._63203309label10 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label10",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label11() : Label
      {
         return this._63203308label11;
      }
      
      public function set label11(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._63203308label11;
         if(_loc2_ !== param1)
         {
            this._63203308label11 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label11",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label12() : Label
      {
         return this._63203307label12;
      }
      
      public function set label12(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._63203307label12;
         if(_loc2_ !== param1)
         {
            this._63203307label12 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label12",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label13() : Label
      {
         return this._63203306label13;
      }
      
      public function set label13(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._63203306label13;
         if(_loc2_ !== param1)
         {
            this._63203306label13 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label13",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label14() : Label
      {
         return this._63203305label14;
      }
      
      public function set label14(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._63203305label14;
         if(_loc2_ !== param1)
         {
            this._63203305label14 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label14",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label2() : Label
      {
         return this._1110417474label2;
      }
      
      public function set label2(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1110417474label2;
         if(_loc2_ !== param1)
         {
            this._1110417474label2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label3() : Label
      {
         return this._1110417473label3;
      }
      
      public function set label3(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1110417473label3;
         if(_loc2_ !== param1)
         {
            this._1110417473label3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label4() : Label
      {
         return this._1110417472label4;
      }
      
      public function set label4(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1110417472label4;
         if(_loc2_ !== param1)
         {
            this._1110417472label4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label5() : Label
      {
         return this._1110417471label5;
      }
      
      public function set label5(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1110417471label5;
         if(_loc2_ !== param1)
         {
            this._1110417471label5 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label5",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label6() : Label
      {
         return this._1110417470label6;
      }
      
      public function set label6(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1110417470label6;
         if(_loc2_ !== param1)
         {
            this._1110417470label6 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label6",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label7() : Label
      {
         return this._1110417469label7;
      }
      
      public function set label7(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1110417469label7;
         if(_loc2_ !== param1)
         {
            this._1110417469label7 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label7",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label8() : Label
      {
         return this._1110417468label8;
      }
      
      public function set label8(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1110417468label8;
         if(_loc2_ !== param1)
         {
            this._1110417468label8 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label8",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get label9() : Label
      {
         return this._1110417467label9;
      }
      
      public function set label9(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1110417467label9;
         if(_loc2_ !== param1)
         {
            this._1110417467label9 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"label9",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get levelIndicator() : Label
      {
         return this._157087467levelIndicator;
      }
      
      public function set levelIndicator(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._157087467levelIndicator;
         if(_loc2_ !== param1)
         {
            this._157087467levelIndicator = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"levelIndicator",_loc2_,param1));
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
         var _loc2_:Object = null;
         _loc2_ = this._1774013829levelSlider;
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
      public function get logArea() : TextArea
      {
         return this._341157361logArea;
      }
      
      public function set logArea(param1:TextArea) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._341157361logArea;
         if(_loc2_ !== param1)
         {
            this._341157361logArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logArea",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get modeGroup() : RadioButtonGroup
      {
         return this._2043913572modeGroup;
      }
      
      public function set modeGroup(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2043913572modeGroup;
         if(_loc2_ !== param1)
         {
            this._2043913572modeGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"modeGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get partPic() : Image
      {
         return this._792957801partPic;
      }
      
      public function set partPic(param1:Image) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._792957801partPic;
         if(_loc2_ !== param1)
         {
            this._792957801partPic = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"partPic",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get qualSpinner() : NumericStepper
      {
         return this._1261429194qualSpinner;
      }
      
      public function set qualSpinner(param1:NumericStepper) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1261429194qualSpinner;
         if(_loc2_ !== param1)
         {
            this._1261429194qualSpinner = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"qualSpinner",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rotator() : Rotate
      {
         return this._1384173485rotator;
      }
      
      public function set rotator(param1:Rotate) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1384173485rotator;
         if(_loc2_ !== param1)
         {
            this._1384173485rotator = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rotator",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot1() : DropDownList
      {
         return this._109532659slot1;
      }
      
      public function set slot1(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._109532659slot1;
         if(_loc2_ !== param1)
         {
            this._109532659slot1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot10() : DropDownList
      {
         return this._899454819slot10;
      }
      
      public function set slot10(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._899454819slot10;
         if(_loc2_ !== param1)
         {
            this._899454819slot10 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot10",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot11() : DropDownList
      {
         return this._899454818slot11;
      }
      
      public function set slot11(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._899454818slot11;
         if(_loc2_ !== param1)
         {
            this._899454818slot11 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot11",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot12() : DropDownList
      {
         return this._899454817slot12;
      }
      
      public function set slot12(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._899454817slot12;
         if(_loc2_ !== param1)
         {
            this._899454817slot12 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot12",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot13() : DropDownList
      {
         return this._899454816slot13;
      }
      
      public function set slot13(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._899454816slot13;
         if(_loc2_ !== param1)
         {
            this._899454816slot13 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot13",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot14() : DropDownList
      {
         return this._899454815slot14;
      }
      
      public function set slot14(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._899454815slot14;
         if(_loc2_ !== param1)
         {
            this._899454815slot14 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot14",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot2() : DropDownList
      {
         return this._109532660slot2;
      }
      
      public function set slot2(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._109532660slot2;
         if(_loc2_ !== param1)
         {
            this._109532660slot2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot3() : DropDownList
      {
         return this._109532661slot3;
      }
      
      public function set slot3(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._109532661slot3;
         if(_loc2_ !== param1)
         {
            this._109532661slot3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot4() : DropDownList
      {
         return this._109532662slot4;
      }
      
      public function set slot4(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._109532662slot4;
         if(_loc2_ !== param1)
         {
            this._109532662slot4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot5() : DropDownList
      {
         return this._109532663slot5;
      }
      
      public function set slot5(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._109532663slot5;
         if(_loc2_ !== param1)
         {
            this._109532663slot5 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot5",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot6() : DropDownList
      {
         return this._109532664slot6;
      }
      
      public function set slot6(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._109532664slot6;
         if(_loc2_ !== param1)
         {
            this._109532664slot6 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot6",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot7() : DropDownList
      {
         return this._109532665slot7;
      }
      
      public function set slot7(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._109532665slot7;
         if(_loc2_ !== param1)
         {
            this._109532665slot7 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot7",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot8() : DropDownList
      {
         return this._109532666slot8;
      }
      
      public function set slot8(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._109532666slot8;
         if(_loc2_ !== param1)
         {
            this._109532666slot8 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot8",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get slot9() : DropDownList
      {
         return this._109532667slot9;
      }
      
      public function set slot9(param1:DropDownList) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._109532667slot9;
         if(_loc2_ !== param1)
         {
            this._109532667slot9 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slot9",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get statGrid() : DataGrid
      {
         return this._1317321658statGrid;
      }
      
      public function set statGrid(param1:DataGrid) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1317321658statGrid;
         if(_loc2_ !== param1)
         {
            this._1317321658statGrid = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statGrid",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get statLabel() : Label
      {
         return this._2108596992statLabel;
      }
      
      public function set statLabel(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2108596992statLabel;
         if(_loc2_ !== param1)
         {
            this._2108596992statLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tabs() : TabNavigator
      {
         return this._3552126tabs;
      }
      
      public function set tabs(param1:TabNavigator) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._3552126tabs;
         if(_loc2_ !== param1)
         {
            this._3552126tabs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tabs",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get techCheck() : CheckBox
      {
         return this._1429921810techCheck;
      }
      
      public function set techCheck(param1:CheckBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1429921810techCheck;
         if(_loc2_ !== param1)
         {
            this._1429921810techCheck = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"techCheck",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get techGrid() : DataGrid
      {
         return this._1616312580techGrid;
      }
      
      public function set techGrid(param1:DataGrid) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1616312580techGrid;
         if(_loc2_ !== param1)
         {
            this._1616312580techGrid = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"techGrid",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get techTab() : NavigatorContent
      {
         return this._1437600481techTab;
      }
      
      public function set techTab(param1:NavigatorContent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1437600481techTab;
         if(_loc2_ !== param1)
         {
            this._1437600481techTab = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"techTab",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleImg() : Image
      {
         return this._1870021045titleImg;
      }
      
      public function set titleImg(param1:Image) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1870021045titleImg;
         if(_loc2_ !== param1)
         {
            this._1870021045titleImg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleImg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get topPanel() : Panel
      {
         return this._980425297topPanel;
      }
      
      public function set topPanel(param1:Panel) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._980425297topPanel;
         if(_loc2_ !== param1)
         {
            this._980425297topPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get urlField() : TextInput
      {
         return this._993593141urlField;
      }
      
      public function set urlField(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._993593141urlField;
         if(_loc2_ !== param1)
         {
            this._993593141urlField = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"urlField",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get valCol() : DataGridColumn
      {
         return this._823860577valCol;
      }
      
      public function set valCol(param1:DataGridColumn) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._823860577valCol;
         if(_loc2_ !== param1)
         {
            this._823860577valCol = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"valCol",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleBar() : Class
      {
         return this._1870028133titleBar;
      }
      
      public function set titleBar(param1:Class) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1870028133titleBar;
         if(_loc2_ !== param1)
         {
            this._1870028133titleBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get bgFill() : Bitmap
      {
         return this._1391998104bgFill;
      }
      
      private function set bgFill(param1:Bitmap) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1391998104bgFill;
         if(_loc2_ !== param1)
         {
            this._1391998104bgFill = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgFill",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get statData() : ArrayCollection
      {
         return this._1317216286statData;
      }
      
      private function set statData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1317216286statData;
         if(_loc2_ !== param1)
         {
            this._1317216286statData = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statData",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get statData2() : ArrayCollection
      {
         return this._2115968044statData2;
      }
      
      private function set statData2(param1:ArrayCollection) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2115968044statData2;
         if(_loc2_ !== param1)
         {
            this._2115968044statData2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statData2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get techData() : ArrayCollection
      {
         return this._1616417952techData;
      }
      
      private function set techData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1616417952techData;
         if(_loc2_ !== param1)
         {
            this._1616417952techData = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"techData",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get isWillow() : Boolean
      {
         return this._113769724isWillow;
      }
      
      private function set isWillow(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._113769724isWillow;
         if(_loc2_ !== param1)
         {
            this._113769724isWillow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isWillow",_loc2_,param1));
            }
         }
      }
   }
}

