/** Created by Marek Brun on 03 marzec 2018 */
package game.view.hero {
import game.Direction;
import game.objects.HeroState;

import starling.display.Sprite;

public class HeroStatesDisplay extends Sprite {

	private var _squat:HeroStateDisplay;
	private var _hangHit:HeroStateDisplay;
	private var _stand:HeroStateDisplay;
	private var _jump:HeroStateDisplay;
	private var _jumpKick:HeroStateDisplay;
	private var _kick:HeroStateDisplay;
	private var _standHit:HeroStateDisplay;
	private var _upHit:HeroStateDisplay;
	private var _uppercut:HeroStateDisplay;
	private var _walkRight:HeroStateDisplay;
	private var _walkLeft:HeroStateDisplay;
	private var _squatPunch:HeroStateDisplay;
	private var _hang:HeroStateDisplay;
	private var _all:Array;
	private var _currentState:HeroStateDisplay;
	private var _headID:uint;
	private var _hue:Number;
	private var _legs:Number;

	public function HeroStatesDisplay(headID:uint, hue:Number, legs:Number) {
		_headID = headID;
		_hue = hue;
		_legs = legs;
		_squat = createState(
				'crouch',
				['crouch_leg'],
				['crouch_torso'],
				['crouch_hand'],
				1//['crouch_head1']
		);
		_hangHit = createState(
				'hangHit',
				['hangHit_leg'],
				['hangHit_torso'],
				['hangHit_hand'],
				2//['hangHit_head1']
		);
		_stand = createState(
				'idle',
				['idle1_leg', 'idle2_leg'],
				['idle1_torso', 'idle2_torso'],
				['idle1_hand', 'idle2_hand'],
				1//['idle1_head1', 'idle2_head']
		);
		_jump = createState(
				'jump',
				['jump_leg'],
				['jump_torso'],
				['jump_hand'],
				1//['jump_head1']
		);
		_jumpKick = createState(
				'jumpKick',
				['jumpKick_leg'],
				['jumpKick_torso'],
				['jumpKick_hand'],
				2//['jumpKick_head1']
		);
		_kick = createState(
				'kick',
				['kick_leg'],
				['kick_torso'],
				['kick_hand'],
				2//['kick_head1']
		);
		_standHit = createState(
				'standHit',
				['standHit_leg'],
				['standHit_torso'],
				['standHit_hand'],
				3//['standHit_head1']
		);
		_upHit = createState(
				'upHit',
				['upHit_leg'],
				['upHit_torso'],
				['upHit_hand'],
				3//['upHit_head1']
		);
		_uppercut = createState(
				'upper',
				['upper_leg'],
				['upper_torso'],
				['upper_hand'],
				2//['upper_head1']
		);
		_walkRight = createState(
				'walkAgainst',
				['walkAgainst1_leg', 'walkAgainst2_leg'],
				['walkAgainst1_torso', 'walkAgainst2_torso'],
				['walkAgainst1_hand', 'walkAgainst2_hand'],
				1//['walkAgainst1_head1', 'walkAgainst2_head']
		);
		_walkLeft = createState(
				'walkWith',
				['walkWith1_leg', 'walkWith2_leg'],
				['walkWith1_torso', 'walkWith2_torso'],
				['walkWith1_hand', 'walkWith2_hand'],
				1//['walkWith1_head1', 'walkWith2_head']
		);
		_squatPunch = createState(
				'crouchPunch',
				['crouchPunch_leg'],
				['crouchPunch_torso'],
				['crouchPunch_hand'],
				1//['crouchPunch_head1']
		);
		_hang = createState(
				'hang',
				['hang_leg'],
				['hang_torso'],
				['hang_hand'],
				1//['hang_head1']
		);
		_all = [_squat, _hangHit, _stand, _jump, _jumpKick, _kick, _standHit, _upHit, _uppercut, _walkRight, _walkLeft, _squatPunch, _hang];
	}

	public function setState(heroState:uint,direction:int=-1):void {
		var newState:HeroStateDisplay;
		switch(heroState) {
			case HeroState.STAND:
				newState = _stand;
				break;
			case HeroState.WALK:
				if (direction==Direction.LEFT)
					newState = _walkLeft;
				else
					newState = _walkRight;
				break;
			case HeroState.SQUAT:
				newState = _squat;
				break;
			case HeroState.KICK:
				newState = _kick;
				break;
			case HeroState.HANG:
				newState = _hang;
				break;
			case HeroState.JUMP:
				newState = _jump;
				break;
			case HeroState.UPPERCUT:
				newState = _uppercut;
				break;
			//case HeroState.STUN:
			//		newState = _stun;
			//	break;
			//case HeroState.STUN_JUMP:
			//		newState = _stun_jump;
			//	break;
			//case HeroState.STUN_FALLING:
			//		newState = _stun_falling;
			//	break;
			//default :
			//	throw new ArgumentError("Unsupported hero state:" + heroState);
		}
		if(_currentState) {
			removeChild(_currentState);
		}
		_currentState = newState;
		addChild(_currentState);
	}

	private function createState(stateName:String, leg:Array, torso:Array, hand:Array, headType:uint):HeroStateDisplay {
		var state:HeroStateDisplay = new HeroStateDisplay(stateName, leg, torso, hand,
				_headID, headType, _hue);
		return state;
	}

	public function get all():Array {
		return _all;
	}

	public function get currentState():HeroStateDisplay {
		return _currentState;
	}
}
}
