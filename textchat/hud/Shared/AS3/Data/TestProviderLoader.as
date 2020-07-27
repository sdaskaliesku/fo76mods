 
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
         // method body index: 683 method index: 683
         super();
         data = new Object();
         this.m_ProviderName = param1;
         this.m_FromClient = param2;
      }
      
      override public function load(param1:URLRequest) : void
      {
         // method body index: 684 method index: 684
         super.load(param1);
      }
      
      public function get providerName() : String
      {
         // method body index: 685 method index: 685
         return this.m_ProviderName;
      }
      
      public function get fromClient() : UIDataFromClient
      {
         // method body index: 686 method index: 686
         return this.m_FromClient;
      }
   }
}
