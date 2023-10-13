import Bomb;
import flixel.FlxG;
import flixel.FlxSprite;

class PlayerCharacter extends FlxSprite {
	private var isEnemy:Bool; // True when the PlayerCharacter object is to be used as CPU
	private var bombPool:Array<Bomb>; // Pool of bombs PC can drop
	private var currentBombIndex:Int; // Index to track bombs from pool

	// constructor
	public function new(x:Float, y:Float, isEnemy:Bool) {
		super(x, y);
		this.isEnemy = isEnemy;

		// change hitbox so sprites can navigate map
		this.height = 56;
		this.width = 56;

		this.bombPool = [];
		this.currentBombIndex = 0;

		// Populate the bomb pool with 10 bombs (i.e PC can drop up to ten bombs before recycling)
		for (i in 0...10) {
			var bomb = new Bomb(0, 0);
			FlxG.state.add(bomb); // Add to global state
			bomb.kill();
			bombPool.push(bomb); // add to pool
		}
	}

	// function to overwrite update
	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (!isEnemy) // player can only control characters that are not designated enemies
		{
			handlePlayerInput();
		}
	}

	// function to control movement based on arrow key input
	private function handlePlayerInput():Void {
		// intial velocity = 0
		velocity.x = 0;
		velocity.y = 0;

		// Handle arrow key input
		if (FlxG.keys.pressed.RIGHT) {
			velocity.x = 100;
			animation.play("Right");
		} else if (FlxG.keys.pressed.LEFT) {
			velocity.x = -100;
			animation.play("Left");
		} else if (FlxG.keys.pressed.DOWN) {
			velocity.y = 100;
			animation.play("Forward");
		} else if (FlxG.keys.pressed.UP) {
			velocity.y = -100;
			animation.play("Backward");
		} else {
			// No arrow keys pressed, set to idle frame based on last movement
			animation.stop();
		}

		// handle spacebar to drop bombs
		if (FlxG.keys.justPressed.SPACE) {
			dropBomb();
		}
	}

	// function to drop a bomb at player's current location
	private function dropBomb():Void {
		// Get the next available bomb from the pool
		var bomb:Bomb = bombPool[currentBombIndex];
		currentBombIndex = (currentBombIndex + 1) % bombPool.length; // Cycle through the bomb pool

		// Move bomb to the player's current position
		bomb.reset(x + 16, y + 16);

		// activate bomb
		bomb.dropped();
	}
}

class BluePC extends PlayerCharacter {
	// constructor
	public function new(x:Float, y:Float, isEnemy:Bool) {
		super(x, y, isEnemy);

		// load unique animations for blue sprite
		loadGraphic("assets/images/BluePC AllAnim 64x64.png", true, 64, 64);
		animation.add("Forward", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 12, true);
		animation.add("Backward", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 12, true);
		animation.add("Left", [24, 25, 26, 27, 28, 29, 30, 31], 8, true);
		animation.add("Right", [24, 25, 26, 27, 28, 29, 30, 31], 8, true, true);
	}
}

class PurplePC extends PlayerCharacter {
	// constructor
	public function new(x:Float, y:Float, isEnemy:Bool) {
		super(x, y, isEnemy);

		// load unique animations for purple sprite
		loadGraphic("assets/images/PurplePC AllAnim 64x64.png", true, 64, 64);
		animation.add("Forward", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 12, true);
		animation.add("Backward", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 12, true);
		animation.add("Left", [24, 25, 26, 27, 28, 29, 30, 31], 8, true);
		animation.add("Right", [24, 25, 26, 27, 28, 29, 30, 31], 8, true, true);
	}
}
