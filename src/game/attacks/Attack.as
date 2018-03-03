/**
 * Created by Drygu on 2018-03-03.
 */
package game.attacks {
import flash.geom.Rectangle;
import flash.geom.Rectangle;

import game.objects.CollisionObject;

import game.objects.Hero;

public class Attack extends CollisionObject{

    private var _type:int;

    public function Attack(h:Hero) {

    }

    public function get type():int {
        return _type;
    }

    public function set type(value:int):void {
        _type = value;
    }


}
}
