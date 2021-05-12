package {
import extractors.GameApiDataExtractor;

public class ItemTransferer {
    public static const DIRECTION_TO_CONTAINER:String = "TO_CONTAINER";
    public static const DIRECTION_FROM_CONTAINER:String = "FROM_CONTAINER";
    private var _playerInventory:Array = [];
    private var _stashInventory:Array = [];
    private var _config:Object = null;

    public function set playerInventory(value:Array):void {
        _playerInventory = value;
    }

    public function set stashInventory(value:Array):void {
        _stashInventory = value;
    }

    public function set config(value:Object):void {
        _config = value;
    }

    private function transfer(inventory:Array, fromContainer:Boolean, config:Object):void {
        if (inventory && inventory.length > 0 && isValidConfig()) {
            inventory.forEach(function (item:Object):void {
                if (isItemMatchingConfig(item, config)) {
                    GameApiDataExtractor.transferItem(item, fromContainer);
                }
            });
        }
    }

    private function isValidConfig():Boolean {
        if (_config) {
            var transferConfig:Object = _config.transferConfig;
            if (transferConfig && transferConfig.enabled && transferConfig.itemNames
                    && transferConfig.itemNames.length > 0 && transferConfig.direction) {
                return true;
            }
        }
        return false;
    }

    public function transferItems():void {
        if (!isValidConfig()) {
            return;
        }
        var transferConfig:Object = _config.transferConfig;
        var direction:String = _config.transferConfig.direction;
        if (DIRECTION_FROM_CONTAINER === direction) {
            transfer(_stashInventory, true, transferConfig);
        } else if (DIRECTION_TO_CONTAINER === direction) {
            transfer(_playerInventory, false, transferConfig);
        }
    }

    private static function isMatchingItemName(item:String, config:Object):Boolean {
        var matches:Boolean = false;
        const matchMode:String = config.matchMode;
        var itemName: String = item.toLowerCase();
        for ( var i:int = 0; i < config.itemNames.length; i++ ) {
            var configItemName:String = config.itemNames[i].toLowerCase();
            if (matchMode === MatchMode.EXACT) {
                matches = itemName === configItemName;
            } else if (matchMode === MatchMode.CONTAINS) {
                matches = itemName.indexOf(configItemName) >= 0;
            } else if (matchMode === MatchMode.STARTS) {
                matches = itemName.indexOf(configItemName) === 0;
            } else if (matchMode === MatchMode.ALL) {
                matches = true;
            }
            if (matches) {
                return matches;
            }
        }
        return matches;
    }

    private static function isItemMatchingConfig(item:Object, config:Object):Boolean {
        var itemText:String = item.text;
        if (itemText === null || itemText == null || itemText.length < 1 || itemText === ''
                || itemText == '') {
            return false;
        }
        var matches:Boolean = isMatchingItemName(itemText, config);
        return matches;
    }

}
}