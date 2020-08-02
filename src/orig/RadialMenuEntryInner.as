 
package
{
   import flash.display.MovieClip;
   
   public class RadialMenuEntryInner extends RadialMenuEntry
   {
       
      
      public var Expanded_mc:MovieClip;
      
      public var Fill_mc:MovieClip;
      
      private var m_FillPercent:Number = 0;
      
      private var m_Expanded:Boolean = false;
      
      public function RadialMenuEntryInner()
      {
         // method body index: 1678 method index: 1678
         super();
         addFrameScript(1,this.frame2,2,this.frame3,14,this.frame15,20,this.frame21);
         m_IconClip = Icon_mc.Body;
         m_IconClip.clipScale = 1;
         m_IconClip.clipAlpha = 1;
         m_IconClip.parent.rotation = -this.rotation;
         Hotkey_mc.rotation = -this.rotation;
         m_IconClip.clipWidth = m_IconClip.width;
         m_IconClip.clipHeight = m_IconClip.height;
         m_IconClip.centerClip = true;
      }
      
      public function set fillPercent(aPercent:Number) : *
      {
         // method body index: 1672 method index: 1672
         this.m_FillPercent = aPercent;
         this.Fill_mc.gotoAndStop(Math.ceil(this.m_FillPercent * 75));
      }
      
      public function get fillPercent() : Number
      {
         // method body index: 1673 method index: 1673
         return this.m_FillPercent;
      }
      
      private function updateState() : *
      {
         // method body index: 1674 method index: 1674
         if(m_Selected)
         {
            gotoAndPlay("selectorFadeOn");
         }
         else
         {
            this.fillPercent = 0;
            gotoAndPlay("selectorFadeOff");
         }
      }
      
      override public function set selected(aSelected:Boolean) : *
      {
         // method body index: 1675 method index: 1675
         if(m_Selected != aSelected)
         {
            m_Selected = aSelected;
            this.updateState();
            updateIconState();
         }
      }
      
      public function set expanded(aExpanded:Boolean) : *
      {
         // method body index: 1676 method index: 1676
         this.m_Expanded = aExpanded;
         this.updateState();
         SetIsDirty();
      }
      
      public function get expanded() : Boolean
      {
         // method body index: 1677 method index: 1677
         return this.m_Expanded;
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 1679 method index: 1679
         super.redrawUIComponent();
         Hotkey_mc.visible = !this.m_Expanded && m_ShowKeyLabel;
      }
      
      function frame2() : *
      {
         // method body index: 1680 method index: 1680
         stop();
      }
      
      function frame3() : *
      {
         // method body index: 1681 method index: 1681
         stop();
      }
      
      function frame15() : *
      {
         // method body index: 1682 method index: 1682
         stop();
      }
      
      function frame21() : *
      {
         // method body index: 1683 method index: 1683
         stop();
      }
   }
}
