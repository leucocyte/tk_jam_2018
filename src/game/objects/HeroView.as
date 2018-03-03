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
import game.view.hero.HeroStatesDisplay;

import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.utils.RectangleUtil;

public class HeroView extends Sprite {

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
	private var _display:HeroStatesDisplay;

	public function HeroView(hero:Hero) {


		var sizeH:int = Settings.HERO_HEIGHT;
		var sizeW:int = Settings.HERO_WIDTH;
		_quad = new Quad(sizeW, sizeH, 0xff0000);
		_quad.pivotX = int(_quad.width / 2);
		_quad.pivotY = int(sizeH);
		_quad.visible = true;
		addChild(_quad);


		_display = new HeroStatesDisplay(hero.head, hero.body / 100, hero.legs);
		_display.setState(HeroState.STAND);

		addChild(_display);


		_quadHead = new Quad(sizeW / 2, sizeH / 3, 0xaa44ff);
		_quadHead.pivotX = int(sizeW / 4);
		_quadHead.pivotY = int(sizeH / 3);
		_quadHead.y = -sizeW;
		_quadHead.x = 10;
		_quadHead.visible = false;
		addChild(_quadHead);

		_label = new Label();
		_label.width = 100;
		_label.x = -50;
		_label.textRendererFactory = function ():ITextRenderer {
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
		_label.y = -Settings.HERO_HEIGHT * 1.3;

//		stand();
	}

	public function setDirection(_direction:int):void {
		if(_direction == Direction.LEFT)
			_quadHead.x = -10;
		else if(_direction == Direction.RIGHT)
			_quadHead.x = 10;
	}

	public function updateState(state:Number, dir:int,width:int,height:int):void {
		_display.setState(state, dir);
		addChild(_display);
		alignDisplay();
		_display.scaleX = 1;


		_quad.height = height;
		_quad.width = width;

		if (width==Settings.HERO_WIDTH_HANG)
			_quad.x= 30;
		else
			_quad.x= 0;

		//_quad.pivotX = width/2;
//		trace(width+" / "+Settings.HERO_HEIGHT_HANG+" / "+_quad.x);

//		trace(_quad.pivotX+" / "+_quad.width+" / "+int(_quad.width / 2));

		switch(state) {
			case HeroState.STAND:
				if(dir == -1) {
					flipLeft();
				}
				break;
			case HeroState.WALK:
				break;
			case HeroState.HANG:
				_display.y = 0;
				break;
			case HeroState.SQUAT:
				break;
			case HeroState.KICK:
			case HeroState.UPPERCUT:
				if(dir == -1) {
					flipLeft();
				}
				break;
			case HeroState.JUMP:
				break;
			case HeroState.STUN:
				break;
		}
	}

	private function flipLeft():void {
		var flip:DisplayObject = flipHorizontally(_display);
		flip.x -= 60;
		addChild(flip);
	}

	private function alignDisplay():void {
		_display.x = Settings.HERO_WIDTH/2 - 80;
		_display.y = -_display.height;
	}

	private function kick():void {
		_quad.color = 0x00ffff;
	}

	private function stun():void {
		_quad.color = 0x00ff00;
	}

	public function squat():void {
		_quad.y = 0;
		_quadHead.y = -Settings.HERO_HEIGHT_SQUAT * 0.6;
		_quad.height = Settings.HERO_HEIGHT_SQUAT;
	}
/*
	public function stand():void {
		_quad.y = 0;
		_quad.color = 0xaa4477;
		_quadHead.y = -Settings.HERO_HEIGHT * 0.6;
		_quad.height = Settings.HERO_HEIGHT;
	}*/
/*
	private function hang():void {
		trace("HANG!!!!");
		_quad.color = 0x00ff55;
		_quad.y = Settings.HERO_HEIGHT;
		_quadHead.y = 0;
	}*/


	public function getRectangle():Rectangle {
		return _quad.getBounds(Game.instance.trainScene.heroes);
	}

	public static function flipHorizontally(display:DisplayObject):DisplayObject {
		display.x = display.width;
		display.scaleX = -display.scaleX;
		var box:Sprite = new Sprite();
		box.addChild(display);
		return box;
	}


}
}
