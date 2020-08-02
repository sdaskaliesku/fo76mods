 
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
         // method body index: 414 method index: 414
         super();
         data = new Object();
         this.m_ProviderName = aProviderName;
         this.m_FromClient = aFromClient;
      }
      
      override public function load(aRequest:URLRequest) : void
      {
         // method body index: 415 method index: 415
         super.load(aRequest);
      }
      
      public function get providerName() : String
      {
         // method body index: 416 method index: 416
         return this.m_ProviderName;
      }
      
      public function get fromClient() : UIDataFromClient
      {
         // method body index: 417 method index: 417
         return this.m_FromClient;
      }
   }
}
