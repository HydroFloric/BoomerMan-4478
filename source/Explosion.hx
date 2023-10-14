package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxG;
import PlayState;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;

var trigger:FlxSprite = new FlxSprite();
var myPoint:FlxPoint = new FlxPoint();

class Explosion extends FlxSprite
{

	public function new(x:Float, y:Float, remainingRange:Int, direction:String = "firstCall")
	{
        super(x,y);

        trigger.makeGraphic(60, 60, FlxColor.BLUE); //this sprite object(trigger), is used to check if it overlap some other object.
        trigger.alpha = 0;
        FlxG.state.add(trigger);


        trigger.x = x;
        trigger.y = y;
        for (obj in PlayState.bombs){  //go through all bombs objects to check if it will overlap.
			if(FlxG.overlap(trigger, obj)){  //if trigger overlap with a bomb, it  will detonate the bomb and destroy the inside timer to prevent the bomb exploding two times
				obj.countdownTimer.destroy();
                obj.explodeChain(); //trigger the explosion of other bomb
			}
        }
        for (obj in PlayState.players){ //go through all bombs objects to check if it will overlap.
			if(FlxG.overlap(trigger, obj)){ //if the trigger overlaps with the player, the function gotExploded will be called.
                obj.gotExploded(); //if the player overlaped with the trigger, it will call this function.
			}
        }
        explosionEffect(x, y);

        recursiveExplosionUp(x, y-64, remainingRange);  //change the sprite position to check if is there any object, or wall.
        recursiveExplosionDown(x, y+64, remainingRange);
        recursiveExplosionLeft(x-64, y, remainingRange);
        recursiveExplosionRight(x+64, y, remainingRange);

	}
    private function recursiveExplosionUp(x:Float, y:Float, remainingRange:Int){
        if(remainingRange <= 0) return;
        if(!checkTileMapColision(x,y)) return; //this functions returns false if there is an wall in the x and y position, if it is, it will just return.
        
        trigger.x = x; //change the sprite position
        trigger.y = y;

        for (obj in PlayState.bombs){ 
			if(FlxG.overlap(trigger, obj)){//if trigger overlap with a bomb, it  will detonate the bomb and destroy the inside timer to prevent the bomb exploding two times
				obj.countdownTimer.destroy();
                obj.explodeChain();
			}
        }
        for (obj in PlayState.players){ 
			if(FlxG.overlap(trigger, obj)){//if the trigger overlaps with the player, the function gotExploded will be called.
                obj.gotExploded();
			}
        }

        explosionEffect(x, y);
        recursiveExplosionUp(x, y-64, remainingRange-1);

    }
    private function recursiveExplosionDown(x:Float, y:Float, remainingRange){
        if(remainingRange <= 0) return;
        if(!checkTileMapColision(x,y)) return;
        trigger.x = x;
        trigger.y = y;
        for (obj in PlayState.bombs){ 
			if(FlxG.overlap(trigger, obj)){
				obj.countdownTimer.destroy();
                obj.explodeChain();
			}
        }
        for (obj in PlayState.players){ 
			if(FlxG.overlap(trigger, obj)){
                obj.gotExploded();
			}
        }

        explosionEffect(x, y);
        recursiveExplosionDown(x, y+64, remainingRange-1);
    }
    private function recursiveExplosionLeft(x:Float, y:Float, remainingRange){
        if(remainingRange <= 0) return;
        if(!checkTileMapColision(x,y)) return;
        trigger.x = x;
        trigger.y = y;
        for (obj in PlayState.bombs){ 
			if(FlxG.overlap(trigger, obj)){
				obj.countdownTimer.destroy();
                obj.explodeChain();
			}
        }
        for (obj in PlayState.players){ 
			if(FlxG.overlap(trigger, obj)){
                obj.gotExploded();
			}
        }

        explosionEffect(x, y);
        recursiveExplosionLeft(x-64, y, remainingRange-1);

    }
    private function recursiveExplosionRight(x:Float, y:Float, remainingRange){
        if(remainingRange <= 0) return;
        if(!checkTileMapColision(x,y)) return;
        trigger.x = x;
        trigger.y = y;
        for (obj in PlayState.bombs){ 
			if(FlxG.overlap(trigger, obj)){
				obj.countdownTimer.destroy();
                obj.explodeChain();
			}
        }
        for (obj in PlayState.players){ 
			if(FlxG.overlap(trigger, obj)){
                obj.gotExploded();
			}
        }

        explosionEffect(x, y);
        recursiveExplosionRight(x+64, y, remainingRange-1);

    }

    //this functions makes an animation for the explosions
    private function explosionEffect(x:Float, y:Float){
        var changeThisForAnActuallySpriteAnimation:FlxSprite = new FlxSprite(x,y).makeGraphic(64, 64, FlxColor.BLUE);
        FlxG.state.add(changeThisForAnActuallySpriteAnimation);
        
        var myTimer = new FlxTimer();
        myTimer.start(1.0, (timer:FlxTimer) ->
        {
            changeThisForAnActuallySpriteAnimation.destroy();
        });
    }

    //return true if it is a walkable tile, false if it is not.
	public function checkTileMapColision(x:Float, y:Float):Bool{
		myPoint.x = x;
		myPoint.y = y;
		if(PlayState.walls.getTileByIndex(PlayState.walls.getTileIndexByCoords(myPoint)) == 1) return false; //return if it is an walkable tile object or not based on x and y coords.
		return true;

	}


}
