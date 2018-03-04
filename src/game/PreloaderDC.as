/** Created by Marek Brun on 04 marzec 2018 */
package game {
import flash.display.Loader;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.net.URLRequest;

[SWF(width='1920', height='1080', backgroundColor='#000000', frameRate='60')]
public class PreloaderDC extends Sprite {

	private var _mc:FontEmbeedMC;
	private var _loader:Loader;

	public function PreloaderDC() {
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		_mc = new FontEmbeedMC();
		addChild(_mc);
		showProgress(0);

		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoader_Complete);
		_loader.load(new URLRequest('Main.swf'));
	}

	private function onLoader_Complete(event:Event):void {
		removeChild(_mc);
		addChild(_loader);
	}

	private function showProgress(progress:Number):void {
		_mc.tf.text = Math.round(progress * 100) + '%';
		_mc.x = stage.stageWidth / 2;
		_mc.y = stage.stageHeight / 2;
	}

}
}
