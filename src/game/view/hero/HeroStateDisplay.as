/** Created by Marek Brun on 03 marzec 2018 */
package game.view.hero {
import game.load.GameAssetsManager;

import starling.core.Starling;

import starling.display.Sprite;
import starling.filters.ColorMatrixFilter;
import starling.filters.FragmentFilter;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class HeroStateDisplay extends Sprite {

	private var _bodyAtlas:TextureAtlas;
	private var _stateName:String;
	private var _leg:Timeline;
	private var _torso:Timeline;
	private var _hand:Timeline;
	private var _head:Timeline;
	private var _fps:uint = 4;

	/**
	 * @param headType:
	 * 1 - normal
	 * 2 - scream
	 * 3 - uppercut punch
	 */
	public function HeroStateDisplay(stateName:String, leg:Array, torso:Array, hand:Array,
			headID:uint, headType:uint, hue:Number) {
		_stateName = stateName;
		_bodyAtlas = GameAssetsManager.assetManager.getTextureAtlas('body');

		_leg = createTimeline(leg);
		_torso = createTimeline(torso);
		_hand = createTimeline(hand);

		if(headType == 1) {
			_head = createTimeline([
				'head' + headID + '_anim1',
				'head' + headID + '_anim2',
				'head' + headID + '_anim3',
				'head' + headID + '_anim2',
				'head' + headID + '_anim1',
			]);
		} else if(headType == 2) {
			_head = createTimeline([
				'head' + headID + '_scream1',
			]);
		} else if(headType == 3) {
			_head = createTimeline([
				'head' + headID + '_scream2',
			]);
		}

		setHUE(hue);
	}

	/**
	 * @param value from 0 to 1
	 */
	public function setHUE(value:Number):void {
		var hueFilter:ColorMatrixFilter = new ColorMatrixFilter();
		hueFilter.adjustHue(-1 + value * 2);
		_torso.filter = hueFilter;
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
		var timeline:Timeline = new Timeline(frames, _fps);
		timeline.play();
		Starling.juggler.add(timeline);
		addChild(timeline);
		return timeline;
	}

	public function get stateName():String {
		return _stateName;
	}
}
}


import starling.display.MovieClip;
import starling.textures.Texture;

class Timeline extends MovieClip {

	public function Timeline(frames:Vector.<Texture>, fps:uint) {
		super(frames, fps);
	}

}
