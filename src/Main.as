package {


import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import game.Game;
import game.init.ConnectingLoginBox;
import game.utils.DifficultyByMouseXCtrl;
import game.utils.Stage2DAbuser;
import game.utils.WorldTime;

import starling.core.Starling;

[SWF(width='1280', height='720', backgroundColor='#333333', frameRate='60')]
public class Main extends Sprite {

	private var _starling:Starling;
	public static var instance:Main;
	private var _connectingBox:ConnectingLoginBox;
	private var _diffX:DifficultyByMouseXCtrl;

	public function Main() {

		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		Stage2DAbuser.init(stage);
		WorldTime.getInstance();

		_diffX = new DifficultyByMouseXCtrl();

		instance = this;

		//loadIntro();

		//connect();

		initStarling();
	}

	private function connect():void {
		_connectingBox = new ConnectingLoginBox();
		addChild(_connectingBox);
	}


	public function onConnected():void {
		initStarling();
		removeChild(_connectingBox);
	}

	private function initStarling():void {
		_starling = new Starling(Game, stage);
		_starling.start();
		_starling.showStats = true;

		// set rectangle dimensions for viewPort:
		var viewPortRectangle:Rectangle = new Rectangle();
		viewPortRectangle.width = stage.stageWidth;
		viewPortRectangle.height = stage.stageHeight;

		// resize the viewport:
		Starling.current.viewPort = viewPortRectangle;

		_starling.stage.stageWidth = stage.stageWidth;
		_starling.stage.stageHeight = stage.stageHeight;

		stage.addEventListener(Event.RESIZE, onResize);
	}

	public function onResize(e:Event):void {
		var viewPortRectangle:Rectangle = new Rectangle();
		viewPortRectangle.width = stage.stageWidth;
		viewPortRectangle.height = stage.stageHeight;

		Starling.current.viewPort = viewPortRectangle;

		_starling.stage.stageWidth = stage.stageWidth;
		_starling.stage.stageHeight = stage.stageHeight;
	}
}
}
