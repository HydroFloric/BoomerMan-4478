package;

import flixel.addons.ui.StrNameLabel;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.text.FlxText;
import flixel.addons.ui.FlxSlider;

class SettingState extends FlxState
{
    var titleText:FlxText;
    var backButton:FlxButton;
    var resolutionText:FlxText;
    var resolutionComboBox:FlxUIDropDownMenu;
    var fullscreenCheckBox:FlxUICheckBox;
    var volumeText:FlxText;
    var volumeSlider:FlxSlider;
    var applyButton:FlxButton;

    override public function create():Void
    {
        super.create();
        // Title
        titleText = new FlxText(0, 20, FlxG.width, "Settings");
        add(titleText);

        // Back button
        backButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height - 60, "Back", onBackButtonClick);
        add(backButton);

        // Resolution
        resolutionText = new FlxText(0, 100, FlxG.width, "Resolution");
        add(resolutionText);

        var resolutionLabel:Array<StrNameLabel> = FlxUIDropDownMenu.makeStrIdLabelArray(["640x480", "800x600", "1024x768", "1280x720", "1920x1080"], true);
        resolutionComboBox = new FlxUIDropDownMenu(0, 140, resolutionLabel, onResolutionChange);
        resolutionComboBox.width = FlxG.width / 2;
        resolutionComboBox.selectedId = "1280x720";
        add(resolutionComboBox);

        // fullscreenCheckBox = new FlxUICheckBox(FlxG.width / 2 + 20, 140, "Fullscreen");
        // fullscreenCheckBox.getLabel().size = 16;
        // fullscreenCheckBox.getLabel().setBorderStyle(SHADOW, 0x000000, 3, 0);
        // add(fullscreenCheckBox);

        // Volume
        volumeText = new FlxText(0, 200, FlxG.width, "Volume");
        add(volumeText);

        // volumeSlider = new FlxSlider(volumeText, "FlxG.sound.volume", 0, 240, 0, 100, Std.int(FlxG.width/2), 10, 2, 0xffffff, 0xffffff);
        // add(volumeSlider);

        applyButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height - 120, "Apply", onApplyButtonClick);
        add(applyButton);
    }

    function onBackButtonClick():Void
    {
        FlxG.switchState(new GameStartState());
    }

    function onResolutionChange(label:String):Void
    {
        var resolution:Array<String> = label.split("x");
        FlxG.resizeGame(Std.parseInt(resolution[0]), Std.parseInt(resolution[1]));
        FlxG.resetGame();
    }

    function onFullscreenChange():Void
    {
        FlxG.fullscreen = !FlxG.fullscreen;
    }

    function onApplyButtonClick():Void
    {
        
    }
}

class PauseState extends FlxState
{
    var titleText:FlxText;
    var resumeButton:FlxButton;
    var settingButton:FlxButton;
    var quitButton:FlxButton;

    override public function create():Void
    {
        // Title
        titleText = new FlxText(0, 20, FlxG.width, "Paused");
        titleText.setFormat(null, 32, 0xffffff, "center");
        add(titleText);

        // Resume button
        resumeButton = new FlxButton(FlxG.width / 2 - 40, 100, "Resume", onResumeButtonClick);
        add(resumeButton);

        // Setting button
        settingButton = new FlxButton(FlxG.width / 2 - 40, 140, "Settings", onSettingButtonClick);
        add(settingButton);

        // Quit button
        quitButton = new FlxButton(FlxG.width / 2 - 40, 180, "Quit", onQuitButtonClick);
        add(quitButton);
    }

    function onResumeButtonClick():Void
    {
        FlxG.switchState(new PlayState());
    }

    function onSettingButtonClick():Void
    {
        FlxG.switchState(new SettingState());
    }

    function onQuitButtonClick():Void
    {
        FlxG.switchState(new GameStartState());
    }
}
