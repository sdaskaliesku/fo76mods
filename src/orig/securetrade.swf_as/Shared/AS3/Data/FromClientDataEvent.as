package Shared.AS3.Data 
{
    import flash.events.*;
    
    public final class FromClientDataEvent extends flash.events.Event
    {
        public function FromClientDataEvent(arg1:Shared.AS3.Data.UIDataFromClient)
        {
            super(flash.events.Event.CHANGE);
            this.m_FromClient = arg1;
            return;
        }

        public function get fromClient():Object
        {
            return this.m_FromClient;
        }

        public function get data():Object
        {
            return this.m_FromClient.data;
        }

        internal var m_FromClient:Shared.AS3.Data.UIDataFromClient;
    }
}
