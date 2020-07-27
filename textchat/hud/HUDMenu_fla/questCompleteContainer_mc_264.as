 
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

         this.__setTabDict = new Dictionary(true);
         super();
         addFrameScript(0,this.frame1,17,this.frame18,18,this.frame19,59,this.frame60,79,this.frame80,80,this.frame81,132,this.frame133,173,this.frame174,214,this.frame215);
         addEventListener(Event.FRAME_CONSTRUCTED,this.__setTab_handler,false,0,true);
      }
      
      function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_58(param1:int) : *
      {

         if(this.FanfareType_mc != null && param1 >= 59 && param1 <= 60 && (this.__setTabDict[this.FanfareType_mc] == undefined || !(int(this.__setTabDict[this.FanfareType_mc]) >= 59 && int(this.__setTabDict[this.FanfareType_mc]) <= 60)))
         {
            this.__setTabDict[this.FanfareType_mc] = param1;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_132() : *
      {

         if(this.__setTabDict[this.FanfareType_mc] == undefined || int(this.__setTabDict[this.FanfareType_mc]) != 133)
         {
            this.__setTabDict[this.FanfareType_mc] = 133;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_213(param1:int) : *
      {

         if(this.FanfareType_mc != null && param1 >= 214 && param1 <= 215 && (this.__setTabDict[this.FanfareType_mc] == undefined || !(int(this.__setTabDict[this.FanfareType_mc]) >= 214 && int(this.__setTabDict[this.FanfareType_mc]) <= 215)))
         {
            this.__setTabDict[this.FanfareType_mc] = param1;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      function __setTab_handler(param1:Object) : *
      {

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

         stop();
      }
      
      function frame18() : *
      {

         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame19() : *
      {

         stop();
      }
      
      function frame60() : *
      {

         stop();
      }
      
      function frame80() : *
      {

         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame81() : *
      {

         stop();
      }
      
      function frame133() : *
      {

         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_132();
         stop();
      }
      
      function frame174() : *
      {

         stop();
      }
      
      function frame215() : *
      {

         stop();
      }
   }
}
