/** Created by Marek Brun on 03 marzec 2018 */
package game.view.scenery.elements {
import game.load.GameAssetsManager;
import game.view.scenery.ElementsSpawner;
import game.utils.Settings;

import starling.display.DisplayObject;
import starling.display.Image;

public class TreesFarSpawner extends ElementsSpawner {

	public function TreesFarSpawner() {
		super(10, 80, Settings.TRAIN_SPEED * 0.3);
	}

	override protected function createNewElement():DisplayObject {
		var element:Image = GameAssetsManager.getImageFromMainAtlas('tree2');
		return element;
	}

	override protected function getElement():DisplayObject {
		var element:DisplayObject = super.getElement();
		var extra:Number = Math.random() * 200;
		element.height = 400 - extra;
		element.scaleX = element.scaleY;
		element.y = -element.height - extra * 1.3;
		element.y -= Math.random() * 40;
		element.y += 40;
		sortChildren(sortChildrenFunc);
		return element;
	}

	public function sortChildrenFunc(do1:DisplayObject, do2:DisplayObject):int {
		if(do1.height > do2.height) {
			return 1;
		}
		return -1;
	}

	override protected function getSpeed(element:DisplayObject):Number {
		var extraPerc:Number = (400 - element.height) / 200;
		return speed - speed * (extraPerc * 0.4);
	}
}
}
