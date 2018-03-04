/** Created by Marek Brun on 04 marzec 2018 */
package game.utils {
import game.TrainScene;

import starling.display.Canvas;

import starling.display.DisplayObject;
import starling.display.Sprite;

public class DisplayUtils {

	public static function flipHorizontally(display:DisplayObject):DisplayObject {
		display.x = display.width;
		display.scaleX = -display.scaleX;
		var box:Sprite = new Sprite();
		box.addChild(display);
		return box;
	}

	public static function drawDebugCircle(display:TrainScene, x:Number, y:Number):void {
		var circle:Canvas = new Canvas();
		circle.beginFill(0xFF0000, 0.5);
		circle.drawCircle(x, y, 20);
		display.addChild(circle);
	}
}
}
