/**
 * Created by Drygu on 2018-03-03.
 */
package game.objects {
import game.load.GameAssetsManager;

import starling.display.Image;
import starling.display.Sprite;

public class PumpView extends Sprite {

	private var _pump:Pump;

	public function PumpView(pump:Pump) {
		this._pump = pump;
		buildPump();
	}

	private function buildPump():Image {
		var name:String = "pump";
		var element:Image = GameAssetsManager.getImageFromMainAtlas(name);
		element.x = -181;
		switch(_pump.type) {
			case 0:
				element.y = 460;
				break;
			case 1:
				element.y = 410;
				break;
			case 2:
				element.y = 360;
				break;
			case 3:
				element.y = 280;
				break;
		}

		addChild(element);
		return element;
	}

}
}
