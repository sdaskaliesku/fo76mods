 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class EmoteWidget extends MovieClip
   {
      
      public static const ALIGN_LEFT:uint = // method body index: 2434 method index: 2434
      0;
      
      public static const ALIGN_RIGHT:uint = // method body index: 2434 method index: 2434
      1;
      
      public static const ALIGN_CENTER:uint = // method body index: 2434 method index: 2434
      2;
      
      public static const EVENT_CLEARED:String = // method body index: 2434 method index: 2434
      "EmoteWidget::Cleared";
      
      public static const EVENT_ACTIVE:String = // method body index: 2434 method index: 2434
      "EmoteWidget::Active";
      
      public static const EMOTE_SPACING:Number = // method body index: 2434 method index: 2434
      30;
      
      public static const FADE_OLDER:Boolean = // method body index: 2434 method index: 2434
      false;
       
      
      private var m_EntityID:uint = 0;
      
      private var m_Align:uint = 0;
      
      private var m_DisplayMax:uint = 1;
      
      private var m_Scale:Number = 1;
      
      private var m_MaxEmoteWidth:Number = 0;
      
      private var m_MaxEmoteHeight:Number = 0;
      
      private var m_ProviderCallback:Function;
      
      private var m_HasPrompt = false;
      
      public function EmoteWidget()
      {

         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function get maxEmoteWidth() : Number
      {

         return this.m_MaxEmoteWidth;
      }
      
      public function get maxEmoteHeight() : Number
      {

         return this.m_MaxEmoteHeight;
      }
      
      public function set displayMax(aMax:uint) : void
      {

         this.m_DisplayMax = aMax;
         this.clear();
      }
      
      public function set scale(aScale:Number) : void
      {

         this.m_Scale = aScale;
         for(var i:int = 0; i < this.numChildren; i++)
         {
            this.getChildElement(i).scaleX = this.m_Scale;
            this.getChildElement(i).scaleY = this.m_Scale;
         }
      }
      
      public function set align(aAlign:uint) : void
      {

         if(aAlign != this.m_Align)
         {
            this.m_Align = aAlign;
            if(this.numChildren > 0)
            {
               this.updatePositions();
            }
         }
      }
      
      public function set entityID(aID:uint) : void
      {

         this.m_EntityID = aID;
      }
      
      public function get entityID() : uint
      {

         return this.m_EntityID;
      }
      
      private function getChildElement(aIndex:int) : EmoteContainer
      {

         return this.getChildAt(aIndex) as EmoteContainer;
      }
      
      private function updatePositions() : void
      {

         var fullWidth:Number = NaN;
         var curChild:EmoteContainer = null;
         var emoteSpacing:Number = NaN;
         var posX:Number = NaN;
         var hasDisplayed:Boolean = false;
         var childCount:int = 0;
         var posChildCount:uint = 0;
         var emoteCount:Number = 0;
         for(var i:int = 0; i < this.numChildren; )
         {
            if(!this.getChildElement(i).removed)
            {
               emoteCount++;
            }
            i++;
         }
         if(emoteCount > 0)
         {
            fullWidth = 0;
            curChild = this.getChildElement(0);
            emoteSpacing = EMOTE_SPACING * this.m_Scale;
            posX = 0;
            hasDisplayed = false;
            this.m_MaxEmoteWidth = 0;
            this.m_MaxEmoteHeight = 0;
            for(i = 0; i < this.numChildren; i++)
            {
               curChild = this.getChildElement(i);
               this.m_MaxEmoteWidth = Math.max(this.maxEmoteWidth,curChild.realWidth * this.m_Scale);
               this.m_MaxEmoteHeight = Math.max(this.maxEmoteHeight,curChild.realHeight * this.m_Scale);
               if(!curChild.removed)
               {
                  if(hasDisplayed)
                  {
                     fullWidth = fullWidth + emoteSpacing;
                     fullWidth = fullWidth + curChild.realWidth * this.m_Scale;
                  }
                  hasDisplayed = true;
               }
            }
            if(this.m_Align != ALIGN_LEFT)
            {
               posX = posX - fullWidth;
               if(this.m_Align == ALIGN_CENTER)
               {
                  posX = posX / 2;
               }
            }
            childCount = this.numChildren;
            posChildCount = 0;
            for(i = 0; i < childCount; i++)
            {
               curChild = this.getChildElement(i);
               if(!curChild.removed)
               {
                  if(i != childCount - 1)
                  {
                     curChild.showMod = false;
                  }
                  if(posChildCount >= 1)
                  {
                     posX = posX + emoteSpacing;
                  }
                  if(FADE_OLDER)
                  {
                     curChild.visAlpha = 1 - (emoteCount - 1 - posChildCount) * (1 / this.m_DisplayMax);
                  }
                  else
                  {
                     curChild.visAlpha = 1;
                  }
                  this.getChildElement(i).slideX(posX);
                  posX = posX + curChild.realWidth * this.m_Scale;
                  posChildCount++;
               }
            }
         }
      }
      
      private function clear() : void
      {

         for(var i:int = 0; i < this.numChildren; i++)
         {
            this.getChildElement(i).hide(false);
         }
         this.m_HasPrompt = false;
      }
      
      public function removeEntry(aEntry:EmoteContainer, aReposition:Boolean = true) : void
      {

         this.removeChild(aEntry);
         if(this.numChildren == 0)
         {
            dispatchEvent(new Event(EVENT_CLEARED,true));
         }
         this.updatePositions();
      }
      
      private function onEmoteUpdate(arEvent:FromClientDataEvent) : *
      {

         var emoteName:String = null;
         var newClip:EmoteContainer = null;
         var firstEntry:EmoteContainer = null;
         if(arEvent.data.entityID == this.m_EntityID)
         {
            emoteName = arEvent.data.emoteName;
            if(emoteName == null || emoteName.length == 0)
            {
               this.clear();
            }
            else
            {
               if(arEvent.data.emoteMod == EmoteContainer.MOD_PROMPT)
               {
                  this.clear();
               }
               if(this.numChildren > 0 && this.numChildren == this.m_DisplayMax)
               {
                  firstEntry = this.getChildElement(0);
                  if(firstEntry.mod == EmoteContainer.MOD_PROMPT)
                  {
                     this.m_HasPrompt = false;
                  }
                  firstEntry.hide(false);
               }
               newClip = new EmoteContainer();
               newClip.scaleX = this.m_Scale;
               newClip.scaleY = this.m_Scale;
               newClip.image = emoteName;
               newClip.mod = arEvent.data.emoteMod;
               if(arEvent.data.emoteMod == EmoteContainer.MOD_PROMPT)
               {
                  this.m_HasPrompt = true;
               }
               if(arEvent.data.ignoreDuration == false)
               {
                  newClip.timeout = arEvent.data.duration;
               }
               newClip.parentWidget = this;
               addChild(newClip);
               if(this.numChildren == 1)
               {
                  dispatchEvent(new Event(EVENT_ACTIVE,true));
               }
               this.updatePositions();
            }
         }
      }
      
      public function onAddedToStage(e:Event) : void
      {

         this.m_ProviderCallback = BSUIDataManager.Subscribe("ActiveEmoteData",this.onEmoteUpdate);
      }
      
      public function onRemovedFromStage(e:Event) : void
      {

         if(this.m_ProviderCallback != null)
         {
            BSUIDataManager.Unsubscribe("ActiveEmoteData",this.onEmoteUpdate);
         }
      }
   }
}
