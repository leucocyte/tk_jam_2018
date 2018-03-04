package game {
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.Sine;

import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import flash.utils.setInterval;
import flash.utils.setTimeout;

import game.load.GameAssetsManager;
import game.objects.HeroState;
import game.objects.HeroView;
import game.utils.ArrayUtils;
import game.utils.DisplayUtils;
import game.utils.Settings;
import game.utils.Stage2DAbuser;
import game.view.BloodAnim;
import game.view.ConductorAnim;
import game.view.HitAnim;
import game.view.hero.HeroStateDisplay;
import game.view.hero.HeroStatesDisplay;
import game.view.scenery.ElementsSpawner;
import game.view.scenery.SeamlessBackground;
import game.view.scenery.elements.BushesSpawner;
import game.view.scenery.elements.TractionSpawner;
import game.view.scenery.elements.Tree1Spawner;
import game.view.scenery.elements.Tree2Spawner;
import game.view.scenery.elements.TreesFarSpawner;

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
	private var _back3Clouds:SeamlessBackground;
	private var _back2Mountains:SeamlessBackground;
	private var _treesFar:TreesFarSpawner;
	private var _pump:Sprite;
	private var _back1Ground:SeamlessBackground;
	private var _bushes:BushesSpawner;
	private var _conductor:ConductorAnim;

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

		_back2Mountains = new SeamlessBackground(Settings.TRAIN_SPEED * 0.04, 'back2');
		_back2Mountains.y = 300;

		_scenery = new Sprite();
		_scenery.y = 1000;

		_treesFar = new TreesFarSpawner();
		_scenery.addChild(_treesFar);

		_trees2 = new Tree2Spawner();
		_scenery.addChild(_trees2);

		_trees1 = new Tree1Spawner();
		_scenery.addChild(_trees1);

		_back1Ground = new SeamlessBackground(_treesFar.speed / 2, 'back1');
		_back1Ground.y = _back2Mountains.y + _back2Mountains.height - 1;
		addChild(_back1Ground);
		addChild(_back2Mountains);

		addChild(_scenery);

		_pump = new Sprite();
		addChild(_pump);

		_conductor = new ConductorAnim();
		_train.addChild(_conductor);

		_trainImage = GameAssetsManager.getImageFromMainAtlas('train_middle');
		_train.addChild(_trainImage);

		var trainImageLeft:Image = GameAssetsManager.getImageFromMainAtlas('train_back');
		trainImageLeft.x = -164;
		_train.addChild(trainImageLeft);
		var trainImageRight:Image = GameAssetsManager.getImageFromMainAtlas('train_front');
		trainImageRight.x = 1870;
		_train.addChild(trainImageRight);
		trainImageLeft.y = trainImageRight.y = _trainImage.y = -9;

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
	}

	public function get heroes():Sprite {
		return _heroes;
	}

	public function get pump():Sprite {
		return _pump;
	}

	public function get conductor():ConductorAnim {
		return _conductor;
	}

	public function showKillEffectPump(view:HeroView):void {
		var point:Point = new Point();
		view.localToGlobal(point, point);
		globalToLocal(point, point);
		var bloodAnim:BloodAnim = new BloodAnim();
		bloodAnim.x = point.x;
		bloodAnim.y = point.y - 50;
		addChild(bloodAnim);
		DisplayUtils.drawDebugCircle(this, point.x, point.y);
		Actuate.tween(bloodAnim, 0.2, {x: bloodAnim.x - 200, y: bloodAnim.y - 200}).ease(Expo.easeIn);
	}

	public function showHitEffect(view:HeroView):void {
		var point:Point = new Point();
		view.localToGlobal(point, point);
		globalToLocal(point, point);
		var hitAnim:HitAnim = new HitAnim();
		hitAnim.x = point.x;
		hitAnim.y = point.y - 60;
		addChild(hitAnim);
		DisplayUtils.drawDebugCircle(this, point.x, point.y);
	}

}
}
