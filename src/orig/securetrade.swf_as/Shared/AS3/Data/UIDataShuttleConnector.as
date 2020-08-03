package Shared.AS3.Data 
{
    public class UIDataShuttleConnector extends Object
    {
        public function UIDataShuttleConnector()
        {
            super();
            return;
        }

        public function AttachToDataManager():Boolean
        {
            var loc1:*=Shared.AS3.Data.BSUIDataManager.ConnectDataShuttleConnector(this);
            return loc1 == this;
        }

        public function Watch(arg1:String, arg2:Shared.AS3.Data.UIDataFromClient=null):Shared.AS3.Data.UIDataFromClient
        {
            var loc3:*=null;
            var loc1:*=new Object();
            var loc2:*;
            if (loc2 == arg2) 
            {
                loc1 = loc2.data;
                var loc4:*=0;
                var loc5:*=loc1;
                for (loc3 in loc5) 
                {
                    loc1[loc3] = undefined;
                }
            }
            else 
            {
                loc2 = new Shared.AS3.Data.UIDataFromClient(loc1);
            }
            if (this._Watch(arg1, loc1)) 
            {
                loc2.isTest = false;
                loc2.SetReady();
                return loc2;
            }
            return null;
        }

        public function onFlush(... rest):void
        {
            Shared.AS3.Data.BSUIDataManager.Flush(rest);
            return;
        }

        public var _Watch:Function;

        public var _RemoveWatch:Function;
    }
}
