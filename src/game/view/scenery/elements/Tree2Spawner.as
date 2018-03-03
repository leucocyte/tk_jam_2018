/** Created by Marek Brun on 03 marzec 2018 */
package game.view.scenery.elements {
import game.load.GameAssetsManager;
import game.view.scenery.ElementsSpawner;
import game.utils.Settings;

import starling.display.DisplayObject;
import starling.display.Image;

public class Tree2Spawner extends ElementsSpawner {

	public function Tree2Spawner() {
		super(100, 2000, Settings.TRAIN_SPEED * 0.3);
	}

	override protected function createNewElement():DisplayObject {
		var element:Image = GameAssetsManager.getImageFromMainAtlas('tree2');
		return element;
	}

	override protected function getElement():DisplayObject {
		var element:DisplayObject = super.getElement();
		element.height = 400 + Math.random() * 200;
		element.scaleX = element.scaleY;
		element.y = -element.height;
		return element;
	}

	override protected function getDelay(delay:Number):Number {
		return super.getDelay(delay) / Settings.TREES_DENSITY;
	}
}
}
