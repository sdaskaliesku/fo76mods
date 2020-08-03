package Shared.AS3.Data 
{
    import flash.net.*;
    
    public class TestProviderLoader extends flash.net.URLLoader
    {
        public function TestProviderLoader(arg1:String, arg2:Shared.AS3.Data.UIDataFromClient)
        {
            super();
            data = new Object();
            this.m_ProviderName = arg1;
            this.m_FromClient = arg2;
            return;
        }

        public override function load(arg1:flash.net.URLRequest):void
        {
            super.load(arg1);
            return;
        }

        public function get providerName():String
        {
            return this.m_ProviderName;
        }

        public function get fromClient():Shared.AS3.Data.UIDataFromClient
        {
            return this.m_FromClient;
        }

        internal var m_ProviderName:String;

        internal var m_FromClient:Shared.AS3.Data.UIDataFromClient;
    }
}
