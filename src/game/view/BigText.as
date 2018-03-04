/** Created by Marek Brun on 04 marzec 2018 */
package game.view {
import game.utils.Settings;

import starling.display.Sprite;

public class BigText extends Sprite {

	public function BigText() {

	}

	public function show(text:String):void {
		var textt:Textt = new Textt(text);
		textt.x = Settings.SCENE_WIDTH / 2;
		textt.y = 160;
		addChild(textt);
	}

}
}

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Back;

import feathers.controls.Label;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.filters.DropShadowFilter;
import flash.text.TextFormat;

import game.utils.Settings;

import starling.display.Sprite;

class Textt extends Sprite {

	private var _label:Label;
	private var _this:Sprite;

	public function Textt(text:String) {
		_this = this;
		_label = new Label();
		_label.textRendererFactory = function ():ITextRenderer {
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = Settings.FONT;
			textFormat.size = 120;
			textFormat.color = 0xFFFFFF;
			var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			textRenderer.textFormat = textFormat;
			textRenderer.nativeFilters = [new DropShadowFilter()];
			textRenderer.embedFonts = true;
			return textRenderer;
		};
		addChild(_label);
		_label.text = text;
		_label.validate();
		_label.x = -_label.width / 2;

		_label.y = 120;
		_label.alpha = 0;
		scale = 0.5;
		Actuate.tween(this, 0.3, {scale:1}).ease(Back.easeOut);
		Actuate.tween(_label, 0.3, {y: 0, alpha: 1}).ease(Back.easeOut)
				.onComplete(function ():void {
					Actuate.tween(_label, 0.3, {y: -80, alpha: 0}).delay(2).ease(Back.easeIn)
							.onComplete(function ():void {
								_label.dispose();
								if(parent) {
									parent.removeChild(_this);
								}
							});
				});
	}

}