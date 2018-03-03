/** Created by flashdeveloper.pl on 2014-10-16. */
package game.utils {
import flash.display.Stage;
import flash.errors.IllegalOperationError;
import flash.events.MouseEvent;

public class Stage2DAbuser {

	private static var _instance:Stage2DAbuser;

	private var _stage:Stage;
	private var _isMouseDown:Boolean;

	public static function getInstance():Stage2DAbuser {
		if(_instance == null)
			_instance = new Stage2DAbuser();

		return _instance;
	}

	public function get stage():Stage {
		if(_stage == null)
			throw new IllegalOperationError('No stage provided');

		return _stage;
	}

	public function set stage(value:Stage):void {
		_stage = value;
		_stage.addEventListener(MouseEvent.MOUSE_DOWN, onStage_MouseDown);
		_stage.addEventListener(MouseEvent.MOUSE_UP, onStage_MouseUp);
	}

	private function onStage_MouseDown(event:MouseEvent):void {
		_isMouseDown = true;
	}

	private function onStage_MouseUp(event:MouseEvent):void {
		_isMouseDown = false;
	}

	static public function getStage():Stage {
		return getInstance().stage;
	}

	static public function init(stage:Stage):void {
		getInstance().stage = stage;
	}

	public function get isMouseDown():Boolean {
		return _isMouseDown;
	}
}
}
