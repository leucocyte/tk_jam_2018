/** Created by Marek Brun on 03 marzec 2018 */
package game.view.scenery.elements {
import game.load.GameAssetsManager;
import game.view.scenery.ElementsSpawner;
import game.utils.Settings;

import starling.display.DisplayObject;
import starling.display.Image;

public class TractionSpawner extends ElementsSpawner {

	public function TractionSpawner() {
		super(3000, 3000, Settings.TRAIN_SPEED * 1.5);
	}

	override protected function createNewElement():DisplayObject {
		var element:Image = GameAssetsManager.getImageFromMainAtlas('pole');
		element.y = -element.height;
		return element;
	}

}
}
