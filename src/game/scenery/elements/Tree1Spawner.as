/** Created by Marek Brun on 03 marzec 2018 */
package game.scenery.elements {
import game.load.GameAssetsManager;
import game.scenery.ElementsSpawner;

import starling.display.DisplayObject;
import starling.display.Image;

public class Tree1Spawner extends ElementsSpawner {

	public function Tree1Spawner() {
		super(1000, 10000, 100);

	}

	override protected function createNewElement():DisplayObject {
		var element:Image = GameAssetsManager.getImageFromMainAtlas('tree1');
		element.height = 400;
		element.scaleX = element.scaleY;
		return element;
	}
}
}
