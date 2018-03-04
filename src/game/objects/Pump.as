/**
 * Created by Drygu on 2018-03-03.
 */
package game.objects {
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Back;
import com.eclecticdesignstudio.motion.easing.Elastic;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.Sine;

import flash.geom.Rectangle;
import flash.net.URLRequest;

import game.Game;
import game.load.GameAssetsManager;
import game.utils.MP3Manager;
import game.utils.Settings;
import game.utils.WorldTime;

import org.osflash.signals.Signal;

import starling.display.Image;

import starling.display.Quad;

public class Pump extends CollisionObject {

	private var _id:Number;
	private var _type:int;
	private var _view:PumpView;
	private var _quad:Quad;

	public var completedSignal:Signal = new Signal(Pump);
	private var _timeStamp:Number;
	private var _alertImg:Image;

	public function Pump(msg:String) {
		var arr:Array = msg.split(",");
		_id = parseInt(arr[0]);
//        _x = parseFloat(arr[1]);
//        _y = parseFloat(arr[2]);
		_type = parseInt(arr[1]);
		_timeStamp = parseInt(arr[2]);
//        _width = parseInt(arr[4]);
//        _height = parseInt(arr[5]);
		_width = 60;
		_height = 140;

		_y = 0;
		_x = 2000;

		trace("new PUMP! " + _type);

		_view = new PumpView(this);
		_view.x = _x;
//        _view.y=500;

		_alertImg = GameAssetsManager.getImageFromMainAtlas('pump_alarm1');
		_alertImg.scale = 0.5;

		switch(_type) {
			case 0:
				_quad = new Quad(_width, _height, 0x55ff00);
				_quad.x = x;
				_quad.y = -100 ;
				_alertImg.y = 600;
				break;
			case 1:
				_quad = new Quad(_width, _height, 0x55ffff);
				_quad.x = x;
				_quad.y = -180;
				_alertImg.y = 500;
				break;
			case 2:
				_quad = new Quad(_width, _height, 0x5500ff);
				_quad.x = x;
				_quad.y = -240;
				_alertImg.y = 400;
				break;
			case 3:
				_quad = new Quad(_width, _height, 0x5500ff);
				_quad.x = x;
				_quad.y = -320;
				_alertImg.y = 300;
				break;
		}


		Game.instance.trainScene.heroes.addChild(_quad);
		Game.instance.trainScene.pump.addChild(_view);

		Game.instance.trainScene.addChild(_alertImg);
		_alertImg.x = Settings.SCENE_WIDTH + _alertImg.width;
		_alertImg.alpha = 0;
		Actuate.tween(_alertImg, 0.5, {x: Settings.SCENE_WIDTH - _alertImg.width * 1.33, alpha: 1})
				.ease(Back.easeOut).onComplete(function ():void {
					Actuate.tween(_alertImg, 0.2, {
						y: _alertImg.y + 20,
						alpha: 0.5
					}).reflect().repeat(6).ease(Sine.easeInOut)
							.onComplete(function ():void {
								Actuate.tween(_alertImg, 0.5, {y: _alertImg.y - _alertImg.height * 2, alpha: 0})
										.ease(Back.easeOut).onComplete(onAnimAlert_Complete);
							})
				});
		_quad.visible = false;
		_view.visible = false;
	}

	public function onAnimAlert_Complete():void {
		_view.visible = true;
		_quad.visible = Settings.QUAD_VISIBLE;
		WorldTime.frameSignal.add(onWorldTime_Time);
	}

	private function onWorldTime_Time(frameTime:Number):void {
		_view.x -= (frameTime / 1000) * Settings.TRAIN_SPEED * Settings.DIFFICULTY;
		_quad.x -= (frameTime / 1000) * Settings.TRAIN_SPEED * Settings.DIFFICULTY;
		if(_view.x < -_view.width) {
			WorldTime.frameSignal.remove(onWorldTime_Time);
			Game.instance.trainScene.pump.removeChild(_view);
			Game.instance.trainScene.heroes.removeChild(_quad);
			completedSignal.dispatch(this);
		}

	}


	override public function hit(hero:CollisionObject):Boolean {
		return super.hit(hero);
	}

	override public function getRectangle():Rectangle {
		if(_quad != null) {
			return _quad.getBounds(Game.instance.trainScene.heroes);
		} else
			return null;

	}

	public function get type():int {
		return _type;
	}

	public function set type(value:int):void {
		_type = value;
	}


	public function get id():Number {
		return _id;
	}

	public function set id(value:Number):void {
		_id = value;
	}
}
}
