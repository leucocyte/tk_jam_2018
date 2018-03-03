package game {
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Sine;

import game.load.GameAssetsManager;
import game.scenery.ElementsSpawner;
import game.scenery.elements.TractionSpawner;
import game.scenery.elements.Tree1Spawner;
import game.scenery.elements.Tree2Spawner;

import starling.display.Image;

import starling.display.Sprite;

public class TrainScene extends Sprite {

	private var _trees1:ElementsSpawner;
	private var _trees2:ElementsSpawner;
	private var _traction:ElementsSpawner;
	private var _scenery:Sprite;
	private var _heroes:Sprite;
	private var _train:Sprite;
	private var _trainImage:Image;

	public function TrainScene() {

		_scenery = new Sprite();
		addChild(_scenery);
		_scenery.y = 550;
		_trees1 = new Tree1Spawner();
		_trees2 = new Tree2Spawner();
		_scenery.addChild(_trees2);
		_scenery.addChild(_trees1);

		_train = new Sprite();
		_train.y = 300;
		_trainImage = GameAssetsManager.getImageFromMainAtlas('train');
		_trainImage.y = _trainImage.height;
		_trainImage.x = 150;
		_trainImage.width = 1500;
		_trainImage.scaleY = _trainImage.scaleX;
		_train.addChild(_trainImage);
		addChild(_train);

		Actuate.tween(_train, 0.5, {y: 310}).reflect().repeat().ease(Sine.easeInOut);

		_heroes = new Sprite();
		_train.addChild(_heroes);

		_traction = new TractionSpawner();
		_traction.y = 1000;
		addChild(_traction);
	}

	public function get heroes():Sprite {
		return _heroes;
	}
}
}
