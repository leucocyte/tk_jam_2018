/** Created by Marek Brun on 03 marzec 2018 */
package game.view {
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Back;
import com.eclecticdesignstudio.motion.easing.Linear;
import com.eclecticdesignstudio.motion.easing.Sine;

import game.GameController;

import game.load.GameAssetsManager;
import game.objects.ObjectController;

import starling.display.Image;
import starling.display.Sprite;

public class ConductorAnim extends Sprite {

	private var _shadow:Image;
	private var _dude:Image;
	private var _scream:Image;
	private var _windows:Image;

	public function ConductorAnim() {
		_dude = GameAssetsManager.getImageFromMainAtlas('konduktor');
		addChild(_dude);
		_scream = GameAssetsManager.getImageFromMainAtlas('konduktor_scream');
		addChild(_scream);
		_windows = GameAssetsManager.getImageFromMainAtlas('train_middle_windows');
		_windows.y = -10;
		addChild(_windows);
		_shadow = GameAssetsManager.getImageFromMainAtlas('konduktor_windows');
		addChild(_shadow);
		_dude.visible = false;
		_scream.visible = false;
	}

	public function play():void {
		_shadow.x = 118 + 110;
		_shadow.y = 120;
		_shadow.alpha = 1;
		Actuate.tween(_shadow, 0.5, {y: _shadow.y + 10}).reflect().repeat().ease(Sine.easeInOut);
		Actuate.tween(_shadow, 10, {x: 1320}).ease(Linear.easeNone).onComplete(
				function ():void {
					Actuate.stop(_shadow);
					Actuate.tween(_shadow, 1, {y: _shadow.y + 130, alpha: 0}).onComplete(goOnRoof);
				});
	}

	private function goOnRoof():void {
		_dude.visible = true;
		_dude.alpha = 1;
		_dude.x = _shadow.x;
		_dude.y = _shadow.y - 40;
		Actuate.tween(_dude, 1.5, {y: _dude.y - 400}).ease(Sine.easeOut).onComplete(
				function ():void {
					GameController.getInstance().onConductor();
					Actuate.tween(_dude, 0.5, {y: _dude.y + 10}).reflect().repeat(4).ease(Sine.easeInOut)
							.onComplete(backToTrain);
				}
		);
		_scream.visible = true;
		_scream.alpha = 0;
		_scream.x = _dude.x + 126;
		_scream.y = _dude.y - 407;
		Actuate.tween(_scream, 0.5, {y: _scream.y - 440, alpha: 1}).delay(1.1).ease(Back.easeOut).onComplete(
				function ():void {
					Actuate.tween(_scream, 0.5, {y: _scream.y + 30}).reflect().repeat(4).ease(Sine.easeInOut);
				}
		);
	}

	public function backToTrain():void {
		Actuate.tween(_dude, 1, {y: _dude.y + 300, alpha: 0}).ease(Sine.easeOut);
		Actuate.tween(_scream, 0.3, {y: _scream.y - 500, alpha: 0}).ease(Back.easeIn);
	}

}
}
