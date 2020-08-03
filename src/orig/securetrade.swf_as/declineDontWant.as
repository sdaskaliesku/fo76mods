package 
{
    import Shared.AS3.*;
    
    public dynamic class declineDontWant extends Shared.AS3.BCBasicMenuItem
    {
        public function declineDontWant()
        {
            super();
            addFrameScript(4, this.frame5, 9, this.frame10);
            return;
        }

        internal function frame5():*
        {
            stop();
            return;
        }

        internal function frame10():*
        {
            stop();
            return;
        }
    }
}
