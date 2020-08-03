package Shared.AS3.Events 
{
    import flash.display.*;
    import flash.events.*;
    
    public class PlatformRequestEvent extends flash.events.Event
    {
        public function PlatformRequestEvent(arg1:flash.display.MovieClip)
        {
            super(PLATFORM_REQUEST);
            this._target = arg1;
            return;
        }

        public function RespondToRequest(arg1:uint, arg2:Boolean, arg3:uint, arg4:uint):*
        {
            this._target.SetPlatform(arg1, arg2, arg3, arg4);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new Shared.AS3.Events.PlatformRequestEvent(this._target);
        }

        public static const PLATFORM_REQUEST:String="GetPlatform";

        var _target:flash.display.MovieClip;
    }
}
