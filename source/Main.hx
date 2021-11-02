package;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.FlxAssets;
import openfl.display.Sprite;

/**
 * ...
 * @author bb
 */
class Main extends Sprite
{

	public function new() 
	{
		super();
		//trace("tets");
		FlxAssets.FONT_DEFAULT =  "Consolas";
		addChild(new FlxGame(1280, 600, UI, 1, 30, 30, true, true));
		FlxG.mouse.useSystemCursor = true;
	}
	
}