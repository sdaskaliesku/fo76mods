 
package Shared.AS3.Data
{
   import com.adobe.serialization.json.JSONDecoder;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class UIDataShuttleTestConnector extends UIDataShuttleConnector
   {
       
      
      public function UIDataShuttleTestConnector()
      {
         // method body index: 213 method index: 213
         super();
      }
      
      override public function Watch(param1:String, param2:UIDataFromClient = null) : UIDataFromClient
      {
         // method body index: 209 method index: 209
         var _loc3_:UIDataFromClient = new UIDataFromClient(new Object());
         var _loc4_:TestProviderLoader = new TestProviderLoader(param1,_loc3_);
         _loc4_.addEventListener(Event.COMPLETE,this.onLoadComplete);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadFailedPrimaryLocation);
         _loc4_.load(new URLRequest("Providers/" + param1 + ".json"));
         _loc3_.isTest = true;
         return _loc3_;
      }
      
      function onLoadComplete(param1:Event) : void
      {
         // method body index: 210 method index: 210
         var _loc6_:* = null;
         var _loc2_:TestProviderLoader = param1.target as TestProviderLoader;
         var _loc3_:UIDataFromClient = _loc2_.fromClient;
         var _loc4_:Object = new JSONDecoder(_loc2_.data,true).getValue();
         var _loc5_:Object = _loc3_.data;
         for(_loc6_ in _loc4_)
         {
            _loc5_[_loc6_] = _loc4_[_loc6_];
         }
         _loc2_.fromClient.SetReady();
      }
      
      function onLoadFailedPrimaryLocation(param1:IOErrorEvent) : *
      {
         // method body index: 211 method index: 211
         var _loc2_:TestProviderLoader = param1.target as TestProviderLoader;
         var _loc3_:* = new TestProviderLoader(_loc2_.providerName,_loc2_.fromClient);
         _loc3_.addEventListener(Event.COMPLETE,this.onLoadComplete);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadFailed);
         _loc3_.load(new URLRequest("../Interface/Providers/" + _loc2_.providerName + ".json"));
      }
      
      function onLoadFailed(param1:IOErrorEvent) : *
      {
         // method body index: 212 method index: 212
         var _loc2_:TestProviderLoader = TestProviderLoader(param1.target);
         var _loc3_:String = _loc2_.providerName;
         trace("WARNING - UIDataShuttleTestConnector.onLoadFailed - TEST PROVIDER: " + _loc3_ + " NOT FOUND");
      }
   }
}
