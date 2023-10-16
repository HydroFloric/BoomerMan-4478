package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;

class GameStartState extends FlxState
{
	override public function create()
        {
            super.create();
    
            //bring back mouse cursor
            FlxG.mouse.visible = true;
    
            // Create the text games title
            var titleText = new FlxText(0, FlxG.height / 2 - 40, FlxG.width, "Super BOOMER Man");
            titleText.setFormat(null, 24, 0xFFFFFF, "center");
            add(titleText);
    
            // Create a button to play again
            var startButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 20, "Begin!", startCall);
            startButton.width = FlxG.width / 2;
            startButton.updateHitbox();
            add(startButton);
        }
    
        function startCall()
        {
            FlxG.switchState(new PlayState());
        }
}
