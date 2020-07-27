 
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
         BSUIDataManager.Subscribe("DamageNumberUIData",function(event:FromClientDataEvent):// method body index: 851 method index: 851
         *
         {

            if(event.data != null)
            {
               _DamageNumberUIData = event.data;
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

         var obj:Object = null;
         if(this._DamageNumberUIData != null)
         {
            for each(obj in this._DamageNumberUIData.updatedDamageNumbers)
            {
               if(!this.UpdateItem(obj.uniqueId,obj.screenX,obj.screenY))
               {
                  this.CreateNew(obj.uniqueId,obj.enemyId,obj.damageTotal,obj.damageHealth,obj.isHeadshot,obj.screenX,obj.screenY);
               }
            }
         }
      }
      
      public function UpdateItem(uniqueID:int, screenX:Number, screenY:Number) : Boolean
      {

         var clip:MovieClip = null;
         var damageClip:DamageNumberClip = null;
         var localPointNormal:Point = null;
         for each(clip in this.DamageClipVector)
         {
            damageClip = clip as DamageNumberClip;
            if(damageClip != null && damageClip.UniqueId == uniqueID)
            {
               localPointNormal = MovieClip(damageClip).parent.globalToLocal(new Point(screenX,screenY));
               MovieClip(damageClip).x = localPointNormal.x;
               MovieClip(damageClip).y = localPointNormal.y;
               return true;
            }
         }
         return false;
      }
      
      public function CreateNew(uniqueID:int, enemyID:int, damageTotal:int, damageHealth:int, headshot:Boolean, xPos:Number, yPos:Number) : *
      {

         var damageClip:DamageNumberClip = new DamageNumberClip();
         damageClip.ParentObj = this;
         damageClip.UniqueId = uniqueID;
         if(headshot)
         {
            damageClip.Crit_mc.Number_mc.txtField.text = damageHealth.toString();
            damageClip.Crit_mc.gotoAndPlay("show");
         }
         else
         {
            damageClip.Base_mc.Number_mc.txtField.text = damageHealth.toString();
            damageClip.Base_mc.gotoAndPlay("show");
         }
         addChild(damageClip);
         this.DamageClipVector.push(damageClip);
         var localPointNormal:Point = MovieClip(damageClip).parent.globalToLocal(new Point(xPos,yPos));
         MovieClip(damageClip).x = localPointNormal.x;
         MovieClip(damageClip).y = localPointNormal.y;
      }
      
      public function RemoveDamageNumber(uID:int) : *
      {

         var item:DamageNumberClip = null;
         for(var i:int = 0; i < this.DamageClipVector.length; i++)
         {
            item = this.DamageClipVector[i] as DamageNumberClip;
            if(item.UniqueId == uID)
            {
               this.DamageClipVector.splice(i,1);
               removeChild(MovieClip(item));
            }
         }
      }
      
      public function GetRandomNumber(minVal:*, maxVal:*) : *
      {

         return minVal + Math.floor(Math.random() * (maxVal + 1 - minVal));
      }
      
      function frame1() : *
      {

      }
   }
}
