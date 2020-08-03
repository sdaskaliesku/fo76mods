package {
import Shared.GlobalFunc;

import com.adobe.serialization.json.JSONEncoder;

public class ItemExtractor {

    private var _sfeObj:Object;

    public function ItemExtractor() {
        this._sfeObj = null;
    }

    public function set sfeObj(value:Object):void {
        _sfeObj = value;
    }

    public function extractItems(obj:Object):void {
        try {
            writeData(toString(obj));
        } catch (e:Error) {
            GlobalFunc.ShowHUDMessage("Error json converting: " + e);
        }
    }

    private function toString(obj:Object):String {
        return new JSONEncoder(obj).getString();
    }

    public function isSfeDefined():Boolean {
        return this._sfeObj != null && this._sfeObj.call != null;
    }

    private function writeData(data:String):void {
        try {
            this._sfeObj.call("writeSaveEverythingFile", data);
            GlobalFunc.ShowHUDMessage("Done saving items!");
        } catch (e:Error) {
            GlobalFunc.ShowHUDMessage("Error saving items! " + e);
        }
    }
}
}