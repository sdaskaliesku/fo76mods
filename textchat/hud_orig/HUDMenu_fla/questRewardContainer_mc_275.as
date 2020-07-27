 
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
         // method body index: 1784 method index: 1784
         super();
         addFrameScript(0,this.frame1,27,this.frame28,44,this.frame45,61,this.frame62,75,this.frame76,88,this.frame89,99,this.frame100,110,this.frame111,112,this.frame113,131,this.frame132,134,this.frame135,165,this.frame166);
      }
      
      function frame1() : *
      {
         // method body index: 1772 method index: 1772
         stop();
      }
      
      function frame28() : *
      {
         // method body index: 1773 method index: 1773
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame45() : *
      {
         // method body index: 1774 method index: 1774
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound1",true));
      }
      
      function frame62() : *
      {
         // method body index: 1775 method index: 1775
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound2",true));
      }
      
      function frame76() : *
      {
         // method body index: 1776 method index: 1776
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound3",true));
      }
      
      function frame89() : *
      {
         // method body index: 1777 method index: 1777
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound4",true));
      }
      
      function frame100() : *
      {
         // method body index: 1778 method index: 1778
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound5",true));
      }
      
      function frame111() : *
      {
         // method body index: 1779 method index: 1779
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound6",true));
      }
      
      function frame113() : *
      {
         // method body index: 1780 method index: 1780
         dispatchEvent(new Event("HUDAnnounce::ShowCurrencyReward",true));
      }
      
      function frame132() : *
      {
         // method body index: 1781 method index: 1781
         dispatchEvent(new Event("HUDAnnounce::ShowXPReward",true));
      }
      
      function frame135() : *
      {
         // method body index: 1782 method index: 1782
         stop();
      }
      
      function frame166() : *
      {
         // method body index: 1783 method index: 1783
         stop();
      }
   }
}
