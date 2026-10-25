package flixel.system.format;

import openfl.utils.Assets;
import haxe.Json;

typedef FlxJson = FlxTypedJson<Dynamic>;

class FlxTypedJson<T> 
{
    var object:T;

    public function new() {}

    public function setField(field:String, value:Dynamic):Void
    {
        if (!hasField(field))
        {
            FlxG.log.warn('Failed to set field, "${field}" does not exist.');
            return;
        }

        Reflect.setField(object, field, value);
    }

    public function getField(field:String):Dynamic
    {
        if (!hasField(field))
        {
            FlxG.log.warn('Failed to get field, "${field}" does not exist.');
            return null;
        }

        return Reflect.field(object, field);
    }

    public function hasField(field:String):Bool
    {
        return Reflect.hasField(object, field);
    }

    public function loadFromText(text:String):T
    {
        try
        {
            this.object = Json.parse(text);
            return object;
        }
        catch(_)
        {
            FlxG.log.error('Failed to load Json from text.');
            return object;
        }
    }

    public function loadFromPath(path:String):T
    {
        try
        {
            if (!Assets.exists(path))
            {
                FlxG.log.error('Failed to load Json from path, file not found.');
                return object;
            }

            this.object = Json.parse(Assets.getText(path));
            return object;
        }
        catch(_)
        {
            FlxG.log.error('Failed to load Json from path.');
            return object;
        }
    }
}