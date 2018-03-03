/** Created by Marek Brun on 03 marzec 2018 */
package game.view.hero {
import game.load.GameAssetsManager;

import starling.core.Starling;

import starling.display.Sprite;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class HeroStateDisplay extends Sprite {

	private var _bodyAtlas:TextureAtlas;
	private var _timelines:Vector.<Timeline> = new <Timeline>[];
	private var _frame:uint;
	private var _stateName:String;
	private var _leg:Timeline;
	private var _torso:Timeline;
	private var _hand:Timeline;
	private var _head:Timeline;

	public function HeroStateDisplay(stateName:String, leg:Array, torso:Array, hand:Array, head:Array) {
		_stateName = stateName;
		_bodyAtlas = GameAssetsManager.assetManager.getTextureAtlas('body');
		_timelines.push(_leg = createTimeline(leg));
		_timelines.push(_torso = createTimeline(torso));
		_timelines.push(_hand = createTimeline(hand));
		_timelines.push(_head = createTimeline(head));
	}

	public function createTimeline(arr:Array):Timeline {
		var frames:Vector.<Texture> = new <Texture>[];
		for each (var textureName:String in arr) {
			var texture:Texture = _bodyAtlas.getTexture(textureName);
			if(!texture) {
				trace('no body texture: ' + textureName);
			}
			frames.push(texture);
		}
		var timeline:Timeline = new Timeline(frames, 4);
		timeline.play();
		Starling.juggler.add(timeline);
		addChild(timeline);
		return timeline;
	}

	//public function get frame():uint {
	//	return _frame;
	//}
	//
	//public function set frame(value:uint):void {
	//	if(_frame != value) {
	//		_frame = value;
	//		for each (var timeline:Timeline in _timelines) {
	//			timeline.frame = _frame;
	//		}
	//	}
	//}

	public function get stateName():String {
		return _stateName;
	}
}
}


import starling.display.MovieClip;
import starling.textures.Texture;

class Timeline extends MovieClip {

	//private var _frames:Vector.<DisplayObject>;
	//private var _frame:uint;
	//private var _currentDisplay:DisplayObject;

	public function Timeline(frames:Vector.<Texture>, fps:uint) {
		super(frames, fps);
	}

	//public function set frame(frame:uint):void {
	//	if(_frame != frame) {
	//		_frame = frame;
	//	}
	//	if(_currentDisplay) {
	//		removeChild(_currentDisplay);
	//		_currentDisplay = null;
	//	}
	//	_currentDisplay = _frames[_frame - 1];
	//	addChild(_currentDisplay);
	//}
	//
	//public function get frame():uint {
	//	return _frame;
	//}
	//
	//public function nextFrame():void {
	//	if(_frame >= _frames.length) {
	//		frame = 1;
	//	} else {
	//		frame++;
	//	}
	//}
}
