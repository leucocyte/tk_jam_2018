/** Created by Marek Brun on 04 marzec 2018 */
package game {
import flash.display.Loader;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;

[SWF(width='1920', height='1080', backgroundColor='#000000', frameRate='60')]
public class PreloaderDC extends Sprite {

	private var _mc:FontEmbeedMC;
	private var _loader:Loader;
	private var _screen:StartScreenMC;

	public function PreloaderDC() {
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		_mc = new FontEmbeedMC();
		addChild(_mc);
		showProgress(0);

		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoader_Progress);
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoader_Complete);
		_loader.load(new URLRequest('Main.swf'));
	}

	private function onLoader_Progress(event:ProgressEvent):void {
		showProgress(_loader.contentLoaderInfo.bytesLoaded / _loader.contentLoaderInfo.bytesTotal);
	}

	private function onLoader_Complete(event:Event):void {
		_screen = new StartScreenMC();
		_screen.startBtn.buttonMode = true;
		_screen.startBtn.addEventListener(MouseEvent.CLICK, onScreen_Click);
		addChild(_screen);
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize(null);
	}

	private function onScreen_Click(event:MouseEvent):void {
		removeChild(_screen);
		stage.removeEventListener(Event.RESIZE, onStageResize);
		removeChild(_mc);
		addChild(_loader);
	}

	private function onStageResize(event:Event):void {
		_screen.scaleX = _screen.scaleY = getRescaleToRect(stage.stageWidth, stage.stageHeight, _screen.width, _screen.height);
		_screen.x = stage.stageWidth / 2 - _screen.width / 2;
		_screen.y = stage.stageHeight / 2 - _screen.height / 2;
	}

	private function showProgress(progress:Number):void {
		_mc.tf.text = Math.round(progress * 100) + '%';
		_mc.x = stage.stageWidth / 2;
		_mc.y = stage.stageHeight / 2;
	}

	public static function getRescaleToRect(toRectWidth:Number, toRectHeight:Number, width:Number, height:Number, isInside:Boolean = true):Number {
		if(isInside) {
			if(toRectWidth / toRectHeight > width / height) {
				return toRectHeight / height;
			} else {
				return toRectWidth / width;
			}
		} else {
			if(width / height > toRectWidth / toRectHeight) {
				return toRectHeight / height;
			} else {
				return toRectWidth / width;
			}
		}
	}

}
}
