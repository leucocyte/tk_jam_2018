package game {
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Sine;

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import game.load.GameAssetsManager;
import game.objects.HeroState;
import game.utils.ArrayUtils;
import game.utils.Settings;
import game.utils.Stage2DAbuser;
import game.view.hero.HeroStateDisplay;
import game.view.hero.HeroStatesDisplay;
import game.view.scenery.ElementsSpawner;
import game.view.scenery.SeamlessBackground;
import game.view.scenery.elements.BushesSpawner;
import game.view.scenery.elements.TractionSpawner;
import game.view.scenery.elements.Tree1Spawner;
import game.view.scenery.elements.Tree2Spawner;
import game.view.scenery.elements.TreesFarSpawner;

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
	private var _back3Clouds:SeamlessBackground;
	private var _back2Mountains:SeamlessBackground;
	private var _treesFar:TreesFarSpawner;
	private var _forestFarBg:SeamlessBackground;
	private var _forest2Bg:SeamlessBackground;
	private var _forest1Bg:SeamlessBackground;
	private var _pump:Sprite;
	private var _back1Ground:SeamlessBackground;
	private var _bushes:BushesSpawner;

	public function TrainScene() {
		_train = new Sprite();
		_train.y = 663;

		var sky:Image = GameAssetsManager.getImageFromMainAtlas('back4');
		sky.width = Settings.SCENE_WIDTH;
		sky.height = Settings.SCENE_HEIGHT;
		addChild(sky);

		_back3Clouds = new SeamlessBackground(Settings.TRAIN_SPEED * 0.04, 'back3');
		_back3Clouds.y = 243;
		addChild(_back3Clouds);

		_back2Mountains = new SeamlessBackground(Settings.TRAIN_SPEED * 0.08, 'back2');
		_back2Mountains.y = 300;

		_scenery = new Sprite();
		_scenery.y = 1000;

		var groundHeight:int = 150;
		var groundY:int = 300;
		_treesFar = new TreesFarSpawner();
		_scenery.addChild(_treesFar);
		//_forestFarBg = new SeamlessBackground(_treesFar.speed, 'forest_ground_fade', groundHeight);
		//_forestFarBg.y = groundY;
		//addChild(_forestFarBg);

		_trees2 = new Tree2Spawner();
		_scenery.addChild(_trees2);
		//_forest2Bg = new SeamlessBackground(_trees2.speed, 'forest_ground_fade', groundHeight);
		//_forest2Bg.y = groundY + 50;
		//addChild(_forest2Bg);

		_trees1 = new Tree1Spawner();
		_scenery.addChild(_trees1);
		//_forest1Bg = new SeamlessBackground(_trees1.speed, 'forest_ground_fade', groundHeight * 1.7);
		//_forest1Bg.y = groundY + 100;
		//addChild(_forest1Bg);

		_back1Ground = new SeamlessBackground(_trees1.speed, 'back1');
		_back1Ground.y = _back2Mountains.y + _back2Mountains.height - 1;
		addChild(_back1Ground);
		addChild(_back2Mountains);

		addChild(_scenery);

		_pump = new Sprite();
		addChild(_pump);

		_trainImage = GameAssetsManager.getImageFromMainAtlas('train_middle');
		_trainImage.x = 0;
		_train.addChild(_trainImage);
		var trainImageLeft:Image = GameAssetsManager.getImageFromMainAtlas('train_back');
		trainImageLeft.x = -164;
		_train.addChild(trainImageLeft);
		var trainImageRight:Image = GameAssetsManager.getImageFromMainAtlas('train_front');
		trainImageRight.x = 1870;
		_train.addChild(trainImageRight);

		addChild(_train);

		Actuate.tween(_train, 0.5, {y: _train.y + 10}).reflect().repeat().ease(Sine.easeInOut);
		Actuate.tween(trainImageLeft, 0.5, {y: 8}).reflect().repeat().ease(Sine.easeInOut).delay(0.1);
		Actuate.tween(trainImageRight, 0.5, {y: 8}).reflect().repeat().ease(Sine.easeInOut).delay(-0.1);

		_heroes = new Sprite();
		_train.addChild(_heroes);

		_bushes = new BushesSpawner();
		_bushes.y = Settings.SCENE_HEIGHT;
		addChild(_bushes);

		_traction = new TractionSpawner();
		_traction.y = Settings.SCENE_HEIGHT;
		addChild(_traction);

		//_heroStates = new HeroStatesDisplay();
		//addChild(_heroStates);
		//Stage2DAbuser.getStage().addEventListener(KeyboardEvent.KEY_DOWN, onStage_KeyDown);
		//_allStates = _heroStates.all.concat();
	}

	//private function onStage_KeyDown(event:KeyboardEvent):void {
	//	if(event.keyCode == Keyboard.H) {
	//		if(_currentState) {
	//			removeChild(_currentState);
	//		}
	//		if(!_allStates.length) {
	//			_allStates = _heroStates.all.concat();
	//		}
	//		_currentState = _allStates.shift();
	//		trace('state: ' + _currentState.stateName);
	//		addChild(_currentState);
	//	}
	//	if(event.keyCode == Keyboard.S) {
	//		_heroStates.setState(ArrayUtils.getRandom([
	//			HeroState.STAND,
	//			HeroState.WALK,
	//			HeroState.SQUAT,
	//			HeroState.KICK,
	//			HeroState.HANG,
	//			HeroState.JUMP,
	//			HeroState.UPPERCUT,
	//		]));
	//		trace('state: ' + _heroStates.currentState.stateName);
	//	}
	//}

	public function get heroes():Sprite {
		return _heroes;
	}

	public function get pump():Sprite {
		return _pump;
	}
}
}
