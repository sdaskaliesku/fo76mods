 
package
{
   import flash.display.MovieClip;
   
   public dynamic class ActiveEffectsTextPopup extends MovieClip
   {
       
      
      public var AETPAnimHolder_mc:MovieClip;
      
      public function ActiveEffectsTextPopup()
      {

         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {

         stop();
      }
   }
}
