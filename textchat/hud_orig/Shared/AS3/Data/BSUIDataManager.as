 
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
         // method body index: 729 method index: 729
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
         // method body index: 717 method index: 717
         if(!_instance)
         {
            _instance = new BSUIDataManager();
         }
         return _instance;
      }
      
      public static function ConnectDataShuttleConnector(aDataShuttleConnector:UIDataShuttleConnector) : UIDataShuttleConnector
      {
         // method body index: 718 method index: 718
         var fromClient:UIDataFromClient = null;
         var key:* = null;
         var dispatchChanges:Array = null;
         var inst:BSUIDataManager = GetInstance();
         if(inst.m_DataShuttleConnector == null)
         {
            inst.m_DataShuttleConnector = aDataShuttleConnector;
            if(inst.m_TestConnector)
            {
               fromClient = null;
               dispatchChanges = new Array();
               for(key in inst.m_Providers)
               {
                  fromClient = inst.m_Providers[key];
                  aDataShuttleConnector.Watch(key,fromClient);
               }
               for(key in inst.m_Providers)
               {
                  fromClient = inst.m_Providers[key];
                  if(!fromClient.isTest)
                  {
                     fromClient.DispatchChange();
                  }
               }
            }
         }
         return inst.m_DataShuttleConnector;
      }
      
      public static function InitDataManager(aEventDispatcherBackend:BSUIEventDispatcherBackend) : void
      {
         // method body index: 719 method index: 719
         GetInstance().eventDispatcherBackend = aEventDispatcherBackend;
      }
      
      public static function Subscribe(aProviderName:String, aCallback:Function, aLoadTestProviders:Boolean = false) : Function
      {
         // method body index: 720 method index: 720
         var fromClient:UIDataFromClient = BSUIDataManager.GetDataFromClient(aProviderName,true,aLoadTestProviders);
         if(fromClient != null)
         {
            fromClient.addEventListener(Event.CHANGE,aCallback);
            return aCallback;
         }
         throw Error("Couldn\'t subscribe to data provider: " + aProviderName);
      }
      
      public static function Flush(providerList:Array) : *
      {
         // method body index: 721 method index: 721
         var dataFromClient:UIDataFromClient = null;
         var len:Number = providerList.length;
         var instance:BSUIDataManager = GetInstance();
         for(var i:uint = 0; i < len; i++)
         {
            dataFromClient = instance.m_Providers[providerList[i]];
            dataFromClient.DispatchChange();
         }
      }
      
      public static function Unsubscribe(aProviderName:String, aCallback:Function, aLoadTestProviders:Boolean = false) : void
      {
         // method body index: 722 method index: 722
         var fromClient:UIDataFromClient = BSUIDataManager.GetDataFromClient(aProviderName,true,aLoadTestProviders);
         if(fromClient != null)
         {
            fromClient.removeEventListener(Event.CHANGE,aCallback);
         }
      }
      
      public static function GetDataFromClient(aProviderName:String, aCreateIfNone:Boolean = true, aLoadTestProviders:Boolean = false) : UIDataFromClient
      {
         // method body index: 723 method index: 723
         var dataConnection:UIDataShuttleConnector = null;
         var testConnection:UIDataShuttleTestConnector = null;
         var dataFromClient:UIDataFromClient = null;
         var inst:BSUIDataManager = GetInstance();
         if(inst.m_Providers[aProviderName] == null && aCreateIfNone)
         {
            dataConnection = inst.m_DataShuttleConnector;
            testConnection = inst.m_TestConnector;
            dataFromClient = null;
            if(dataConnection)
            {
               dataFromClient = dataConnection.Watch(aProviderName);
            }
            if(!dataFromClient)
            {
               if(aLoadTestProviders)
               {
                  dataFromClient = testConnection.Watch(aProviderName);
               }
               else
               {
                  dataFromClient = new UIDataFromClient(new Object());
                  dataFromClient.isTest = true;
               }
            }
            inst.m_Providers[aProviderName] = dataFromClient;
         }
         return inst.m_Providers[aProviderName];
      }
      
      public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         // method body index: 724 method index: 724
         GetInstance().addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         // method body index: 725 method index: 725
         GetInstance().removeEventListener(type,listener,useCapture);
      }
      
      public static function dispatchEvent(event:Event) : Boolean
      {
         // method body index: 726 method index: 726
         return GetInstance().dispatchEvent(event);
      }
      
      public static function hasEventListener(type:String) : Boolean
      {
         // method body index: 727 method index: 727
         return GetInstance().hasEventListener(type);
      }
      
      public static function willTrigger(type:String) : Boolean
      {
         // method body index: 728 method index: 728
         return GetInstance().willTrigger(type);
      }
   }
}
