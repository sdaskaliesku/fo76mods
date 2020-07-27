 
package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public dynamic class uniqueItemContainer_mc_277 extends MovieClip
   {
       
      
      public var FanfareDescription_mc:MovieClip;
      
      public var FanfareItem_mc:MovieClip;
      
      public var FanfareName_mc:MovieClip;
      
      public function uniqueItemContainer_mc_277()
      {

         super();
         addFrameScript(0,this.frame1,21,this.frame22,56,this.frame57,63,this.frame64,118,this.frame119,119,this.frame120,149,this.frame150);
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame22() : *
      {

         this.FanfareItem_mc.gotoAndPlay("rollOn");
      }
      
      function frame57() : *
      {

         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame64() : *
      {

         if(this.FanfareDescription_mc.FanfareDescription_tf.text.length == 0)
         {
            stop();
         }
      }
      
      function frame119() : *
      {

         stop();
      }
      
      function frame120() : *
      {

         this.FanfareItem_mc.gotoAndPlay("rollOff");
      }
      
      function frame150() : *
      {

         stop();
      }
   }
}
