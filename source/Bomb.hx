package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;
import Explosion;

import flixel.FlxG;

class Bomb extends FlxSprite
{
	public var countdownTimer:FlxTimer;

	public var bombOwner:PlayerCharacter;

	public var bombRange:Int;

	// constructor
	public function new(x:Float, y:Float, player:PlayerCharacter)
	{
		super(x, y);
		loadGraphic("assets/images/Bomb 32x32.png", true, 32, 32);

		width = 64;
		height = 64;
		offset.set(-16, -16);
		

		bombOwner = player;
		this.bombRange = player.bombRange;
		
		animation.add("Explode", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], 16, false);
		PlayState.bombs.push(this);
		dropped();

	}

	// function to handle bomb behaviour once dropped by a player character
	public function dropped():Void
	{
		countdownTimer = new FlxTimer().start(3, explode);
	}

	// callback function for countdownTimer: to explode bomb
	public function explode(_):Void
	{		
		this.destroy();  
		countdownTimer.destroy();
		
		bombOwner.bombsLeft +=1; //give a bomb back to the player
		PlayState.bombs.splice(PlayState.bombs.indexOf(this), 1); //remove bomb from the list.
		
		new Explosion(x, y, bombOwner.bombRange); //calls the explosion
	}

	public function explodeChain():Void //this is called from the Explosion.hx, when the bomb is exploded by another bomb
	{		
		this.destroy();  
		bombOwner.bombsLeft +=1;
		PlayState.bombs.splice(PlayState.bombs.indexOf(this), 1);
			
		new Explosion(x, y, bombOwner.bombRange);
	}
}
