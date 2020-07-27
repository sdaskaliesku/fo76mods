 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class MeterBarInternalEnemy_231 extends MovieClip
   {
       
      
      public var Contents:MovieClip;
      
      public function MeterBarInternalEnemy_231()
      {
         // method body index: 1070 method index: 1070
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,15,this.frame16,20,this.frame21,25,this.frame26,30,this.frame31,35,this.frame36,39,this.frame40);
      }
      
      function frame1() : *
      {
         // method body index: 1071 method index: 1071
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 1072 method index: 1072
         stop();
      }
      
      function frame11() : *
      {
         // method body index: 1073 method index: 1073
         this["onBarFlashedDark"]();
      }
      
      function frame16() : *
      {
         // method body index: 1074 method index: 1074
         this["onBarFlashedBright"]();
      }
      
      function frame21() : *
      {
         // method body index: 1075 method index: 1075
         this["onBarFlashedDark"]();
      }
      
      function frame26() : *
      {
         // method body index: 1076 method index: 1076
         this["onBarFlashedBright"]();
      }
      
      function frame31() : *
      {
         // method body index: 1077 method index: 1077
         this["onBarFlashedDark"]();
      }
      
      function frame36() : *
      {
         // method body index: 1078 method index: 1078
         this["onBarFlashedBright"]();
      }
      
      function frame40() : *
      {
         // method body index: 1079 method index: 1079
         this["onBarFlashingDone"]();
      }
   }
}
