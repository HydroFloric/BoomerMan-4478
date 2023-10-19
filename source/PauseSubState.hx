package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class Globals
{
	public static var FONT_L:String = "Arial";
	public static var FONT_N:String = "Arial";
	public static var FONT_SIZE_L:Int = 24;
	public static var FONT_SIZE_N:Int = 16;
}

class PauseSubState extends FlxState
{
	public var pauseText:FlxText;

	private var resolutions:Array<{width:Int, height:Int}> = [
		{width: 800, height: 600},
		{width: 1024, height: 768},
		{width: 1280, height: 720},
		{width: 1920, height: 1080}
	];
	private var currentResolutionIndex:Int = 0;

	override public function create()
	{
		FlxG.mouse.visible = true;

		pauseText = new FlxText(0, 0, -1, 'Pause', Globals.FONT_SIZE_L);
		pauseText.setFormat(Globals.FONT_L);
		pauseText.screenCenter();
		pauseText.y -= 30;
		add(pauseText);

		var resumeButton = new FlxButton(0, 0, "Resume", resumeGame);
		resumeButton.label.setFormat(Globals.FONT_N, Globals.FONT_SIZE_N, FlxColor.RED, "center");
		resumeButton.screenCenter();
		resumeButton.y += 40;
		add(resumeButton);

		var changeResolutionButton = new FlxButton(0, 0, "Change Resolution", changeResolution);
		changeResolutionButton.label.setFormat(Globals.FONT_N, Globals.FONT_SIZE_N, FlxColor.RED, "center");
		changeResolutionButton.screenCenter();
		changeResolutionButton.y += 80;
		add(changeResolutionButton);

		super.create();
	}

	public function resumeGame():Void
	{
		FlxG.mouse.visible = false; 
		closeSubState(); 
	}

	public function changeResolution():Void
	{
		currentResolutionIndex = (currentResolutionIndex + 1) % resolutions.length;
		var resolution = resolutions[currentResolutionIndex];
		FlxG.resizeGame(resolution.width, resolution.height);
	}
}

