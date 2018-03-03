/** Created by Marek Brun on 03 marzec 2018 */
package game.view.scenery {
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
	private var _newElementCount:int;
	private static var _newElement:int;

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
		var delay:Number = (_minTime + Math.random() * (_maxTime - _minTime)) / Settings.DIFFICULTY;
		if(delay > 10000) {
			delay = 10000;
		}
		_newElementTimer.delay = delay;
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

		var movement:ElementMovement = new ElementMovement(element, getSpeed(element));
		movement.completedSignal.add(onMovement_Completed);
		_movements.push(movement);
	}

	protected function getSpeed(element:DisplayObject):Number {
		return _speed;
	}

	protected function getElement():DisplayObject {
		if(_pool.length) {
			return _pool.pop();
		}
		_newElement++;
		return createNewElement();
	}

	protected function createNewElement():DisplayObject {
		_newElementCount++;
		var element:Image = GameAssetsManager.getImageFromMainAtlas('tree1');
		return element;
	}

	private function onMovement_Completed(movement:ElementMovement):void {
		_pool.push(movement.display);
		_movements.removeAt(_movements.indexOf(movement));
	}

	public function get speed():uint {
		return _speed;
	}

}
}
