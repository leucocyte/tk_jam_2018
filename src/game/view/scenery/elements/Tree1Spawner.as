/** Created by Marek Brun on 03 marzec 2018 */
package game.view.scenery.elements {
import game.load.GameAssetsManager;
import game.view.scenery.ElementsSpawner;
import game.utils.Settings;

import starling.display.DisplayObject;
import starling.display.Image;

public class Tree1Spawner extends ElementsSpawner {

	public function Tree1Spawner() {
		super(100, 1000, Settings.TRAIN_SPEED * 0.4);
	}

	override protected function createNewElement():DisplayObject {
		var element:Image = GameAssetsManager.getImageFromMainAtlas(
				Math.random() > 0.5 ? 'tree1' : 'tree3'
		);
		element.height = 700 + Math.random() * 100;
		element.scaleX = element.scaleY;
		return element;
	}

	override protected function getElement():DisplayObject {
		var element:DisplayObject = super.getElement();
		element.y = -element.height;
		return element;
	}

	override protected function getDelay(delay:Number):Number {
		return super.getDelay(delay) / Settings.TREES_DENSITY;
	}
}
}
