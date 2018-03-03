/**
 * Created by Drygu on 2018-03-03.
 */
package game.objects {
import flash.geom.Rectangle;

import game.Game;
import game.utils.Settings;
import game.utils.WorldTime;

import org.osflash.signals.Signal;

import starling.display.Quad;

public class Pump extends CollisionObject{

    private var _id:Number;
    private var _type:int;
    private var _view:PumpView;
    private var _quad:Quad;

    public var completedSignal:Signal = new Signal(Pump);
    private var _timeStamp:Number;

    public function Pump(msg:String) {
        var arr:Array = msg.split(",");
        _id = parseInt(arr[0]);
//        _x = parseFloat(arr[1]);
//        _y = parseFloat(arr[2]);
        _type = parseInt(arr[1]);
        _timeStamp = parseInt(arr[2]);
//        _width = parseInt(arr[4]);
//        _height = parseInt(arr[5]);
        _width = 60;
        _height = 100;

        _y=0;
        _x=2000;

        trace("new PUMP! "+_type);

        _view = new PumpView(this);
        _view.x= _x;
//        _view.y=500;


        Game.instance.trainScene.pump.addChild(_view);


        switch(_type) {
            case 0:
                _quad = new Quad(_width, _height, 0x55ff00);
                _quad.x = x;
                _quad.y = -_quad.width;
                break;
            case 1:
                _quad = new Quad(_width, _height, 0x55ffff);
                _quad.x = x;
                _quad.y = -2*_quad.width;
                break;
            case 2:
                _quad = new Quad(_width, _height, 0x5500ff);
                _quad.x = x;
                _quad.y = -3*_quad.width;
                break;
        }
        Game.instance.trainScene.heroes.addChild(_quad);
//

        WorldTime.frameSignal.add(onWorldTime_Time);
    }

    private function onWorldTime_Time(frameTime:Number):void {
        _view.x -= (frameTime / 1000) * Settings.TRAIN_SPEED * Settings.DIFFICULTY;
        _quad.x -= (frameTime / 1000) * Settings.TRAIN_SPEED * Settings.DIFFICULTY;
        if(_view.x < -_view.width) {
            WorldTime.frameSignal.remove(onWorldTime_Time);
            Game.instance.trainScene.pump.removeChild(_view);
            Game.instance.trainScene.heroes.removeChild(_quad);
            completedSignal.dispatch(this);
        }

    }



    override public function hit(hero:CollisionObject):Boolean {
        return super.hit(hero);
    }

    override public function getRectangle():Rectangle {
        if (_quad!=null){
            return _quad.getBounds(Game.instance.trainScene.heroes);
        }else
            return null;

    }

    public function get type():int {
        return _type;
    }

    public function set type(value:int):void {
        _type = value;
    }


    public function get id():Number {
        return _id;
    }

    public function set id(value:Number):void {
        _id = value;
    }
}
}
