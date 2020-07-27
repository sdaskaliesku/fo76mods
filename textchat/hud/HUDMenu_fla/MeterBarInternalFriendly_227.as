 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   public dynamic class MeterBarInternalFriendly_227 extends MovieClip
   {
       
      
      public var Contents:MovieClip;
      
      public function MeterBarInternalFriendly_227()
      {
         // method body index: 1082 method index: 1082
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,15,this.frame16,20,this.frame21,25,this.frame26,30,this.frame31,35,this.frame36,39,this.frame40);
      }
      
      function frame1() : *
      {
         // method body index: 1083 method index: 1083
         stop();
      }
      
      function frame6() : *
      {
         // method body index: 1084 method index: 1084
         stop();
      }
      
      function frame11() : *
      {
         // method body index: 1085 method index: 1085
         this["onBarFlashedDark"]();
      }
      
      function frame16() : *
      {
         // method body index: 1086 method index: 1086
         this["onBarFlashedBright"]();
      }
      
      function frame21() : *
      {
         // method body index: 1087 method index: 1087
         this["onBarFlashedDark"]();
      }
      
      function frame26() : *
      {
         // method body index: 1088 method index: 1088
         this["onBarFlashedBright"]();
      }
      
      function frame31() : *
      {
         // method body index: 1089 method index: 1089
         this["onBarFlashedDark"]();
      }
      
      function frame36() : *
      {
         // method body index: 1090 method index: 1090
         this["onBarFlashedBright"]();
      }
      
      function frame40() : *
      {
         // method body index: 1091 method index: 1091
         this["onBarFlashingDone"]();
      }
   }
}
