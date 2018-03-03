/** Created by Marek Brun on 03 marzec 2018 */
package game.scenery.elements {
import game.load.GameAssetsManager;
import game.scenery.ElementsSpawner;

import starling.display.DisplayObject;
import starling.display.Image;

public class Tree2Spawner extends ElementsSpawner {

	public function Tree2Spawner() {
		super(100, 2000, 400);
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
}
}
