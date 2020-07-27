 
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
         // method body index: 1678 method index: 1678
         this.__setTabDict = new Dictionary(true);
         super();
         addFrameScript(0,this.frame1,17,this.frame18,18,this.frame19,59,this.frame60,79,this.frame80,80,this.frame81,132,this.frame133,173,this.frame174,214,this.frame215);
         addEventListener(Event.FRAME_CONSTRUCTED,this.__setTab_handler,false,0,true);
      }
      
      function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_58(param1:int) : *
      {
         // method body index: 1679 method index: 1679
         if(this.FanfareType_mc != null && param1 >= 59 && param1 <= 60 && (this.__setTabDict[this.FanfareType_mc] == undefined || !(int(this.__setTabDict[this.FanfareType_mc]) >= 59 && int(this.__setTabDict[this.FanfareType_mc]) <= 60)))
         {
            this.__setTabDict[this.FanfareType_mc] = param1;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_132() : *
      {
         // method body index: 1680 method index: 1680
         if(this.__setTabDict[this.FanfareType_mc] == undefined || int(this.__setTabDict[this.FanfareType_mc]) != 133)
         {
            this.__setTabDict[this.FanfareType_mc] = 133;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_213(param1:int) : *
      {
         // method body index: 1681 method index: 1681
         if(this.FanfareType_mc != null && param1 >= 214 && param1 <= 215 && (this.__setTabDict[this.FanfareType_mc] == undefined || !(int(this.__setTabDict[this.FanfareType_mc]) >= 214 && int(this.__setTabDict[this.FanfareType_mc]) <= 215)))
         {
            this.__setTabDict[this.FanfareType_mc] = param1;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      function __setTab_handler(param1:Object) : *
      {
         // method body index: 1682 method index: 1682
         var _loc2_:int = currentFrame;
         if(this.__lastFrameTab == _loc2_)
         {
            return;
         }
         this.__lastFrameTab = _loc2_;
         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_58(_loc2_);
         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_213(_loc2_);
      }
      
      function frame1() : *
      {
         // method body index: 1683 method index: 1683
         stop();
      }
      
      function frame18() : *
      {
         // method body index: 1684 method index: 1684
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame19() : *
      {
         // method body index: 1685 method index: 1685
         stop();
      }
      
      function frame60() : *
      {
         // method body index: 1686 method index: 1686
         stop();
      }
      
      function frame80() : *
      {
         // method body index: 1687 method index: 1687
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame81() : *
      {
         // method body index: 1688 method index: 1688
         stop();
      }
      
      function frame133() : *
      {
         // method body index: 1689 method index: 1689
         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_132();
         stop();
      }
      
      function frame174() : *
      {
         // method body index: 1690 method index: 1690
         stop();
      }
      
      function frame215() : *
      {
         // method body index: 1691 method index: 1691
         stop();
      }
   }
}
