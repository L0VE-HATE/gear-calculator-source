package gearcalc
{
   public class Version
   {
      
      public static const NUMBER:String = "v0.9.1";
      
      public static const NUMBER_2:String = "v0.9.2";
      
      public static const NUMBER_3:String = "v0.9.3";
      
      public static const NUMBER_4:String = "v0.9.4";
      
      public static const NUMBER_5:String = "v0.9.5";
      
      public static const NUMBER_6:String = "v0.9.6";
      
      public static const NUMBER_7:String = "v0.9.6.5";
      
      public static const NUMBER_8:String = "v0.9.6.8";
      
      public static const NUMBER_9:String = "v0.9.6.9";
      
      public static const NUMBER_10:String = "v0.9.7.3";
      
      public static const NUMBER_11:String = "v0.9.7.4";
      
      public static const NUMBER_12:String = "v1.0.1.4";
      
      public static const NUMBER_13:String = "v1.0.1.5";
      
      public static const NUMBER_14:String = "v1.1.0";
      
      public static const NUMBER_15:String = "v1.2.0";
      
      public static const NUMBER_16:String = "v1.2.5";
      
      public static const NUMBER_17:String = "v1.2.8";
      
      public static const AUTHOR:String = "duncanfogg";
      
      public static const SEPARATOR:String = "\n------------------------------\n\n";
      
      public static var notes:* = "GEAR CALCULATOR by " + AUTHOR;
      
      addSection(NUMBER_17);
      addLine("Full Eridian support added.");
      addSection(NUMBER_16);
      addLine("Direct export of cards to ImageShack added");
      addLine("Cracked Sash fixed");
      addLine("Infinity percent bugs fixed");
      addLine("Support for future WillowTree bridge added");
      addSection(NUMBER_15);
      addLine("FULL shield support added");
      addLine("Crit damage fixed");
      addLine("Grip/Material/Manufacturer lists properly linked");
      addSection(NUMBER_14);
      addLine("Auto-naming and tech calc preferences now saved for future visits");
      addLine("URLs linking directly to a specific gun build are now generated");
      addLine("Option to enable the auto-load of user\'s last build during a previous visit");
      addLine("Part previews are now shown in the log area");
      addLine("Export of weapon card and stats as BBCode added");
      addLine("Weapon card contents adjusted, rescaled");
      addLine("Tweaked a few naming errors, shotgun pricing fixed");
      addLine("A few minor UI tweaks for convenience (click-to-copy, etc.)");
      
      public function Version()
      {
         super();
      }
      
      private static function addSection(param1:String) : void
      {
         notes += SEPARATOR + param1 + " Notes:\n";
      }
      
      private static function addLine(param1:String) : void
      {
         notes += "> " + param1 + "\n";
      }
   }
}

