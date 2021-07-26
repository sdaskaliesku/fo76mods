package {
import Shared.GlobalFunc;

import extractors.GameApiDataExtractor;

import utils.Logger;

public class ItemWorker {
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
        if (inventory && inventory.length > 0 && isValidTransferConfig()) {
            var executor:DelayedExecutor = new DelayedExecutor(config.initialDelay, config.step);
            inventory.forEach(function (item:Object):void {
                if (isItemMatchingConfig(item, config)) {
                    executor.execute(function ():void {
                        GameApiDataExtractor.transferItem(item, fromContainer);
                    });
                }
            });
        }
    }

    private function scrap(inventory:Array, config:Object):void {
        try {
            if (inventory && inventory.length > 0 && isValidScrapConfig()) {
                var executor:DelayedExecutor = new DelayedExecutor(config.initialDelay, config.step);
                inventory.forEach(function (item:Object):void {
                    if (!item.isLegendary && shouldScrap(item, config)) {
                        if (config.debug) {
                            Logger.get().info("Going to scrap: " + item.text);
                            GlobalFunc.ShowHUDMessage("Going to scrap: " + item.text);
                        }
                        executor.execute(function ():void {
                            GameApiDataExtractor.scrapItem(item);
                        });
                    }
                });
            }
        } catch (e:Error) {
            Logger.get().errorHandler("Error ItemWorker scrap", e);
        }
    }

    private function isValidScrapConfig():Boolean {
        if (_config) {
            var scrapConfig:Object = _config.scrapConfig;
            if (scrapConfig && scrapConfig.enabled && scrapConfig.types && scrapConfig.types.length
                    > 0) {
                return true;
            }
        }
        return false;
    }

    private function isValidTransferConfig():Boolean {
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
        if (!isValidTransferConfig()) {
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

    public function scrapItems():void {
        if (!isValidScrapConfig()) {
            return;
        }
        var scrapConfig:Object = _config.scrapConfig;
        scrap(_playerInventory, scrapConfig);
    }

    private static function isMatchingString(itemName:String, stringToCompare:String,
            matchMode:String):Boolean {
        var matches:Boolean = false;
        if (itemName.length < 1 || stringToCompare.length < 1) {
            return matches;
        }
        try {
            if (matchMode === MatchMode.EXACT) {
                matches = itemName === stringToCompare;
            } else if (matchMode === MatchMode.CONTAINS) {
                matches = itemName.indexOf(stringToCompare) >= 0;
            } else if (matchMode === MatchMode.STARTS) {
                matches = itemName.indexOf(stringToCompare) === 0;
            } else if (matchMode === MatchMode.ALL) {
                matches = true;
            }
        } catch (e:Error) {
            Logger.get().errorHandler("Error checking string match mode", e);
        }
        return matches;
    }

    private static function isMatchingItemName(item:String, config:Object):Boolean {
        var matches:Boolean = false;
        const matchMode:String = config.matchMode;
        var itemName:String = item.toLowerCase();
        for (var i:int = 0; i < config.itemNames.length; i++) {
            var configItemName:String = config.itemNames[i].toLowerCase();
            matches = isMatchingString(itemName, configItemName, matchMode);
            if (matches) {
                return matches;
            }
        }
        return matches;
    }

    private static function isValidTypeToScrap(item:Object, config:Object):Boolean {
        try {
            var types:Array = config.types;
            var matchingFilterFlags:Array = [];
            for (var i:int = 0; i < types.length; i++) {
                matchingFilterFlags = matchingFilterFlags.concat(matchingFilterFlags,
                        ItemTypes.ITEM_TYPES[types[i]]);
            }
            return matchingFilterFlags.indexOf(item.filterFlag) !== -1;
        } catch (e:Error) {
            Logger.get().errorHandler("Error checking type for scrap", e);
        }
        return false;
    }

    private static function shouldScrap(item:Object, config:Object):Boolean {
        var matches:Boolean = false;
        if (!isValidTypeToScrap(item, config)) {
            return matches;
        }
        try {
            var excludedItems:Array = config.excluded;
            var excludedSize:int = excludedItems.length;
            if (excludedSize < 1) {
                return true;
            }
            var itemName:String = item.text;
            itemName = itemName.toLowerCase();
            for (var i:int = 0; i < excludedSize; i++) {
                var configItemName:String = excludedItems[i].toLowerCase();
                matches = isMatchingString(itemName, configItemName, MatchMode.CONTAINS);
                Logger.get().info(itemName + " " + matches);
                if (matches) {
                    return false;
                }
            }
            return true;
        } catch (e:Error) {
            Logger.get().errorHandler("Error checking items for scrapping", e);
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