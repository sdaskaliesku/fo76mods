 
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

         super();
      }
      
      override public function load(request:URLRequest, context:LoaderContext = null) : void
      {

         if(CompanionAppMode.isOn)
         {
            if(ExternalInterface.available)
            {
               this._request = request;
               this._context = context;
               ExternalInterface.call.apply(null,["GetAssetPath",request.url,this]);
            }
            else
            {
               trace("PipboyLoader::load -- ExternalInterface is not available!");
            }
         }
         else
         {
            super.load(request,context);
         }
      }
      
      public function OnGetAssetPathResult(assetPath:String) : void
      {

         this._request.url = assetPath;
         super.load(this._request,this._context);
         this._request = null;
         this._context = null;
      }
   }
}
