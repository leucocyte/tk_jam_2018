/**
 * Created by Drygu on 2018-03-03.
 */
package game.objects {
import game.Game;

public class Obstacle {

    private var _id:Number;
    private var _x:Number;
    private var _y:Number;
    private var _type:int;
    private var _width:int;
    private var _height:int;
    private var _view:ObstacleView;

    public function Obstacle(msg:String) {
        var arr:Array = msg.split(",");
        _id = parseInt(arr[0]);
        _x = parseFloat(arr[1]);
        _y = parseFloat(arr[2]);
        _type = parseInt(arr[3]);
        _width = parseInt(arr[4]);
        _height = parseInt(arr[5]);

        _view = new ObstacleView(this);
        Game.instance.trainScene.heroes.addChild(_view);
    }
}
}
