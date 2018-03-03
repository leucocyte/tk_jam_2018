/** Created by Marek Brun on 03 marzec 2018 */
package game.view.scenery {
import game.utils.Settings;
import game.utils.WorldTime;

import org.osflash.signals.Signal;

import starling.display.DisplayObject;

public class ElementMovement {

	private var _display:DisplayObject;
	public const completedSignal:Signal = new Signal(ElementMovement);
	private var _speed:Number;

	public function ElementMovement(display:DisplayObject, speed:Number) {
		_display = display;
		_speed = speed;

		WorldTime.frameSignal.add(onWorldTime_Time);
	}

	private function onWorldTime_Time(frameTime:Number):void {
		_display.x -= (frameTime / 1000) * _speed * Settings.DIFFICULTY;
		if(_display.x < -_display.width) {
			WorldTime.frameSignal.remove(onWorldTime_Time);
			completedSignal.dispatch(this);
		}
	}

	public function get display():DisplayObject {
		return _display;
	}
}
}
