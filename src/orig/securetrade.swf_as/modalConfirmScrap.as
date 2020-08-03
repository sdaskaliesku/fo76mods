package 
{
    public dynamic class modalConfirmScrap extends SecureTradeScrapConfirmModal
    {
        public function modalConfirmScrap()
        {
            super();
            addFrameScript(0, this.frame1, 10, this.frame11, 21, this.frame22);
            return;
        }

        internal function frame1():*
        {
            stop();
            return;
        }

        internal function frame11():*
        {
            stop();
            return;
        }

        internal function frame22():*
        {
            stop();
            return;
        }
    }
}
