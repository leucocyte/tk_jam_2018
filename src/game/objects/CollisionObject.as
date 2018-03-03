/**
 * Created by Drygu on 2018-03-03.
 */
package game.objects {
import flash.geom.Rectangle;

public class CollisionObject {

    protected var _x:Number;
    protected var _y:Number;
    protected var _width:int;
    protected var _height:int;
    protected var _bound:Rectangle;

    public function CollisionObject() {

    }

    public function hit(hero:CollisionObject):Boolean {

//        var r1:Rectangle = new Rectangle(_x,_y,_width,_height);
//        var r2:Rectangle = new Rectangle(hero.x,hero.y,hero.width,hero.height);
//        trace("1. "+r1.intersects(r2));
        return hero.getRectangle().intersects(getRectangle());
/*
        if (_x < (hero.x + hero.width) && _x+_width>hero.x &&
                _y < (hero.y + hero.height) && _y+_height>hero.y){
            return true;
        }else
            return false;
*/
    }

    public function getRectangle():Rectangle {
        return new Rectangle(0,0,100,100);
    }

    public function get width():int {
        return _width;
    }

    public function set width(value:int):void {
        _width = value;
    }

    public function get height():int {
        return _height;
    }

    public function set height(value:int):void {
        _height = value;
    }

    public function get y():Number {
        return _y;
    }

    public function set y(value:Number):void {
        _y = value;
    }

    public function get x():Number {
        return _x;
    }

    public function set x(value:Number):void {
        _x = value;
    }
}
}
