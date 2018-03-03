/** Created by Marek Brun on 03 marzec 2018 */
package game.view.scenery.elements {
import game.load.GameAssetsManager;
import game.view.scenery.ElementsSpawner;
import game.utils.Settings;

import starling.display.DisplayObject;
import starling.display.Image;

public class BushesSpawner extends ElementsSpawner {

	public function BushesSpawner() {
		super(100, 2000, Settings.TRAIN_SPEED * 1.2);
	}

	override protected function createNewElement():DisplayObject {
		var element:Image = GameAssetsManager.getImageFromMainAtlas('bush' + int(1 + Math.random() * 2));
		element.y = -element.height;
		return element;
	}

}
}
