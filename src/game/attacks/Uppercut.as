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

public class Uppercut extends Attack {
    private var _quad:Quad;

    public function Uppercut(h:Hero) {
        super(h);
        type = AttackType.UPPERCUT;

        _width = 50;
        _height = 100;
        _y = h.y - Settings.HERO_HEIGHT/2 - height;
        if (h.direction==Direction.RIGHT){
            _x = h.x+35;
        }else
            _x = h.x-_width-10;


        _quad = new Quad(_width,_height,0x555599);
        _quad.x = _x;
        _quad.y = _y;
        Game.instance.trainScene.heroes.addChild(_quad);
        _quad.visible = Settings.QUAD_VISIBLE;
        Actuate.tween(_quad,0.5,{alpha:0.5}).onComplete(function(){Game.instance.trainScene.heroes.removeChild(_quad)});

    }

    override public function getRectangle():Rectangle {
        if (_quad!=null){
            return _quad.getBounds(Game.instance.trainScene.heroes);
        }else
            return null;

    }



}
}
