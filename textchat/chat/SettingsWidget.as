 
package
{
   import Shared.AS3.BSUIComponent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import scaleform.gfx.Extensions;
   
   public dynamic class SettingsWidget extends BSUIComponent
   {
       
      
      public var AlertColor_tf:TextField;
      
      public var AlertNoise_tf:TextField;
      
      public var ChatBackgroundColor_tf:TextField;
      
      public var ChatBackgroundOpacity_tf:TextField;
      
      public var ChatBackground_tf:TextField;
      
      public var ChatEntryHeight_tf:TextField;
      
      public var ChatEntryWidth_tf:TextField;
      
      public var ChatTime_tf:TextField;
      
      public var ClanColor_tf:TextField;
      
      public var EUGlobalColor_tf:TextField;
      
      public var EnableEU_tf:TextField;
      
      public var EnableGlobal_tf:TextField;
      
      public var EnableTrade_tf:TextField;
      
      public var FontSize_tf:TextField;
      
      public var GlobalColor_tf:TextField;
      
      public var GlobalDefault_tf:TextField;
      
      public var LocalColor_tf:TextField;
      
      public var PartyColor_tf:TextField;
      
      public var ReduceChatChannelTags_tf:TextField;
      
      public var TradeColor_tf:TextField;
      
      public var ChatHeight_tf:TextField;
      
      public var ChatWidth_tf:TextField;
      
      public var ChatLocX_tf:TextField;
      
      public var ChatLocY_tf:TextField;
      
      public function SettingsWidget()
      {

         super();
         Extensions.enabled = true;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "$MAIN_Font";
         this.ChatHeight_tf.setTextFormat(_loc1_);
         this.ChatWidth_tf.setTextFormat(_loc1_);
         this.ChatLocX_tf.setTextFormat(_loc1_);
         this.ChatLocY_tf.setTextFormat(_loc1_);
         this.ChatEntryHeight_tf.setTextFormat(_loc1_);
         this.ChatEntryWidth_tf.setTextFormat(_loc1_);
         this.FontSize_tf.setTextFormat(_loc1_);
         this.GlobalColor_tf.setTextFormat(_loc1_);
         this.LocalColor_tf.setTextFormat(_loc1_);
         this.TradeColor_tf.setTextFormat(_loc1_);
         this.PartyColor_tf.setTextFormat(_loc1_);
         this.ClanColor_tf.setTextFormat(_loc1_);
         this.EUGlobalColor_tf.setTextFormat(_loc1_);
         this.AlertColor_tf.setTextFormat(_loc1_);
         this.GlobalDefault_tf.setTextFormat(_loc1_);
         this.EnableGlobal_tf.setTextFormat(_loc1_);
         this.EnableTrade_tf.setTextFormat(_loc1_);
         this.EnableEU_tf.setTextFormat(_loc1_);
         this.ChatTime_tf.setTextFormat(_loc1_);
         this.AlertNoise_tf.setTextFormat(_loc1_);
         this.ChatBackground_tf.setTextFormat(_loc1_);
         this.ChatBackgroundColor_tf.setTextFormat(_loc1_);
         this.ChatBackgroundOpacity_tf.setTextFormat(_loc1_);
         this.ReduceChatChannelTags_tf.setTextFormat(_loc1_);
      }
      
      override public function redrawUIComponent() : void
      {

      }
   }
}
