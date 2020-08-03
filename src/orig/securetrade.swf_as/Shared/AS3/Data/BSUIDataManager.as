package Shared.AS3.Data 
{
    import flash.events.*;
    
    public final class BSUIDataManager extends Shared.AS3.Data.UsesEventDispatcherBackend
    {
        public function BSUIDataManager()
        {
            super();
            if (_instance != null) 
            {
                throw new Error(this + " is a Singleton. Access using getInstance()");
            }
            this.m_TestConnector = new Shared.AS3.Data.UIDataShuttleTestConnector();
            this.m_Providers = new Object();
            return;
        }

        internal static function GetInstance():Shared.AS3.Data.BSUIDataManager
        {
            if (!_instance) 
            {
                _instance = new BSUIDataManager();
            }
            return _instance;
        }

        public static function ConnectDataShuttleConnector(arg1:Shared.AS3.Data.UIDataShuttleConnector):Shared.AS3.Data.UIDataShuttleConnector
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=GetInstance();
            if (loc1.m_DataShuttleConnector == null) 
            {
                loc1.m_DataShuttleConnector = arg1;
                if (loc1.m_TestConnector) 
                {
                    loc2 = null;
                    loc4 = new Array();
                    var loc5:*=0;
                    var loc6:*=loc1.m_Providers;
                    for (loc3 in loc6) 
                    {
                        loc2 = loc1.m_Providers[loc3];
                        arg1.Watch(loc3, loc2);
                    }
                    loc5 = 0;
                    loc6 = loc1.m_Providers;
                    for (loc3 in loc6) 
                    {
                        loc2 = loc1.m_Providers[loc3];
                        if (loc2.isTest) 
                        {
                            continue;
                        }
                        loc2.DispatchChange();
                    }
                }
            }
            return loc1.m_DataShuttleConnector;
        }

        public static function InitDataManager(arg1:Shared.AS3.Data.BSUIEventDispatcherBackend):void
        {
            GetInstance().eventDispatcherBackend = arg1;
            return;
        }

        public static function Subscribe(arg1:String, arg2:Function, arg3:Boolean=false):Function
        {
            var loc1:*;
            if ((loc1 = Shared.AS3.Data.BSUIDataManager.GetDataFromClient(arg1, true, arg3)) != null) 
            {
                loc1.addEventListener(flash.events.Event.CHANGE, arg2);
                return arg2;
            }
            throw Error("Couldn\'t subscribe to data provider: " + arg1);
        }

        public static function Flush(arg1:Array):*
        {
            var loc4:*=null;
            var loc1:*=arg1.length;
            var loc2:*=GetInstance();
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                (loc4 = loc2.m_Providers[arg1[loc3]]).DispatchChange();
                ++loc3;
            }
            return;
        }

        public static function Unsubscribe(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            var loc1:*;
            if ((loc1 = Shared.AS3.Data.BSUIDataManager.GetDataFromClient(arg1, true, arg3)) != null) 
            {
                loc1.removeEventListener(flash.events.Event.CHANGE, arg2);
            }
            return;
        }

        public static function GetDataFromClient(arg1:String, arg2:Boolean=true, arg3:Boolean=false):Shared.AS3.Data.UIDataFromClient
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*;
            if ((loc1 = GetInstance()).m_Providers[arg1] == null && arg2) 
            {
                loc2 = loc1.m_DataShuttleConnector;
                loc3 = loc1.m_TestConnector;
                loc4 = null;
                if (loc2) 
                {
                    loc4 = loc2.Watch(arg1);
                }
                if (!loc4) 
                {
                    if (arg3) 
                    {
                        loc4 = loc3.Watch(arg1);
                    }
                    else 
                    {
                        (loc4 = new Shared.AS3.Data.UIDataFromClient(new Object())).isTest = true;
                    }
                }
                loc1.m_Providers[arg1] = loc4;
            }
            return loc1.m_Providers[arg1];
        }

        public static function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            GetInstance().addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public static function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            GetInstance().removeEventListener(arg1, arg2, arg3);
            return;
        }

        public static function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            return GetInstance().dispatchEvent(arg1);
        }

        public static function hasEventListener(arg1:String):Boolean
        {
            return GetInstance().hasEventListener(arg1);
        }

        public static function willTrigger(arg1:String):Boolean
        {
            return GetInstance().willTrigger(arg1);
        }

        internal var m_DataShuttleConnector:Shared.AS3.Data.UIDataShuttleConnector;

        internal var m_TestConnector:Shared.AS3.Data.UIDataShuttleTestConnector;

        internal var m_Providers:Object;

        internal static var _instance:Shared.AS3.Data.BSUIDataManager;
    }
}
