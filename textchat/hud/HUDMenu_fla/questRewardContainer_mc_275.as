 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class questRewardContainer_mc_275 extends MovieClip
   {
       
      
      public var FanfareName_mc1:MovieClip;
      
      public var FanfareName_mc2:MovieClip;
      
      public var FanfareName_mc3:MovieClip;
      
      public var FanfareName_mc4:MovieClip;
      
      public var FanfareName_mc5:MovieClip;
      
      public var FanfareName_mc6:MovieClip;
      
      public var FanfareType_mc:MovieClip;
      
      public function questRewardContainer_mc_275()
      {
         // method body index: 1698 method index: 1698
         super();
         addFrameScript(0,this.frame1,27,this.frame28,44,this.frame45,61,this.frame62,75,this.frame76,88,this.frame89,99,this.frame100,110,this.frame111,112,this.frame113,131,this.frame132,134,this.frame135,165,this.frame166);
      }
      
      function frame1() : *
      {
         // method body index: 1699 method index: 1699
         stop();
      }
      
      function frame28() : *
      {
         // method body index: 1700 method index: 1700
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame45() : *
      {
         // method body index: 1701 method index: 1701
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound1",true));
      }
      
      function frame62() : *
      {
         // method body index: 1702 method index: 1702
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound2",true));
      }
      
      function frame76() : *
      {
         // method body index: 1703 method index: 1703
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound3",true));
      }
      
      function frame89() : *
      {
         // method body index: 1704 method index: 1704
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound4",true));
      }
      
      function frame100() : *
      {
         // method body index: 1705 method index: 1705
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound5",true));
      }
      
      function frame111() : *
      {
         // method body index: 1706 method index: 1706
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound6",true));
      }
      
      function frame113() : *
      {
         // method body index: 1707 method index: 1707
         dispatchEvent(new Event("HUDAnnounce::ShowCurrencyReward",true));
      }
      
      function frame132() : *
      {
         // method body index: 1708 method index: 1708
         dispatchEvent(new Event("HUDAnnounce::ShowXPReward",true));
      }
      
      function frame135() : *
      {
         // method body index: 1709 method index: 1709
         stop();
      }
      
      function frame166() : *
      {
         // method body index: 1710 method index: 1710
         stop();
      }
   }
}
