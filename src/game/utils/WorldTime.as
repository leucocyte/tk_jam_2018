/** Created by Marek Brun on 03 marzec 2018 */
package game.utils {
import flash.events.Event;
import flash.utils.getTimer;

import org.osflash.signals.Signal;

public class WorldTime {

	private var _lastFrameTime:int;
	private static var _ins:WorldTime;
	public static const frameSignal:Signal = new Signal(Number); //frame time

	public function WorldTime() {
		_lastFrameTime = getTimer();
		Stage2DAbuser.getStage().addEventListener(Event.ENTER_FRAME, onStage_EnterFrame);
	}

	private function onStage_EnterFrame(event:Event):void {
		var timer:int = getTimer();
		var frameTime:int = timer - _lastFrameTime;
		_lastFrameTime = timer;
		dispatchFrame(frameTime);
	}

	private function dispatchFrame(frameTime:int):void {
		frameSignal.dispatch(frameTime);
	}

	public static function getInstance():WorldTime {
		if(!_ins) {
			_ins = new WorldTime();
		}
		return _ins;
	}

}
}
