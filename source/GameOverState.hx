package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class GameOverState extends FlxState
{
	override public function create()
	{
		super.create();

        //bring back mouse cursor
        FlxG.mouse.visible = true;

		// Create the "GAME OVER" text
        var gameOverText = new FlxText(0, FlxG.height / 2 - 40, FlxG.width, "GAME OVER");
        gameOverText.setFormat(null, 24, 0xFFFFFF, "center");
        add(gameOverText);

		// Create a button to play again
        var playAgainButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 20, "Play again", playAgainCallback);
        playAgainButton.width = FlxG.width / 2;
		playAgainButton.updateHitbox();
        add(playAgainButton);
	}

	function playAgainCallback()
	{
		FlxG.switchState(new PlayState());
	}
}
