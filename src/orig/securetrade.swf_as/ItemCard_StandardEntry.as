package 
{
    public dynamic class ItemCard_StandardEntry extends ItemCard_Entry
    {
        public function ItemCard_StandardEntry()
        {
            super();
            addFrameScript(0, this.frame1, 1, this.frame2);
            return;
        }

        internal function frame1():*
        {
            stop();
            return;
        }

        internal function frame2():*
        {
            stop();
            return;
        }
    }
}
