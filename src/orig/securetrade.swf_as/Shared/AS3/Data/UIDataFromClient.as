package Shared.AS3.Data 
{
    import flash.events.*;
    
    public class UIDataFromClient extends flash.events.EventDispatcher
    {
        public function UIDataFromClient(arg1:Object)
        {
            super();
            this.m_Ready = false;
            this.m_Payload = arg1;
            this.m_IsTest = false;
            return;
        }

        public function DispatchChange():void
        {
            dispatchEvent(new Shared.AS3.Data.FromClientDataEvent(this));
            return;
        }

        public function SetReady():void
        {
            if (!this.m_Ready) 
            {
                this.m_Ready = true;
                this.DispatchChange();
            }
            return;
        }

        public function get data():Object
        {
            return this.m_Payload;
        }

        public function get dataReady():Boolean
        {
            return this.m_Ready;
        }

        public function get isTest():Boolean
        {
            return this.m_IsTest;
        }

        public function set isTest(arg1:Boolean):*
        {
            this.m_IsTest = arg1;
            return;
        }

        internal var m_Payload:Object;

        internal var m_Ready:Boolean=false;

        internal var m_IsTest:Boolean=false;
    }
}
