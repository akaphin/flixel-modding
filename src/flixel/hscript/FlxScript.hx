package flixel.hscript;

import flixel.hscript._internal.*;
import flixel.hscript._internal.Expr;
import flixel.util.FlxDestroyUtil;
import haxe.io.Path;
import openfl.utils.Assets;

class FlxScript implements IFlxDestroyable
{
    public static final SCRIPT_FILE_EXT:String = 'hxs';

    public static var cachedScripts:Map<String, FlxScript> = [];

    public var pack(get, never):Array<String>;

    function get_pack():Array<String>
    {
        var parts:Array<String> = Path.withoutExtension(path).split('/');
        return parts.slice(0, parts.length - 1);
    }

    public var name(get, never):String;
    
    function get_name():String
    {
        return Path.withoutDirectory(Path.withoutExtension(path));
    }

    public var module(get, never):String;
    
    function get_module():String
    {
        return '${pack.join('.')}.${name}';
    }

    public var path:String;

    var interp:Interp;

    var parser:Parser;

    var expr:Expr;

    public function new(path:String)
    {
        this.path = path;

        parser = new Parser();
        parser.allowJSON = true;
        parser.allowMetadata = true;
        parser.allowTypes = true;

        interp = new Interp();

        expr = parser.parseString(Assets.getText(path), path);
    }

    public function execute():Dynamic
    {
        return interp.execute(expr);
    }

    public function destroy():Void
    {
        interp = null;
        parser = null;
        path = null;
        expr = null;
    }
}