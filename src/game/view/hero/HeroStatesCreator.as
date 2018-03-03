/** Created by Marek Brun on 03 marzec 2018 */
package game.view.hero {
public class HeroStatesCreator {

	private var _squat:HeroStateDisplay;
	private var _hangHit:HeroStateDisplay;
	private var _walk:HeroStateDisplay;
	private var _jump:HeroStateDisplay;
	private var _jumpKick:HeroStateDisplay;
	private var _kick:HeroStateDisplay;
	private var _standHit:HeroStateDisplay;
	private var _upHit:HeroStateDisplay;
	private var _upper:HeroStateDisplay;
	private var _walkRight:HeroStateDisplay;
	private var _walkLeft:HeroStateDisplay;
	private var _squatPunch:HeroStateDisplay;
	private var _hang:HeroStateDisplay;
	private var _all:Array;

	public function HeroStatesCreator() {
		_squat = createState(
				'crouch',
				['crouch_leg'],
				['crouch_torso'],
				['crouch_hand'],
				['crouch_head1']
		);
		_hangHit = createState(
				'hangHit',
				['hangHit_leg'],
				['hangHit_torso'],
				['hangHit_hand'],
				['hangHit_head1']
		);
		_walk = createState(
				'idle',
				['idle1_leg', 'idle2_leg'],
				['idle1_torso', 'idle2_torso'],
				['idle1_hand', 'idle2_hand'],
				['idle1_head1', 'idle2_head']
		);
		_jump = createState(
				'jump',
				['jump_leg'],
				['jump_torso'],
				['jump_hand'],
				['jump_head1']
		);
		_jumpKick = createState(
				'jumpKick',
				['jumpKick_leg'],
				['jumpKick_torso'],
				['jumpKick_hand'],
				['jumpKick_head1']
		);
		_kick = createState(
				'kick',
				['kick_leg'],
				['kick_torso'],
				['kick_hand'],
				['kick_head1']
		);
		_kick = createState(
				'kick',
				['kick_leg'],
				['kick_torso'],
				['kick_hand'],
				['kick_head1']
		);
		_standHit = createState(
				'standHit',
				['standHit_leg'],
				['standHit_torso'],
				['standHit_hand'],
				['standHit_head1']
		);
		_upHit = createState(
				'upHit',
				['upHit_leg'],
				['upHit_torso'],
				['upHit_hand'],
				['upHit_head1']
		);
		_upper = createState(
				'upper',
				['upper_leg'],
				['upper_torso'],
				['upper_hand'],
				['upper_head1']
		);
		_walkRight = createState(
				'walkAgainst',
				['walkAgainst1_leg', 'walkAgainst2_leg'],
				['walkAgainst1_torso', 'walkAgainst2_torso'],
				['walkAgainst1_hand', 'walkAgainst2_hand'],
				['walkAgainst1_head1', 'walkAgainst2_head']
		);
		_walkLeft = createState(
				'walkWith',
				['walkWith1_leg', 'walkWith2_leg'],
				['walkWith1_torso', 'walkWith2_torso'],
				['walkWith1_hand', 'walkWith2_hand'],
				['walkWith1_head1', 'walkWith2_head']
		);
		_upper = createState(
				'upper',
				['upper_leg'],
				['upper_torso'],
				['upper_hand'],
				['upper_head1']
		);
		_squatPunch = createState(
				'crouchPunch',
				['crouchPunch_leg'],
				['crouchPunch_torso'],
				['crouchPunch_hand'],
				['crouchPunch_head1']
		);
		_hang = createState(
				'hang',
				['hang_leg'],
				['hang_torso'],
				['hang_hand'],
				['hang_head1']
		);
		_all = [_squat, _hangHit, _walk, _jump, _jumpKick, _kick, _standHit, _upHit, _upper, _walkRight, _walkLeft, _squatPunch, _hang];
	}

	private function createState(stateName:String, leg:Array, torso:Array, hand:Array, head:Array):HeroStateDisplay {
		var state:HeroStateDisplay = new HeroStateDisplay(stateName, leg, torso, hand, head);
		return state;
	}

	public function get all():Array {
		return _all;
	}
}
}
