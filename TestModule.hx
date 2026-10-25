package test.module;

class TestClass
{
    public static var helloWorld:String = "Hello, World!";

    public static function main():Void
    {
        trace(TestScript.helloWorld);
    }
}

enum TestEnum
{
    THING_ONE;
    ThingTwo(input:String);    
}

typedef TestTypedef = 
{
    > TestTypedefTwo,
    var fieldOne:String;
    var ?fieldTwo:Float;
}

private typedef TestTypedefTwo = 
{
    var fieldThree:Bool;
}

interface TestInterface ;
{
    var     
}