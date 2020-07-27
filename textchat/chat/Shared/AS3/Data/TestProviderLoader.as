 
package Shared.AS3.Data
{
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class TestProviderLoader extends URLLoader
   {
       
      
      private var m_ProviderName:String;
      
      private var m_FromClient:UIDataFromClient;
      
      public function TestProviderLoader(param1:String, param2:UIDataFromClient)
      {

         super();
         data = new Object();
         this.m_ProviderName = param1;
         this.m_FromClient = param2;
      }
      
      override public function load(param1:URLRequest) : void
      {

         super.load(param1);
      }
      
      public function get providerName() : String
      {

         return this.m_ProviderName;
      }
      
      public function get fromClient() : UIDataFromClient
      {

         return this.m_FromClient;
      }
   }
}
