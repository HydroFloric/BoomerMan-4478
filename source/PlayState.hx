package;

import flixel.FlxObject;
import PlayerCharacter;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;
import Bomb;



class PlayState extends FlxState {
	private var testPC:BluePC;
	private var testPC2:PurplePC;
	public static var walls:FlxTilemap;
	public static var bombs:Array<Bomb> = [];
	public static var players:Array<PlayerCharacter> = [];
	public var playerList:FlxTypedGroup<PlayerCharacter>; //Group containing active player objects
	var toAddMenu:Bool = false;  // Flag to determine whether to add the game over menu

	override public function create() {
		super.create();

		// create tilemap
		var map:FlxOgmo3Loader = new FlxOgmo3Loader("assets/data/TileMap.ogmo", "assets/data/BrickTileMap.json");
		walls = map.loadTilemap("assets/images/bg Tiles 64x64.png", "walls");
		walls.follow();
		walls.setTileProperties(1, ANY); // collision from any side on wall tile
		walls.setTileProperties(2, NONE); // no collision on floor tile
		add(walls);

		// add player character to map
		playerList = new FlxTypedGroup();
		testPC = new BluePC(0, 0, false);
		testPC2 = new PurplePC(0, 0, false);
		playerList.add(testPC);
		playerList.add(testPC2);
		add(playerList);
		playerList.forEach(players.push, false);

		map.loadEntities(placeEntities, "entities");

		//hide mouse cursor
		FlxG.mouse.visible = false;
		FlxG.debugger.drawDebug = true;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		playerList.update(elapsed);
		FlxG.collide(playerList, walls);
	}

	// function to place entities according to entity layer from tilemap
	function placeEntities(entity:EntityData) {
		if (entity.name == "player") {
			for (i in 0...players.length) {
				players[i].setPosition(entity.x,entity.y);
			}
		}
	}

}
