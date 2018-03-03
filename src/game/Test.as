/**
 * Created by Drygu on 2018-03-03.
 */
package game {
import flash.display.Sprite;

import game.objects.CollisionObject;
import game.objects.Hero;

[SWF(width='1280',height='720',backgroundColor='#333333',frameRate='60')]
public class Test extends Sprite{
    public function Test() {
        var o1:CollisionObject = new CollisionObject();
        o1.x=0;
        o1.y=0;
        o1.width=54;
        o1.height=50;

        var s:Sprite = new Sprite();
        s.graphics.beginFill(0xff0000);
        s.graphics.drawRect(0,0,o1.width,o1.height);
        s.x=o1.x;
        s.y=o1.y;
        addChild(s);



        var o2:CollisionObject = new CollisionObject();
        o2.x=50;
        o2.y=50;
        o2.width=100;
        o2.height=100;

        var s:Sprite = new Sprite();
        s.graphics.beginFill(0x00ff00);
        s.graphics.drawRect(0,0,o2.width,o2.height);
        s.x=o2.x;
        s.y=o2.y;
        addChild(s);

        trace(o1.hit(o2));

    }
}
}
