 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public dynamic class questCompleteContainer_mc_264 extends MovieClip
   {
       
      
      public var FanfareDescription_mc:MovieClip;
      
      public var FanfareName_mc:MovieClip;
      
      public var FanfareQuestCompleted_mc:MovieClip;
      
      public var FanfareType_mc:MovieClip;
      
      public var __setTabDict:Dictionary;
      
      public var __lastFrameTab:int = -1;
      
      public function questCompleteContainer_mc_264()
      {
         // method body index: 1765 method index: 1765
         this.__setTabDict = new Dictionary(true);
         super();
         addFrameScript(0,this.frame1,17,this.frame18,18,this.frame19,59,this.frame60,79,this.frame80,80,this.frame81,132,this.frame133,173,this.frame174,214,this.frame215);
         addEventListener(Event.FRAME_CONSTRUCTED,this.__setTab_handler,false,0,true);
      }
      
      function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_58(curFrame:int) : *
      {
         // method body index: 1752 method index: 1752
         if(this.FanfareType_mc != null && curFrame >= 59 && curFrame <= 60 && (this.__setTabDict[this.FanfareType_mc] == undefined || !(int(this.__setTabDict[this.FanfareType_mc]) >= 59 && int(this.__setTabDict[this.FanfareType_mc]) <= 60)))
         {
            this.__setTabDict[this.FanfareType_mc] = curFrame;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_132() : *
      {
         // method body index: 1753 method index: 1753
         if(this.__setTabDict[this.FanfareType_mc] == undefined || int(this.__setTabDict[this.FanfareType_mc]) != 133)
         {
            this.__setTabDict[this.FanfareType_mc] = 133;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_213(curFrame:int) : *
      {
         // method body index: 1754 method index: 1754
         if(this.FanfareType_mc != null && curFrame >= 214 && curFrame <= 215 && (this.__setTabDict[this.FanfareType_mc] == undefined || !(int(this.__setTabDict[this.FanfareType_mc]) >= 214 && int(this.__setTabDict[this.FanfareType_mc]) <= 215)))
         {
            this.__setTabDict[this.FanfareType_mc] = curFrame;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      function __setTab_handler(e:Object) : *
      {
         // method body index: 1755 method index: 1755
         var curFrame:int = currentFrame;
         if(this.__lastFrameTab == curFrame)
         {
            return;
         }
         this.__lastFrameTab = curFrame;
         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_58(curFrame);
         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_213(curFrame);
      }
      
      function frame1() : *
      {
         // method body index: 1756 method index: 1756
         stop();
      }
      
      function frame18() : *
      {
         // method body index: 1757 method index: 1757
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame19() : *
      {
         // method body index: 1758 method index: 1758
         stop();
      }
      
      function frame60() : *
      {
         // method body index: 1759 method index: 1759
         stop();
      }
      
      function frame80() : *
      {
         // method body index: 1760 method index: 1760
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame81() : *
      {
         // method body index: 1761 method index: 1761
         stop();
      }
      
      function frame133() : *
      {
         // method body index: 1762 method index: 1762
         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_132();
         stop();
      }
      
      function frame174() : *
      {
         // method body index: 1763 method index: 1763
         stop();
      }
      
      function frame215() : *
      {
         // method body index: 1764 method index: 1764
         stop();
      }
   }
}
