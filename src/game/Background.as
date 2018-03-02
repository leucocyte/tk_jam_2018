/**
 * Created by flashdeveloper.pl on 2016-02-27.
 */
package game
{

import game.load.GameAssetsManager;

import starling.core.Starling;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.display.Stage;

public class Background extends Sprite
{

    public static const BACKGROUND_WIDTH:int = 1920;
    public static const BACKGROUND_HEIGHT:int = 1080;

    public static const MARGIN:Number = 20;

//    private var _floorQuad:Quad;
    public var shadowLayer:Sprite;
    public var aimLayer:Sprite;
    public var objectsLayer:Sprite;
    public var bloodLayer:Sprite;

    private static var _instance:Background;
    private var _bgImage:Image;

    public function Background()
    {
        shadowLayer = new Sprite();
        aimLayer = new Sprite();
        objectsLayer = new Sprite();
        bloodLayer = new Sprite();

    }

    public static function getInstance():Background
    {
        if(_instance == null)
            _instance = new Background();

        return _instance;
    }


    public function init():void
    {
        /*
        _floor = new Image(GameAssetsManager.getInstance().getTexture("testin_back"));
        _floor.width = Starling.current.nativeOverlay.stage.stageWidth;
        _floor.height = Starling.current.nativeOverlay.stage.stageHeight;
        Game.instance.addBackground(_floor);
        */

//        _floorQuad = new Quad(BACKGROUND_WIDTH, BACKGROUND_HEIGHT, 0x006600);
        _bgImage = new Image(GameAssetsManager._instance.getTexture("background"));
        addChild(_bgImage);
        Game.instance.addBackground(this);

        addChild(shadowLayer);
        addChild(bloodLayer);
        addChild(aimLayer);
        addChild(objectsLayer);

    }

    public function isOnMap(x:Number, y:Number):Boolean
    {
        if(x > MARGIN*2 && x < BACKGROUND_WIDTH - MARGIN*2 && y > MARGIN*2 && y < BACKGROUND_HEIGHT - MARGIN*2)
            return true;
        else
            return false;
    }



    public function destroy():void
    {
//        Game.instance.removeObjectFromScreen(_floor);
    }

	public function get floorQuad():Image {
        return _bgImage;
    }
}
}
