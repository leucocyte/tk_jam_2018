/**
 * Created by Drygu on 2018-03-03.
 */
package game.attacks {
import com.eclecticdesignstudio.motion.Actuate;

import flash.geom.Rectangle;

import game.Direction;
import game.Game;
import game.objects.Hero;
import game.utils.Settings;

import starling.display.Quad;

public class Drop extends Attack {
    private var _quad:Quad;

    public function Drop(h:Hero) {
        super(h);
        type = AttackType.DROP;

        _width = 50;
        _height = 20;
        _y = h.y;
        _x = h.x;

        if (Settings.DEBUG_ATTACKS){
            _quad = new Quad(_width,_height,0x555599);
            _quad.x = _x;
            _quad.y = _y+20;
            Game.instance.trainScene.heroes.addChild(_quad);
            Actuate.tween(_quad,0.5,{alpha:0.5}).onComplete(function(){Game.instance.trainScene.heroes.removeChild(_quad)});
        }
    }

    override public function getRectangle():Rectangle {
        if (_quad!=null){
            return _quad.getBounds(Game.instance.trainScene.heroes);
        }else
            return null;

    }



}
}
