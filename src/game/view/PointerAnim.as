/** Created by Marek Brun on 03 marzec 2018 */
package game.view {
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Back;
import com.eclecticdesignstudio.motion.easing.Sine;

import flash.utils.setTimeout;

import game.load.GameAssetsManager;

import starling.display.Image;
import starling.display.Sprite;

public class PointerAnim extends Sprite {

	private var _pointer:Image;

	public function PointerAnim() {
		_pointer = GameAssetsManager.getImageFromMainAtlas('arrow');
		_pointer.x = -_pointer.width / 2;
		_pointer.y = -_pointer.height;
		addChild(_pointer);
		_pointer.alpha = 0;
		Actuate.tween(_pointer, 1, {alpha: 1});
		Actuate.tween(_pointer, 0.5, {y: 20}).reflect().repeat().ease(Sine.easeInOut);
		setTimeout(end, 3000);
	}

	public function end():void {
		Actuate.stop(_pointer);
		Actuate.tween(_pointer, 1, {y: _pointer.y - 300, alpha:0}).ease(Back.easeIn);
	}

}
}
