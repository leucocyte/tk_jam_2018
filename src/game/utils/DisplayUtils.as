/** Created by Marek Brun on 04 marzec 2018 */
package game.utils {
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
}
}
