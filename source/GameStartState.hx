package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

import SettingState;

class GameStartState extends FlxState
{
	override public function create()
        {
            super.create();

            //bring back mouse cursor
            FlxG.mouse.visible = true;

            var quitButton:FlxButton;
    
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

            //Creating the quit button
            quitButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 50, "Quit Game", onQuitButtonClick);
            add(quitButton);
        }
        override function update(elapsed:Float) {
                super.update(elapsed);
                if(!FlxG.mouse.visible) FlxG.mouse.visible = true;
                if(FlxG.keys.justPressed.ESCAPE){
                    openSubState(new PauseState());
                }
        }
    
        function startCall1P()
        {
            FlxG.sound.play(AssetPaths.menubutton__wav);
            PlayState.playerMode = 1;
            FlxG.switchState(new PlayState());
        }
        function startCall2P()
            {
                FlxG.sound.play(AssetPaths.menubutton__wav);
                PlayState.playerMode = 2;
                FlxG.switchState(new PlayState());
            }
        function onQuitButtonClick() {
            Sys.exit(0);
        }
}
