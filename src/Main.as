package {


import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.utils.setTimeout;

import game.Game;
import game.init.ConnectingLoginBox;
import game.utils.DifficultyByMouseXCtrl;
import game.utils.Settings;
import game.utils.Stage2DAbuser;
import game.utils.WorldTime;

import starling.core.Starling;
import starling.utils.RectangleUtil;
import starling.utils.ScaleMode;

//[SWF(width='1280', height='720', backgroundColor='#333333', frameRate='60')]
//[SWF(width='1920', height='600', backgroundColor='#333333', frameRate='60')]
[SWF(width='1920', height='1080', backgroundColor='#333333', frameRate='60')]
public class Main extends Sprite {

	private var _starling:Starling;
	public static var instance:Main;
	private var _connectingBox:ConnectingLoginBox;
	private var _diffX:DifficultyByMouseXCtrl;

	public function Main() {
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}


	private function onAddedToStage(event:Event):void {
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		//MP3Manager.play(new URLRequest('http://btccharts.com/sounds/double_click_mouse_over.mp3'), 99999);

		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		Stage2DAbuser.init(stage);
		WorldTime.getInstance();

		//_diffX = new DifficultyByMouseXCtrl();

		instance = this;

		//loadIntro();
		if(Settings.ONLINE)
			connect();
		else
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
		_starling = new Starling(Game, stage, new Rectangle(0, 0, Settings.SCENE_WIDTH, Settings.SCENE_HEIGHT));
		_starling.start();
		_starling.showStats = true;

		setTimeout(onResize, 1000);
		stage.addEventListener(Event.RESIZE, onResize);
	}

	public function onResize(e:Event = null):void {
		var playerWidth:int = stage.stageWidth;
		var playerHeight:int = stage.stageHeight;

		Starling.current.viewPort = RectangleUtil.fit(
				new Rectangle(0, 0, Settings.SCENE_WIDTH, Settings.SCENE_HEIGHT),
				new Rectangle(0, 0, playerWidth, playerHeight),
				ScaleMode.SHOW_ALL, false);

		//var screenRect:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		//
		//var viewportRect:Rectangle = RectangleUtil.fit(
		//		new Rectangle(0, 0, Settings.SCENE_WIDTH, Settings.SCENE_HEIGHT), screenRect, ScaleMode.SHOW_ALL);
		//viewportRect.copyFrom(screenRect);
		//viewportRect.x = 0;
		//viewportRect.y = 0;
		//
		//Starling.current.viewPort = viewportRect;

		//var rescale:Number = getRescaleToRect(playerWidth, playerHeight, Settings.SCENE_WIDTH, Settings.SCENE_HEIGHT);
		//Starling.current.viewPort = new Rectangle(0, 0, Settings.SCENE_WIDTH * rescale, Settings.SCENE_HEIGHT * rescale);

		//var viewPortRectangle:Rectangle = new Rectangle();
		//viewPortRectangle.width = stage.stageWidth;
		//viewPortRectangle.height = stage.stageHeight;
		//
		//Starling.current.viewPort = viewPortRectangle;
		//
		//_starling.stage.stageWidth = stage.stageWidth;
		//_starling.stage.stageHeight = stage.stageHeight;
	}
}
}
