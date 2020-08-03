package Shared.AS3.Data 
{
    public class BSUIEventDispatcherBackend extends Object
    {
        public function BSUIEventDispatcherBackend()
        {
            super();
            return;
        }

        public function InitDataManager():*
        {
            Shared.AS3.Data.BSUIDataManager.InitDataManager(this);
            return;
        }

        public var DispatchEventToGame:Function;
    }
}
