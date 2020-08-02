 
package
{
   public class RadialMenuEntryOuter extends RadialMenuEntry
   {
       
      
      public function RadialMenuEntryOuter()
      {
         // method body index: 1688 method index: 1688
         super();
         addFrameScript(1,this.frame2,10,this.frame11,21,this.frame22);
         m_IconClip = Icon_mc.Body;
         m_IconClip.parent.rotation = -this.rotation;
         Hotkey_mc.rotation = -this.rotation;
         m_IconClip.clipScale = 1;
         m_IconClip.clipAlpha = 1;
         m_IconClip.clipWidth = m_IconClip.width;
         m_IconClip.clipHeight = m_IconClip.height;
         m_IconClip.centerClip = true;
      }
      
      private function updateState() : *
      {
         // method body index: 1686 method index: 1686
         if(m_ItemVisible)
         {
            if(m_Selected)
            {
               gotoAndPlay("rollOn");
            }
            else
            {
               gotoAndPlay("rollOff");
            }
         }
         else
         {
            gotoAndPlay("off");
         }
      }
      
      override public function set selected(aSelected:Boolean) : *
      {
         // method body index: 1687 method index: 1687
         if(m_Selected != aSelected)
         {
            m_Selected = aSelected;
            this.updateState();
            updateIconState();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         // method body index: 1689 method index: 1689
         super.redrawUIComponent();
         Hotkey_mc.visible = m_ShowKeyLabel;
      }
      
      function frame2() : *
      {
         // method body index: 1690 method index: 1690
         stop();
      }
      
      function frame11() : *
      {
         // method body index: 1691 method index: 1691
         stop();
      }
      
      function frame22() : *
      {
         // method body index: 1692 method index: 1692
         stop();
      }
   }
}
