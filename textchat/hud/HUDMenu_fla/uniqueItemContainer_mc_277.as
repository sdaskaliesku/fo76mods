 
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
         // method body index: 1879 method index: 1879
         super();
         addFrameScript(0,this.frame1,21,this.frame22,56,this.frame57,63,this.frame64,118,this.frame119,119,this.frame120,149,this.frame150);
      }
      
      function frame1() : *
      {
         // method body index: 1880 method index: 1880
         stop();
      }
      
      function frame22() : *
      {
         // method body index: 1881 method index: 1881
         this.FanfareItem_mc.gotoAndPlay("rollOn");
      }
      
      function frame57() : *
      {
         // method body index: 1882 method index: 1882
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      function frame64() : *
      {
         // method body index: 1883 method index: 1883
         if(this.FanfareDescription_mc.FanfareDescription_tf.text.length == 0)
         {
            stop();
         }
      }
      
      function frame119() : *
      {
         // method body index: 1884 method index: 1884
         stop();
      }
      
      function frame120() : *
      {
         // method body index: 1885 method index: 1885
         this.FanfareItem_mc.gotoAndPlay("rollOff");
      }
      
      function frame150() : *
      {
         // method body index: 1886 method index: 1886
         stop();
      }
   }
}
