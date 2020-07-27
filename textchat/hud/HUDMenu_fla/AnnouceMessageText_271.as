 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class AnnouceMessageText_271 extends MovieClip
   {
       
      
      public var Text_mc:MovieClip;
      
      public function AnnouceMessageText_271()
      {

         super();
         addFrameScript(0,this.frame1,50,this.frame51,199,this.frame200,239,this.frame240);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame51() : *
      {

         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame200() : *
      {

         stop();
      }
      
      function frame240() : *
      {

         stop();
      }
   }
}
