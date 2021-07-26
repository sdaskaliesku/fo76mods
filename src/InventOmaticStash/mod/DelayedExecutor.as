package {
import flash.utils.setTimeout;

import utils.Logger;

public class DelayedExecutor {
    private static const DEFAULT_DELAY:int = 100;
    private static const DEFAULT_STEP:int = 20;
    private var step:int;
    private var currentDelay:int;

    public function DelayedExecutor(initialDelay:int = DEFAULT_DELAY, step:int = DEFAULT_STEP) {
        if (!initialDelay) {
            this.currentDelay = DEFAULT_DELAY;
        }
        if (!step) {
            this.step = DEFAULT_STEP;
        }
        Logger.get().info("Delay: " + this.currentDelay + " Step: " + this.step);
    }

    public function execute(callback:Function):void {
        setTimeout(function ():void {
            callback();
        }, this.currentDelay);
        this.currentDelay += step;
    }
}
}