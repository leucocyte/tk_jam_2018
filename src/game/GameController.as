/**
 * Created by flashdeveloper.pl on 2016-02-27.
 */
package game
{

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Linear;

import flash.ui.Keyboard;

import game.attacks.AttackType;
import game.attacks.Stun;

import game.objects.Hero;
import game.objects.HeroState;

import game.objects.HeroView;
import game.objects.KickAction;
import game.objects.ObjectController;
import game.server.ActionServer;
import game.utils.Settings;
import game.utils.TimeUtils;

import starling.events.KeyboardEvent;

public class GameController
{

    private static var _instance:GameController;

    private var _isLeft:Boolean;
    private var _isRight:Boolean;
    private var _isDown:Boolean;
    private var _isUp:Boolean;
    private var _isSpace:Boolean;
    private var _isEnter:Boolean;

    private var _forceX:Number = 0;
    private var _forceY:Number = 0;

    private var _attackForceX:Number = 0;
    private var _attackForceY:Number = 0;

    private var _isJumping:Boolean = false;
    private var _isKicking:Boolean = false;
    private var _isUppercuting:Boolean=false;;
    private var _isDucking:Boolean = false;
    private var _isHanging:Boolean = false;
    private var _isStunned:Boolean = false;
    private var _isStopped:Boolean = true;

    private var _moveDir:int;
//    private var _heroView:HeroView;
    private var _hero:Hero;
    private var _downTime:Number=0;
    private var _stunnedVector:Vector.<Stun>;






    public function GameController()
    {
    }

    public static function getInstance():GameController
    {
        if(_instance == null)
            _instance = new GameController();

        return _instance;
    }
/*
    public function init(heroView:HeroView):void
    {
        _heroView = heroView;
//        _hero = hero;
        Game.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyEventHandler);
        Game.instance.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyEventHandler);
    }
*/
    public function init(hero:Hero):void
    {
//        _heroView = heroView;
        _hero = hero;
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
            case Keyboard.SPACE:
                _isSpace=e.type == KeyboardEvent.KEY_DOWN;
                break;
            case Keyboard.ENTER:
                _isEnter=e.type == KeyboardEvent.KEY_DOWN;
                break;

        }

        if (_isSpace){
            kick();
           /* if (_isKicking){
                _isKicking = true;
                Actuate.tween(this, 0.5, {}, false).onComplete(kickFinished);
            }*/
        }else
        if (_isEnter){
            uppercut();
        }

//        _moveDir = Direction.STOP;

        if(_isUp) {
            if (!_isJumping) {
                _isJumping = true;
                _forceY = -Settings.JUMP_FORCE;
                Actuate.tween(this, 0.5, {forceY: 0}, false);
//                Actuate.tween(this, 0.5, {speedY: 5}, false).onComplete(jumpFinished).delay(0.5);
            }
        }

        if(_isLeft) {
            _moveDir = Direction.LEFT;
            _isStopped = false;
        }
        else
            if(_isRight) {
                _moveDir = Direction.RIGHT;
                _isStopped = false;
            }
            else
                _isStopped = true;
//                _moveDir = Direction.STOP;

        if(_isDown)
        {
//            trace("diff: "+(TimeUtils.getCurrentTime() - _downTime)+" / "+_isHanging);
            if (!_isHanging) {
                if (TimeUtils.getCurrentTime() - _downTime < 1000) {
                    _isDucking = false;
                    _isHanging = true;
//                    trace("hanging: " + _isHanging);
                } else {
                    _downTime = TimeUtils.getCurrentTime();
                    _isDucking = true;
                    _isHanging = false;
//                    trace("hanging: " + _isHanging);
                }
            }
        }else {
            _isDucking = false;
            _isHanging = false;
//            trace("hanging: "+false);
//            trace("ducking: "+false);
        }

        if (_isStopped)
            _forceX = 0;
        else {
            var moveForce:Number = 5;
            switch (_moveDir) {
                case Direction.RIGHT:
                    _forceX = moveForce;
                    break;
                case Direction.LEFT:
                    _forceX = -moveForce;
                    break;
            }
        }

    }



    private function isAttacking(){
        if (_isKicking)
            return true;
        if (_isUppercuting)
            return true;

        return false;
    }

    private function uppercut():void {
        _isUppercuting = true;
        Actuate.tween(this, 0.5, {}, false).onComplete(uppercutFinished);
        ObjectController.instance().onAttack(_hero,AttackType.UPPERCUT);
    }

    private function uppercutFinished():void {
        _isUppercuting = false;
    }

    private function kick():void {
        if (!isAttacking()){
            _isKicking = true;
            Actuate.tween(this, 0.5, {}, false).onComplete(kickFinished);
            ObjectController.instance().onAttack(_hero,AttackType.KICK);
        }

    }

    private function kickFinished():void {
        _isKicking = false;
    }

    private function jumpFinished():void {
        trace("jump finished");
        _isJumping = false;
//        _forceY=0;
    }


    public function onEnterFrame():void {

        var sx:Number = _forceX;
        var sy:Number = _forceY + Settings.GRAVITY;

        var state:Number=HeroState.STAND;
        if (_isStunned){
            sx = _attackForceX;
            sy = _attackForceY + Settings.GRAVITY;
        }else
        if (_isHanging){
            state = HeroState.HANG;
//            _hero.state = HeroState.HANG;
        }else {
            if (_hero.y > Settings.GROUND_Y) {
                sx += Settings.WIND_SPEED;
                if (isStunned()) {
                    state = HeroState.STUN_JUMP;
                }
                else {
                    if (isAttacking()) {
                        if (_isKicking)
                            state = HeroState.KICK;
                        if (_isUppercuting)
                            state = HeroState.UPPERCUT;
                    } else if (_isDucking) {
                        state = HeroState.SQUAT;
                    } else {
                        state = HeroState.JUMP;
                    }
                }
            } else {
                if (isStunned()) {
                    state = HeroState.STUN;
                } else {
                    if (isAttacking()) {
                        if (_isKicking)
                            state = HeroState.KICK;
                        if (_isUppercuting)
                            state = HeroState.UPPERCUT;
                    } else if (_isDucking) {
                        state = HeroState.SQUAT;
                    } else {
                        if (_moveDir == Direction.LEFT)
                            state = HeroState.WALK;
                        else
                            state = HeroState.WALK;
                    }
                }
//            _heroView.setDirection(_moveDir);
            }
        }


  /*      if (isAttacking()) {
            if (_isKicking)
                state = HeroState.KICK;
        }else{
            if (_isDucking) {
//            _hero.state = HeroState.SQUAT;
                state = HeroState.SQUAT;
//                _heroView.squat();
//            if (!_isJumping)
//                sx = 0;
            } else {
                state = HeroState.STAND;
//                _heroView.stand();
            }
        }*/

        if (_hero.y < Settings.GROUND_Y || sx!=0){
            sx += Settings.WIND_SPEED;
        }

        _hero.x+= sx;
        _hero.y+= sy;

        _hero.direction = _moveDir;

        if (_hero.y >=Settings.GROUND_Y)
        {
            if (_isJumping)
                jumpFinished();
            _hero.y = Settings.GROUND_Y;
        }
        _hero.state = state;
        _hero.updateView();

        ActionServer.updatePosition(_hero.x,_hero.y,_hero.state,_hero.direction);
//        trace("state: "+state);
//        _heroView.updateState(state);

       /* if (_isJumping || sx != 0)
            sx += Settings.WIND_SPEED;
*/
/*
        _heroView.setDirection(_moveDir);

        _heroView.x += sx;
        _heroView.y += sy;

        if (_heroView.x <=10)
            _heroView.x =10;

        if (_heroView.x >=1280)
            _heroView.x =1280;

        if (_heroView.y >= Settings.GROUND_Y) {
            if (_isJumping)
                jumpFinished();
            _heroView.y = Settings.GROUND_Y;
        }*/
    }


    private function isStunned():Boolean {
        return false;
    }

    public function onHit(type:int,direction:int):void {
        _isStunned = true;

        _stunnedVector = new Vector.<Stun>();
        var stun:Stun = new Stun();
        switch(type){
            case AttackType.KICK:
                _stunnedVector.push(stun);
                _attackForceX =+ Settings.KICK_FORCE*direction;
                Actuate.tween(this, 0.5, {attackForceX: 0}, false).ease(Linear.easeNone).onComplete(stunnedFinished,stun);

                break;
            case AttackType.UPPERCUT:
                _attackForceY =- Settings.UPPERCUT_FORCE;
                _attackForceX =+ Settings.UPPERCUT_FORCE*0.3*direction;
                Actuate.tween(this, 0.5, {attackForceY: 0}, false).ease(Linear.easeNone);
                Actuate.tween(this, 0.5, {attackForceX: 0}, false).ease(Linear.easeNone).onComplete(stunnedFinished,stun);
                break;
        }
    }

    private function stunnedFinished(stun:Stun):void {
        _stunnedVector.splice(_stunnedVector.indexOf(stun),1);
        if (_stunnedVector.length==0)
            _isStunned = false;
    }

    public function updateServerPositions(){

    }
/*

    public function onEnterFrame():void {

        var sx:Number = _forceX;
        var sy:Number = _forceY + Settings.GRAVITY;

        var state:Number=HeroState.STAND;
        if (isAttacking()) {
            if (_isKicking)
                state = HeroState.KICK;
        }else{
            if (_isDucking) {
//            _hero.state = HeroState.SQUAT;
                state = HeroState.SQUAT;
//                _heroView.squat();
//            if (!_isJumping)
//                sx = 0;
            } else {
                state = HeroState.STAND;
//                _heroView.stand();
            }
        }
        if (_hero.y >= Settings.GROUND_Y){
            sx += Settings.WIND_SPEED;
        }

        if (_isJumping || sx != 0)
            sx += Settings.WIND_SPEED;


        _heroView.setDirection(_moveDir);

        _heroView.x += sx;
        _heroView.y += sy;

        if (_heroView.x <=10)
            _heroView.x =10;

        if (_heroView.x >=1280)
            _heroView.x =1280;

        if (_heroView.y >= Settings.GROUND_Y) {
            if (_isJumping)
                jumpFinished();
            _heroView.y = Settings.GROUND_Y;
        }
    }
*/


    public function get forceX():Number
    {
        return _forceX;
    }

    public function set forceX(value:Number):void
    {
        _forceX = value;
    }

    public function get forceY():Number
    {
        return _forceY;
    }

    public function set forceY(value:Number):void
    {
        _forceY = value;
    }

 /*   public function get moveDir():String
    {
        return _moveDir;
    }

    public function set moveDir(value:String):void
    {
        _moveDir = value;
    }
*/
    public function onKilled():void
    {
        _forceX = _forceY = 0;
        _isDown = _isLeft = _isRight = _isUp = false;
//        Game.instance.myHero.updateHeroBehavior();

    }

    public function reset():void{
        _forceX = _forceY = 0;
        _isDown = _isLeft = _isRight = _isUp = false;
    }

    public function get attackForceX():Number {
        return _attackForceX;
    }

    public function get attackForceY():Number {
        return _attackForceY;
    }

    public function set attackForceY(value:Number):void {
        _attackForceY = value;
    }

    public function set attackForceX(value:Number):void {
        _attackForceX = value;
    }
}
}
