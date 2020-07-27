 
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
         // method body index: 22 method index: 22
         this.m_Data = new Object();
         super();
         this.messageID = aMessageID;
         this.type = aType;
         this.data = aData;
         this.sound = aSound;
      }
      
      public function set messageID(aMessageID:Number) : void
      {
         // method body index: 14 method index: 14
         this.m_MessageID = aMessageID;
      }
      
      public function get messageID() : Number
      {
         // method body index: 15 method index: 15
         return this.m_MessageID;
      }
      
      public function set type(aType:String) : void
      {
         // method body index: 16 method index: 16
         this.m_Type = aType;
      }
      
      public function get type() : String
      {
         // method body index: 17 method index: 17
         return this.m_Type;
      }
      
      public function set data(aData:Object) : void
      {
         // method body index: 18 method index: 18
         var prop:* = null;
         for(prop in aData)
         {
            this.m_Data[prop] = aData[prop];
         }
      }
      
      public function get data() : Object
      {
         // method body index: 19 method index: 19
         return this.m_Data;
      }
      
      public function set sound(aSound:String) : void
      {
         // method body index: 20 method index: 20
         this.m_Sound = aSound;
      }
      
      public function get sound() : String
      {
         // method body index: 21 method index: 21
         return this.m_Sound;
      }
   }
}
