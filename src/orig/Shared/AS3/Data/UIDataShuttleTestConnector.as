 
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
         // method body index: 267 method index: 267
         super();
      }
      
      override public function Watch(aProviderName:String, existingDataShuttle:UIDataFromClient = null) : UIDataFromClient
      {
         // method body index: 263 method index: 263
         var fromClient:UIDataFromClient = new UIDataFromClient(new Object());
         var tempLoader:TestProviderLoader = new TestProviderLoader(aProviderName,fromClient);
         tempLoader.addEventListener(Event.COMPLETE,this.onLoadComplete);
         tempLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadFailedPrimaryLocation);
         tempLoader.load(new URLRequest("Providers/" + aProviderName + ".json"));
         fromClient.isTest = true;
         return fromClient;
      }
      
      function onLoadComplete(e:Event) : void
      {
         // method body index: 264 method index: 264
         var key:* = null;
         var testLoader:TestProviderLoader = e.target as TestProviderLoader;
         var fromClient:UIDataFromClient = testLoader.fromClient;
         var data:Object = new JSONDecoder(testLoader.data,true).getValue();
         var payloadData:Object = fromClient.data;
         for(key in data)
         {
            payloadData[key] = data[key];
         }
         testLoader.fromClient.SetReady();
      }
      
      function onLoadFailedPrimaryLocation(e:IOErrorEvent) : *
      {
         // method body index: 265 method index: 265
         var loader:TestProviderLoader = e.target as TestProviderLoader;
         var tempLoader:* = new TestProviderLoader(loader.providerName,loader.fromClient);
         tempLoader.addEventListener(Event.COMPLETE,this.onLoadComplete);
         tempLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadFailed);
         tempLoader.load(new URLRequest("../Interface/Providers/" + loader.providerName + ".json"));
      }
      
      function onLoadFailed(e:IOErrorEvent) : *
      {
         // method body index: 266 method index: 266
         var loader:TestProviderLoader = TestProviderLoader(e.target);
         var providerName:String = loader.providerName;
         trace("WARNING - UIDataShuttleTestConnector.onLoadFailed - TEST PROVIDER: " + providerName + " NOT FOUND");
      }
   }
}
