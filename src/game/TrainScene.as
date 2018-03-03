package game {
import game.scenery.ElementsSpawner;
import game.scenery.elements.Tree1Spawner;
import game.scenery.elements.Tree2Spawner;

import starling.display.Sprite;

public class TrainScene extends Sprite {

	private var _trees1:ElementsSpawner;
	private var _trees2:ElementsSpawner;
	private var _heroes:Sprite;

	public function TrainScene() {
		_trees1 = new Tree1Spawner();
		_trees2 = new Tree2Spawner();
		_heroes = new Sprite();

		addChild(_trees2);
		addChild(_trees1);
		addChild(_heroes);
	}

	public function get heroes():Sprite {
		return _heroes;
	}
}
}
