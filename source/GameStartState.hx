package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

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
    
            // Create the start buttons
            //1P mode
            var startButton1P = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 20, "1 Player Mode!", startCall1P);
            startButton1P.width = FlxG.width / 2;
            startButton1P.x -= startButton1P.width/4;
            startButton1P.updateHitbox();
            add(startButton1P);

            //2P mode
            var startButton2P = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 20, "2 Player Mode!", startCall2P);
            startButton2P.width = FlxG.width / 2;
            startButton2P.x += startButton2P.width/4;
            startButton2P.updateHitbox();
            add(startButton2P);
        }
    
        function startCall1P()
        {
            PlayState.playerMode = 1;
            FlxG.switchState(new PlayState());
        }
        function startCall2P()
            {
                PlayState.playerMode = 2;
                FlxG.switchState(new PlayState());
            }
}
