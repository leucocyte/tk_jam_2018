/** Created by Marek Brun on 04 marzec 2018 */
package game.view {

import game.load.GameAssetsManager;

import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class HitAnim extends Sprite {

	private var _anim:MovieClip;

	public function HitAnim() {
		_anim = new MovieClip(new <Texture>[
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "hit1"),
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "hit2"),
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "hit3"),
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "hit4"),
		], 24);
		_anim.x = -38;
		_anim.y = -57;
		addChild(_anim);
		_anim.play();
		_anim.addEventListener(Event.COMPLETE, onAnim_Complete);
		Starling.current.juggler.add(_anim);
	}

	private function onAnim_Complete(event:Event):void {
		_anim.removeEventListener(Event.COMPLETE, onAnim_Complete);
		_anim.parent.removeChild(_anim);
		_anim.stop();
		Starling.current.juggler.remove(_anim);
		if(parent) {
			parent.removeChild(this);
		}
	}

}
}
