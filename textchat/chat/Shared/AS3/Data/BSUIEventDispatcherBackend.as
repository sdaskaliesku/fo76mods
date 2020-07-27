 
package Shared.AS3.Data
{
   public class BSUIEventDispatcherBackend
   {
       
      
      public var DispatchEventToGame:Function;
      
      public function BSUIEventDispatcherBackend()
      {

         super();
      }
      
      public function InitDataManager() : *
      {

         BSUIDataManager.InitDataManager(this);
      }
   }
}
