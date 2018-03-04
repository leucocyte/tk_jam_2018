/**
 * Created by Drygu on 2018-03-03.
 */
package game.objects {
import flash.geom.Rectangle;

import game.Direction;
import game.Game;
import game.utils.Settings;

public class Hero extends CollisionObject {

	private var _id:int;
	private var _name:String;
	private var _state:int;
	private var _direction:int;

	private var _head:int;
	private var _body:int;
	private var _legs:int;

	private var _rectangle:Rectangle;

	private var _view:HeroView;

	public function Hero(msg:String = null) {
		_width = Settings.HERO_WIDTH;
		_height = Settings.HERO_HEIGHT;
		_state = -1;
		_direction = Direction.RIGHT;

		_rectangle = new Rectangle();

		if(msg == null) {
			_id = 0;
			_name = "Drygu";
		} else {

			var split:Array = msg.split(",");
			_id = parseInt(split[0]);
			_name = split[1];
			_head = parseInt(split[2]);
			_body = parseInt(split[3]);
			_legs = parseInt(split[4]);
			_state = parseInt(split[5]);
			_x = parseInt(split[6]);
			_y = parseInt(split[7]);
			_direction = parseInt(split[8]);
		}
		_y = Settings.GROUND_Y;

		_view = new HeroView(this);
		Game.instance.trainScene.heroes.addChild(_view);
		updateView();
	}


	public function updateHero(msg:String) {
		var split:Array = msg.split(",");
		//skip id
		_x = parseInt(split[1]);
		_y = parseInt(split[2]);
		_direction = parseInt(split[3]);
		_state = parseInt(split[4]);

		updateView();
	}

	public function updateView():void {

		switch(_state) {
			case HeroState.SQUAT:
			case HeroState.DROP:
				_height = Settings.HERO_HEIGHT_SQUAT;
				_width = Settings.HERO_WIDTH;
				break;
			case HeroState.HANG:
				_height = Settings.HERO_HEIGHT_HANG;
				_width = Settings.HERO_WIDTH_HANG;
				break;
			default :
				_height = Settings.HERO_HEIGHT;
				_width = Settings.HERO_WIDTH;
				break;

		}

		_view.setDirection(_direction);
		_view.updateState(_state, _direction, _width, _height);
		_view.x = _x;
		_view.y = _y;
	}

	public function destroy():void {
		Game.instance.trainScene.heroes.removeChild(_view);
	}

	public override function getRectangle():Rectangle {
		return _view.getRectangle();
	}

	public function get id():int {
		return _id;
	}

	public function set id(value:int):void {
		_id = value;
	}

	public function get name():String {
		return _name;
	}


	public function get state():int {
		return _state;
	}

	public function set state(value:int):void {
		_state = value;
	}

	public function get direction():int {
		return _direction;
	}

	public function set direction(value:int):void {
		_direction = value;
	}


	public function get head():int {
		return _head;
	}

	public function get body():int {
		return _body;
	}

	public function get legs():int {
		return _legs;
	}

	public function get view():HeroView {
		return _view;
	}
}
}
