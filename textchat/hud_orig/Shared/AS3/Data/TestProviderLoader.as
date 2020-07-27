 
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
         // method body index: 768 method index: 768
         super();
         data = new Object();
         this.m_ProviderName = aProviderName;
         this.m_FromClient = aFromClient;
      }
      
      override public function load(aRequest:URLRequest) : void
      {
         // method body index: 769 method index: 769
         super.load(aRequest);
      }
      
      public function get providerName() : String
      {
         // method body index: 770 method index: 770
         return this.m_ProviderName;
      }
      
      public function get fromClient() : UIDataFromClient
      {
         // method body index: 771 method index: 771
         return this.m_FromClient;
      }
   }
}
