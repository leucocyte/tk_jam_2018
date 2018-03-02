/**
 * Created by flashdeveloper.pl on 2017-03-04.
 */
package game.objects {

import game.load.GameAssetsManager;

import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;

public class HeroView extends Sprite {

	public static const HEIGHT:Number = 100;
	public static const WIDTH:Number = 150;

	protected var _stand:MovieClip;
	protected var _walk:MovieClip;
	protected var _squat:MovieClip;
	protected var _kick:MovieClip;
	protected var _hang:MovieClip;
	protected var _jump:MovieClip;

	protected var _currentState:String = "";
	protected var _character:MovieClip;

	public function HeroView() {
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

		setState(HeroState.STAND);
	}

	public function setState(state:String):void {
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

}
}
