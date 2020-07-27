 
package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import scaleform.gfx.Extensions;
   
   public class HUDWorkshopMarkers extends BSUIComponent
   {
      
      private static const DATA_PROVIDER_KEY:String = // method body index: 2927 method index: 2927
      "WorkshopMarkers";
       
      
      private var MarkerMCs:Vector.<WorkshopMarker>;
      
      private var MarkersData:Array;
      
      public function HUDWorkshopMarkers()
      {

         super();
         Extensions.enabled = true;
         this.MarkerMCs = new Vector.<WorkshopMarker>();
      }
      
      override public function onAddedToStage() : void
      {

         super.onAddedToStage();
         BSUIDataManager.Subscribe(DATA_PROVIDER_KEY,this.onMarkersUpdated);
      }
      
      public function onMarkersUpdated(param1:FromClientDataEvent) : void
      {

         this.MarkersData = param1.data.markersA;
         SetIsDirty();
      }
      
      override public function redrawUIComponent() : void
      {

         var _loc1_:WorkshopMarker = null;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.MarkersData.length)
         {
            if(_loc3_ < this.MarkerMCs.length)
            {
               _loc1_ = this.MarkerMCs[_loc3_];
            }
            else
            {
               _loc1_ = new WorkshopMarker();
               addChild(_loc1_);
               this.MarkerMCs.push(_loc1_);
            }
            _loc2_ = this.MarkersData[_loc3_];
            _loc1_.x = _loc2_.fScreenX;
            _loc1_.y = _loc2_.fScreenY;
            _loc1_.Update(_loc2_.strDisplayName,_loc2_.strStateName,_loc2_.fCapturePct,_loc2_.bIsOffScreen,_loc2_.bPlayerInContestRadius);
            _loc3_++;
         }
         var _loc4_:int = _loc3_;
         while(_loc4_ < this.MarkerMCs.length)
         {
            removeChild(this.MarkerMCs[_loc4_]);
            _loc4_++;
         }
         this.MarkerMCs.length = _loc3_;
      }
   }
}
