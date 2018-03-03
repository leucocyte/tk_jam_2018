/** Created by Marek Brun on 03 marzec 2018 */
package game.scenery {
import game.load.GameAssetsManager;

import starling.display.Image;
import starling.display.Sprite;

public class SeamlessBackground extends Sprite {

	private var _speed:uint = 200;
	private const _images:Vector.<Image> = new <Image>[];
	private var _nextX:Number = 0;

	public function SeamlessBackground() {
		addImage();
		check();
	}

	private function check():void {

	}

	private function addImage():void {
		var img:Image = createImage();
		img.x = _nextX;
		addChild(img);
		_nextX = img.x + img.width
		;
	}

	public function createImage():Image {
		var img:Image = GameAssetsManager.getImageFromMainAtlas('mountains1');
		img.width = 200;
		return img;
	}
}
}
