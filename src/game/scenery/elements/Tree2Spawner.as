/** Created by Marek Brun on 03 marzec 2018 */
package game.scenery.elements {
import game.load.GameAssetsManager;
import game.scenery.ElementsSpawner;

import starling.display.DisplayObject;
import starling.display.Image;

public class Tree2Spawner extends ElementsSpawner {

	public function Tree2Spawner() {
		super(1000, 2000, 200);
	}

	override protected function createNewElement():DisplayObject {
		var element:Image = GameAssetsManager.getImageFromMainAtlas('tree2');
		element.height = 400;
		element.scaleX = element.scaleY;
		return element;
	}

	override protected function getElement():DisplayObject {
		var element:DisplayObject = super.getElement();
		element.y = -100 + Math.random() * 200;
		return element;
	}
}
}
