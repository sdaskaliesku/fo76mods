 
package Overlay.PublicTeams
{
   import Shared.AS3.SWFLoaderClip;
   
   public class PublicTeamsIcon extends SWFLoaderClip
   {
       
      
      private var m_originalWidth:Number;
      
      private var m_originalHeight:Number;
      
      public function PublicTeamsIcon()
      {
         // method body index: 2747 method index: 2747
         super();
         this.m_originalWidth = this.width;
         this.m_originalHeight = this.height;
      }
      
      public function setIconType(aTeamType:uint) : void
      {
         // method body index: 2748 method index: 2748
         var typeString:String = null;
         if(PublicTeamsShared.IsValidPublicTeamType(aTeamType))
         {
            typeString = PublicTeamsShared.DecideTeamTypeString(aTeamType);
            this.removeChildren();
            this.setContainerIconClip("IconPT_" + typeString);
         }
         this.getChildAt(0).width = this.m_originalWidth / this.scaleX;
         this.getChildAt(0).height = this.m_originalHeight / this.scaleY;
      }
   }
}
