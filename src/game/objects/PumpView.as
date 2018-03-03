/**
 * Created by Drygu on 2018-03-03.
 */
package game.objects {
import flash.geom.Rectangle;

import game.load.GameAssetsManager;

import starling.display.Image;
import starling.display.Sprite;

public class PumpView extends Sprite {

    private var _pump:Pump;

    public function PumpView(pump:Pump) {
        super();
        this._pump = pump;
        buildPump();
    }

    private function buildPump():Image {
        var name:String = "traction_blur";
        switch(_pump.type){
            case 1:
            case 2:
            case 3:
                break;
        }

        var element:Image = GameAssetsManager.getImageFromMainAtlas(name);
        element.color = 0xff0000;
        element.height = 400;
        element.scaleX = element.scaleY;
        addChild(element);
        return element;
    }

}
}
