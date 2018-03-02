/**
 * Created by flashdeveloper.pl on 2016-02-27.
 */
package game
{

import flash.ui.Keyboard;

import starling.events.KeyboardEvent;

public class GameController
{

    private static var _instance:GameController;

    private var _isLeft:Boolean;
    private var _isRight:Boolean;
    private var _isDown:Boolean;
    private var _isUp:Boolean;

    private var _speedX:Number = 0;
    private var _speedY:Number = 0;


    private var _moveDir:String;

    public function GameController()
    {
    }

    public static function getInstance():GameController
    {
        if(_instance == null)
            _instance = new GameController();

        return _instance;
    }

    public function init():void
    {
        Game.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyEventHandler);
        Game.instance.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyEventHandler);
    }

    private function onKeyEventHandler(e:KeyboardEvent):void
    {
    /*    if (Game.instance.block) {
            reset();
            return;
        }*/
        switch (e.keyCode)
        {
            case Keyboard.A :
            case Keyboard.LEFT :
                _isLeft=e.type == KeyboardEvent.KEY_DOWN;
                break;
            case Keyboard.D :
            case Keyboard.RIGHT :
                _isRight=e.type == KeyboardEvent.KEY_DOWN;
                break;
            case Keyboard.W :
            case Keyboard.UP :
                _isUp=e.type == KeyboardEvent.KEY_DOWN;
                break;
            case Keyboard.S :
            case Keyboard.DOWN :
                _isDown=e.type == KeyboardEvent.KEY_DOWN;
                break;

        }

        _moveDir = Direction.STOP;

        if(_isUp)
        {
            _moveDir = Direction.UP;

            if(_isLeft) _moveDir = Direction.UP_LEFT;
            else if(_isRight) _moveDir = Direction.UP_RIGHT;
        }
        else
        if(_isDown)
        {
            _moveDir = Direction.DOWN;

            if(_isLeft) _moveDir = Direction.DOWN_LEFT;
            else if(_isRight) _moveDir = Direction.DOWN_RIGHT;
        }
        else
        {
            if(_isLeft) _moveDir = Direction.LEFT;
            else if(_isRight) _moveDir = Direction.RIGHT;
        }

        var speed:Number = 5;
        switch (_moveDir)
        {

            case Direction.STOP:
                _speedY = 0;
                _speedX = 0;
                break;

            case Direction.UP:
                _speedY = -speed;
                _speedX = 0;
                break;

            case Direction.UP_RIGHT:
                _speedY = -speed;
                _speedX = speed;
                break;

            case Direction.RIGHT:
                _speedY = 0;
                _speedX = speed;
                break;

            case Direction.DOWN_RIGHT:
                _speedY = speed;
                _speedX = speed;
                break;

            case Direction.DOWN:
                _speedY = speed;
                _speedX = 0;
                break;

            case Direction.DOWN_LEFT:
                _speedY = speed;
                _speedX = -speed;
                break;

            case Direction.LEFT:
                _speedY = 0;
                _speedX = -speed;
                break;

            case Direction.UP_LEFT:
                _speedY = -speed;
                _speedX = -speed;
                break;
        }

    }


    public function get speedX():Number
    {
        return _speedX;
    }

    public function set speedX(value:Number):void
    {
        _speedX = value;
    }

    public function get speedY():Number
    {
        return _speedY;
    }

    public function set speedY(value:Number):void
    {
        _speedY = value;
    }

    public function get moveDir():String
    {
        return _moveDir;
    }

    public function set moveDir(value:String):void
    {
        _moveDir = value;
    }

    public function onKilled():void
    {
        _speedX = _speedY = 0;
        _isDown = _isLeft = _isRight = _isUp = false;
//        Game.instance.myHero.updateHeroBehavior();

    }

    public function reset():void{
        _speedX = _speedY = 0;
        _isDown = _isLeft = _isRight = _isUp = false;
    }
}
}
