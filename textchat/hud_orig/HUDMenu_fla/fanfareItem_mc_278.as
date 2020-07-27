 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class fanfareItem_mc_278 extends MovieClip
   {
       
      
      public var FanfareItemCatcher_mc:MovieClip;
      
      public var eraser_mc:MovieClip;
      
      public function fanfareItem_mc_278()
      {

         super();
         addFrameScript(0,this.frame1,1,this.frame2,10,this.frame11,32,this.frame33,74,this.frame75,104,this.frame105);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame2() : *
      {

         this.eraser_mc.gotoAndPlay(1);
         dispatchEvent(new Event("HUDAnnounce::InitShowModel",true));
      }
      
      function frame11() : *
      {

         dispatchEvent(new Event("HUDAnnounce::ShowModel",true));
      }
      
      function frame33() : *
      {

         stop();
      }
      
      function frame75() : *
      {

         this.eraser_mc.gotoAndPlay(1);
      }
      
      function frame105() : *
      {

         stop();
         dispatchEvent(new Event("HUDAnnounce::ClearModel",true));
      }
   }
}
