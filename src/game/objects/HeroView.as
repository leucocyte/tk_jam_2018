/**
 * Created by flashdeveloper.pl on 2017-03-04.
 */
package game.objects {

import feathers.controls.Label;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;

import flash.text.TextFormat;

import game.Direction;
import game.Game;
import game.load.GameAssetsManager;
import game.utils.Settings;

import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.utils.RectangleUtil;

public class HeroView extends Sprite{

	public static const HEIGHT:Number = 100;
	public static const WIDTH:Number = 150;

	protected var _stand:MovieClip;
	protected var _walk:MovieClip;
	protected var _squat:MovieClip;
	protected var _kick:MovieClip;
	protected var _hang:MovieClip;
	protected var _jump:MovieClip;

	protected var _currentState:uint = -1;
	protected var _character:MovieClip;

	protected var _quad:Quad;
	protected var _quadHead:Quad;
	protected var _label:Label;

	public function HeroView(hero:Hero) {

		var sizeH:int = Settings.HERO_HEIGHT;
		var sizeW:int = Settings.HERO_WIDTH;
		_quad = new Quad(sizeW,sizeH,0xaa4477);
		_quad.pivotX=int(sizeW/2);
		_quad.pivotY=int(sizeH);
		addChild(_quad);

		_quadHead = new Quad(sizeW/2,sizeH/3,0xaa44ff);
		_quadHead.pivotX=int(sizeW/4);
		_quadHead.pivotY=int(sizeH/3);
		_quadHead.y = -sizeW;
		_quadHead.x = 10;
		addChild(_quadHead);

		_label = new Label();
		_label.width=100;
		_label.x = - 50;
		_label.textRendererFactory = function():ITextRenderer
		{
			var textFormat:TextFormat = new TextFormat();
//            textFormat.font = "Action Comics";
			textFormat.font = Settings.FONT;
			textFormat.size = 20;
			textFormat.color = 0xFFFFFF;
			textFormat.align = "center";

			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			textRenderer.textFormat = textFormat;
			textRenderer.nativeFilters = [new DropShadowFilter()];

			return textRenderer;
		};
		addChild(_label);

		_label.text = hero.name;
		_label.y = - Settings.HERO_HEIGHT *1.3;

		stand();
		/*
		_walk = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("man", "walk"));
		_walk.fps = 2;
		_walk.loop = true;

		_squat = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("man", "squat"));
		_squat.fps = 2;
		_squat.loop = false;

		_kick = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("man", "kick"));
		_kick.fps = 2;
		_kick.loop = false;
		_kick.addEventListener(Event.COMPLETE, function (e:*):void {
			setState(HeroState.STAND);
		});

		_stand = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("man", "stand"));
		_stand.fps = 2;
		_stand.loop = true;

		_hang = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("man", "hang"));
		_hang.fps = 2;
		_hang.loop = true;

		_jump = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("man", "jump"));
		_jump.fps = 2;
		_jump.loop = false;
		_jump.addEventListener(Event.COMPLETE, function (e:*):void {
			setState(HeroState.STAND);
		});

		_walk.x = _squat.x = _kick.x = _stand.x = _hang.x = -WIDTH / 2;
		_walk.y = _squat.y = _kick.y = _stand.y = _hang.y = -HEIGHT;

		setState(HeroState.STAND);*/
	}

	public function setState(state:uint):void {
		if(_currentState != state) {
			_character.stop();
			Starling.juggler.remove(_character);
			removeChild(_character);

			switch(state) {
				case HeroState.STAND:
					_character = _stand;
					break;
				case HeroState.WALK:
					_character = _walk;
					break;
				case HeroState.HANG:
					_character = _hang;
					break;
				case HeroState.SQUAT:
					_character = _squat;
					break;
				case HeroState.KICK:
					_character = _kick;
					break;
				case HeroState.JUMP:
					_character = _kick;
					break;
				default :
					throw new ArgumentError("State " + state + " is not supported");
			}

			_character.play();
			addChild(_character);

			Starling.juggler.add(_character);
			_currentState = state;
		}
	}

	public function squat():void {
		_quad.y = 0;
		_quadHead.y = -Settings.HERO_HEIGHT_SQUAT *0.6;
		_quad.height = Settings.HERO_HEIGHT_SQUAT;
	}

	public function stand():void {
		_quad.y = 0;
		_quad.color = 0xaa4477;
		_quadHead.y = -Settings.HERO_HEIGHT *0.6;
		_quad.height = Settings.HERO_HEIGHT;
	}

	private function hang():void {
		trace("HANG!!!!");
		_quad.color = 0x00ff55;
		_quad.y = Settings.HERO_HEIGHT;
		_quadHead.y = 0;
	}

	public function setDirection(_direction:int):void {
		if (_direction == Direction.LEFT)
			_quadHead.x = -10;
		else
			if (_direction == Direction.RIGHT)
				_quadHead.x = 10;
	}

	public function updateState(state:Number):void {
		switch(state){
			case HeroState.STAND:
				stand();
				break;
			case HeroState.WALK:
				stand();
				_character = _walk;
				break;
			case HeroState.HANG:
				hang();
				break;
			case HeroState.SQUAT:
				stand();
				squat();
				break;
			case HeroState.KICK:
				stand();
				kick();
//				_character = _kick;
				break;
			case HeroState.JUMP:
				stand();
//				_character = _kick;
				break;
			case HeroState.STUN:
				stun();
				break;
		}
	}

	private function kick():void {
		_quad.color = 0x00ffff;
	}

	private function stun():void {
		_quad.color = 0x00ff00;
	}


	public function getRectangle():Rectangle{
		return _quad.getBounds(Game.instance.trainScene.heroes);
	}


}
}
