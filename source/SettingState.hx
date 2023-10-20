package;

import flixel.addons.ui.StrNameLabel;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
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

    var resolutionLabel:Array<StrNameLabel>;
    var fullscreenCheck:Bool;
    var volume:Float;
    var selectedRes:String;

    override public function create():Void
    {
        super.create();
        selectedRes = "720x576";
        fullscreenCheck = false;
        volume = 100;
        resolutionLabel = FlxUIDropDownMenu.makeStrIdLabelArray(["720x576", "800x600", "1024x768", "1280x720", "1920x1080"], true);

        // Title
        titleText = new FlxText(0, 20, FlxG.width, "Settings");
        titleText.setFormat(null, 32, 0xffffff, "center");
        add(titleText);

        // Back button
        backButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height - 60, "Back", onBackButtonClick);
        add(backButton);

        // Resolution
        resolutionText = new FlxText(FlxG.width / 2-150, 250, FlxG.width, "Resolution");
        resolutionText.setFormat(null, 16, 0xffffff, "left");
        add(resolutionText);

        resolutionComboBox = new FlxUIDropDownMenu(FlxG.width / 2-30, 250, resolutionLabel, onPress -> selectedRes = resolutionComboBox.selectedLabel);
        resolutionComboBox.width = FlxG.width / 2;
        add(resolutionComboBox);

         fullscreenCheckBox = new FlxUICheckBox((FlxG.width / 2) - 60, 100, null, null, "Fullscreen", 150, null, onFullscreenChange);
         fullscreenCheckBox.getLabel().alignment = LEFT;
         fullscreenCheckBox.width = (FlxG.width /2) - 20;
         fullscreenCheckBox.height = 20;
         fullscreenCheckBox.getLabel().size = 16;
         fullscreenCheckBox.getLabel().setBorderStyle(SHADOW, 0x000000, 3, 0);
         add(fullscreenCheckBox);

        // Volume
        volumeText = new FlxText(0, 0, FlxG.width, "Volume");
        volumeSlider = new FlxSlider(this, "volume", FlxG.width / 4, 150, 0, 100, Std.int(FlxG.width/2),15,15,0xFFFFFFFF,0xFFC7BDBD);
        volumeSlider.width = FlxG.width / 2;
        volumeSlider.nameLabel = volumeText;
        add(volumeSlider);

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
        FlxG.resizeWindow(Std.parseInt(resolution[0]), Std.parseInt(resolution[1]));
    }

    function onFullscreenChange():Void
    {
        fullscreenCheck = !fullscreenCheck;
    }

    function onApplyButtonClick():Void
    {
        if(fullscreenCheck){
            fullscreenCheckBox.checked = true;
            FlxG.fullscreen = fullscreenCheck;
        }
        else{
            fullscreenCheckBox.checked = false;
            FlxG.fullscreen = false;
            onResolutionChange(selectedRes);
        } 
        FlxG.sound.volume = volume/100;
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
