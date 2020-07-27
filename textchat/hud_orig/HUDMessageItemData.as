 
package
{
   public class HUDMessageItemData
   {
      
      public static const TYPE_EVENT:String = // method body index: 13 method index: 13
      "eventBox";
      
      public static const TYPE_KILL_SINGLE:String = // method body index: 13 method index: 13
      "kill";
      
      public static const TYPE_KILL_TEAM:String = // method body index: 13 method index: 13
      "teamKill";
      
      public static const TYPE_UNDER_ATTACK:String = // method body index: 13 method index: 13
      "underAttack";
      
      public static const TYPE_COMEBACK:String = // method body index: 13 method index: 13
      "comeback";
      
      public static const TYPE_KILL_GROUP:String = // method body index: 13 method index: 13
      "groupKill";
       
      
      private var m_MessageID:Number;
      
      private var m_Type:String;
      
      private var m_Data:Object;
      
      private var m_Sound:String;
      
      public function HUDMessageItemData(aMessageID:Number, aType:String, aData:Object, aSound:String)
      {

         this.m_Data = new Object();
         super();
         this.messageID = aMessageID;
         this.type = aType;
         this.data = aData;
         this.sound = aSound;
      }
      
      public function set messageID(aMessageID:Number) : void
      {

         this.m_MessageID = aMessageID;
      }
      
      public function get messageID() : Number
      {

         return this.m_MessageID;
      }
      
      public function set type(aType:String) : void
      {

         this.m_Type = aType;
      }
      
      public function get type() : String
      {

         return this.m_Type;
      }
      
      public function set data(aData:Object) : void
      {

         var prop:* = null;
         for(prop in aData)
         {
            this.m_Data[prop] = aData[prop];
         }
      }
      
      public function get data() : Object
      {

         return this.m_Data;
      }
      
      public function set sound(aSound:String) : void
      {

         this.m_Sound = aSound;
      }
      
      public function get sound() : String
      {

         return this.m_Sound;
      }
   }
}
