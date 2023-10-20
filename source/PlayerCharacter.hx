package;

import flixel.FlxObject;
import flixel.math.FlxMath;
import haxe.rtti.CType.Rights;
import flixel.math.FlxVelocity;
import Bomb;
import flixel.FlxG;
import flixel.FlxSprite;
import PlayState;


class PlayerCharacter extends FlxSprite {
	private var isEnemy:Bool; // True when the PlayerCharacter object is to be used as CPU
	private var currentBombIndex:Int; // Index to track bombs from pool

	public var bombsLeft:Int; // Pool of bombs PC can drop
	public var bombRange:Int; // Bomb explosion range

	public var playerNum:Int; //When multiple players are active this differentiates them.
							 //Defaults to -1 for enemies and parent class PlayerCharacter

	public var moveSpeed:Float; // MoveSpeed
	var delta:Int = 64;

	// constructor
	public function new(x:Float, y:Float, isEnemy:Bool) {
		super(x, y);
		this.isEnemy = isEnemy;
		playerNum = -1; 

		//Change scale of the sprite, to match better the tile map
		this.scale *=0.8;

		//Starting player conditions
		bombsLeft = 3;
		bombRange = 1;
		moveSpeed = 70;

	}

	// function to overwrite update
	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		if (!isEnemy) // player can only control characters that are not designated enemies
		{
			handlePlayerInput();
		}
	}

	// function to control movement based on arrow key/wasd input
	private function handlePlayerInput():Void {
		// intial velocity = 0
		velocity.x = 0;
		velocity.y = 0;

		if(this.playerNum == 0){// Handle WASD key input
		if (FlxG.keys.pressed.D) {
			velocity.x = moveSpeed;
			animation.play("Right");
		} else if (FlxG.keys.pressed.A) {
			velocity.x = -moveSpeed;
			animation.play("Left");
		} else if (FlxG.keys.pressed.S) {
			velocity.y = moveSpeed;
			animation.play("Forward");
		} else if (FlxG.keys.pressed.W) {
			velocity.y = -moveSpeed;
			animation.play("Backward");
		} else {
			// No arrow keys pressed, set to idle frame based on last movement
			animation.stop();
		}

		// handle spacebar to drop bombs
		if (FlxG.keys.justPressed.SPACE) {
			dropBomb();
		}}

		else if(this.playerNum == 1){// Handle arrow key input
			if (FlxG.keys.pressed.RIGHT) {
				velocity.x = moveSpeed;
				animation.play("Right");
			} else if (FlxG.keys.pressed.LEFT) {
				velocity.x = -moveSpeed;
				animation.play("Left");
			} else if (FlxG.keys.pressed.DOWN) {
				velocity.y = moveSpeed;
				animation.play("Forward");
			} else if (FlxG.keys.pressed.UP) {
				velocity.y = -moveSpeed;
				animation.play("Backward");
			} else {
				// No arrow keys pressed, set to idle frame based on last movement
				animation.stop();
			}
	
			// handle spacebar to drop bombs
			if (FlxG.keys.justPressed.SHIFT) {
				dropBomb();
			}}
	}

	// function to drop a bomb at player's current location
	private function dropBomb():Void {
		
		//Checks if is there already a bomb in the tile the player is trying to place a bomb
		for (obj in PlayState.bombs){ 
			if(FlxG.overlap(this, obj)){//if there is, the function just returns and do nothing
				return;
			}
		}
		//Checks if the bomb has bombs left to place
		if(this.bombsLeft > 0){
			bombsLeft -= 1; //reduces one bomb from the player's bombs stock
			FlxG.state.add(new Bomb(Math.floor(this.x/delta)*delta, Math.floor(this.y/delta)*delta, this)); //place a bomb in the tile the player is standing
		}
	}

	public function gotExploded(){ //the player get killed in this function, if it was hitten by the trigger of the explosion
		this.kill();
		if(PlayState.playerList.countLiving() <= 1){
			
			FlxG.camera.fade(gameOver);
		}
		}

	//function to control changing the game state after the player dies
	private function gameOver(){
		var playerTmp:PlayerCharacter = PlayState.playerList.getFirstAlive();
		if(playerTmp == null){
			PlayState.winningPlayer = -1;
		}
		else{
			PlayState.winningPlayer = playerTmp.playerNum;
		}
	
		FlxG.switchState(new GameOverState());
	}
	
}

class BluePC extends PlayerCharacter {
	// constructor
	public function new(x:Float, y:Float, isEnemy:Bool) {
		super(x, y, isEnemy);
		playerNum = 0;

		// load unique animations for blue sprite
		loadGraphic("assets/images/BluePC AllAnim 64x64.png", true, 64, 64);
		animation.add("Forward", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 12, true);
		animation.add("Backward", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 12, true);
		animation.add("Left", [24, 25, 26, 27, 28, 29, 30, 31], 8, true);
		animation.add("Right", [24, 25, 26, 27, 28, 29, 30, 31], 8, true, true);

		this.height = 12; //adjust the hitboxes
		this.width = 24;
		offset.set(20, 45); //adjust the offset of the hitbox with the sprite
	}
}

class PurplePC extends PlayerCharacter {
	// constructor
	public function new(x:Float, y:Float, isEnemy:Bool) {
		super(x, y, isEnemy);
		playerNum = 1;

		// load unique animations for purple sprite
		loadGraphic("assets/images/PurplePC AllAnim 64x64.png", true, 64, 64);
		animation.add("Forward", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 12, true);
		animation.add("Backward", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 12, true);
		animation.add("Left", [24, 25, 26, 27, 28, 29, 30, 31], 8, true);
		animation.add("Right", [24, 25, 26, 27, 28, 29, 30, 31], 8, true, true);


		this.height = 12; //adjust the hitboxes
		this.width = 24;
		offset.set(20, 45); //adjust the offset of the hitbox with the sprite
	}
}

class BasicEnemy extends PlayerCharacter{
	public function new(x:Float, y:Float, isEnemy:Bool) {
		super(x, y, isEnemy);
		playerNum = -1;
		bombsLeft = 1;

		// load unique animations for purple sprite
		loadGraphic("assets/images/RedPC AllAnim 64x64.png", true, 64, 64);
		animation.add("Forward", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 12, true);
		animation.add("Backward", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], 12, true);
		animation.add("Left", [24, 25, 26, 27, 28, 29, 30, 31], 8, true);
		animation.add("Right", [24, 25, 26, 27, 28, 29, 30, 31], 8, true, true);


		this.height = 12; //adjust the hitboxes
		this.width = 24;
		offset.set(20, 45); //adjust the offset of the hitbox with the sprite
	}

    override public function update(elapsed:Float):Void {
		super.update(elapsed);
        if (isEnemy) {
            handleEnemyBehavior();
        } else {
            handlePlayerInput();
        }
    
        if(!alive) {
            FlxG.camera.fade(gameOver);
        }
    }
    
    private function handleEnemyBehavior():Void {
		// intial velocity = 0
		//velocity.x = 0;
		//velocity.y = 0;

		// Randomly change direction every few seconds
		if (FlxG.random.float() < 0.01) {
			velocity.x = (FlxG.random.bool()) ? moveSpeed : -moveSpeed;
			velocity.y = (FlxG.random.bool()) ? moveSpeed : -moveSpeed;
		}

		// Randomly drop a bomb
        if (FlxG.random.float() < 0.01) {
            dropBomb();
        }

		//Enemies should attempt to keep a safe distance from bombs
		//TODO: AI keeps getting stuck in corners like an idiot, fix later
		for(obj in PlayState.bombs){
			if(obj!= null && this!= null){


				if((this.x < obj.x + 64*obj.bombRange + this.width && this.x > obj.x || this.x > obj.x + 64*obj.bombRange + this.width && this.x < obj.x)
					 &&( this.y < obj.y + 64*obj.bombRange + this.height && this.y > obj.y || this.y > obj.y + 64*obj.bombRange + this.height && this.y < obj.y)){
				if(obj.y < this.y){
					this.velocity.y = moveSpeed;
				}
				else if(obj.y > this.y){
					this.velocity.x = -moveSpeed;
				}
				if(obj.x < this.x){
					this.velocity.x = moveSpeed;
				}
				else if(obj.x > this.x){
					this.velocity.x = -moveSpeed;
				}
			}
			}
		}
    
        // Update animation based on movement direction
        if (velocity.x > 0) {
            animation.play("Right");
        } else if (velocity.x < 0) {
            animation.play("Left");
        } else if (velocity.y > 0) {
            animation.play("Forward");
        } else if (velocity.y < 0) {
            animation.play("Backward");
        } else {
            animation.stop();
        }
    }

}
