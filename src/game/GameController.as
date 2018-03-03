/**
 * Created by flashdeveloper.pl on 2016-02-27.
 */
package game
{

import com.eclecticdesignstudio.motion.Actuate;

import flash.ui.Keyboard;

import game.objects.HeroView;
import game.utils.Settings;

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

    private var _isJumping:Boolean = false;
    private var _isKicking:Boolean = false;
    private var _isDucking:Boolean = false;


    private var _moveDir:String;
    private var _heroView:HeroView;

    public function GameController()
    {
    }

    public static function getInstance():GameController
    {
        if(_instance == null)
            _instance = new GameController();

        return _instance;
    }

    public function init(heroView:HeroView):void
    {
        _heroView = heroView;
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

        if(_isUp) {
            if (!_isJumping) {
                _isJumping = true;
                Actuate.tween(this, 0.5, {speedY: -5}, false);
                Actuate.tween(this, 0.5, {speedY: 5}, false).onComplete(jumpFinished).delay(0.5);
            }
        }

        if(_isLeft)
            _moveDir = Direction.LEFT;
        else
            if(_isRight)
                _moveDir = Direction.RIGHT;
            else
                _moveDir = Direction.STOP;

        if(_isDown)
        {
            if (!_isJumping){
                _isDucking = true;
            }
        }

        var speed:Number = 5;
        switch (_moveDir)
        {
            case Direction.STOP:
                _speedX = 0;
                break;

            case Direction.RIGHT:
                _speedY = 0;
                _speedX = speed;
                break;

            case Direction.LEFT:
                _speedX = -speed;
                break;
        }

    }

    private function jumpFinished():void {
        trace("jump finished");
        _isJumping = false;
        _speedY=0;
    }


    public function onEnterFrame():void {

        var sx:Number = _speedX;
        var sy:Number = _speedY;
        if (_isJumping || sx!=0)
            sx += Settings.WIND_SPEED;



        if (_isDucking)
            sx = 0;

        _heroView.x += sx;
        _heroView.y += sy;

        if (_heroView.x <=10)
            _heroView.x =10;

        if (_heroView.x >=1280)
            _heroView.x =1280;

        if (_heroView.y >= Settings.GROUND_Y)
            _heroView.y = Settings.GROUND_Y;
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
