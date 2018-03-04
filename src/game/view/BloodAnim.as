/** Created by Marek Brun on 04 marzec 2018 */
package game.view {

import game.load.GameAssetsManager;

import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class BloodAnim extends Sprite {

	private var _anim:MovieClip;

	public function BloodAnim() {
		_anim = new MovieClip(new <Texture>[
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "blood_exp1"),
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "blood_exp2"),
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "blood_exp3"),
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "blood_exp4"),
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "blood_exp5"),
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "blood_exp6"),
			GameAssetsManager.getInstance().getTextureFromAtlas('main', "blood_exp7"),
		], 24);
		_anim.x = -193;
		_anim.y = -186;
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
