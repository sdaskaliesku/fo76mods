 
package Shared.AS3.COMPANIONAPP
{
   import flash.display.Loader;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class PipboyLoader extends Loader
   {
       
      
      private var _request:URLRequest;
      
      private var _context:LoaderContext;
      
      public function PipboyLoader()
      {
         // method body index: 700 method index: 700
         super();
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         // method body index: 701 method index: 701
         if(CompanionAppMode.isOn)
         {
            if(ExternalInterface.available)
            {
               this._request = param1;
               this._context = param2;
               ExternalInterface.call.apply(null,["GetAssetPath",param1.url,this]);
            }
            else
            {
               trace("PipboyLoader::load -- ExternalInterface is not available!");
            }
         }
         else
         {
            super.load(param1,param2);
         }
      }
      
      public function OnGetAssetPathResult(param1:String) : void
      {
         // method body index: 702 method index: 702
         this._request.url = param1;
         super.load(this._request,this._context);
         this._request = null;
         this._context = null;
      }
   }
}
