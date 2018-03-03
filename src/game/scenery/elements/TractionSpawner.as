/** Created by Marek Brun on 03 marzec 2018 */
package game.scenery.elements {
import game.load.GameAssetsManager;
import game.scenery.ElementsSpawner;

import starling.display.DisplayObject;
import starling.display.Image;

public class TractionSpawner extends ElementsSpawner {

	public function TractionSpawner() {
		super(1000, 1000, 4200);
	}

	override protected function createNewElement():DisplayObject {
		var element:Image = GameAssetsManager.getImageFromMainAtlas('traction1');
		element.height = 800;
		element.scaleX = element.scaleY;
		return element;
	}

	override protected function getElement():DisplayObject {
		var element:DisplayObject = super.getElement();
		element.y = -element.height;
		return element;
	}

}
}
