

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


        //checks if the player are in the same tile as the initial position of the bomb. 
        for (obj in PlayState.players){ //go through all bombs objects to check if it will overlap(are in the same tile)
			if(Std.int(obj.x/64) == Std.int(x/64) && Std.int(obj.y/64) == Std.int(y/64)){ //Checks if the player is in the same tile as the explosion.
                obj.gotExploded(); //kills the player if it is true
			}
        }
        explosionEffect(x, y, "center");

        recursiveExplosionUp(x, y-64, remainingRange);  //change the sprite position to check if is there any object, or wall.
        recursiveExplosionDown(x, y+64, remainingRange);
        recursiveExplosionLeft(x-64, y, remainingRange);
        recursiveExplosionRight(x+64, y, remainingRange);

	}
    //explosion go through the y axis
    private function recursiveExplosionUp(x:Float, y:Float, remainingRange:Int){
        if(remainingRange <= 0) return;
        if(!checkTileMapColision(x,y)) return; //this functions returns false if there is an wall in the x and y position, if it is, it will just return.

        for (obj in PlayState.bombs){ 
			if(Std.int(obj.x/64) == Std.int(x/64) && Std.int(obj.y/64) == Std.int(y/64)){ //Checks if the bomb is in the same tile as the explosion. We get the tile index(x,y) by geting the intenger part of the division of the bomb(obj.x,obj.y)/64 and the explosion(x,y)/64
				obj.countdownTimer.destroy();
                obj.explodeChain();
			}
        }
        for (obj in PlayState.players){ 
			if(Std.int(obj.x/64) == Std.int(x/64) && Std.int(obj.y/64) == Std.int(y/64)){ //Checks if the player is in the same tile as the explosion.
                obj.gotExploded();
			}
        }

        explosionEffect(x, y, "horizon");
        recursiveExplosionUp(x, y-64, remainingRange-1);

    }
    //explosion go through the y axis
    private function recursiveExplosionDown(x:Float, y:Float, remainingRange){
        if(remainingRange <= 0) return;
        if(!checkTileMapColision(x,y)) return;


        for (obj in PlayState.bombs){ 
			if(Std.int(obj.x/64) == Std.int(x/64) && Std.int(obj.y/64) == Std.int(y/64)){
				obj.countdownTimer.destroy();
                obj.explodeChain();
			}
        }
        for (obj in PlayState.players){ 
			if(Std.int(obj.x/64) == Std.int(x/64) && Std.int(obj.y/64) == Std.int(y/64)){
                obj.gotExploded();
			}
        }

        explosionEffect(x, y, "horizon");
        recursiveExplosionDown(x, y+64, remainingRange-1);
    }
    //explosion go through the x axis
    private function recursiveExplosionLeft(x:Float, y:Float, remainingRange){
        if(remainingRange <= 0) return;
        if(!checkTileMapColision(x,y)) return;


        for (obj in PlayState.bombs){ 
			if(Std.int(obj.x/64) == Std.int(x/64) && Std.int(obj.y/64) == Std.int(y/64)){
				obj.countdownTimer.destroy();
                obj.explodeChain();
			}
        }
        for (obj in PlayState.players){ 
			if(Std.int(obj.x/64) == Std.int(x/64) && Std.int(obj.y/64) == Std.int(y/64)){
                obj.gotExploded();
			}
        }

        explosionEffect(x, y, "vert");
        recursiveExplosionLeft(x-64, y, remainingRange-1);

    }
     //explosion go through the x axis
    private function recursiveExplosionRight(x:Float, y:Float, remainingRange){
        if(remainingRange <= 0) return;
        if(!checkTileMapColision(x,y)) return;

        for (obj in PlayState.bombs){ 
			if(Std.int(obj.x/64) == Std.int(x/64) && Std.int(obj.y/64) == Std.int(y/64)){
				obj.countdownTimer.destroy();
                obj.explodeChain();
			}
        }
        for (obj in PlayState.players){ 
			if(Std.int(obj.x/64) == Std.int(x/64) && Std.int(obj.y/64) == Std.int(y/64)){
                obj.gotExploded();
			}
        }

        explosionEffect(x, y, "vert");
        recursiveExplosionRight(x+64, y, remainingRange-1);

    }

    //this functions makes an animation for the explosions
    private function explosionEffect(x:Float, y:Float, dir:String){

        //create the animations for vertical and horizontal explosions
        var shockAnim:FlxSprite = new FlxSprite(x,y).loadGraphic("assets/images/explosionTiles.png", true, 64, 64);
        shockAnim.animation.add("vert", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 20, true);
        shockAnim.animation.add("horizon", [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27], 20, true);
        FlxG.state.add(shockAnim);

        //center does not have directional animation
        var centerGraphic:FlxSprite = new FlxSprite(x, y);

        //decide which animation to play in each tile
        if(dir == "vert"){
            shockAnim.animation.play("vert");
        }
        else if(dir == "horizon"){
            shockAnim.animation.play("horizon");
        }
        else
        {
            //static asset for center of explosion
            centerGraphic.makeGraphic(64, 64, 0xFFD7C639);
            FlxG.state.add(centerGraphic);
        }
        
        //animation plays for half a second (10 frames)
        var myTimer = new FlxTimer();
        myTimer.start(0.5, (timer:FlxTimer) ->
        {
            shockAnim.destroy();
            centerGraphic.destroy();
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