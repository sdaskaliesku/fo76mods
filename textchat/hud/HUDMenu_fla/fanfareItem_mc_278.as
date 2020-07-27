 
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
         // method body index: 1522 method index: 1522
         super();
         addFrameScript(0,this.frame1,1,this.frame2,10,this.frame11,32,this.frame33,74,this.frame75,104,this.frame105);
      }
      
      function frame1() : *
      {
         // method body index: 1523 method index: 1523
         stop();
      }
      
      function frame2() : *
      {
         // method body index: 1524 method index: 1524
         this.eraser_mc.gotoAndPlay(1);
         dispatchEvent(new Event("HUDAnnounce::InitShowModel",true));
      }
      
      function frame11() : *
      {
         // method body index: 1525 method index: 1525
         dispatchEvent(new Event("HUDAnnounce::ShowModel",true));
      }
      
      function frame33() : *
      {
         // method body index: 1526 method index: 1526
         stop();
      }
      
      function frame75() : *
      {
         // method body index: 1527 method index: 1527
         this.eraser_mc.gotoAndPlay(1);
      }
      
      function frame105() : *
      {
         // method body index: 1528 method index: 1528
         stop();
         dispatchEvent(new Event("HUDAnnounce::ClearModel",true));
      }
   }
}
