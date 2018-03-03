/**
 * Created by Drygu on 2016-02-27.
 */
package game {
import flash.geom.Point;

import starling.display.Image;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class MouseController {

    private static var _instance:MouseController;

    private var _cursor:Image;
    private var _location:Point;
    private var _rotation:Number=0;
    private var _speedX:Number;
    private var _speedY:Number;

    public function MouseController() {
    }

    public static function getInstance():MouseController
    {
        if(_instance == null)
            _instance = new MouseController();

        return _instance;
    }

    public function init():void
    {
//        _cursor = new Image(GameAssetsManager.getInstance().getTexture("crosshair"));
//        Game.instance.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
//        Game.instance.backGround.addEventListener(TouchEvent.TOUCH, touchHandler);

        _location = new Point(0,0);
    }

    private function touchHandler(e:TouchEvent):void {
//        var touch:Touch = e.getTouch(Game.instance.backGround);
//
////        var t:Touch = e.getTouch(DisplayObject(e.target));
//        if(touch){
//            switch(touch.phase) {
//                case TouchPhase.BEGAN:
//                    Game.instance.mouseDown();
////                      Game.instance.testTreeFall();
////                    trace("BEGIN " + e.target + " " + e.currentTarget + " " + touch.target);
////                    Mouse.cursor = CursorManager.SHOT;
////                    ShootingManager.getInstance().startShooting();
//                    break;
//                case TouchPhase.ENDED:
//                    Game.instance.mouseUp();
////                    trace("END " + e.target + " " + e.currentTarget + " " + touch.target);
////                    Mouse.cursor = CursorManager.AUTO;
////                    ShootingManager.getInstance().stopShooting();
//                    break;
//                case TouchPhase.MOVED:
//                    _location = touch.getLocation(Game.instance.backGround,null);
////                    rotateCharacter();
//                    break;
//                case TouchPhase.STATIONARY:
//
//                    break;
//                case TouchPhase.HOVER: // MOUSE ONLY
//                    _location = touch.getLocation(Game.instance.backGround,null);
////                    rotateCharacter();
//                    break;
//            }
//
//
//        }

    }



    //public function get location():Point {
    //    return _location;
    //}
	//
    //public function get rotation():Number {
    //    return _rotation;
    //}
	//
    //public function get speedX():Number {
    //    return _speedX;
    //}
	//
    //public function get speedY():Number {
    //    return _speedY;
    //}
}
}
