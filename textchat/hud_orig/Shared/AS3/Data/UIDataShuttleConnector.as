 
package Shared.AS3.Data
{
   public class UIDataShuttleConnector
   {
       
      
      public var _Watch:Function;
      
      public var _RemoveWatch:Function;
      
      public function UIDataShuttleConnector()
      {
         // method body index: 268 method index: 268
         super();
      }
      
      public function AttachToDataManager() : Boolean
      {
         // method body index: 265 method index: 265
         var connectedShuttle:UIDataShuttleConnector = BSUIDataManager.ConnectDataShuttleConnector(this);
         return connectedShuttle == this;
      }
      
      public function Watch(aProviderName:String, existingDataShuttle:UIDataFromClient = null) : UIDataFromClient
      {
         // method body index: 266 method index: 266
         var k:* = null;
         var payload:Object = new Object();
         var fromClient:UIDataFromClient = existingDataShuttle;
         if(!fromClient)
         {
            fromClient = new UIDataFromClient(payload);
         }
         else
         {
            payload = fromClient.data;
            for(k in payload)
            {
               payload[k] = undefined;
            }
         }
         if(this._Watch(aProviderName,payload))
         {
            fromClient.isTest = false;
            fromClient.SetReady();
            return fromClient;
         }
         return null;
      }
      
      public function onFlush(... args) : void
      {
         // method body index: 267 method index: 267
         BSUIDataManager.Flush(args);
      }
   }
}
