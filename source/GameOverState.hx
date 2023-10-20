package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

import SettingState;

class GameOverState extends FlxState
{
	var winnerText:FlxText;
	override public function create()
	{
		super.create();

        //bring back mouse cursor
        FlxG.mouse.visible = true;

		//Create the "GAME OVER" text
        var gameOverText = new FlxText(0, FlxG.height / 2 - 40, FlxG.width, "GAME OVER");
        gameOverText.setFormat(null, 24, 0xFFFFFF, "center");
        add(gameOverText);

		winnerText = new FlxText(0, FlxG.height / 2 - 10, FlxG.width, "");

		//If 2P mode, display winning player
		if(PlayState.playerMode == 2){
			winnerText.text = PlayState.winningPlayer == 0 ? "Player 1 Wins!" : "Player 2 Wins!";
			if(PlayState.winningPlayer == -1){
				winnerText.text = "Draw!";
			}
		}
		if(PlayState.playerMode == 1){
			winnerText.text = PlayState.winningPlayer == -1 ? "You lose!" : "You win!";
		}

		winnerText.setFormat(null, 16, 0xFFFFFF, "center");
        add(winnerText);

		//Create a button to play again
        var playAgainButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 20, "Play again", playAgainCallback);
        playAgainButton.width = FlxG.width / 2;
		playAgainButton.x -= playAgainButton.width/4;
		playAgainButton.updateHitbox();
        add(playAgainButton);

		//Main menu button, returns to GameStartState
		var mainMenuButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 20, "Main Menu", mainMenuCallback);
        mainMenuButton.width = FlxG.width / 2;
		mainMenuButton.x += mainMenuButton.width/4;
		mainMenuButton.updateHitbox();
        add(mainMenuButton);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		if(FlxG.keys.justPressed.ESCAPE){
			openSubState(new PauseState());
		}
	}

	function playAgainCallback()
	{
		FlxG.switchState(new PlayState());
	}
	function mainMenuCallback()
		{
			FlxG.switchState(new GameStartState());
		}
}
