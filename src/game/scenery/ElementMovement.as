/** Created by Marek Brun on 03 marzec 2018 */
package game.scenery {
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Linear;

import org.osflash.signals.Signal;

import starling.display.DisplayObject;

public class ElementMovement {

	private var _display:DisplayObject;
	public const completedSignal:Signal = new Signal(ElementMovement);

	public function ElementMovement(display:DisplayObject, duration:Number) {
		_display = display;
		Actuate.tween(display, duration / 1000, {x: -display.width})
				.onComplete(onAnimation_Complete)
				.ease(Linear.easeNone);
	}

	private function onAnimation_Complete():void {
		completedSignal.dispatch(this);
	}

	public function get display():DisplayObject {
		return _display;
	}
}
}
