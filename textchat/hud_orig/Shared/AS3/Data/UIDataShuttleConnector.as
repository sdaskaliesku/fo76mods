 
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

         var connectedShuttle:UIDataShuttleConnector = BSUIDataManager.ConnectDataShuttleConnector(this);
         return connectedShuttle == this;
      }
      
      public function Watch(aProviderName:String, existingDataShuttle:UIDataFromClient = null) : UIDataFromClient
      {

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

         BSUIDataManager.Flush(args);
      }
   }
}
