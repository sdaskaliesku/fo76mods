 
package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import fl.transitions.easing.*;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class DamageNumbers extends MovieClip
   {
       
      
      public var Damage_mc:MovieClip;
      
      public var DamageClipVector:Vector.<MovieClip>;
      
      private var _DamageNumberUIData:Object;
      
      public function DamageNumbers()
      {

         this.DamageClipVector = new Vector.<MovieClip>();
         super();
         addFrameScript(0,this.frame1);
         BSUIDataManager.Subscribe("DamageNumberUIData",function(param1:FromClientDataEvent):// method body index: 776 method index: 776
         *
         {

            if(param1.data != null)
            {
               _DamageNumberUIData = param1.data;
               RefreshView();
            }
         });
      }
      
      public function TestFunction() : *
      {

         trace("test function called.");
      }
      
      public function RefreshView() : *
      {

         var _loc1_:Object = null;
         if(this._DamageNumberUIData != null)
         {
            for each(_loc1_ in this._DamageNumberUIData.updatedDamageNumbers)
            {
               if(!this.UpdateItem(_loc1_.uniqueId,_loc1_.screenX,_loc1_.screenY))
               {
                  this.CreateNew(_loc1_.uniqueId,_loc1_.enemyId,_loc1_.damageTotal,_loc1_.damageHealth,_loc1_.isHeadshot,_loc1_.screenX,_loc1_.screenY);
               }
            }
         }
      }
      
      public function UpdateItem(param1:int, param2:Number, param3:Number) : Boolean
      {

         var _loc4_:MovieClip = null;
         var _loc5_:DamageNumberClip = null;
         var _loc6_:Point = null;
         for each(_loc4_ in this.DamageClipVector)
         {
            _loc5_ = _loc4_ as DamageNumberClip;
            if(_loc5_ != null && _loc5_.UniqueId == param1)
            {
               _loc6_ = MovieClip(_loc5_).parent.globalToLocal(new Point(param2,param3));
               MovieClip(_loc5_).x = _loc6_.x;
               MovieClip(_loc5_).y = _loc6_.y;
               return true;
            }
         }
         return false;
      }
      
      public function CreateNew(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Number, param7:Number) : *
      {

         var _loc8_:DamageNumberClip = new DamageNumberClip();
         _loc8_.ParentObj = this;
         _loc8_.UniqueId = param1;
         if(param5)
         {
            _loc8_.Crit_mc.Number_mc.txtField.text = param4.toString();
            _loc8_.Crit_mc.gotoAndPlay("show");
         }
         else
         {
            _loc8_.Base_mc.Number_mc.txtField.text = param4.toString();
            _loc8_.Base_mc.gotoAndPlay("show");
         }
         addChild(_loc8_);
         this.DamageClipVector.push(_loc8_);
         var _loc9_:Point = MovieClip(_loc8_).parent.globalToLocal(new Point(param6,param7));
         MovieClip(_loc8_).x = _loc9_.x;
         MovieClip(_loc8_).y = _loc9_.y;
      }
      
      public function RemoveDamageNumber(param1:int) : *
      {

         var _loc2_:DamageNumberClip = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.DamageClipVector.length)
         {
            _loc2_ = this.DamageClipVector[_loc3_] as DamageNumberClip;
            if(_loc2_.UniqueId == param1)
            {
               this.DamageClipVector.splice(_loc3_,1);
               removeChild(MovieClip(_loc2_));
            }
            _loc3_++;
         }
      }
      
      public function GetRandomNumber(param1:*, param2:*) : *
      {

         return param1 + Math.floor(Math.random() * (param2 + 1 - param1));
      }
      
      function frame1() : *
      {

      }
   }
}
