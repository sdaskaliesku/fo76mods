 
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
         // method body index: 257 method index: 257
         super();
         data = new Object();
         this.m_ProviderName = param1;
         this.m_FromClient = param2;
      }
      
      override public function load(param1:URLRequest) : void
      {
         // method body index: 258 method index: 258
         super.load(param1);
      }
      
      public function get providerName() : String
      {
         // method body index: 259 method index: 259
         return this.m_ProviderName;
      }
      
      public function get fromClient() : UIDataFromClient
      {
         // method body index: 260 method index: 260
         return this.m_FromClient;
      }
   }
}
