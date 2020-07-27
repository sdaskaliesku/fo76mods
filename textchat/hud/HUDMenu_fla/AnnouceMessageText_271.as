 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class AnnouceMessageText_271 extends MovieClip
   {
       
      
      public var Text_mc:MovieClip;
      
      public function AnnouceMessageText_271()
      {
         // method body index: 892 method index: 892
         super();
         addFrameScript(0,this.frame1,50,this.frame51,199,this.frame200,239,this.frame240);
      }
      
      function frame1() : *
      {
         // method body index: 893 method index: 893
         stop();
      }
      
      function frame51() : *
      {
         // method body index: 894 method index: 894
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame200() : *
      {
         // method body index: 895 method index: 895
         stop();
      }
      
      function frame240() : *
      {
         // method body index: 896 method index: 896
         stop();
      }
   }
}
