package
{
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _GearCalcAppWatcherSetupUtil implements IWatcherSetupUtil2
   {
      
      public function _GearCalcAppWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         GearCalcApp.watcherSetupUtil = new _GearCalcAppWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[7] = new PropertyWatcher("blackShadow",{"propertyChange":true},[param4[8]],param2);
         param5[4] = new PropertyWatcher("statData2",{"propertyChange":true},[param4[3]],param2);
         param5[1] = new PropertyWatcher("techData",{"propertyChange":true},[param4[1]],param2);
         param5[2] = new PropertyWatcher("levelSlider",{"propertyChange":true},[param4[2]],param2);
         param5[3] = new PropertyWatcher("value",{"valueCommit":true},[param4[2]],null);
         param5[8] = new PropertyWatcher("isWillow",{"propertyChange":true},[param4[9]],param2);
         param5[6] = new PropertyWatcher("modeGroup",{"propertyChange":true},[param4[5],param4[6],param4[7]],param2);
         param5[0] = new PropertyWatcher("bgFill",{"propertyChange":true},[param4[0]],param2);
         param5[5] = new PropertyWatcher("titleBar",{"propertyChange":true},[param4[4]],param2);
         param5[7].updateParent(param1);
         param5[4].updateParent(param1);
         param5[1].updateParent(param1);
         param5[2].updateParent(param1);
         param5[2].addChild(param5[3]);
         param5[8].updateParent(param1);
         param5[6].updateParent(param1);
         param5[0].updateParent(param1);
         param5[5].updateParent(param1);
      }
   }
}

