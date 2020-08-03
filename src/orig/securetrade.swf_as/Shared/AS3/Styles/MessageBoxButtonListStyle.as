package Shared.AS3.Styles 
{
    import Shared.AS3.*;
    
    public class MessageBoxButtonListStyle extends Object
    {
        public function MessageBoxButtonListStyle()
        {
            super();
            return;
        }

        
        {
            listEntryClass_Inspectable = "MessageBoxButtonEntry";
            numListItems_Inspectable = 4;
            textOption_Inspectable = Shared.AS3.BSScrollingList.TEXT_OPTION_MULTILINE;
            verticalSpacing_Inspectable = 7.5;
            restoreListIndex_Inspectable = false;
        }

        public static var listEntryClass_Inspectable:String="MessageBoxButtonEntry";

        public static var numListItems_Inspectable:uint=4;

        public static var textOption_Inspectable:String;

        public static var verticalSpacing_Inspectable:Number=7.5;

        public static var restoreListIndex_Inspectable:Boolean=false;
    }
}
