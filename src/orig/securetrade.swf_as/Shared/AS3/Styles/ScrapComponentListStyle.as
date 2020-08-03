package Shared.AS3.Styles 
{
    import Shared.AS3.*;
    
    public class ScrapComponentListStyle extends Object
    {
        public function ScrapComponentListStyle()
        {
            super();
            return;
        }

        
        {
            listEntryClass_Inspectable = "ScrapComponentListEntry";
            numListItems_Inspectable = 9;
            textOption_Inspectable = Shared.AS3.BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT;
            disableInput_Inspectable = false;
            disableSelection_Inspectable = true;
        }

        public static var listEntryClass_Inspectable:String="ScrapComponentListEntry";

        public static var numListItems_Inspectable:uint=9;

        public static var textOption_Inspectable:String;

        public static var disableInput_Inspectable:Boolean=false;

        public static var disableSelection_Inspectable:Boolean=true;
    }
}
