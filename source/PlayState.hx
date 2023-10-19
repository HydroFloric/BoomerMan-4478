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
	public static var playerMode = 0; //Indicates selected playermode (1P=1,2P=2), 0 by default.
	public static var winningPlayer = 0; //Indicates the winning player in 2P mode. Used by GameOverState to display the correct text.
	private var testPC:BluePC;
	private var testPC2:PurplePC;
	private var testNPC:BasicEnemy;
	public static var walls:FlxTilemap;
	public static var bombs:Array<Bomb> = [];
	public static var playerList:FlxTypedGroup<PlayerCharacter> = null; //Group containing active player objects
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
		playerList.add(testPC);

		//If 2P mode is selected load the second player
		if(PlayState.playerMode == 2){
			testPC2 = new PurplePC(0, 0, false);
			playerList.add(testPC2);
		}
		else if(PlayState.playerMode == 1){
			testNPC = new BasicEnemy(0,0,true);
			playerList.add(testNPC);
		}
		add(playerList);

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
			for (obj in playerList) {
				obj.setPosition(entity.x+(32-(obj.width/2)),entity.y+(64-(obj.height)));
				
				//Player spawning logic
				if(obj.playerNum == 0){ //P1
					obj.x -= 64*2;
				}
				else if(obj.playerNum == 1 || obj.playerNum == -1){ //P2 or Enemy
					obj.x += 64*2;
				}
			
			}
		}
	}
	

}
