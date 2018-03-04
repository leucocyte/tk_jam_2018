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
import game.objects.ObjectController;
import game.server.ActionServer;
import game.sound.SoundManager;
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
    private var _isJumpKey:Boolean;
    private var _isAttackKey:Boolean;
//    private var _isF:Boolean;

    private var _forceX:Number = 0;
    private var _forceY:Number = 0;

    private var _attackForceX:Number = 0;
    private var _attackForceY:Number = 0;

    private var _isJumping:Boolean = false;
    private var _isKicking:Boolean = false;
    private var _isUppercuting:Boolean=false;
    private var _isDucking:Boolean = false;
    private var _isHanging:Boolean = false;
    private var _isStunned:Boolean = false;
    private var _isStopped:Boolean = true;
    private var _isFalling:Boolean=false;
    private var _isDying:Boolean=false;
    private var _isDropping:Boolean=false;
    private var _isKilled:Boolean;

    private var _moveDir:int;
//    private var _heroView:HeroView;
    private var _hero:Hero;
    private var _downTime:Number=0;
    private var _stunnedVector:Vector.<Stun>;
    private var _blocked:Boolean;










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
        _blocked = true;
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
            case Keyboard.O:
                _isJumpKey=e.type == KeyboardEvent.KEY_DOWN;
                break;
            case Keyboard.P:
                _isAttackKey=e.type == KeyboardEvent.KEY_DOWN;
                break;

            case Keyboard.L:
//                Game.instance.trainScene.pump.startMovingNext(1);
                if (e.type == KeyboardEvent.KEY_DOWN)
                    Settings.DIFFICULTY+=0.1;
                break;
            case Keyboard.K:
//                Game.instance.trainScene.pump.startMovingNext(1);
                if (e.type == KeyboardEvent.KEY_DOWN)
                    Settings.DIFFICULTY-=0.1;
                break;

        }

        if (_isAttackKey && !_isDown && !_isUp){
            kick();
        }else
            if (_isAttackKey && _isUp){
                uppercut();
            }else
                if (_isAttackKey && _isDown){
                    drop();
                }

        if(_isJumpKey && !_isDown) {
            if (!_isJumping) {
                jump();
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

        if (_isDown && _isJumpKey){
            _isDucking = false;
            _isHanging = true;
        }else
            if (_isDown){
                _isDucking = true;
                _isHanging = false;
            }else{
                _isDucking = false;
                _isHanging = false;
            }

        if (_isStopped)
            _forceX = 0;
        else {
//            var moveForce:Number = 5;
            switch (_moveDir) {
                case Direction.RIGHT:
                    _forceX = Settings.WALK_SPEED;
                    break;
                case Direction.LEFT:
                    _forceX = -Settings.WALK_SPEED;
                    break;
            }
        }

    }

    private function jump():void {
        _isJumping = true;
        _forceY = -Settings.JUMP_FORCE;
        Actuate.tween(this, 0.5, {forceY: 0}, false);
    }

    public function isAlive():Boolean {
        return !_isFalling && !_isKilled;
    }

    private function isAttacking(){
        if (_isKicking)
            return true;
        if (_isUppercuting)
            return true;
        if (_isDropping)
            return true;

        return false;
    }

    private function uppercut():void {
        if (!isAttacking()) {
            _isUppercuting = true;
            SoundManager.getInstance().punch(true);
            Actuate.tween(this, 0.5, {}, false).onComplete(uppercutFinished);
            ObjectController.instance().onAttack(_hero, AttackType.UPPERCUT);
        }
    }

    private function uppercutFinished():void {
        _isUppercuting = false;
    }

    private function kick():void {
        if (!isAttacking()){
            _isKicking = true;
            SoundManager.getInstance().punch(true);
            Actuate.tween(this, 0.5, {}, false).onComplete(kickFinished);
            ObjectController.instance().onAttack(_hero,AttackType.KICK);
        }
    }

    private function drop():void {
        if (!isAttacking()) {
            _isDropping = true;
            SoundManager.getInstance().punch(true);
            Actuate.tween(this, 0.5, {}, false).onComplete(dropFinished);
            ObjectController.instance().onAttack(_hero, AttackType.DROP);
        }
    }

    private function dropFinished():void {
        _isDropping = false;
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

        if (_blocked)
            return;

        var sx:Number = _forceX;
        var sy:Number = _forceY + Settings.GRAVITY;

        var state:Number=HeroState.STAND;
        if (_isKilled){
            state=HeroState.KILLED;
        }else
        if (_isFalling){
            sx = _attackForceX;
            sy = _attackForceY + Settings.GRAVITY;
            state = HeroState.STUN_JUMP;
        }else
        if (_isStunned){
            sx = _attackForceX;
            sy = _attackForceY + Settings.GRAVITY;
//            state = HeroState.STUN;
            if(_hero.y == Settings.GROUND_Y)
                state = HeroState.STUN;
            else
                state = HeroState.STUN_JUMP;
        }else
        if (_isHanging){
            state = HeroState.HANG;
//            _hero.state = HeroState.HANG;
        }else {

            //LECI
            if (_hero.y < Settings.GROUND_Y) {
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
                        trace("JUMPING!!!");
                        state = HeroState.JUMP;
                    }
                }
            } else {
                //NA ZIEMI
                if (_isStunned) {
                    state = HeroState.STUN;
                } else {
                    if (isAttacking()) {
                        if (_isKicking)
                            state = HeroState.KICK;
                        if (_isUppercuting)
                            state = HeroState.UPPERCUT;
                        if (_isDropping)
                            state = HeroState.DROP;
                    } else if (_isDucking) {
                        state = HeroState.SQUAT;
                    } else {
                        if (_forceX==0)
                            state = HeroState.STAND;
                        else
                            if (_moveDir == Direction.LEFT)
                                state = HeroState.WALK;
                            else
                                state = HeroState.WALK;
                    }
                }
//            _heroView.setDirection(_moveDir);
            }
        }

        if (_hero.y < Settings.GROUND_Y || sx!=0){
            sx += Settings.WIND_SPEED;
        }

        if (_hero.y==0){
            if (isAttacking() || _hero.state==HeroState.HANG || _hero.state==HeroState.SQUAT)
                sx=0;
        }


        _hero.x+= sx;
        _hero.y+= sy;

        _hero.direction = _moveDir;

        if (!_isFalling && !_isKilled) {
            if (_hero.y >= Settings.GROUND_Y) {
                if (_isJumping)
                    jumpFinished();
                _hero.y = Settings.GROUND_Y;
            }
            if(_hero.x<0)
                _hero.x=0;
            if (_hero.x>Settings.SCENE_WIDTH)
                _hero.x = Settings.SCENE_WIDTH;
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

    public function onHitMyHero(type:int,direction:int):void {
        _isStunned = true;

        _stunnedVector = new Vector.<Stun>();
        var stun:Stun = new Stun();
        switch(type){
            case AttackType.KICK:
                _stunnedVector.push(stun);
                _attackForceX =+ Settings.KICK_FORCE*direction;
                Actuate.tween(this, 0.5, {attackForceX: 0}, false).ease(Linear.easeNone);
                Actuate.tween(this, 1, {}, false).ease(Linear.easeNone).onComplete(stunnedFinished,stun);
                break;
            case AttackType.UPPERCUT:
                _attackForceY =- Settings.UPPERCUT_FORCE_Y;
                _attackForceX =+ Settings.UPPERCUT_FORCE_X*direction;
                Actuate.tween(this, 0.5, {attackForceY: 0}, false).ease(Linear.easeNone);
                Actuate.tween(this, 0.5, {attackForceX: 0}, false).ease(Linear.easeNone);
                Actuate.tween(this, 1, {}, false).ease(Linear.easeNone).onComplete(stunnedFinished,stun);
                break;
            case AttackType.DROP:
                _attackForceY =+ Settings.DROP_FORCE_Y;
//                _attackForceX =-Settings.WIND_SPEED;
                _isFalling = true;
                Actuate.tween(this, 0.5, {attackForceY: 0}, false).ease(Linear.easeNone).onComplete(killedByDrop);
                break;
        }
    }

    public function onStartRound():void {
        _isKilled = false;
        _isFalling = false;
        _isDown = false;
        _isDying = false;
        _isStunned = false;
        _isUppercuting = false;

        _blocked = false;
//        jump();
    }

    public function onResetRound(msg:String):void {
        _blocked = true;
        _hero.updateHero(msg);
//        jump();
    }

    private function stunnedFinished(stun:Stun):void {
        _stunnedVector.splice(_stunnedVector.indexOf(stun),1);
        if (_stunnedVector.length==0)
            _isStunned = false;
    }

    public function updateServerPositions(){

    }



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

    public function onKilledByPump():void {
        SoundManager.getInstance().killedByPump();
        _isKilled = true;
        _forceX = -Settings.DIFFICULTY * Settings.TRAIN_SPEED/20;

        Actuate.tween(this,2,{}).onComplete(respawn);
    }

    private function killedByDrop():void {
        SoundManager.getInstance().killedByDrop();
        Actuate.tween(this,2,{}).onComplete(respawn);
    }

    private function killedByConductor():void {

        _attackForceY =+ Settings.DROP_FORCE_Y*0.3;
        jump();
        _isFalling = true;
        SoundManager.getInstance().killedByConductor();
        Actuate.tween(this,2,{}).onComplete(respawn);
    }

    public function onConductor():void {
        if (!_isHanging){
            killedByConductor();
        }


    }

    private function respawn():void {
        Game.instance.showBigText("You've been killed!");
     /*   _hero.x = 500;
        _hero.y = 0;

        _isKilled = false;
        _isFalling = false;*/
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

    public function get hero():Hero {
        return _hero;
    }


}
}
