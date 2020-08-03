package Shared.AS3.Data 
{
    import com.adobe.serialization.json.*;
    import flash.events.*;
    import flash.net.*;
    
    public class UIDataShuttleTestConnector extends Shared.AS3.Data.UIDataShuttleConnector
    {
        public function UIDataShuttleTestConnector()
        {
            super();
            return;
        }

        public override function Watch(arg1:String, arg2:Shared.AS3.Data.UIDataFromClient=null):Shared.AS3.Data.UIDataFromClient
        {
            var loc1:*=new Shared.AS3.Data.UIDataFromClient(new Object());
            var loc2:*;
            (loc2 = new Shared.AS3.Data.TestProviderLoader(arg1, loc1)).addEventListener(flash.events.Event.COMPLETE, this.onLoadComplete);
            loc2.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLoadFailedPrimaryLocation);
            loc2.load(new flash.net.URLRequest("Providers/" + arg1 + ".json"));
            loc1.isTest = true;
            return loc1;
        }

        function onLoadComplete(arg1:flash.events.Event):void
        {
            var loc5:*=null;
            var loc1:*=arg1.target as Shared.AS3.Data.TestProviderLoader;
            var loc2:*=loc1.fromClient;
            var loc3:*=new com.adobe.serialization.json.JSONDecoder(loc1.data, true).getValue();
            var loc4:*=loc2.data;
            var loc6:*=0;
            var loc7:*=loc3;
            for (loc5 in loc7) 
            {
                loc4[loc5] = loc3[loc5];
            }
            loc1.fromClient.SetReady();
            return;
        }

        function onLoadFailedPrimaryLocation(arg1:flash.events.IOErrorEvent):*
        {
            var loc1:*=arg1.target as Shared.AS3.Data.TestProviderLoader;
            var loc2:*=new Shared.AS3.Data.TestProviderLoader(loc1.providerName, loc1.fromClient);
            loc2.addEventListener(flash.events.Event.COMPLETE, this.onLoadComplete);
            loc2.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLoadFailed);
            loc2.load(new flash.net.URLRequest("../Interface/Providers/" + loc1.providerName + ".json"));
            return;
        }

        function onLoadFailed(arg1:flash.events.IOErrorEvent):*
        {
            var loc1:*=Shared.AS3.Data.TestProviderLoader(arg1.target);
            var loc2:*=loc1.providerName;
            trace("WARNING - UIDataShuttleTestConnector.onLoadFailed - TEST PROVIDER: " + loc2 + " NOT FOUND");
            return;
        }
    }
}
