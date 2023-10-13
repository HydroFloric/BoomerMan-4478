import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Bomb extends FlxSprite
{
	private var countdownTimer:FlxTimer;

	// constructor
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic("assets/images/Bomb 32x32.png", true, 32, 32);
		animation.add("Explode", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], 16, false);
	}

	// function to handle bomb behaviour once dropped by a player character
	public function dropped():Void
	{
		countdownTimer = new FlxTimer().start(3, explode);
	}

	// callback function for countdownTimer: to explode bomb
	private function explode(_):Void
	{
		animation.play("Explode");
	}
}
