package;

import PlayerCharacter;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;
import Bomb;



class PlayState extends FlxState {
	private var testPC:BluePC;
	public static var walls:FlxTilemap;
	public static var bombs:Array<Bomb> = [];
	public static var players:Array<PlayerCharacter> = [];

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
		testPC = new BluePC(0, 0, false);
		map.loadEntities(placeEntities, "entities");
		players.push(testPC);
		add(testPC);

		


		FlxG.debugger.drawDebug = true;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		testPC.update(elapsed);
		FlxG.collide(testPC, walls);
	}

	// function to place entities according to entity layer from tilemap
	function placeEntities(entity:EntityData) {
		if (entity.name == "player") {
			testPC.setPosition(entity.x, entity.y);
		}
	}

	
}
