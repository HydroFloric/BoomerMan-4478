package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;
import Explosion;
import PlayState;
import flixel.FlxG;
import PlayerCharacter;

class Upgrade extends FlxSprite
{


	public var upgrade:Int;

	// constructor
	public function new(x:Float, y:Float, upgradeType)
	{
		super(x, y);
        upgrade = upgradeType;
		
        if(upgrade == 1){
            loadGraphic("assets/images/powerup_bombRange.png", true, 32, 32);
            animation.add("bombRangeUpgrade", [0,1,2,3], 16, false);
            animation.play("bombRangeUpgrade");

        }else if(upgrade == 2){
            loadGraphic("assets/images/powerups_speed_bomb.png", true, 32, 32);
            animation.add("bombCapUpgrade", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24], 16, false);
            animation.play("bombCapUpgrade");
        }else{
            loadGraphic("assets/images/powerups_speed_bomb.png", true, 32, 32);
            animation.add("MoveSpeedUpgrade", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 16, false);
            animation.play("MoveSpeedUpgrade");
        }

		offset.set(-16, -16);
		

		PlayState.upgrades.push(this);
	
	}

    public function grabbed(player:PlayerCharacter){
        if(upgrade == 1){
            player.bombRange +=1;

        }else if(upgrade == 2){
            player.bombsLeft +=1;
        }else{
            player.moveSpeed += 15;
        }
        PlayState.upgrades;
        PlayState.upgrades.splice(PlayState.upgrades.indexOf(this), 1);
        FlxG.sound.play(AssetPaths.pickup__wav);
        this.destroy();

    }
	
}
