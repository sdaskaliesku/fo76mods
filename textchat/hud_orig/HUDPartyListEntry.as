 
package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class HUDPartyListEntry extends MovieClip
   {
       
      
      public var LeaderIcon_mc:MovieClip;
      
      public var Meter_mc:MovieClip;
      
      public var SharedPerkCardIcon_mc:MovieClip;
      
      public var Sizer_mc:MovieClip;
      
      public var SpeakerIcon_mc:MovieClip;
      
      public var levelTextField:TextField;
      
      public var nameField_mc:MovieClip;
      
      public function HUDPartyListEntry()
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
