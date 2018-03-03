package game {
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Sine;

import game.load.GameAssetsManager;
import game.scenery.ElementsSpawner;
import game.scenery.SeamlessBackground;
import game.scenery.elements.TractionSpawner;
import game.scenery.elements.Tree1Spawner;
import game.scenery.elements.Tree2Spawner;
import game.scenery.elements.TreesFarSpawner;
import game.utils.Settings;

import starling.display.Canvas;
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
	private var _bg:SeamlessBackground;
	private var _treesFar:TreesFarSpawner;
	private var _forestFarBg:SeamlessBackground;
	private var _forest2Bg:SeamlessBackground;
	private var _forest1Bg:SeamlessBackground;

	public function TrainScene() {
		_train = new Sprite();
		_train.y = 400;

		_bg = new SeamlessBackground(Settings.TRAIN_SPEED * 0.018, 'mountains1', 500);
		addChild(_bg);

		_scenery = new Sprite();
		_scenery.y = 550;

		var groundHeight:int = 200;
		var groundY:int = 300;
		_treesFar = new TreesFarSpawner();
		_scenery.addChild(_treesFar);
		_forestFarBg = new SeamlessBackground(_treesFar.speed, 'forest_ground_fade', groundHeight);
		_forestFarBg.y = groundY;
		addChild(_forestFarBg);

		_trees2 = new Tree2Spawner();
		_scenery.addChild(_trees2);
		_forest2Bg = new SeamlessBackground(_trees2.speed, 'forest_ground_fade', groundHeight);
		_forest2Bg.y = groundY + 50;
		addChild(_forest2Bg);

		_trees1 = new Tree1Spawner();
		_scenery.addChild(_trees1);
		_forest1Bg = new SeamlessBackground(_trees1.speed, 'forest_ground_fade', groundHeight * 1.7);
		_forest1Bg.y = groundY + 100;
		addChild(_forest1Bg);

		addChild(_scenery);

		_trainImage = GameAssetsManager.getImageFromMainAtlas('train');
		_trainImage.x = 150;
		_trainImage.width = 1500;
		_trainImage.scaleY = _trainImage.scaleX;
		_train.addChild(_trainImage);
		addChild(_train);

		Actuate.tween(_train, 0.5, {y: _train.y + 10}).reflect().repeat().ease(Sine.easeInOut);

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
