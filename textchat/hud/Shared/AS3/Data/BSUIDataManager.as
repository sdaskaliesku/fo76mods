 
package Shared.AS3.Data
{
   import flash.events.Event;
   
   public final class BSUIDataManager extends UsesEventDispatcherBackend
   {
      
      private static var _instance:BSUIDataManager;
       
      
      private var m_DataShuttleConnector:UIDataShuttleConnector;
      
      private var m_TestConnector:UIDataShuttleTestConnector;
      
      private var m_Providers:Object;
      
      public function BSUIDataManager()
      {

         super();
         if(_instance != null)
         {
            throw new Error(this + " is a Singleton. Access using getInstance()");
         }
         this.m_TestConnector = new UIDataShuttleTestConnector();
         this.m_Providers = new Object();
      }
      
      private static function GetInstance() : BSUIDataManager
      {

         if(!_instance)
         {
            _instance = new BSUIDataManager();
         }
         return _instance;
      }
      
      public static function ConnectDataShuttleConnector(param1:UIDataShuttleConnector) : UIDataShuttleConnector
      {

         var _loc2_:UIDataFromClient = null;
         var _loc3_:* = null;
         var _loc4_:Array = null;
         var _loc5_:BSUIDataManager = GetInstance();
         if(_loc5_.m_DataShuttleConnector == null)
         {
            _loc5_.m_DataShuttleConnector = param1;
            if(_loc5_.m_TestConnector)
            {
               _loc2_ = null;
               _loc4_ = new Array();
               for(_loc3_ in _loc5_.m_Providers)
               {
                  _loc2_ = _loc5_.m_Providers[_loc3_];
                  param1.Watch(_loc3_,_loc2_);
               }
               for(_loc3_ in _loc5_.m_Providers)
               {
                  _loc2_ = _loc5_.m_Providers[_loc3_];
                  if(!_loc2_.isTest)
                  {
                     _loc2_.DispatchChange();
                  }
               }
            }
         }
         return _loc5_.m_DataShuttleConnector;
      }
      
      public static function InitDataManager(param1:BSUIEventDispatcherBackend) : void
      {

         GetInstance().eventDispatcherBackend = param1;
      }
      
      public static function Subscribe(param1:String, param2:Function, param3:Boolean = false) : Function
      {

         var _loc4_:UIDataFromClient = BSUIDataManager.GetDataFromClient(param1,true,param3);
         if(_loc4_ != null)
         {
            _loc4_.addEventListener(Event.CHANGE,param2);
            return param2;
         }
         throw Error("Couldn\'t subscribe to data provider: " + param1);
      }
      
      public static function Flush(param1:Array) : *
      {

         var _loc2_:UIDataFromClient = null;
         var _loc3_:Number = param1.length;
         var _loc4_:BSUIDataManager = GetInstance();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = _loc4_.m_Providers[param1[_loc5_]];
            _loc2_.DispatchChange();
            _loc5_++;
         }
      }
      
      public static function Unsubscribe(param1:String, param2:Function, param3:Boolean = false) : void
      {

         var _loc4_:UIDataFromClient = BSUIDataManager.GetDataFromClient(param1,true,param3);
         if(_loc4_ != null)
         {
            _loc4_.removeEventListener(Event.CHANGE,param2);
         }
      }
      
      public static function GetDataFromClient(param1:String, param2:Boolean = true, param3:Boolean = false) : UIDataFromClient
      {

         var _loc4_:UIDataShuttleConnector = null;
         var _loc5_:UIDataShuttleTestConnector = null;
         var _loc6_:UIDataFromClient = null;
         var _loc7_:BSUIDataManager = GetInstance();
         if(_loc7_.m_Providers[param1] == null && param2)
         {
            _loc4_ = _loc7_.m_DataShuttleConnector;
            _loc5_ = _loc7_.m_TestConnector;
            _loc6_ = null;
            if(_loc4_)
            {
               _loc6_ = _loc4_.Watch(param1);
            }
            if(!_loc6_)
            {
               if(param3)
               {
                  _loc6_ = _loc5_.Watch(param1);
               }
               else
               {
                  _loc6_ = new UIDataFromClient(new Object());
                  _loc6_.isTest = true;
               }
            }
            _loc7_.m_Providers[param1] = _loc6_;
         }
         return _loc7_.m_Providers[param1];
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {

         GetInstance().addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {

         GetInstance().removeEventListener(param1,param2,param3);
      }
      
      public static function dispatchEvent(param1:Event) : Boolean
      {

         return GetInstance().dispatchEvent(param1);
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {

         return GetInstance().hasEventListener(param1);
      }
      
      public static function willTrigger(param1:String) : Boolean
      {

         return GetInstance().willTrigger(param1);
      }
   }
}
