 
package
{
   public dynamic class QuickContainerItemData
   {
       
      
      public var text:String;
      
      public var count:uint;
      
      public var equipState:uint;
      
      public var filterFlag:int;
      
      public var favorite:Boolean;
      
      public var isLegendary:Boolean;
      
      public var taggedForSearch:Boolean;
      
      public var isBetterThanEquippedItem:Boolean;
      
      public var itemLevel:Number;
      
      public var durability:Number;
      
      public var currentHealth:Number;
      
      public var maximumHealth:Number;
      
      public function QuickContainerItemData()
      {

         super();
         this.text = new String();
         this.count = 0;
         this.equipState = 0;
         this.filterFlag = 0;
         this.favorite = false;
         this.isLegendary = false;
         this.taggedForSearch = false;
         this.isBetterThanEquippedItem = false;
         this.itemLevel = 0;
         this.durability = 0;
         this.currentHealth = 0;
         this.maximumHealth = 0;
      }
   }
}
