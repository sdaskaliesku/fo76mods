 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class AnnouceMessageText_271 extends MovieClip
   {
       
      
      public var Text_mc:MovieClip;
      
      public function AnnouceMessageText_271()
      {
         // method body index: 970 method index: 970
         super();
         addFrameScript(0,this.frame1,50,this.frame51,199,this.frame200,239,this.frame240);
      }
      
      function frame1() : *
      {
         // method body index: 966 method index: 966
         stop();
      }
      
      function frame51() : *
      {
         // method body index: 967 method index: 967
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame200() : *
      {
         // method body index: 968 method index: 968
         stop();
      }
      
      function frame240() : *
      {
         // method body index: 969 method index: 969
         stop();
      }
   }
}
