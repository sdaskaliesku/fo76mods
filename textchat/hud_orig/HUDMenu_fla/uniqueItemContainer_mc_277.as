 
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
         // method body index: 1960 method index: 1960
         super();
         addFrameScript(0,this.frame1,21,this.frame22,56,this.frame57,63,this.frame64,118,this.frame119,119,this.frame120,149,this.frame150);
      }
      
      function frame1() : *
      {
         // method body index: 1953 method index: 1953
         stop();
      }
      
      function frame22() : *
      {
         // method body index: 1954 method index: 1954
         this.FanfareItem_mc.gotoAndPlay("rollOn");
      }
      
      function frame57() : *
      {
         // method body index: 1955 method index: 1955
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame64() : *
      {
         // method body index: 1956 method index: 1956
         if(this.FanfareDescription_mc.FanfareDescription_tf.text.length == 0)
         {
            stop();
         }
      }
      
      function frame119() : *
      {
         // method body index: 1957 method index: 1957
         stop();
      }
      
      function frame120() : *
      {
         // method body index: 1958 method index: 1958
         this.FanfareItem_mc.gotoAndPlay("rollOff");
      }
      
      function frame150() : *
      {
         // method body index: 1959 method index: 1959
         stop();
      }
   }
}
