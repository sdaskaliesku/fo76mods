 
package Overlay.PublicTeams
{
   import Shared.AS3.SWFLoaderClip;
   
   public class PublicTeamsIcon extends SWFLoaderClip
   {
       
      
      private var m_originalWidth:Number;
      
      private var m_originalHeight:Number;
      
      public function PublicTeamsIcon()
      {

         super();
         this.m_originalWidth = this.width;
         this.m_originalHeight = this.height;
      }
      
      public function setIconType(param1:uint) : void
      {

         var _loc2_:String = null;
         if(PublicTeamsShared.IsValidPublicTeamType(param1))
         {
            _loc2_ = PublicTeamsShared.DecideTeamTypeString(param1);
            this.removeChildren();
            this.setContainerIconClip("IconPT_" + _loc2_);
         }
         this.getChildAt(0).width = this.m_originalWidth / this.scaleX;
         this.getChildAt(0).height = this.m_originalHeight / this.scaleY;
      }
   }
}
