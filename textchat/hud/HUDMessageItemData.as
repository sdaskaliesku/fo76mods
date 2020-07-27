 
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
      
      public function HUDMessageItemData(param1:Number, param2:String, param3:Object, param4:String)
      {
         // method body index: 14 method index: 14
         this.m_Data = new Object();
         super();
         this.messageID = param1;
         this.type = param2;
         this.data = param3;
         this.sound = param4;
      }
      
      public function set messageID(param1:Number) : void
      {
         // method body index: 15 method index: 15
         this.m_MessageID = param1;
      }
      
      public function get messageID() : Number
      {
         // method body index: 16 method index: 16
         return this.m_MessageID;
      }
      
      public function set type(param1:String) : void
      {
         // method body index: 17 method index: 17
         this.m_Type = param1;
      }
      
      public function get type() : String
      {
         // method body index: 18 method index: 18
         return this.m_Type;
      }
      
      public function set data(param1:Object) : void
      {
         // method body index: 19 method index: 19
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            this.m_Data[_loc2_] = param1[_loc2_];
         }
      }
      
      public function get data() : Object
      {
         // method body index: 20 method index: 20
         return this.m_Data;
      }
      
      public function set sound(param1:String) : void
      {
         // method body index: 21 method index: 21
         this.m_Sound = param1;
      }
      
      public function get sound() : String
      {
         // method body index: 22 method index: 22
         return this.m_Sound;
      }
   }
}
