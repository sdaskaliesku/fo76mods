 
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
         // method body index: 1602 method index: 1602
         super();
         addFrameScript(0,this.frame1,1,this.frame2,10,this.frame11,32,this.frame33,74,this.frame75,104,this.frame105);
      }
      
      function frame1() : *
      {
         // method body index: 1596 method index: 1596
         stop();
      }
      
      function frame2() : *
      {
         // method body index: 1597 method index: 1597
         this.eraser_mc.gotoAndPlay(1);
         dispatchEvent(new Event("HUDAnnounce::InitShowModel",true));
      }
      
      function frame11() : *
      {
         // method body index: 1598 method index: 1598
         dispatchEvent(new Event("HUDAnnounce::ShowModel",true));
      }
      
      function frame33() : *
      {
         // method body index: 1599 method index: 1599
         stop();
      }
      
      function frame75() : *
      {
         // method body index: 1600 method index: 1600
         this.eraser_mc.gotoAndPlay(1);
      }
      
      function frame105() : *
      {
         // method body index: 1601 method index: 1601
         stop();
         dispatchEvent(new Event("HUDAnnounce::ClearModel",true));
      }
   }
}
