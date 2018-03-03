/** Created by Marek Brun on 03 marzec 2018 */
package game.scenery {
import flash.errors.IllegalOperationError;
import flash.events.TimerEvent;
import flash.utils.Timer;

import game.load.GameAssetsManager;
import game.utils.Settings;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;

public class ElementsSpawner extends Sprite {

	private var _minTime:uint; //ms
	private var _maxTime:uint; //ms
	private var _newElementTimer:Timer;
	private const _movements:Vector.<ElementMovement> = new <ElementMovement>[];
	private const _pool:Vector.<DisplayObject> = new <DisplayObject>[];
	private var _speed:uint;

	/**
	 * @param minTime
	 * @param maxTime
	 * @param speed - pixels per second
	 */
	public function ElementsSpawner(minTime:uint, maxTime:uint, speed:uint) {
		_minTime = minTime;
		_maxTime = maxTime;
		_speed = speed;

		_newElementTimer = new Timer(1, 1);
		_newElementTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onNewTreeTimer_Complete);

		startTimerForNewElement();
	}

	private function startTimerForNewElement():void {
		if(_newElementTimer.running) {
			throw new IllegalOperationError("newTreeTimer is already running");
		}
		_newElementTimer.delay = _minTime + Math.random() * (_maxTime - _minTime);
		_newElementTimer.reset();
		_newElementTimer.start();
	}

	private function onNewTreeTimer_Complete(event:TimerEvent):void {
		startMovingNext();
		startTimerForNewElement();
	}

	public function startMovingNext():void {
		var element:DisplayObject = getElement();
		element.x = Settings.SCENE_WIDTH + 1;
		addChild(element);

		var movementDuration:Number = ((Settings.SCENE_WIDTH + element.width) / _speed) * 1000;
		var movement:ElementMovement = new ElementMovement(element, movementDuration);
		movement.completedSignal.add(onMovement_Completed);
		_movements.push(movement);
	}

	protected function getElement():DisplayObject {
		if(_pool.length) {
			return _pool.pop();
		}
		return createNewElement();
	}

	protected function createNewElement():DisplayObject {
		var element:Image = GameAssetsManager.getImageFromMainAtlas('tree1');
		return element;
	}

	private function onMovement_Completed(movement:ElementMovement):void {
		_pool.push(movement.display);
		_movements.removeAt(_movements.indexOf(movement));
	}

}
}
