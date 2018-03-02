/**
 * Created by flashdeveloper.pl on 2017-03-03.
 */
package game
{

import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.filters.DropShadowFilter;

import flash.text.TextFormat;

import flashx.textLayout.formats.TextAlign;

import game.init.ConnectingBox;

import game.init.ConnectingLoginBox;


import game.load.GameAssetsManager;
import game.ui.StartMenu;
import game.utils.CursorManager;
import game.utils.Settings;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;



public class Game extends Sprite
{
    private static var _instance:Game;

   private var _backGround:Background;
    private var _startMenu:StartMenu;
    private var _trainScene:TrainScene;
    /*     private var _hero:Hero;

    private var _trees:Vector.<Tree>;
    private var _mushrooms:Vector.<Mushroom>;
    private var _pickers:Vector.<Picker>;
    private var _police:Vector.<Policeman>;

    private var _aimer:Aimer;
    private var _score:PlayerScore;
    private var _activeTree:Tree;
    public var block:Boolean = false;
    private var _highlighted:Tree;
    private var _timeLabel:TimeLabel;

*/

    public function Game()
    {
        super();
        _instance = this;
        init();
    }

    public static function get instance():Game
    {
        return _instance;
    }

    private function init():void
    {
        GameAssetsManager.getInstance().coreAssetsLoadedSignal.addOnce(coreAssetsLoaded);
        GameAssetsManager.getInstance().loadCoreAssets();
    }

    private function coreAssetsLoaded():void
    {
        CursorManager.init();
        Background.getInstance().init();
//        aimerTest();
        initMenu();

        addEventListener(Event.ENTER_FRAME, onEnterFrame);

    }

    private function initMenu():void {

        _startMenu = new StartMenu();
        _startMenu.x = 100;
        _startMenu.y = 100;
        addChild(_startMenu);

    }

    public function startGame():void {
        removeChild(_startMenu);
        _trainScene = new TrainScene();
        addChild(_trainScene);
    }

    private function joinClicked(event:Event):void {
        trace("JOIN!");
    }




    private function entitySort(a:DisplayObject, b:DisplayObject):int
    {
        /*
        if (a==_aimer) {
            if (b==backGround.floorQuad)
                return 1;
            else
                return -1;
        }
        if (b==_aimer) {
            if (a==backGround.floorQuad)
                return -1;
            else
                return 1;
        }
*/
        var gleb1:Number=int((980*a.y+a.x)/10);
        var gleb2:Number=int((980*b.y+b.x)/10);

        if (gleb1 > gleb2)
            return 1;
        else
            return -1;
    }

    private function initHero():void
    {

    }


    public function removeObjectFromScreen(image:Image):void
    {
        removeChild(image);
    }


    public function onResize():void
    {
//        _backGround.x = stage.stageWidth / 2 - _backGround.width / 2;
//        _backGround.y = stage.stageHeight / 2 - _backGround.height / 2;
//        trace()

        if (stage.stageWidth<1920){
            var ratio:Number = stage.stageWidth/1920;
            _backGround.scale = ratio;
        }else
            _backGround.scale =1;

    }



    public function addBackground(background:Background):void
    {
        _backGround = background;
        addChild(_backGround);
    }


    private function onEnterFrame(e:Event):void
    {

    }



    public function mouseDown():void {
        trace("mouse down");
    }


    public function mouseUp():void {
        trace("mouse up");

    }


}
}
