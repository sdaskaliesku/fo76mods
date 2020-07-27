 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class MeterBarInternalEnemy_231 extends MovieClip
   {
       
      
      public var Contents:MovieClip;
      
      public function MeterBarInternalEnemy_231()
      {
         // method body index: 1153 method index: 1153
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,15,this.frame16,20,this.frame21,25,this.frame26,30,this.frame31,35,this.frame36,39,this.frame40);
      }
      
      function frame1() : *
      {
         // method body index: 1144 method index: 1144
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 1145 method index: 1145
         stop();
      }
      
      function frame11() : *
      {
         // method body index: 1146 method index: 1146
         this["onBarFlashedDark"]();
      }
      
      function frame16() : *
      {
         // method body index: 1147 method index: 1147
         this["onBarFlashedBright"]();
      }
      
      function frame21() : *
      {
         // method body index: 1148 method index: 1148
         this["onBarFlashedDark"]();
      }
      
      function frame26() : *
      {
         // method body index: 1149 method index: 1149
         this["onBarFlashedBright"]();
      }
      
      function frame31() : *
      {
         // method body index: 1150 method index: 1150
         this["onBarFlashedDark"]();
      }
      
      function frame36() : *
      {
         // method body index: 1151 method index: 1151
         this["onBarFlashedBright"]();
      }
      
      function frame40() : *
      {
         // method body index: 1152 method index: 1152
         this["onBarFlashingDone"]();
      }
   }
}
