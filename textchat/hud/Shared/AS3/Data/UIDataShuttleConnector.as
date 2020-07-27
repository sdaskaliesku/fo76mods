 
package Shared.AS3.Data
{
   public class UIDataShuttleConnector
   {
       
      
      public var _Watch:Function;
      
      public var _RemoveWatch:Function;
      
      public function UIDataShuttleConnector()
      {

         super();
      }
      
      public function AttachToDataManager() : Boolean
      {

         var _loc1_:UIDataShuttleConnector = BSUIDataManager.ConnectDataShuttleConnector(this);
         return _loc1_ == this;
      }
      
      public function Watch(param1:String, param2:UIDataFromClient = null) : UIDataFromClient
      {

         var _loc3_:* = null;
         var _loc4_:Object = new Object();
         var _loc5_:UIDataFromClient = param2;
         if(!_loc5_)
         {
            _loc5_ = new UIDataFromClient(_loc4_);
         }
         else
         {
            _loc4_ = _loc5_.data;
            for(_loc3_ in _loc4_)
            {
               _loc4_[_loc3_] = undefined;
            }
         }
         if(this._Watch(param1,_loc4_))
         {
            _loc5_.isTest = false;
            _loc5_.SetReady();
            return _loc5_;
         }
         return null;
      }
      
      public function onFlush(... rest) : void
      {

         BSUIDataManager.Flush(rest);
      }
   }
}
