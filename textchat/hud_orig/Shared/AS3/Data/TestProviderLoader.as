 
package Shared.AS3.Data
{
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class TestProviderLoader extends URLLoader
   {
       
      
      private var m_ProviderName:String;
      
      private var m_FromClient:UIDataFromClient;
      
      public function TestProviderLoader(aProviderName:String, aFromClient:UIDataFromClient)
      {

         super();
         data = new Object();
         this.m_ProviderName = aProviderName;
         this.m_FromClient = aFromClient;
      }
      
      override public function load(aRequest:URLRequest) : void
      {

         super.load(aRequest);
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
