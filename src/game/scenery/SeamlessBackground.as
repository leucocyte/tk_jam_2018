/** Created by Marek Brun on 03 marzec 2018 */
package game.scenery {
import game.load.GameAssetsManager;
import game.utils.Settings;
import game.utils.WorldTime;

import starling.display.Image;
import starling.display.Sprite;

public class SeamlessBackground extends Sprite {

	private var _speed:uint;
	private const _images:Vector.<Image> = new <Image>[];
	private var _lastImage:Image;
	private var _textureName:String;
	private var _height:Number;
	private var _imagePool:Vector.<Image> = new <Image>[];
	private var _countNew:int;

	public function SeamlessBackground(speed:Number, textureName:String, height:Number) {
		_textureName = textureName;
		_speed = speed;
		_height = height;
		addImage();
		check();
		WorldTime.frameSignal.add(onWorldTime_Time);
	}

	private function check():void {
		while(_lastImage.x < Settings.SCENE_WIDTH) {
			addImage();
		}
		while(_images.length > 1 && _images[0].x < -_images[0].width) {
			var img:Image = _images.shift();
			removeChild(img);
			_imagePool.push(img);
		}
	}

	private function addImage():void {
		var img:Image = createImage();
		if(_lastImage) {
			img.x = _lastImage.x + _lastImage.width;
		}
		addChild(img);
		_lastImage = img;
		_images.push(_lastImage);
	}

	private function createImage():Image {
		if(_imagePool.length) {
			return _imagePool.pop();
		}
		_countNew++;
		var img:Image = GameAssetsManager.getImageFromMainAtlas(_textureName);
		img.height = _height;
		img.scaleX = img.scaleY;
		return img;
	}

	private function onWorldTime_Time(frameTime:Number):void {
		move(frameTime);
		check();
	}

	private function move(frameTime:Number):void {
		var moveX:Number = (frameTime / 1000) * _speed * Settings.DIFFICULTY;
		for each (var image:Image in _images) {
			image.x -= moveX;
		}
	}
}
}
