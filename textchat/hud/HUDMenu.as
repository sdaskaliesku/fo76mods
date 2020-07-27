 
package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.Events.NetworkedUIEvent;
   import Shared.AS3.Events.QuestEvent;
   import Shared.AS3.ExtendedSocket;
   import Shared.AS3.IMenu;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import fl.motion.motion_internal;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.filters.*;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDMenu extends IMenu
   {
      
      public static const EVENT_LEVELUP_VISIBLE:String = // method body index: 3286 method index: 3286
      "HUD::LevelUpVisible";
      
      public static const EVENT_LEVELUP_HIDDEN:String = // method body index: 3286 method index: 3286
      "HUD::LevelUpHidden";
      
      public static const EVENT_LEVELUP_START:String = // method body index: 3286 method index: 3286
      "HUD::LevelUpStart";
      
      public static var EVENT_SCOREBOARD_CATEGORY_CHANGE:String = // method body index: 3286 method index: 3286
      "Scoreboard::StatFilterChanged";
      
      public static const CURRENCY_UPDATE_LEVELUP_OFFSETY:Number = // method body index: 3286 method index: 3286
      -160;
      
      public static const CURRENCY_REPUTATION_CHANGE_OFFSETY:Number = // method body index: 3286 method index: 3286
      -90;
      
      public static const WANTED_POWER_ARMOR_Y_OFFSET:Number = // method body index: 3286 method index: 3286
      175;
      
      public static const WANTED_SCOREBOARD_RANK_Y_OFFSET:Number = // method body index: 3286 method index: 3286
      6;
      
      public static const ON_STARTEDITTEXT:String = // method body index: 3286 method index: 3286
      "ControlMap::StartEditText";
      
      public static const ON_ENDEDITTEXT:String = // method body index: 3286 method index: 3286
      "ControlMap::EndEditText";
      
      public static var modArray;
      
      public static var clanArray;
      
      public static var bVarNotifyNoise = // method body index: 3286 method index: 3286
      true;
      
      public static var bVarGlobalChat = // method body index: 3286 method index: 3286
      true;
      
      public static var bVarTradeChat = // method body index: 3286 method index: 3286
      true;
      
      public static var bVarEUChat = // method body index: 3286 method index: 3286
      true;
      
      public static var bVarWhisper = // method body index: 3286 method index: 3286
      true;
      
      public static var bVarChatModeGlobal = // method body index: 3286 method index: 3286
      false;
      
      public static var bVarChatModeLocal = // method body index: 3286 method index: 3286
      true;
      
      public static var bVarChatModeTrade = // method body index: 3286 method index: 3286
      false;
      
      public static var bVarChatModeParty = // method body index: 3286 method index: 3286
      false;
      
      public static var bVarChatModeClan = // method body index: 3286 method index: 3286
      false;
      
      public static var bVarChatModeEU = // method body index: 3286 method index: 3286
      false;
      
      public static var bVarChatModeWhisper = // method body index: 3286 method index: 3286
      false;
      
      public static var reduceTags;
       
      
      public var emergencyClosePressed:Boolean = false;
      
      public var __animFactory_SafeRect_mcaf1:AnimatorFactory3D;
      
      public var __animArray_SafeRect_mcaf1:Array;
      
      public var ____motion_SafeRect_mcaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_SafeRect_mcaf1_matArray__:Array;
      
      public var __motion_SafeRect_mcaf1:MotionBase;
      
      public var FloatingQuestMarkerBase:MovieClip;
      
      public var TeammateMarkerBase:MovieClip;
      
      public var networkIndicator_mc:MovieClip;
      
      public var HUDNotificationsGroup_mc:MovieClip;
      
      public var TopCenterGroup_mc:MovieClip;
      
      public var TopRightGroup_mc:MovieClip;
      
      public var HUDChatBase_mc:MovieClip;
      
      public var PartyResolutionContainer_mc:MovieClip;
      
      public var CenterGroup_mc:MovieClip;
      
      public var LeftMeters_mc:MovieClip;
      
      public var BottomCenterGroup_mc:MovieClip;
      
      public var RightMeters_mc:HUDRightMeters;
      
      public var SafeRect_mc:MovieClip;
      
      public var questMessagingQuest_mc:MovieClip;
      
      public var testItem_deleteME:MovieClip;
      
      public var fanfareItem_mc:MovieClip;
      
      public var uniqueItemContainer_mc:MovieClip;
      
      public var questRewardContainer_mc:MovieClip;
      
      public var dpadMapContainer:MovieClip;
      
      public var CompassWidget_mc:MovieClip;
      
      public var ScreenEdgeHitIndicator_mc:MovieClip;
      
      public var AnnounceEventWidget_mc:HUDAnnounceEventWidget;
      
      public var WorkshopMarkersBase_mc:HUDWorkshopMarkers;
      
      public var PvPScoreboard_mc:HUDPvPScoreboard;
      
      public var LevelUpAnimation_mc:MovieClip;
      
      public var YouAreWanted_mc:MovieClip;
      
      public var ScoreboardRank_mc:MovieClip;
      
      public var DamageNumbers_mc:DamageNumbers;
      
      public var ReputationUpdates_mc:HUDReputationUpdatesWidget;
      
      public var FrobberWidget_mc:HUDFrobberWidget;
      
      public var FloatingTargetManager_mc:HUDFloatingTargetManager;
      
      public var AnnounceAvailableQuest_mc:MovieClip;
      
      public var QuestTracker:HUDQuestTracker;
      
      private var m_EntityID:uint = 0;
      
      private var m_QuestTrackerBaseX:Number = 0;
      
      private var m_QuestTrackerBaseY:Number = 0;
      
      private var m_MessagesBaseX:Number = 0;
      
      private var m_MessagesBaseY:Number = 0;
      
      private var m_PromptMessageBaseX:Number = 0;
      
      private var m_PromptMessageBaseY:Number = 0;
      
      private var m_TutorialTextBaseX:Number = 0;
      
      private var m_TutorialTextBaseY:Number = 0;
      
      private var m_PartyListBaseX:Number = 0;
      
      private var m_PartyListBaseY:Number = 0;
      
      private var m_CompassBaseY:Number = 0;
      
      private var m_XPBarBaseY:Number = 0;
      
      private var m_CurrencyUpdateBaseY:Number = 0;
      
      private var m_ValidWantedHUDModes:Array;
      
      private var m_LastHUDMode:String = "All";
      
      private var m_IsWanted:Boolean = false;
      
      private var m_ValidWantedHUDMode:Boolean = false;
      
      private var m_LastPowerArmor:Boolean = false;
      
      private var m_WantedBaseY:Number = 0;
      
      private var m_RankBaseY:Number = 0;
      
      private var m_ScoreboardRank:Number = 0;
      
      private var m_ScoreboardValue:Number = 0;
      
      private var m_WorldType:uint = 0;
      
      private var m_LastBounty:Number = 0;
      
      private var m_ScoreboardFilterData:UIDataFromClient;
      
      private var m_ScoreboardFilterDataUpdated:Boolean = false;
      
      private var m_WorldRankFilterOverride:int = -1;
      
      private var m_LevelUpVisible:Boolean = false;
      
      private var m_RepLevelUpVisible:Boolean = false;
      
      private var m_RepChangeVisible:Boolean = false;
      
      private var DpadMap_mc:MovieClip;
      
      public var BGSCodeObj:Object;
      
      private var ControlMapData:Object;
      
      private var CharacterInfoData:Object;
      
      private var ReviveButtonCallForHelp:BSButtonHintData;
      
      private var ReviveButtonGiveUp:BSButtonHintData;
      
      var hideTimeout:Number = -1;
      
      public var RequestUsername:String = "";
      
      private var LocalEmote_mc:EmoteWidget;
      
      public var RevivePrompt_mc:MovieClip;
      
      private var m_RevivePromptVisible:Boolean = false;
      
      private var m_PrevReviveTime:Number = -1;
      
      private var m_QuestAnnounceQueue:Vector.<QuestEvent>;
      
      private var m_QuestAnnounceBusy:Boolean = false;
      
      private var message:TextField;
      
      private var shiftMod:uint = 16;
      
      private var isShiftPress = false;
      
      public var socket:ExtendedSocket;
      
      public var __SFCodeObj:Object;
      
      public var chatOpenPressed:Boolean = false;
      
      public var chatKeyTimer:Timer;
      
      public var isEditingChat:Boolean = false;
      
      private var blockedPlayers;
      
      private var bSeenCommands = false;
      
      private var thisTimer;
      
      public var bConnected = false;
      
      private var iniLoader:URLLoader;
      
      private var blockLoader:URLLoader;
      
      private var iniArray:Array;
      
      private var colorGlobal:String = "";
      
      private var colorLocal:String = "";
      
      private var colorAlert:String = "";
      
      private var colorTrade:String = "";
      
      private var colorParty:String = "";
      
      private var colorClan:String = "";
      
      private var colorWhisper:String = "";
      
      private var colorEU:String = "";
      
      private var hotKey:String = "";
      
      private var fontSizeChat:String = "";
      
      private var account:Object;
      
      private var pendingInviter:String = "";
      
      public var plmLoader:Loader;
      
      private var myTimer:Timer;
      
      private var currentHUDMode:String;
      
      public var ihbLoader:Loader;
      
      public var enLoader:Loader;
      
      public var ccLoader:Loader;
      
      public var chatUILoader:Loader;
      
      public var blockList:String;
      
      public var settingObj:Array;
      
      public var bFail = false;
      
      public var backgroundVisible:Boolean;
      
      public var TextChat:MovieClip;
      
      public var lastSelectedChannel;
      
      public var disableTabs:Boolean = false;
      
      public var lastWhisperTarget:String = "";
      
      public var lastWhisperReceived:String = "PtRjYMpeSSkVfEDy";
      
      public var lastWhisperReceivedTwo:String = "PtRjYMpeSSkVfEDy";
      
      private var loadConnect:Boolean = false;
      
      public function HUDMenu()
      {

         this.chatKeyTimer = new Timer(50,1);
         this.blockedPlayers = [];
         this.iniLoader = new URLLoader();
         this.blockLoader = new URLLoader();
         this.ReviveButtonCallForHelp = new BSButtonHintData("$CALLFORHELP","$SPACEBAR","PSN_Y","Xenon_Y",1,null);
         this.ReviveButtonGiveUp = new BSButtonHintData("$GIVEUP","TAB","PSN_B","Xenon_B",1,null);
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
         this.BGSCodeObj = new Object();
         Extensions.enabled = true;
         Extensions.noInvisibleAdvance = true;
         this.message = new TextField();
         this.__SFCodeObj = new Object();
         this.myTimer = new Timer(5000,0);
         this.myTimer.start();
         this.myTimer.addEventListener(TimerEvent.TIMER,this.timerHandler);
         try
         {
            this.HUDChatBase_mc.visible = false;
            this.HUDChatBase_mc.HUDChatWidget_mc.visible = false;
            this.HUDChatBase_mc.HUDChatEntryWidget_mc.visible = false;
            this.chatUILoader = new Loader();
            addChild(this.chatUILoader);
            try
            {
               this.chatUILoader.load(new URLRequest("TextChat.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
               this.chatUILoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.textChatLoaded);
               this.chatUILoader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.uncaughtErrorHandler);
            }
            catch(e:Error)
            {
               this.displayError("ERROR" + e.toString());
            }
         }
         catch(error:*)
         {
         }
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageEvent);
         this.QuestTracker = this.TopRightGroup_mc.QuestTracker;
         BSUIDataManager.Subscribe("DeathReviveData",function(param1:FromClientDataEvent):// method body index: 3288 method index: 3288
         *
         {

            var _loc2_:Number = NaN;
            var _loc3_:* = param1.data;
            var _loc4_:Boolean = false;
            if(_loc3_.isInBleedout)
            {
               if(!_loc3_.bleedoutDisabled)
               {
                  if(_loc3_.timeTillExpire > 0)
                  {
                     _loc4_ = true;
                     _loc2_ = Math.ceil(_loc3_.timeTillExpire);
                     RevivePrompt_mc.reviveTimer.reviveTime_tf.text = "[" + _loc2_ + "s]";
                     if(m_PrevReviveTime != _loc2_)
                     {
                        GlobalFunc.PlayMenuSound("UIMenuCriticallyInjuredCounterDecrement");
                        m_PrevReviveTime = _loc2_;
                     }
                  }
                  else
                  {
                     m_PrevReviveTime = -1;
                  }
               }
               else
               {
                  _loc4_ = true;
                  RevivePrompt_mc.reviveTimer.reviveTime_tf.text = "";
               }
            }
            if(_loc4_ != m_RevivePromptVisible)
            {
               if(_loc4_)
               {
                  RevivePrompt_mc.gotoAndPlay("rollOn");
               }
               else
               {
                  RevivePrompt_mc.gotoAndPlay("rollOff");
               }
            }
            m_RevivePromptVisible = _loc4_;
         });
         var reviveButtonBar:BSButtonHintBar = this.RevivePrompt_mc.ButtonHintBar_mc;
         var buttonHintDataV:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         buttonHintDataV.push(this.ReviveButtonCallForHelp);
         buttonHintDataV.push(this.ReviveButtonGiveUp);
         reviveButtonBar.SetButtonHintData(buttonHintDataV);
         addEventListener(QuestEvent.EVENT_AVAILABLE,this.onQuestAvailable);
         this.LocalEmote_mc = this.RightMeters_mc.LocalEmote_mc;
         this.LocalEmote_mc.align = EmoteWidget.ALIGN_RIGHT;
         this.LocalEmote_mc.scale = 1;
         BSUIDataManager.Subscribe("PVPData",function(param1:FromClientDataEvent):// method body index: 3289 method index: 3289
         *
         {

            var _loc2_:* = param1.data;
            if(_loc2_.announcement.length > 0)
            {
               onPVPAnnounced(_loc2_);
            }
         });
         this.m_QuestAnnounceQueue = new Vector.<QuestEvent>();
         this.m_QuestTrackerBaseX = this.QuestTracker.x;
         this.m_QuestTrackerBaseY = this.QuestTracker.y;
         this.m_MessagesBaseX = this.HUDNotificationsGroup_mc.Messages_mc.x;
         this.m_MessagesBaseY = this.HUDNotificationsGroup_mc.Messages_mc.y;
         this.m_PromptMessageBaseX = this.HUDNotificationsGroup_mc.PromptMessageHolder_mc.x;
         this.m_PromptMessageBaseY = this.HUDNotificationsGroup_mc.PromptMessageHolder_mc.y;
         this.m_TutorialTextBaseX = this.HUDNotificationsGroup_mc.TutorialText_mc.x;
         this.m_TutorialTextBaseY = this.HUDNotificationsGroup_mc.TutorialText_mc.y;
         this.m_PartyListBaseX = this.HUDPartyListBase_mc.x;
         this.m_PartyListBaseY = this.HUDPartyListBase_mc.y;
         this.m_XPBarBaseY = this.HUDNotificationsGroup_mc.XPMeter_mc.y;
         this.m_CurrencyUpdateBaseY = this.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y;
         this.m_WantedBaseY = this.YouAreWanted_mc.y;
         this.m_RankBaseY = this.ScoreboardRank_mc.y;
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         this.DpadMap_mc = this.dpadMapContainer["DpadMap_mc"];
         this.CompassWidget_mc = this.BottomCenterGroup_mc.CompassWidget_mc;
         this.m_CompassBaseY = this.CompassWidget_mc.y;
         BSUIDataManager.Subscribe("RadialMenuStatus",this.onRadialMenuStatusUpdate);
         BSUIDataManager.Subscribe("ScreenResolutionData",this.onResolutionUpdate);
         addEventListener(HUDAnnounceEventWidget.EVENT_ACTIVE,this.onFanfareActive);
         addEventListener(HUDAnnounceEventWidget.EVENT_CLEARED,this.onFanfareCleared);
         addEventListener(EVENT_LEVELUP_VISIBLE,function(param1:Event):// method body index: 3290 method index: 3290
         *
         {

            levelUpVisible = true;
         });
         addEventListener(EVENT_LEVELUP_HIDDEN,function(param1:Event):// method body index: 3291 method index: 3291
         *
         {

            levelUpVisible = false;
         });
         addEventListener(HUDReputationUpdatesWidget.EVENT_LEVELUP_VISIBLE,function(param1:Event):// method body index: 3292 method index: 3292
         *
         {

            repLevelUpVisible = true;
         });
         addEventListener(HUDReputationUpdatesWidget.EVENT_CHANGE_VISIBLE,function(param1:Event):// method body index: 3293 method index: 3293
         *
         {

            repChangeVisible = true;
         });
         addEventListener(HUDReputationUpdatesWidget.EVENT_HIDDEN,function(param1:Event):// method body index: 3294 method index: 3294
         *
         {

            repLevelUpVisible = false;
            repChangeVisible = false;
         });
         addEventListener(EVENT_LEVELUP_START,function(param1:CustomEvent):// method body index: 3295 method index: 3295
         *
         {

            LevelUpAnimation_mc.LevelUpText.textField.text = param1.params.displayText;
            LevelUpAnimation_mc.gotoAndPlay("On");
         });
         this.m_ValidWantedHUDModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY);
         BSUIDataManager.Subscribe("AccountInfoData",this.onAccountInfoUpdate);
         var RankPlayerIcon:ImageFixture = this.ScoreboardRank_mc.AccountIcon_mc;
         RankPlayerIcon.clipWidth = RankPlayerIcon.width * (1 / RankPlayerIcon.scaleX);
         RankPlayerIcon.clipHeight = RankPlayerIcon.height * (1 / RankPlayerIcon.scaleY);
         BSUIDataManager.Subscribe("ScoreboardData",this.onLeaderboardDataUpdate);
         this.m_ScoreboardFilterData = BSUIDataManager.GetDataFromClient("ScoreboardFilterData");
         BSUIDataManager.Subscribe("ScoreboardFilterData",function(param1:FromClientDataEvent):// method body index: 3296 method index: 3296
         *
         {

            if(param1.data.worldRankFilter.statType == GlobalFunc.STAT_TYPE_INVALID)
            {
               m_WorldRankFilterOverride = GlobalFunc.STAT_TYPE_SURVIVAL_SCORE;
            }
            else
            {
               m_WorldRankFilterOverride = -1;
            }
            if(!m_ScoreboardFilterDataUpdated)
            {
               revertScoreboardFilter();
               m_ScoreboardFilterDataUpdated = true;
            }
         });
         TextFieldEx.setTextAutoSize(this.YouAreWanted_mc.bountyAmount.bounty_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         addEventListener(Event.ADDED_TO_STAGE,this.__setPerspectiveProjection_);
         if(this.__animFactory_SafeRect_mcaf1 == null)
         {
            this.__animArray_SafeRect_mcaf1 = new Array();
            this.__motion_SafeRect_mcaf1 = new MotionBase();
            this.__motion_SafeRect_mcaf1.duration = 3;
            this.__motion_SafeRect_mcaf1.overrideTargetTransform();
            this.__motion_SafeRect_mcaf1.addPropertyArray("blendMode",["normal","normal","normal"]);
            this.__motion_SafeRect_mcaf1.addPropertyArray("cacheAsBitmap",[false,false,false]);
            this.__motion_SafeRect_mcaf1.addPropertyArray("opaqueBackground",[null,null,null]);
            this.__motion_SafeRect_mcaf1.addPropertyArray("visible",[false,false,false]);
            this.__motion_SafeRect_mcaf1.is3D = true;
            this.__motion_SafeRect_mcaf1.motion_internal::spanStart = 0;
            this.____motion_SafeRect_mcaf1_matArray__ = new Array();
            this.____motion_SafeRect_mcaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_SafeRect_mcaf1_mat3DVec__[0] = 1.5;
            this.____motion_SafeRect_mcaf1_mat3DVec__[1] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[2] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[3] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[4] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[5] = 1.5;
            this.____motion_SafeRect_mcaf1_mat3DVec__[6] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[7] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[8] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[9] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[10] = 1;
            this.____motion_SafeRect_mcaf1_mat3DVec__[11] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[12] = 960;
            this.____motion_SafeRect_mcaf1_mat3DVec__[13] = 540;
            this.____motion_SafeRect_mcaf1_mat3DVec__[14] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[15] = 1;
            this.____motion_SafeRect_mcaf1_matArray__.push(new Matrix3D(this.____motion_SafeRect_mcaf1_mat3DVec__));
            this.____motion_SafeRect_mcaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_SafeRect_mcaf1_mat3DVec__[0] = 1.5;
            this.____motion_SafeRect_mcaf1_mat3DVec__[1] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[2] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[3] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[4] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[5] = 1.664917;
            this.____motion_SafeRect_mcaf1_mat3DVec__[6] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[7] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[8] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[9] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[10] = 1;
            this.____motion_SafeRect_mcaf1_mat3DVec__[11] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[12] = 960;
            this.____motion_SafeRect_mcaf1_mat3DVec__[13] = 539.950012;
            this.____motion_SafeRect_mcaf1_mat3DVec__[14] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[15] = 1;
            this.____motion_SafeRect_mcaf1_matArray__.push(new Matrix3D(this.____motion_SafeRect_mcaf1_mat3DVec__));
            this.____motion_SafeRect_mcaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_SafeRect_mcaf1_mat3DVec__[0] = 1.999985;
            this.____motion_SafeRect_mcaf1_mat3DVec__[1] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[2] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[3] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[4] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[5] = 1.5;
            this.____motion_SafeRect_mcaf1_mat3DVec__[6] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[7] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[8] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[9] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[10] = 1;
            this.____motion_SafeRect_mcaf1_mat3DVec__[11] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[12] = 959.950012;
            this.____motion_SafeRect_mcaf1_mat3DVec__[13] = 540;
            this.____motion_SafeRect_mcaf1_mat3DVec__[14] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[15] = 1;
            this.____motion_SafeRect_mcaf1_matArray__.push(new Matrix3D(this.____motion_SafeRect_mcaf1_mat3DVec__));
            this.__motion_SafeRect_mcaf1.addPropertyArray("matrix3D",this.____motion_SafeRect_mcaf1_matArray__);
            this.__animArray_SafeRect_mcaf1.push(this.__motion_SafeRect_mcaf1);
            this.__animFactory_SafeRect_mcaf1 = new AnimatorFactory3D(null,this.__animArray_SafeRect_mcaf1);
            this.__animFactory_SafeRect_mcaf1.sceneName = "Scene 1";
            this.__animFactory_SafeRect_mcaf1.addTargetInfo(this,"SafeRect_mc",0,true,0,true,null,-1);
         }
         this.plmLoader = new Loader();
         addChild(this.plmLoader);
         try
         {
            this.plmLoader.load(new URLRequest("PLMHudMenu.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
            this.plmLoader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.uncaughtErrorHandler);
         }
         catch(e:Error)
         {
            this.displayError("ERROR" + e.toString());
         }
         this.ihbLoader = new Loader();
         addChild(this.ihbLoader);
         try
         {
            this.ihbLoader.load(new URLRequest("ImprovedHealthBars.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
            this.ihbLoader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.uncaughtErrorHandler);
         }
         catch(e:Error)
         {
            this.displayError("ERROR" + e.toString());
         }
         this.enLoader = new Loader();
         addChild(this.enLoader);
         try
         {
            this.enLoader.load(new URLRequest("EventNotifications.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
            this.enLoader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.uncaughtErrorHandler);
         }
         catch(e:Error)
         {
            this.displayError("ERROR" + e.toString());
         }
         this.ccLoader = new Loader();
         addChild(this.ccLoader);
         try
         {
            this.ccLoader.load(new URLRequest("CustomCrosshair.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
            this.ccLoader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.uncaughtErrorHandler);
            return;
         }
         catch(e:Error)
         {
            this.displayError("ERROR" + e.toString());
            return;
         }
      }
      
      public static function clearDelimeters(param1:String) : String
      {

         return param1.replace(/[\r\n\b]+/g,"");
      }
      
      public function emergencyClose() : void
      {

         if(this.chatOpenPressed && this.isEditingChat)
         {
            this.chatOpenPressed = false;
         }
      }
      
      public function textChatLoaded() : void
      {

         this.TextChat = this.chatUILoader.content as MovieClip;
         this.resetChatMode();
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.TextEntry_bg.visible = false;
         this.settingObj = ["true","6","true","true","0","0","504F52","0.8","77e57c","db5e5e","b384e0","INSERT","120","510","16","c7ceb1","true","true","85a1c4","23","600","ceb1e2","true","ffc0cb","true","646365","4A494B","0.8","B0A295","7C787C","0.8","13FF17","false","FFC7A5","true","false"];
         this.iniLoader.addEventListener(Event.COMPLETE,this.onLoaded);
         this.iniLoader.addEventListener(IOErrorEvent.IO_ERROR,this.failLoaded);
         this.blockLoader.addEventListener(Event.COMPLETE,this.onBlockLoaded);
         this.chatKeyTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCheckChatKey);
         this.chatKeyTimer.start();
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.addEventListener(KeyboardEvent.KEY_UP,this.chatEntryKeyUp);
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.addEventListener(KeyboardEvent.KEY_DOWN,this.chatEntryKeyDown);
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.addEventListener(FocusEvent.FOCUS_OUT,this.chatEntryFocusOut);
      }
      
      public function onCheckChatKey() : void
      {

         if(this.chatOpenPressed && this.isEditingChat && this.emergencyClosePressed)
         {
            this.emergencyClosePressed = false;
            setTimeout(this.emergencyClose,10);
         }
         if(this.chatOpenPressed == false && this.isEditingChat == true)
         {
            this.resetChatMode();
            this.isEditingChat = false;
         }
         if(this.currentHUDMode == HUDModes.TERMINAL_MODE || this.currentHUDMode == HUDModes.PERKS_MODE || this.currentHUDMode == HUDModes.CAMP_PLACEMENT || this.currentHUDMode == HUDModes.INSPECT_MODE || this.currentHUDMode == "RadialMenu" || this.currentHUDMode == HUDModes.WORKSHOP_MODE)
         {
            this.chatKeyTimer.reset();
            this.chatKeyTimer.start();
            return;
         }
         if(this.chatOpenPressed && this.isEditingChat == false)
         {
            this.isEditingChat = true;
            this.enterChatMode();
         }
         this.chatKeyTimer.reset();
         this.chatKeyTimer.start();
      }
      
      private function loadBlockList() : void
      {

         try
         {
            this.blockLoader.load(new URLRequest("../configuration/blocklist.ini"));
            return;
         }
         catch(error:Error)
         {
            OnNetworkedUIEventReceived("ALERT","ERROR: There was an error loading your block list file!",2);
            return;
         }
      }
      
      function saveTheConfig() : void
      {

         var _loc1_:* = [];
         _loc1_ = this.settingObj.concat();
         _loc1_[0] = "globalDefault=" + _loc1_[0];
         _loc1_[1] = "chatTimeout=" + _loc1_[1];
         _loc1_[2] = "alertNoise=" + _loc1_[2];
         _loc1_[3] = "chatBackground=" + _loc1_[3];
         _loc1_[4] = "chatLocationY=" + _loc1_[4];
         _loc1_[5] = "chatLocationX=" + _loc1_[5];
         _loc1_[6] = "chatBackgroundColor=" + _loc1_[6];
         _loc1_[7] = "chatBackgroundOpacity=" + _loc1_[7];
         _loc1_[8] = "globalColor=" + _loc1_[8];
         _loc1_[9] = "localColor=" + _loc1_[9];
         _loc1_[10] = "alertColor=" + _loc1_[10];
         _loc1_[11] = "chatKey=" + _loc1_[11];
         _loc1_[12] = "chatHeight=" + _loc1_[12];
         _loc1_[13] = "chatWidth=" + _loc1_[13];
         _loc1_[14] = "fontSize=" + _loc1_[14];
         _loc1_[15] = "tradeColor=" + _loc1_[15];
         _loc1_[16] = "enableGlobal=" + _loc1_[16];
         _loc1_[17] = "enableTrade=" + _loc1_[17];
         _loc1_[18] = "partyColor=" + _loc1_[18];
         _loc1_[19] = "chatEntryHeight=" + _loc1_[19];
         _loc1_[20] = "chatEntryWidth=" + _loc1_[20];
         _loc1_[21] = "clanColor=" + _loc1_[21];
         _loc1_[22] = "enableEU=" + _loc1_[22];
         _loc1_[23] = "EUColor=" + _loc1_[23];
         _loc1_[24] = "reduceChannelTags=" + _loc1_[24];
         _loc1_[25] = "tabColorFocus=" + _loc1_[25];
         _loc1_[26] = "tabColorNoFocus=" + _loc1_[26];
         _loc1_[27] = "tabColorOpacity=" + _loc1_[27];
         _loc1_[28] = "tabTextColor=" + _loc1_[28];
         _loc1_[29] = "chatEntryBackground=" + _loc1_[29];
         _loc1_[30] = "chatEntryOpacity=" + _loc1_[30];
         _loc1_[31] = "chatEntryFontColor=" + _loc1_[31];
         _loc1_[32] = "disableChatTabs=" + _loc1_[32];
         _loc1_[33] = "whisperColor=" + _loc1_[33];
         _loc1_[34] = "enableWhisper=" + _loc1_[34];
         _loc1_[35] = "enableTimestamps=" + _loc1_[35];
         var _loc2_:* = _loc1_.join("\n");
         this.saveConfiguration(_loc2_);
      }
      
      function failLoaded() : void
      {

         if(this.bFail == true)
         {
            return;
         }
         this.bFail = true;
         if(this.settingObj[0].search("true") >= 0)
         {
            bVarChatModeGlobal = true;
            bVarChatModeLocal = false;
            bVarChatModeTrade = false;
            bVarChatModeParty = false;
            bVarChatModeClan = false;
            bVarChatModeEU = false;
            bVarGlobalChat = true;
         }
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.setTimer(parseInt(this.settingObj[1]));
         if(this.settingObj[2].search("true") >= 0)
         {
            bVarNotifyNoise = true;
         }
         else
         {
            bVarNotifyNoise = false;
         }
         if(this.settingObj[3].search("true") >= 0)
         {
            this.backgroundVisible = true;
         }
         else
         {
            this.backgroundVisible = false;
         }
         this.TextChat.TextChatBase_mc.y = parseInt(this.settingObj[4]);
         this.TextChat.TextChatBase_mc.x = parseInt(this.settingObj[5]);
         this.colorGlobal = this.settingObj[8];
         this.colorLocal = this.settingObj[9];
         this.colorAlert = this.settingObj[10];
         this.colorTrade = this.settingObj[15];
         this.colorParty = this.settingObj[18];
         this.colorClan = this.settingObj[21];
         this.colorEU = this.settingObj[23];
         this.colorWhisper = this.settingObj[33];
         this.fontSizeChat = this.settingObj[14];
         if(this.settingObj[16].search("true") >= 0)
         {
            bVarGlobalChat = true;
         }
         else
         {
            bVarGlobalChat = false;
            bVarChatModeGlobal = false;
         }
         if(this.settingObj[34].search("true") >= 0)
         {
            bVarWhisper = true;
         }
         else
         {
            bVarWhisper = false;
            bVarChatModeWhisper = false;
         }
         if(this.settingObj[17].search("true") >= 0)
         {
            bVarTradeChat = true;
         }
         else
         {
            bVarTradeChat = false;
            bVarChatModeTrade = false;
         }
         if(this.settingObj[22].search("true") >= 0)
         {
            bVarEUChat = true;
         }
         else
         {
            bVarEUChat = false;
            bVarChatModeEU = false;
         }
         this.hotKey = this.settingObj[11];
         if(this.__SFCodeObj.call != null)
         {
            this.__SFCodeObj.call("updateChatHotkey",this.hotKey);
         }
         if(this.settingObj[24].search("true") >= 0)
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.setReduceTags(true);
            reduceTags = true;
         }
         else
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.setReduceTags(false);
            reduceTags = false;
         }
         if(this.settingObj[35].search("true") >= 0)
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.setTimeStamps(true);
         }
         else
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.setTimeStamps(false);
         }
         if(this.settingObj[32].search("true") >= 0)
         {
            this.disableTabs = true;
         }
         else
         {
            this.disableTabs = false;
         }
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.setIniProperties(parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),this.backgroundVisible,parseInt(this.settingObj[5]),parseInt(this.settingObj[4]),parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
         this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
         this.saveTheConfig();
         this.loadBlockList();
      }
      
      function onLoaded(param1:Event) : void
      {

         this.iniArray = param1.target.data.split(/\r\n/);
         var _loc2_:int = 0;
         while(_loc2_ < this.iniArray.length)
         {
            this.settingObj[_loc2_] = this.iniArray[_loc2_].split("=").pop();
            _loc2_++;
         }
         if(this.settingObj[0].search("true") >= 0)
         {
            bVarChatModeGlobal = true;
            bVarChatModeLocal = false;
            bVarChatModeTrade = false;
            bVarChatModeParty = false;
            bVarChatModeClan = false;
            bVarChatModeEU = false;
            bVarGlobalChat = true;
         }
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.setTimer(parseInt(this.settingObj[1]));
         if(this.settingObj[2].search("true") >= 0)
         {
            bVarNotifyNoise = true;
         }
         else
         {
            bVarNotifyNoise = false;
         }
         if(this.settingObj[3].search("true") >= 0)
         {
            this.backgroundVisible = true;
         }
         else
         {
            this.backgroundVisible = false;
         }
         this.TextChat.TextChatBase_mc.y = parseInt(this.settingObj[4]);
         this.TextChat.TextChatBase_mc.x = parseInt(this.settingObj[5]);
         this.colorGlobal = this.settingObj[8];
         this.colorLocal = this.settingObj[9];
         this.colorAlert = this.settingObj[10];
         this.colorTrade = this.settingObj[15];
         this.colorParty = this.settingObj[18];
         this.colorClan = this.settingObj[21];
         this.colorEU = this.settingObj[23];
         this.colorWhisper = this.settingObj[33];
         this.fontSizeChat = this.settingObj[14];
         if(this.settingObj[16].search("true") >= 0)
         {
            bVarGlobalChat = true;
         }
         else
         {
            bVarGlobalChat = false;
            bVarChatModeGlobal = false;
            bVarChatModeLocal = true;
            bVarChatModeTrade = false;
            bVarChatModeParty = false;
            bVarChatModeClan = false;
            bVarChatModeEU = false;
         }
         if(this.settingObj[34].search("true") >= 0)
         {
            bVarWhisper = true;
         }
         else
         {
            bVarWhisper = false;
            bVarChatModeWhisper = false;
         }
         if(this.settingObj[17].search("true") >= 0)
         {
            bVarTradeChat = true;
         }
         else
         {
            bVarTradeChat = false;
            bVarChatModeTrade = false;
         }
         if(this.settingObj[22].search("true") >= 0)
         {
            bVarEUChat = true;
         }
         else
         {
            bVarEUChat = false;
            bVarChatModeEU = false;
         }
         this.hotKey = this.settingObj[11];
         if(this.__SFCodeObj.call != null)
         {
            this.__SFCodeObj.call("updateChatHotkey",this.hotKey);
         }
         if(this.settingObj[24].search("true") >= 0)
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.setReduceTags(true);
            reduceTags = true;
         }
         else
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.setReduceTags(false);
            reduceTags = false;
         }
         if(this.settingObj[35].search("true") >= 0)
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.setTimeStamps(true);
         }
         else
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.setTimeStamps(false);
         }
         if(this.settingObj[32].search("true") >= 0)
         {
            this.disableTabs = true;
         }
         else
         {
            this.disableTabs = false;
         }
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.setIniProperties(parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),this.backgroundVisible,parseInt(this.settingObj[5]),parseInt(this.settingObj[4]),parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
         this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
         this.saveTheConfig();
         this.loadBlockList();
      }
      
      function saveBlockList(param1:String) : void
      {

         if(this.__SFCodeObj.call != null && this.__SFCodeObj.call("writeBlockFile",param1))
         {
            this.OnNetworkedUIEventReceived("ALERT","Block list saved successfully.",2);
         }
         else
         {
            this.OnNetworkedUIEventReceived("ALERT","ERROR: Could not access your block list file for saving.",2);
         }
      }
      
      function saveConfiguration(param1:String) : void
      {

         if(this.__SFCodeObj.call != null && this.__SFCodeObj.call("writeChatConfigFile",param1))
         {
            this.OnNetworkedUIEventReceived("ALERT","Configuration saved successfully.",2);
         }
         else
         {
            this.OnNetworkedUIEventReceived("ALERT","ERROR: Could not access your configuration file for saving.",2);
         }
      }
      
      function onBlockLoaded(param1:Event) : void
      {

         this.blockedPlayers = param1.target.data.split("\r\n");
         this.blockedPlayers.replace(/\r?\n|\r/g,"");
      }
      
      function handleWebSocketOpen(param1:Event) : void
      {

      }
      
      function handleWebSocketMessage(param1:ProgressEvent) : void
      {

      }
      
      public function __setPerspectiveProjection_(param1:Event) : void
      {

         root.transform.perspectiveProjection.fieldOfView = 1.002611;
         root.transform.perspectiveProjection.projectionCenter = new Point(960,540);
      }
      
      private function get HUDPartyListBase_mc() : HUDTeamWidget
      {

         return this.PartyResolutionContainer_mc.HUDPartyListBase_mc;
      }
      
      private function revertScoreboardFilter() : void
      {

         if(this.m_WorldRankFilterOverride >= 0)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SCOREBOARD_CATEGORY_CHANGE,{"statTypeFilter":this.m_WorldRankFilterOverride}));
         }
         else
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SCOREBOARD_CATEGORY_CHANGE,{"statTypeFilter":this.m_ScoreboardFilterData.data.worldRankFilter.statType}));
         }
      }
      
      private function displayError(param1:String) : void
      {

         this.message.width = 1600;
         GlobalFunc.SetText(this.message,this.message.text + "\n" + param1,false);
         TextFieldEx.setTextAutoSize(this.message,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.message.autoSize = TextFieldAutoSize.LEFT;
         this.message.wordWrap = true;
         this.message.multiline = true;
         addChild(this.message);
         this.message.visible = true;
         var _loc2_:TextFormat = new TextFormat("Arial",18,16777215);
         this.message.defaultTextFormat = _loc2_;
         this.message.setTextFormat(_loc2_);
         this.message.mouseEnabled = false;
      }
      
      public function uncaughtErrorHandler(param1:UncaughtErrorEvent) : *
      {

         this.displayError(param1.toString());
      }
      
      private function onHUDModeUpdate(param1:FromClientDataEvent) : void
      {

         this.currentHUDMode = param1.data.hudMode;
         var _loc2_:String = param1.data.hudMode;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         this.m_LastPowerArmor = param1.data.inPowerArmor && param1.data.powerArmorHUDEnabled;
         switch(_loc2_)
         {
            case HUDModes.WORKSHOP_MODE:
               _loc3_ = 100;
               _loc5_ = -285;
               _loc6_ = 80;
               break;
            case HUDModes.INSPECT_MODE:
               _loc7_ = 133;
         }
         if(this.m_LastPowerArmor && _loc2_ != HUDModes.PHOTO_MODE && _loc2_ != HUDModes.MAP_MENU && _loc2_ != HUDModes.DIALOGUE_MODE)
         {
            _loc3_ = 205;
            _loc4_ = -226;
         }
         this.QuestTracker.x = this.m_QuestTrackerBaseX + _loc5_;
         this.QuestTracker.y = this.m_QuestTrackerBaseY + _loc6_;
         this.HUDPartyListBase_mc.x = this.m_PartyListBaseX + _loc3_;
         this.HUDPartyListBase_mc.y = this.m_PartyListBaseY + _loc4_;
         this.HUDNotificationsGroup_mc.XPMeter_mc.y = this.m_XPBarBaseY + _loc7_;
         this.m_ValidWantedHUDMode = this.m_ValidWantedHUDModes.indexOf(_loc2_) != -1;
         if(_loc2_ != this.m_LastHUDMode && (this.m_LastHUDMode == HUDModes.MAP_MENU || this.m_LastHUDMode == HUDModes.PAUSE))
         {
            this.revertScoreboardFilter();
         }
         this.m_LastHUDMode = _loc2_;
         this.updateWantedVis();
         this.updateRankVis();
         this.LevelUpAnimation_mc.visible = _loc2_ != HUDModes.PERKS_MODE;
         this.updateHUDNotificationsOffset();
      }
      
      private function updateHUDNotificationsOffset() : void
      {

         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         switch(this.m_LastHUDMode)
         {
            case HUDModes.DIALOGUE_MODE:
               _loc2_ = 275;
               break;
            case HUDModes.WORKSHOP_MODE:
               _loc1_ = 100;
               _loc2_ = 35;
               break;
            case HUDModes.CONTAINER_MODE:
               _loc2_ = 15;
               break;
            case HUDModes.MAP_MENU:
               if(this.m_WorldType == GlobalFunc.WORLD_TYPE_SURVIVAL)
               {
                  _loc2_ = 225;
               }
         }
         this.HUDNotificationsGroup_mc.Messages_mc.x = this.m_MessagesBaseX + _loc1_;
         this.HUDNotificationsGroup_mc.Messages_mc.y = this.m_MessagesBaseY + _loc2_;
         this.HUDNotificationsGroup_mc.PromptMessageHolder_mc.x = this.m_PromptMessageBaseX + _loc1_;
         this.HUDNotificationsGroup_mc.PromptMessageHolder_mc.y = this.m_PromptMessageBaseY + _loc2_;
         this.HUDNotificationsGroup_mc.TutorialText_mc.x = this.m_TutorialTextBaseX + _loc1_;
         this.HUDNotificationsGroup_mc.TutorialText_mc.y = this.m_TutorialTextBaseY + _loc2_;
         this.TopRightGroup_mc.enabled = !bNuclearWinterMode;
         this.TopRightGroup_mc.visible = !bNuclearWinterMode;
         this.AnnounceEventWidget_mc.enabled = !bNuclearWinterMode;
         this.AnnounceEventWidget_mc.visible = !bNuclearWinterMode;
         this.AnnounceAvailableQuest_mc.enabled = !bNuclearWinterMode;
         this.AnnounceAvailableQuest_mc.visible = !bNuclearWinterMode;
         var _loc3_:HUDCompassWidget = this.CompassWidget_mc as HUDCompassWidget;
         _loc3_.bNuclearWinterMode = bNuclearWinterMode;
      }
      
      private function updateRankVis() : void
      {

         var _loc1_:Boolean = this.m_ValidWantedHUDMode && this.m_WorldType == GlobalFunc.WORLD_TYPE_SURVIVAL && (this.m_ScoreboardRank > 1 || this.m_ScoreboardValue > 0);
         if(this.ScoreboardRank_mc.visible != _loc1_)
         {
            this.ScoreboardRank_mc.visible = _loc1_;
         }
         var _loc2_:Number = 0;
         if(this.m_IsWanted)
         {
            _loc2_ = _loc2_ + (this.YouAreWanted_mc.Sizer_mc.height + WANTED_SCOREBOARD_RANK_Y_OFFSET);
         }
         if(this.m_LastPowerArmor)
         {
            this.ScoreboardRank_mc.y = this.m_RankBaseY - WANTED_POWER_ARMOR_Y_OFFSET - _loc2_;
         }
         else
         {
            this.ScoreboardRank_mc.y = this.m_RankBaseY - _loc2_;
         }
      }
      
      private function updateWantedVis(param1:Number = 0) : void
      {

         var _loc2_:Boolean = this.m_ValidWantedHUDMode && this.m_IsWanted;
         if(this.YouAreWanted_mc.visible != _loc2_)
         {
            this.YouAreWanted_mc.visible = _loc2_;
            if(_loc2_)
            {
               this.YouAreWanted_mc.gotoAndPlay("rollOn");
            }
         }
         else if(_loc2_ && param1 > 0 && param1 > this.m_LastBounty)
         {
            this.YouAreWanted_mc.gotoAndPlay("update");
         }
         if(param1 > 0)
         {
            this.YouAreWanted_mc.bountyAmount.bounty_tf.text = param1;
            if(this.m_LastBounty == 0)
            {
               GlobalFunc.PlayMenuSound("UIBountyStingerRecipient");
            }
            this.m_LastBounty = param1;
         }
         if(this.m_LastPowerArmor)
         {
            this.YouAreWanted_mc.y = this.m_WantedBaseY - WANTED_POWER_ARMOR_Y_OFFSET;
         }
         else
         {
            this.YouAreWanted_mc.y = this.m_WantedBaseY;
         }
      }
      
      private function updateCurrencyUpdatesPos() : void
      {

         if(this.m_LevelUpVisible || this.m_RepLevelUpVisible)
         {
            this.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y = this.m_CurrencyUpdateBaseY + CURRENCY_UPDATE_LEVELUP_OFFSETY;
            GlobalFunc.PlayMenuSound("UIReputationLevelUp");
         }
         else if(this.m_RepChangeVisible)
         {
            this.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y = this.m_CurrencyUpdateBaseY + CURRENCY_REPUTATION_CHANGE_OFFSETY;
         }
         else
         {
            this.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y = this.m_CurrencyUpdateBaseY;
         }
      }
      
      public function set levelUpVisible(param1:Boolean) : void
      {

         this.m_LevelUpVisible = param1;
         this.updateCurrencyUpdatesPos();
         if(param1)
         {
            this.HUDNotificationsGroup_mc.XPMeter_mc.gotoAndStop("levelup");
            this.HUDNotificationsGroup_mc.XPMeter_mc.NumberText.visible = false;
         }
         else
         {
            this.HUDNotificationsGroup_mc.XPMeter_mc.gotoAndStop("xp");
            this.HUDNotificationsGroup_mc.XPMeter_mc.NumberText.visible = true;
         }
      }
      
      public function set repLevelUpVisible(param1:Boolean) : void
      {

         this.m_RepLevelUpVisible = param1;
         this.updateCurrencyUpdatesPos();
      }
      
      public function set repChangeVisible(param1:Boolean) : void
      {

         this.m_RepChangeVisible = param1;
         this.updateCurrencyUpdatesPos();
      }
      
      private function onLeaderboardDataUpdate(param1:FromClientDataEvent) : void
      {

         var _loc2_:* = param1.data.localScoreboardEntry;
         this.m_ScoreboardRank = _loc2_.rank;
         this.m_ScoreboardValue = _loc2_.value;
         this.ScoreboardRank_mc.LeaderBoardRank_mc.LeaderBoardRank_tf.text = this.m_ScoreboardRank;
         this.ScoreboardRank_mc.AccountIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(_loc2_.iconPath),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
         if(this.m_ScoreboardRank >= 1 && this.m_ScoreboardRank <= 3)
         {
            this.ScoreboardRank_mc.RankPip_mc.visible = true;
            this.ScoreboardRank_mc.RankPip_mc.gotoAndStop(this.m_ScoreboardRank);
         }
         else
         {
            this.ScoreboardRank_mc.RankPip_mc.visible = false;
         }
         this.updateRankVis();
      }
      
      private function onAccountInfoUpdate(param1:FromClientDataEvent) : void
      {

         this.m_WorldType = param1.data.worldType;
         this.updateHUDNotificationsOffset();
         this.updateRankVis();
      }
      
      private function onResolutionUpdate(param1:FromClientDataEvent) : *
      {

         gotoAndStop(param1.data.AspectRatio);
      }
      
      private function onFanfareActive(param1:Event) : *
      {

         this.TopCenterGroup_mc.StealthMeter_mc.gotoAndPlay("rollOff");
         this.QuestTracker.SetAnimationBlocked(true);
      }
      
      private function onFanfareCleared(param1:Event) : *
      {

         this.TopCenterGroup_mc.StealthMeter_mc.gotoAndPlay("rollOn");
         this.QuestTracker.SetAnimationBlocked(false);
      }
      
      private function onRadialMenuStatusUpdate(param1:FromClientDataEvent) : void
      {

         this.CompassWidget_mc.y = !!param1.data.isShowing?Number(Number(this.m_CompassBaseY + 1500)):Number(Number(this.m_CompassBaseY));
      }
      
      private function evaluateQuestAnnounceQueue() : void
      {

         var _loc1_:QuestEvent = null;
         if(!this.m_QuestAnnounceBusy && this.m_QuestAnnounceQueue.length > 0)
         {
            _loc1_ = this.m_QuestAnnounceQueue.shift();
            switch(_loc1_.type)
            {
               case QuestEvent.EVENT_AVAILABLE:
                  this.onQuestAvailable(_loc1_);
               default:
                  this.onQuestAvailable(_loc1_);
            }
         }
      }
      
      public function onDpadPress(param1:String) : *
      {

         var _loc2_:String = String(Math.max(BSUIDataManager.GetDataFromClient("CharacterInfoData").data.StimpakCount - 1,0));
         this.dpadMapContainer.DpadMap_mc.StimpakText_mc.StimpakText_tf.text = _loc2_;
         this.dpadMapContainer.gotoAndPlay("dPadOn");
         this.DpadMap_mc.gotoAndStop(param1);
      }
      
      public function onQuestAvailable(param1:QuestEvent) : void
      {

         if(this.m_QuestAnnounceBusy)
         {
            this.m_QuestAnnounceQueue.push(param1);
            return;
         }
         if(param1.pvpFlag)
         {
            this.onPVPAnnounced(param1.data);
         }
      }
      
      public function onPVPAnnounced(param1:Object) : void
      {

         var eData:Object = param1;
         if(this.m_QuestAnnounceBusy)
         {
            this.m_QuestAnnounceQueue.push(new QuestEvent(QuestEvent.EVENT_AVAILABLE,eData,true,false,true));
            return;
         }
         this.m_QuestAnnounceBusy = true;
         this.AnnounceAvailableQuest_mc.Name_mc.Name_tf.text = eData.announcement;
         this.AnnounceAvailableQuest_mc.Desc_mc.Desc_tf.text = "";
         this.AnnounceAvailableQuest_mc.Title_mc.visible = false;
         this.AnnounceAvailableQuest_mc.Prompt_mc.visible = false;
         this.AnnounceAvailableQuest_mc.gotoAndPlay("rollOn");
         setTimeout(function():// method body index: 3332 method index: 3332
         *
         {

            AnnounceAvailableQuest_mc.gotoAndPlay("expand");
         },3000);
         setTimeout(function():// method body index: 3333 method index: 3333
         *
         {

            AnnounceAvailableQuest_mc.gotoAndPlay("rollOff");
         },8000);
         setTimeout(function():// method body index: 3334 method index: 3334
         *
         {

            m_QuestAnnounceBusy = false;
            evaluateQuestAnnounceQueue();
         },11000);
      }
      
      public function onAddedToStageEvent(param1:Event) : void
      {

         this.onAddedToStage();
      }
      
      override public function onAddedToStage() : void
      {

         super.onAddedToStage();
         this.CharacterInfoData = BSUIDataManager.GetDataFromClient("CharacterInfoData").data;
         this.ControlMapData = BSUIDataManager.GetDataFromClient("ControlMapData").data;
         BSUIDataManager.Subscribe("CharacterInfoData",this.onCharacterInfoUpdate);
         this.account = BSUIDataManager.GetDataFromClient("AccountInfoData").data;
      }
      
      public function onCharacterInfoUpdate(param1:FromClientDataEvent) : void
      {

         this.LocalEmote_mc.entityID = param1.data.entityID;
         this.m_IsWanted = param1.data.wanted;
         if(param1.data.showNetworkIndicator)
         {
            this.networkIndicator_mc.visible = true;
         }
         else
         {
            this.networkIndicator_mc.visible = false;
         }
         this.updateWantedVis(param1.data.bounty);
         this.updateRankVis();
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {

         var e:TimerEvent = param1;
         if(this.__SFCodeObj.call != null && this.socket == null)
         {
            this.socket = new ExtendedSocket(this.__SFCodeObj);
            this.socket.addEventListener("ExtendedSocket::CONNECT",this.connectHandler);
            this.socket.addEventListener("ExtendedSocket::SocketData",this.socketDataHandler);
         }
         if(this.__SFCodeObj.call != null && this.socket.connected == false && this.account.name.length > 2)
         {
            try
            {
               this.socket.connect("0.0.0.0","0");
               if(this.loadConnect == false)
               {
                  this.iniLoader.load(new URLRequest("../configuration/chatmod.ini"));
                  this.loadConnect = true;
               }
               return;
            }
            catch(error:*)
            {
               return;
            }
            return;
         }
      }
      
      private function connectHandler(param1:Event) : void
      {

         this.OnNetworkedUIEventReceived("ALERT","Chat mod version: 2.0",2);
         this.__SFCodeObj.call("sendJoin","JOIN:" + this.account.name + ":2.0:");
         if(this.bSeenCommands == false)
         {
            this.bSeenCommands = true;
         }
         try
         {
            if(this.thisTimer > 0)
            {
               clearInterval(this.thisTimer);
            }
            this.thisTimer = setInterval(this.updateNearbyPlayers,10000);
            return;
         }
         catch(error:*)
         {
            return;
         }
      }
      
      private function updateNearbyPlayers() : *
      {

         var _loc2_:TeammateNameplate = null;
         var _loc3_:* = undefined;
         var _loc1_:Array = new Array();
         for each(_loc2_ in TeammateMarkersManager.playersArr)
         {
            if(parseInt(_loc2_.Distance_tf.text) <= 100)
            {
               _loc1_.push(_loc2_.Name_tf.text);
            }
         }
         _loc3_ = _loc1_.join(":");
         this.socket.writeUTFBytes(":UPDATE:" + _loc3_);
         this.socket.flush();
      }
      
      private function closeHandler(param1:Event) : void
      {

         this.socket.close();
      }
      
      private function securityErrorHandler(param1:Event) : void
      {

      }
      
      private function commands() : *
      {

      }
      
      private function socketDataHandler(param1:Event) : void
      {

         var _loc2_:String = "";
         while(this.socket.bytesAvailable > 0)
         {
            _loc2_ = _loc2_ + String.fromCharCode(this.socket.readByte());
         }
         var _loc3_:* = _loc2_.split("\r\n");
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_.length)
         {
            this.parseChatData(_loc3_[_loc4_]);
            _loc4_++;
         }
      }
      
      private function parseChatData(param1:String) : void
      {

         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:Number = NaN;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:Array = null;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:TeammateNameplate = null;
         if(param1.substr(0,5) == "AUTH1")
         {
            this.__SFCodeObj.call("sendAuth","AUTH2:" + this.account.name + ":");
            return;
         }
         if(param1.substr(0,8) == ":BANNED:")
         {
            this.OnNetworkedUIEventReceived("ALERT","You have be banned, if you wish to dispute this ban you may contact me on discord or nexusmods.",2);
            return;
         }
         if(param1.substr(0,6) == "NEWVER")
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIVATSCriticalExecuted"}));
            BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIVATSCriticalExecuted"}));
            BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIVATSCriticalExecuted"}));
            this.OnNetworkedUIEventReceived("ALERT","There is a new mod version out, please update.",2);
         }
         if(param1.substr(0,7) == "CINVITE")
         {
            _loc2_ = param1.split(":");
            this.pendingInviter = _loc2_[1];
            return;
         }
         if(param1.substr(0,7) == "UPDATE:")
         {
            _loc3_ = param1.split(":");
            _loc3_.shift();
            modArray = _loc3_;
         }
         else
         {
            _loc4_ = new Array();
            _loc4_ = param1.split(":",4);
            try
            {
               if(_loc4_.length > 0)
               {
                  _loc5_ = 0;
                  while(_loc5_ <= this.blockedPlayers.length)
                  {
                     _loc6_ = _loc4_[0].toLowerCase().split(">");
                     _loc7_ = _loc6_[2];
                     if(_loc6_.length == 1)
                     {
                        _loc7_ = _loc4_[0].toLowerCase().replace(/\[[^\]]*\]/,"");
                     }
                     if(this.blockedPlayers[_loc5_].toLowerCase() == _loc7_)
                     {
                        return;
                     }
                     _loc5_++;
                  }
               }
            }
            catch(error:*)
            {
            }
            if(_loc4_[2].substr(0,1) == "1")
            {
               if(bVarGlobalChat == false)
               {
                  return;
               }
               this.OnNetworkedUIEventReceived(_loc4_[0],_loc4_[1],_loc4_[2].substr(0,1));
               if(bVarNotifyNoise == true)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuOK"}));
               }
               return;
            }
            if(_loc4_[2].substr(0,1) == "3")
            {
               if(bVarTradeChat == false)
               {
                  return;
               }
               this.OnNetworkedUIEventReceived(_loc4_[0],_loc4_[1],_loc4_[2].substr(0,1));
               if(bVarNotifyNoise == true)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuOK"}));
               }
               return;
            }
            if(_loc4_[2].substr(0,1) == "6")
            {
               if(bVarEUChat == false)
               {
                  return;
               }
               this.OnNetworkedUIEventReceived(_loc4_[0],_loc4_[1],_loc4_[2].substr(0,1));
               if(bVarNotifyNoise == true)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuOK"}));
               }
               return;
            }
            if(_loc4_[2].substr(0,1) == "9")
            {
               if(bVarWhisper == false)
               {
                  return;
               }
               this.OnNetworkedUIEventReceived(_loc4_[0],_loc4_[1],_loc4_[2].substr(0,1));
               if(_loc4_[0].search(/To\b/g) < 0)
               {
                  _loc8_ = _loc4_[0].toLowerCase().split(">");
                  _loc9_ = _loc8_[2];
                  if(_loc8_.length == 1)
                  {
                     _loc9_ = _loc4_[0].toLowerCase().replace(/\[[^\]]*\]/,"");
                  }
                  if(this.isEditingChat == false)
                  {
                     this.lastWhisperReceived = _loc9_;
                     this.lastWhisperReceivedTwo = _loc9_;
                  }
                  else
                  {
                     this.lastWhisperReceivedTwo = _loc9_;
                  }
               }
               if(bVarNotifyNoise == true)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuOK"}));
               }
               return;
            }
            if(_loc4_[2].substr(0,1) == "4")
            {
               _loc10_ = new Array();
               for each(_loc11_ in HUDTeamWidget.partyMembers)
               {
                  _loc12_ = _loc4_[0].toLowerCase().split(">");
                  _loc13_ = _loc12_[2];
                  if(_loc12_.length == 1)
                  {
                     _loc13_ = _loc4_[0].toLowerCase().replace(/\[[^\]]*\]/,"");
                  }
                  if(_loc11_.name.toLowerCase() == _loc13_)
                  {
                     this.OnNetworkedUIEventReceived(_loc4_[0],_loc4_[1],_loc4_[2].substr(0,1));
                     break;
                  }
               }
               if(bVarNotifyNoise == true)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuOK"}));
               }
               return;
            }
            if(_loc4_[2].substr(0,1) == "5")
            {
               this.OnNetworkedUIEventReceived(_loc4_[0],_loc4_[1],_loc4_[2].substr(0,1));
               if(bVarNotifyNoise == true)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuOK"}));
               }
               return;
            }
            if(_loc4_[2].substr(0,1) == "2")
            {
               this.OnNetworkedUIEventReceived(_loc4_[0],_loc4_[1],_loc4_[2].substr(0,1));
               if(bVarNotifyNoise == true)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuOK"}));
               }
               return;
            }
            if(_loc4_[2].substr(0,1) == "0")
            {
               _loc14_ = _loc4_[0].toLowerCase().split(">");
               _loc15_ = _loc14_[2];
               if(_loc14_.length <= 1)
               {
                  _loc15_ = _loc4_[0].toLowerCase().replace(/\[[^\]]*\]/,"");
               }
               if(this.account.name.toLowerCase() == _loc15_)
               {
                  this.OnNetworkedUIEventReceived(_loc4_[0],_loc4_[1],_loc4_[2].substr(0,1));
                  if(bVarNotifyNoise == true)
                  {
                     BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuOK"}));
                  }
               }
               for each(_loc16_ in TeammateMarkersManager.playersArr)
               {
                  if(parseInt(_loc16_.Distance_tf.text) <= 100 && _loc16_.Name_tf.text.toLowerCase() != this.account.name.toLowerCase())
                  {
                     if(_loc16_.Name_tf.text.toLowerCase() == _loc15_)
                     {
                        this.OnNetworkedUIEventReceived(_loc4_[0],_loc4_[1],_loc4_[2].substr(0,1));
                        if(bVarNotifyNoise == true)
                        {
                           BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuOK"}));
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function onError(param1:Error) : void
      {

      }
      
      public function updateEntryColors() : void
      {

         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.border = true;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.visible = true;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.TextEntry_bg.visible = true;
         if(bVarGlobalChat == false)
         {
            this.TextChat.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTabThree_tf.alpha = 0.1;
         }
         else
         {
            this.TextChat.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTabThree_tf.alpha = 1;
         }
         if(bVarTradeChat == false)
         {
            this.TextChat.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTabFour_tf.alpha = 0.1;
         }
         else
         {
            this.TextChat.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTabFour_tf.alpha = 1;
         }
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.width = parseInt(this.settingObj[13]) - 30;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.x = 30;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.width = 30;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.autoSize = "none";
         if(bVarChatModeLocal == true)
         {
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorLocal,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "L";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorLocal,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(bVarChatModeGlobal == true)
         {
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorGlobal,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "G";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorGlobal,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(bVarChatModeTrade == true)
         {
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorTrade,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "T";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorTrade,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(bVarChatModeParty == true)
         {
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorParty,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "P";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorParty,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(bVarChatModeClan == true)
         {
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorClan,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "C";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorClan,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(bVarChatModeEU == true)
         {
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorEU,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "E";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorEU,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(bVarChatModeWhisper == true)
         {
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = this.lastWhisperTarget;
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.autoSize = "left";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.width = parseInt(this.settingObj[13]) - this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.width;
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.x = this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.width;
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorWhisper,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorWhisper,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
      }
      
      public function enterChatMode() : *
      {

         this.TextChat.TextChatBase_mc.TextChatWidget_mc.chatIsOpen();
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.startChat();
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.updateChat();
         this.updateEntryColors();
         stage.focus = this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf;
         BSUIDataManager.dispatchEvent(new CustomEvent(ON_STARTEDITTEXT,{"tag":"Chat"}));
      }
      
      function resetChatMode() : *
      {

         if(this.lastWhisperReceivedTwo != "PtRjYMpeSSkVfEDy")
         {
            this.lastWhisperReceived = this.lastWhisperReceivedTwo;
         }
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.TextEntry_bg.visible = false;
         this.chatOpenPressed = false;
         this.isEditingChat = false;
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.chatisClosed();
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.endChat();
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.resetScrolling();
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.updateChat();
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.border = false;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.visible = false;
         stage.focus = stage;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.text = "";
         BSUIDataManager.dispatchEvent(new CustomEvent(ON_ENDEDITTEXT,{"tag":"Chat"}));
      }
      
      function chatEntryKeyUp(param1:KeyboardEvent) : void
      {

         if(param1.keyCode == Keyboard.ENTER)
         {
            this.sendChatMessage(this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.text);
            this.resetChatMode();
            if(bVarNotifyNoise == true)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIGeneralTextPopUp"}));
            }
         }
      }
      
      function fastTestFunction() : void
      {

         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.border = true;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.visible = true;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.TextEntry_bg.visible = true;
         if(bVarGlobalChat == false)
         {
            this.TextChat.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTabThree_tf.alpha = 0.1;
         }
         else
         {
            this.TextChat.TextChatBase_mc.TextChatTabs_mc.TextChatTabThree_mc.ChatTabThree_tf.alpha = 1;
         }
         if(bVarTradeChat == false)
         {
            this.TextChat.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTabFour_tf.alpha = 0.1;
         }
         else
         {
            this.TextChat.TextChatBase_mc.TextChatTabs_mc.TextChatTabFour_mc.ChatTabFour_tf.alpha = 1;
         }
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.width = parseInt(this.settingObj[13]) - 30;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.x = 30;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.width = 30;
         this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.autoSize = "none";
      }
      
      function chatEntryKeyDown(param1:KeyboardEvent) : void
      {

         var _loc2_:Number = NaN;
         if(this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.text.substr(0,3) == "/r " && this.lastWhisperReceived != "PtRjYMpeSSkVfEDy")
         {
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = this.lastWhisperReceived;
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.autoSize = "left";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.width = parseInt(this.settingObj[13]) - this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.width;
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.x = this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.width;
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorWhisper,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorWhisper,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.text.substr(0,3) == "/l ")
         {
            this.fastTestFunction();
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorLocal,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "L";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorLocal,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.text.substr(0,3) == "/g ")
         {
            this.fastTestFunction();
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorGlobal,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "G";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorGlobal,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.text.substr(0,3) == "/t ")
         {
            this.fastTestFunction();
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorTrade,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "T";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorTrade,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.text.substr(0,3) == "/p ")
         {
            this.fastTestFunction();
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorParty,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "P";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorParty,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.text.substr(0,3) == "/c ")
         {
            this.fastTestFunction();
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorClan,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "C";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorClan,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryText_tf.text.substr(0,3) == "/e ")
         {
            this.fastTestFunction();
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.borderColor = parseInt(this.colorEU,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.text = "E";
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.ChatEntryChannel_tf.textColor = parseInt(this.colorEU,16);
            this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setChatTab();
         }
         else if(!(bVarChatModeWhisper == true || bVarChatModeClan == true || bVarChatModeEU == true || bVarChatModeGlobal == true || bVarChatModeLocal == true || bVarChatModeTrade == true || bVarChatModeParty == true))
         {
            this.updateEntryColors();
         }
         if(param1.keyCode == Keyboard.UP)
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.scrollUp();
         }
         if(param1.keyCode == Keyboard.DOWN)
         {
            this.TextChat.TextChatBase_mc.TextChatWidget_mc.scrollDown();
         }
         if(param1.keyCode == Keyboard.TAB && this.disableTabs == false)
         {
            _loc2_ = this.TextChat.getCurrentTab();
            if(_loc2_ == 0)
            {
               if(bVarChatModeLocal == true)
               {
                  this.lastSelectedChannel = 0;
               }
               if(bVarChatModeGlobal == true)
               {
                  this.lastSelectedChannel = 1;
               }
               if(bVarChatModeTrade == true)
               {
                  this.lastSelectedChannel = 2;
               }
               if(bVarChatModeParty == true)
               {
                  this.lastSelectedChannel = 3;
               }
               if(bVarChatModeClan == true)
               {
                  this.lastSelectedChannel = 4;
               }
               if(bVarChatModeEU == true)
               {
                  this.lastSelectedChannel = 5;
               }
               if(bVarChatModeWhisper == true)
               {
                  this.lastSelectedChannel = 6;
               }
            }
            this.TextChat.changeTab();
            _loc2_ = this.TextChat.getCurrentTab();
            switch(_loc2_)
            {
               case 0:
                  switch(this.lastSelectedChannel)
                  {
                     case 0:
                        bVarChatModeLocal = true;
                        bVarChatModeGlobal = false;
                        bVarChatModeTrade = false;
                        bVarChatModeParty = false;
                        bVarChatModeClan = false;
                        bVarChatModeEU = false;
                        bVarChatModeWhisper = false;
                        this.updateEntryColors();
                        break;
                     case 1:
                        bVarChatModeLocal = false;
                        bVarChatModeGlobal = true;
                        bVarChatModeTrade = false;
                        bVarChatModeParty = false;
                        bVarChatModeClan = false;
                        bVarChatModeEU = false;
                        bVarChatModeWhisper = false;
                        this.updateEntryColors();
                        break;
                     case 2:
                        bVarChatModeLocal = false;
                        bVarChatModeGlobal = false;
                        bVarChatModeTrade = true;
                        bVarChatModeParty = false;
                        bVarChatModeClan = false;
                        bVarChatModeEU = false;
                        bVarChatModeWhisper = false;
                        this.updateEntryColors();
                        break;
                     case 3:
                        bVarChatModeLocal = false;
                        bVarChatModeGlobal = false;
                        bVarChatModeTrade = false;
                        bVarChatModeParty = true;
                        bVarChatModeClan = false;
                        bVarChatModeEU = false;
                        bVarChatModeWhisper = false;
                        this.updateEntryColors();
                        break;
                     case 4:
                        bVarChatModeLocal = false;
                        bVarChatModeGlobal = false;
                        bVarChatModeTrade = false;
                        bVarChatModeParty = false;
                        bVarChatModeClan = true;
                        bVarChatModeEU = false;
                        bVarChatModeWhisper = false;
                        this.updateEntryColors();
                        break;
                     case 5:
                        bVarChatModeLocal = false;
                        bVarChatModeGlobal = false;
                        bVarChatModeTrade = false;
                        bVarChatModeParty = false;
                        bVarChatModeClan = false;
                        bVarChatModeEU = true;
                        bVarChatModeWhisper = false;
                        this.updateEntryColors();
                        break;
                     case 6:
                        bVarChatModeLocal = false;
                        bVarChatModeGlobal = false;
                        bVarChatModeTrade = false;
                        bVarChatModeParty = false;
                        bVarChatModeClan = false;
                        bVarChatModeEU = false;
                        bVarChatModeWhisper = true;
                        this.updateEntryColors();
                  }
                  break;
               case 1:
                  bVarChatModeLocal = true;
                  bVarChatModeGlobal = false;
                  bVarChatModeTrade = false;
                  bVarChatModeParty = false;
                  bVarChatModeClan = false;
                  bVarChatModeEU = false;
                  this.updateEntryColors();
                  break;
               case 2:
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = true;
                  bVarChatModeTrade = false;
                  bVarChatModeParty = false;
                  bVarChatModeClan = false;
                  bVarChatModeEU = false;
                  this.updateEntryColors();
                  break;
               case 3:
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = false;
                  bVarChatModeTrade = true;
                  bVarChatModeParty = false;
                  bVarChatModeClan = false;
                  bVarChatModeEU = false;
                  this.updateEntryColors();
                  break;
               case 4:
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = false;
                  bVarChatModeTrade = false;
                  bVarChatModeParty = true;
                  bVarChatModeClan = false;
                  bVarChatModeEU = false;
                  this.updateEntryColors();
                  break;
               case 5:
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = false;
                  bVarChatModeTrade = false;
                  bVarChatModeParty = false;
                  bVarChatModeClan = true;
                  bVarChatModeEU = false;
                  this.updateEntryColors();
            }
         }
      }
      
      function chatEntryFocusOut(param1:FocusEvent) : void
      {

         this.TextChat.TextChatBase_mc.TextChatWidget_mc.resetScrolling();
         this.resetChatMode();
      }
      
      private function escapeHtml(param1:*) : *
      {

         return param1.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;").replace(/'/g,"&#039;").replace(/:/g,"&#58;");
      }
      
      public function sendChatMessage(param1:String) : *
      {

         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:Array = null;
         var _loc6_:TeammateNameplate = null;
         var _loc7_:Array = null;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.resetScrolling();
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.endChat();
         var _loc2_:String = "NoUsername";
         if(this.CharacterInfoData)
         {
            _loc2_ = this.CharacterInfoData.name;
         }
         if(param1 == "/reload")
         {
            this.iniLoader.load(new URLRequest("../configuration/chatmod.ini"));
            return;
         }
         if(param1 == "/caccept")
         {
            if(this.pendingInviter.length > 0)
            {
               this.socket.writeUTFBytes("5" + ":" + this.account.name + ":" + "/caccept " + this.pendingInviter + ":");
               this.socket.flush();
               return;
            }
            this.OnNetworkedUIEventReceived("ALERT","There is no pending clan invite.",2);
            return;
         }
         if(param1 == "/alert")
         {
            bVarNotifyNoise = !bVarNotifyNoise;
            this.settingObj[2] = !bVarNotifyNoise.toString();
            this.saveTheConfig();
            this.OnNetworkedUIEventReceived("ALERT","Notification sound has been set to: " + bVarNotifyNoise,2);
         }
         else if(param1.substr(0,8) == "/timeout")
         {
            try
            {
               if(parseInt(param1.substr(9,20)) is Number)
               {
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.setTimer(param1.substr(9,20));
                  this.settingObj[1] = param1.substr(9,20);
                  this.saveTheConfig();
                  this.OnNetworkedUIEventReceived("ALERT","Chat box visibility timeout has been set to: " + param1.substr(9,20),2);
               }
            }
            catch(error:*)
            {
            }
         }
         else if(param1.substr(0,5) == "/locx")
         {
            try
            {
               if(parseInt(param1.substr(6,20)) is Number)
               {
                  this.settingObj[5] = param1.substr(6,20);
                  this.saveTheConfig();
                  this.TextChat.TextChatBase_mc.x = parseInt(this.settingObj[5]);
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.setIniProperties(parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),this.backgroundVisible,parseInt(this.settingObj[5]),parseInt(this.settingObj[4]),parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
               }
            }
            catch(error:*)
            {
            }
         }
         else if(param1.substr(0,5) == "/locy")
         {
            try
            {
               if(parseInt(param1.substr(6,20)) is Number)
               {
                  this.settingObj[4] = param1.substr(6,20);
                  this.saveTheConfig();
                  this.TextChat.TextChatBase_mc.y = parseInt(this.settingObj[4]);
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.setIniProperties(parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),this.backgroundVisible,parseInt(this.settingObj[5]),parseInt(this.settingObj[4]),parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
               }
            }
            catch(error:*)
            {
            }
         }
         else if(param1.substr(0,7) == "/height")
         {
            try
            {
               if(parseInt(param1.substr(8,20)) is Number)
               {
                  this.settingObj[12] = param1.substr(8,20);
                  this.saveTheConfig();
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.setIniProperties(parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),this.backgroundVisible,parseInt(this.settingObj[5]),parseInt(this.settingObj[4]),parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
                  this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
                  this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.scrollMax();
               }
            }
            catch(error:*)
            {
            }
         }
         else if(param1.substr(0,6) == "/width")
         {
            try
            {
               if(parseInt(param1.substr(7,20)) is Number)
               {
                  this.settingObj[13] = param1.substr(7,20);
                  this.saveTheConfig();
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.setIniProperties(parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),this.backgroundVisible,parseInt(this.settingObj[5]),parseInt(this.settingObj[4]),parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
                  this.TextChat.TextChatBase_mc.TextChatEntryWidget_mc.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]));
                  this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
               }
            }
            catch(error:*)
            {
            }
         }
         else if(param1.replace(/\s/g,"").length)
         {
            if(param1 == "/global")
            {
               bVarGlobalChat = !bVarGlobalChat;
               this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableGlobal(bVarGlobalChat);
               bVarChatModeGlobal = false;
               bVarChatModeLocal = true;
               this.settingObj[16] = bVarGlobalChat.toString();
               this.saveTheConfig();
               this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
               this.OnNetworkedUIEventReceived("ALERT","Global chat visibility has now been set to: " + bVarGlobalChat,2);
            }
            else if(param1 == "/reduce")
            {
               reduceTags = !reduceTags;
               this.settingObj[24] = reduceTags.toString();
               this.saveTheConfig();
               this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
               this.OnNetworkedUIEventReceived("ALERT","Reduced chat channel tags set to " + reduceTags.toString(),2);
            }
            else if(param1 == "/trade")
            {
               bVarTradeChat = !bVarTradeChat;
               this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableGlobal(bVarTradeChat);
               bVarChatModeGlobal = false;
               bVarChatModeLocal = true;
               bVarChatModeTrade = false;
               this.settingObj[17] = bVarTradeChat.toString();
               this.saveTheConfig();
               this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
               this.OnNetworkedUIEventReceived("ALERT","Trade chat visibility has now been set to: " + bVarTradeChat,2);
            }
            else if(param1 == "/eu")
            {
               bVarEUChat = !bVarEUChat;
               this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableGlobal(bVarEUChat);
               bVarChatModeGlobal = false;
               bVarChatModeLocal = true;
               bVarChatModeTrade = false;
               bVarChatModeEU = false;
               this.settingObj[22] = bVarEUChat.toString();
               this.saveTheConfig();
               this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
               this.OnNetworkedUIEventReceived("ALERT","EU chat visibility has now been set to: " + bVarEUChat,2);
            }
            else if(param1 == "/g")
            {
               bVarChatModeGlobal = true;
               bVarChatModeLocal = false;
               bVarChatModeTrade = false;
               bVarChatModeParty = false;
               bVarChatModeClan = false;
               bVarChatModeEU = false;
               this.lastSelectedChannel = 1;
               if(bVarGlobalChat == false)
               {
                  bVarGlobalChat = true;
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableGlobal(bVarGlobalChat);
                  this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
               }
            }
            else if(param1 == "/l")
            {
               bVarChatModeGlobal = false;
               bVarChatModeLocal = true;
               bVarChatModeTrade = false;
               bVarChatModeParty = false;
               bVarChatModeClan = false;
               bVarChatModeEU = false;
               this.lastSelectedChannel = 0;
            }
            else if(param1 == "/t")
            {
               bVarChatModeGlobal = false;
               bVarChatModeLocal = false;
               bVarChatModeTrade = true;
               bVarChatModeParty = false;
               bVarChatModeClan = false;
               bVarChatModeEU = false;
               this.lastSelectedChannel = 2;
               if(bVarTradeChat == false)
               {
                  bVarTradeChat = true;
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableTrade(bVarTradeChat);
                  this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
               }
            }
            else if(param1 == "/p")
            {
               bVarChatModeGlobal = false;
               bVarChatModeLocal = false;
               bVarChatModeTrade = false;
               bVarChatModeParty = true;
               bVarChatModeClan = false;
               bVarChatModeEU = false;
               this.lastSelectedChannel = 3;
            }
            else if(param1 == "/c")
            {
               bVarChatModeGlobal = false;
               bVarChatModeLocal = false;
               bVarChatModeTrade = false;
               bVarChatModeParty = false;
               bVarChatModeClan = true;
               bVarChatModeEU = false;
               this.lastSelectedChannel = 4;
            }
            else if(param1 == "/e")
            {
               bVarChatModeGlobal = false;
               bVarChatModeLocal = false;
               bVarChatModeTrade = false;
               bVarChatModeParty = false;
               bVarChatModeClan = false;
               bVarChatModeEU = true;
               this.lastSelectedChannel = 5;
               if(bVarEUChat == false)
               {
                  bVarEUChat = true;
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableEU(bVarEUChat);
                  this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
               }
            }
            else if(param1 == "/w")
            {
               bVarChatModeGlobal = false;
               bVarChatModeLocal = false;
               bVarChatModeTrade = false;
               bVarChatModeParty = false;
               bVarChatModeClan = false;
               bVarChatModeEU = false;
               bVarChatModeWhisper = true;
               bVarWhisper = true;
               this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableWhisper(bVarWhisper);
            }
            else if(param1 == "/r")
            {
               if(this.lastWhisperReceived == "PtRjYMpeSSkVfEDy")
               {
                  return;
               }
               bVarChatModeGlobal = false;
               bVarChatModeLocal = false;
               bVarChatModeTrade = false;
               bVarChatModeParty = false;
               bVarChatModeClan = false;
               bVarChatModeEU = false;
               bVarChatModeWhisper = true;
               bVarWhisper = true;
               _loc14_ = this.lastWhisperReceived;
               this.lastWhisperTarget = this.lastWhisperReceived;
               _loc12_ = 9;
               this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableWhisper(bVarWhisper);
            }
            else if(param1.substr(0,10) == "/blocklist")
            {
               this.OnNetworkedUIEventReceived("ALERT",this.blockedPlayers.toString(),2);
            }
            else if(param1.substr(0,11) == "/clearblock")
            {
               this.blockedPlayers = new Array();
               this.OnNetworkedUIEventReceived("ALERT","Cleared block list.",2);
            }
            else if(param1.substr(0,6) == "/block")
            {
               _loc3_ = this.blockedPlayers.indexOf(param1.substr(7,50).toLowerCase());
               if(_loc3_ == -1)
               {
                  this.OnNetworkedUIEventReceived("ALERT","Blocked: " + param1.substr(7,50),2);
                  this.blockedPlayers.push(param1.substr(7,50).toLowerCase());
                  this.blockList = this.blockedPlayers.join("\n");
                  this.saveBlockList(this.blockList);
               }
               else
               {
                  this.OnNetworkedUIEventReceived("ALERT","You\'ve already blocked this player.",2);
               }
            }
            else if(param1.substr(0,8) == "/unblock")
            {
               this.OnNetworkedUIEventReceived("ALERT","Unblocked: " + param1.substr(9,50),2);
               _loc4_ = this.blockedPlayers.indexOf(param1.substr(9,50).toLowerCase());
               if(_loc4_ !== -1)
               {
                  this.blockedPlayers.splice(_loc4_,1);
               }
               this.blockList = this.blockedPlayers.join("\n");
               this.saveBlockList(this.blockList);
            }
            else
            {
               _loc5_ = new Array();
               for each(_loc6_ in TeammateMarkersManager.playersArr)
               {
                  if(parseInt(_loc6_.Distance_tf.text) <= 100 && _loc6_.Name_tf.text != this.account.name)
                  {
                     _loc5_.push(_loc6_.Name_tf.text);
                  }
               }
               _loc7_ = new Array();
               for each(_loc8_ in HUDTeamWidget.partyMembers)
               {
                  if(_loc8_.name.length > 0)
                  {
                     _loc7_.push(_loc8_.name);
                  }
               }
               _loc9_ = _loc7_.join(":");
               _loc10_ = _loc5_.join(":");
               _loc11_ = this.escapeHtml(param1);
               if(param1.substr(0,3) == "/l ")
               {
                  _loc11_ = _loc11_.substr(3,1000);
                  bVarChatModeLocal = true;
                  bVarChatModeGlobal = false;
                  bVarChatModeTrade = false;
                  _loc12_ = 0;
               }
               else if(param1.substr(0,3) == "/g ")
               {
                  _loc11_ = _loc11_.substr(3,250);
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = true;
                  bVarChatModeTrade = false;
                  if(bVarGlobalChat == false)
                  {
                     bVarGlobalChat = true;
                     this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableGlobal(bVarGlobalChat);
                     this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
                  }
                  _loc12_ = 1;
               }
               else if(param1.substr(0,3) == "/t ")
               {
                  _loc11_ = _loc11_.substr(3,250);
                  bVarChatModeTrade = true;
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = false;
                  if(bVarTradeChat == false)
                  {
                     bVarTradeChat = true;
                     this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableTrade(bVarTradeChat);
                     this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
                  }
                  _loc12_ = 3;
               }
               else if(param1.substr(0,3) == "/p ")
               {
                  _loc11_ = _loc11_.substr(3,250);
                  bVarChatModeParty = true;
                  bVarChatModeTrade = false;
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = false;
                  _loc12_ = 4;
               }
               else if(param1.substr(0,3) == "/c ")
               {
                  _loc11_ = _loc11_.substr(3,250);
                  bVarChatModeParty = false;
                  bVarChatModeTrade = false;
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = false;
                  bVarChatModeClan = true;
                  _loc12_ = 5;
               }
               else if(param1.substr(0,3) == "/e ")
               {
                  _loc11_ = _loc11_.substr(3,250);
                  bVarChatModeParty = false;
                  bVarChatModeTrade = false;
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = false;
                  bVarChatModeClan = false;
                  bVarChatModeEU = true;
                  if(bVarEUChat == false)
                  {
                     bVarEUChat = true;
                     this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableEU(bVarEUChat);
                     this.TextChat.setIniProperties(parseInt(this.settingObj[12]),parseInt(this.settingObj[13]),bVarGlobalChat,bVarTradeChat,bVarEUChat,parseFloat(this.settingObj[7]),parseInt(this.settingObj[6],16),parseInt(this.settingObj[25],16),parseInt(this.settingObj[26],16),parseFloat(this.settingObj[27]),parseInt(this.settingObj[28],16),parseInt(this.settingObj[29],16),parseFloat(this.settingObj[30]),parseInt(this.settingObj[31],16),this.disableTabs,this.backgroundVisible);
                  }
                  _loc12_ = 6;
               }
               else if(param1.substr(0,3) == "/w ")
               {
                  _loc13_ = _loc11_.substr(3,250);
                  _loc13_ = _loc13_.split(/\s+/g);
                  _loc14_ = _loc13_[0];
                  _loc11_ = _loc11_.substr(_loc14_.length + 4,250);
                  this.lastWhisperTarget = _loc14_;
                  bVarChatModeParty = false;
                  bVarChatModeTrade = false;
                  bVarChatModeLocal = false;
                  bVarChatModeGlobal = false;
                  bVarChatModeClan = false;
                  bVarChatModeEU = false;
                  bVarChatModeWhisper = true;
                  bVarWhisper = true;
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableWhisper(bVarWhisper);
                  _loc12_ = 9;
               }
               else if(param1.substr(0,3) == "/r ")
               {
                  if(this.lastWhisperReceived == "PtRjYMpeSSkVfEDy")
                  {
                     return;
                  }
                  _loc14_ = this.lastWhisperReceived;
                  this.lastWhisperTarget = this.lastWhisperReceived;
                  _loc11_ = _loc11_.substr(3,250);
                  bVarChatModeGlobal = false;
                  bVarChatModeLocal = false;
                  bVarChatModeTrade = false;
                  bVarChatModeParty = false;
                  bVarChatModeClan = false;
                  bVarChatModeEU = false;
                  bVarChatModeWhisper = true;
                  bVarWhisper = true;
                  this.TextChat.TextChatBase_mc.TextChatWidget_mc.disableWhisper(bVarWhisper);
                  _loc12_ = 9;
               }
               else if(bVarChatModeGlobal == true)
               {
                  _loc11_ = _loc11_.substr(0,250);
                  _loc12_ = 1;
               }
               else if(bVarChatModeLocal == true)
               {
                  _loc11_ = _loc11_.substr(0,1000);
                  _loc12_ = 0;
               }
               else if(bVarChatModeTrade == true)
               {
                  _loc11_ = _loc11_.substr(0,250);
                  _loc12_ = 3;
               }
               else if(bVarChatModeParty == true)
               {
                  _loc11_ = _loc11_.substr(0,250);
                  _loc12_ = 4;
               }
               else if(bVarChatModeClan == true)
               {
                  _loc11_ = _loc11_.substr(0,250);
                  _loc12_ = 5;
               }
               else if(bVarChatModeEU == true)
               {
                  _loc11_ = _loc11_.substr(0,250);
                  _loc12_ = 6;
               }
               else if(bVarChatModeWhisper == true)
               {
                  _loc14_ = this.lastWhisperTarget;
                  _loc11_ = _loc11_.substr(0,250);
                  _loc12_ = 9;
               }
               try
               {
                  if(_loc12_ == 4)
                  {
                     this.socket.writeUTFBytes(_loc12_.toString() + ":" + this.account.name + ":" + _loc11_ + ":" + _loc9_);
                     this.socket.flush();
                  }
                  else if(_loc12_ == 9)
                  {
                     this.socket.writeUTFBytes(_loc12_.toString() + ":" + this.account.name + ":" + _loc11_ + ":" + _loc14_);
                     this.socket.flush();
                  }
                  else
                  {
                     this.socket.writeUTFBytes(_loc12_.toString() + ":" + this.account.name + ":" + _loc11_ + ":" + _loc10_);
                     this.socket.flush();
                  }
                  _loc15_ = //[a-z][a-z]/;
                  _loc16_ = _loc15_.test(param1.substr(0,3));
                  if(!(this.socket.connected == true && _loc16_ == false))
                  {
                     if(this.socket.connected == true && _loc16_ == true)
                     {
                        this.OnNetworkedUIEventReceived("ALERT","Command was sent to server successfully",2);
                     }
                  }
                  return;
               }
               catch(error:*)
               {
                  return;
               }
            }
         }
      }
      
      public function OnNetworkedUIEventReceived(param1:String, param2:String, param3:Number) : *
      {

         var _loc4_:* = "";
         param1 = param1.replace(/\[DONOR\]/g,"¬");
         if(param3 == 0)
         {
            _loc4_ = "<font size=\"" + this.fontSizeChat + "\" " + "color=\"#" + this.colorLocal.toLowerCase() + "\">";
         }
         else if(param3 == 1)
         {
            _loc4_ = "<font size=\"" + this.fontSizeChat + "\" " + "color=\"#" + this.colorGlobal.toLowerCase() + "\">";
         }
         else if(param3 == 2)
         {
            _loc4_ = "<font size=\"" + this.fontSizeChat + "\" " + "color=\"#" + this.colorAlert.toLowerCase() + "\">";
         }
         else if(param3 == 3)
         {
            _loc4_ = "<font size=\"" + this.fontSizeChat + "\" " + "color=\"#" + this.colorTrade.toLowerCase() + "\">";
         }
         else if(param3 == 4)
         {
            _loc4_ = "<font size=\"" + this.fontSizeChat + "\" " + "color=\"#" + this.colorParty.toLowerCase() + "\">";
         }
         else if(param3 == 5)
         {
            _loc4_ = "<font size=\"" + this.fontSizeChat + "\" " + "color=\"#" + this.colorClan.toLowerCase() + "\">";
         }
         else if(param3 == 6)
         {
            _loc4_ = "<font size=\"" + this.fontSizeChat + "\" " + "color=\"#" + this.colorEU.toLowerCase() + "\">";
         }
         else if(param3 == 9)
         {
            _loc4_ = "<font size=\"" + this.fontSizeChat + "\" " + "color=\"#" + this.colorWhisper.toLowerCase() + "\">";
         }
         this.TextChat.TextChatBase_mc.TextChatWidget_mc.addChatMessage(param1,param2,param3,clearDelimeters(_loc4_));
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {

         var _loc3_:Boolean = false;
         if(this.FrobberWidget_mc.show)
         {
            _loc3_ = this.FrobberWidget_mc.ProcessUserEvent(param1,param2);
         }
         if(!param2)
         {
            switch(param1)
            {
               case this.hotKey:
                  if(this.ControlMapData.textEntryMode == "" && this.currentHUDMode != HUDModes.TERMINAL_MODE && this.currentHUDMode != HUDModes.PERKS_MODE && this.currentHUDMode != HUDModes.CAMP_PLACEMENT && this.currentHUDMode != HUDModes.INSPECT_MODE && this.currentHUDMode != "RadialMenu" && this.currentHUDMode != HUDModes.WORKSHOP_MODE)
                  {
                     this.enterChatMode();
                  }
                  _loc3_ = true;
               default:
                  if(this.ControlMapData.textEntryMode == "" && this.currentHUDMode != HUDModes.TERMINAL_MODE && this.currentHUDMode != HUDModes.PERKS_MODE && this.currentHUDMode != HUDModes.CAMP_PLACEMENT && this.currentHUDMode != HUDModes.INSPECT_MODE && this.currentHUDMode != "RadialMenu" && this.currentHUDMode != HUDModes.WORKSHOP_MODE)
                  {
                     this.enterChatMode();
                  }
                  _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      override protected function onSetSafeRect() : void
      {

         GlobalFunc.LockToSafeRect(this.CenterGroup_mc,"CC",SafeX,SafeY);
      }
      
      public function onCodeObjCreate() : *
      {

         (this.RightMeters_mc.PowerArmorLowBatteryWarning_mc.WarningTextHolder_mc as PAWarningText).codeObj = this.BGSCodeObj;
      }
      
      public function onCodeObjDestruction() : *
      {

         this.BGSCodeObj = null;
         (this.RightMeters_mc.PowerArmorLowBatteryWarning_mc.WarningTextHolder_mc as PAWarningText).codeObj = null;
      }
      
      private function handleTeamInviteAccept() : *
      {

         BSUIDataManager.dispatchEvent(new NetworkedUIEvent("networked::UIEVENT","TeamInviteAccepted",this.CharacterInfoData.name,this.RequestUsername,"NoData"));
      }
      
      function frame1() : *
      {

         stop();
      }
      
      function frame2() : *
      {

         stop();
      }
      
      function frame3() : *
      {

         stop();
      }
   }
}
