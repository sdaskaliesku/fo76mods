 
package Shared.AS3.Data
{
   public class UIDataShuttleConnector
   {
       
      
      public var _Watch:Function;
      
      public var _RemoveWatch:Function;
      
      public function UIDataShuttleConnector()
      {
         // method body index: 83 method index: 83
         super();
      }
      
      public function AttachToDataManager() : Boolean
      {
         // method body index: 80 method index: 80
         var _loc1_:UIDataShuttleConnector = BSUIDataManager.ConnectDataShuttleConnector(this);
         return _loc1_ == this;
      }
      
      public function Watch(param1:String, param2:UIDataFromClient = null) : UIDataFromClient
      {
         // method body index: 81 method index: 81
         var _loc5_:* = null;
         var _loc3_:Object = new Object();
         var _loc4_:UIDataFromClient = param2;
         if(!_loc4_)
         {
            _loc4_ = new UIDataFromClient(_loc3_);
         }
         else
         {
            _loc3_ = _loc4_.data;
            for(_loc5_ in _loc3_)
            {
               _loc3_[_loc5_] = undefined;
            }
         }
         if(this._Watch(param1,_loc3_))
         {
            _loc4_.isTest = false;
            _loc4_.SetReady();
            return _loc4_;
         }
         return null;
      }
      
      public function onFlush(... rest) : void
      {
         // method body index: 82 method index: 82
         BSUIDataManager.Flush(rest);
      }
   }
}
