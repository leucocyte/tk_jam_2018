/**
 * Created by flashdeveloper.pl on 2016-02-25.
 */
package game.load {
import flash.text.Font;

import game.utils.Settings;

import org.osflash.signals.Signal;

import starling.core.Starling;
import starling.display.Image;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

import starling.utils.AssetManager;

public class GameAssetsManager {
	/*

	 [Embed(source="/../embed/verdanab.ttf", fontFamily='Verdana', mimeType="application/x-font", embedAsCFF="false")]
	 private static const VerdanaBold:Class;

	 [Embed(source="/../embed/Beast Machines.ttf",fontFamily='Beast Machines',mimeType="application/x-font",embedAsCFF="false")]
	 private static const BestMachines:Class;

	 */


	public static const NAME_REGEX:RegExp = /([^\?\/\\]+?)(?:\.([\w\-]+))?(?:\?.*)?$/; // wyciaganie nazwy pliku

	private var _toLoad:int;
	private var _loadedCount:int;


	public static var assetManager:AssetManager;
	public static var _instance:GameAssetsManager

	public var coreAssetsLoadedSignal:Signal;

	public function GameAssetsManager() {
		assetManager = new AssetManager();
		coreAssetsLoadedSignal = new Signal();
	}

	public static function getInstance():GameAssetsManager {
		if(_instance == null)
			_instance = new GameAssetsManager();

		return _instance;
	}


	public function loadCoreAssets():void {
		/* Font.registerFont(BestMachines);
		 Font.registerFont(VerdanaBold);*/


		var atlasAssets:Array =
				[

					Settings.ASSETS_DIR + "main",
					Settings.ASSETS_DIR + "body",
				];

		var normalAssets:Array =
				[

					//Settings.ASSETS_DIR+"shroom/gamejam5_26",

				];


		_toLoad = atlasAssets.length + normalAssets.length;
		_loadedCount = 0;

		for(var i:int = 0; i < atlasAssets.length; i++) {
			loadAsset(atlasAssets[i]);
		}

		for(var i:int = 0; i < normalAssets.length; i++) {
			loadAsset(normalAssets[i], false);
		}
	}


	private function loadAsset(path:String, atlas:Boolean = true, format:String = ".png"):void {

		assetManager.enqueue(path + format);

		if(atlas)
			assetManager.enqueue(path + ".xml");

		assetManager.loadQueue(onProgress)

	}

	private function onProgress(ratio:Number):void {
		if(ratio == 1)
			Starling.juggler.delayCall(onComplete, 0.15);
	}

	private function onComplete():void {
		_loadedCount++;
		if(_loadedCount == _toLoad) {
			coreAssetsLoadedSignal.dispatch();
		}
	}

	public static function getAssetNameFromPath(path:String):String {
		return path.match(NAME_REGEX)[0];
	}


	public function getTexture(name:String):Texture {
		return assetManager.getTexture(name);
	}

	public function getTextureFromAtlas(atlasName:String, name:String):Texture {
		return assetManager.getTextureAtlas(atlasName).getTexture(name);
	}

	public static function getImageFromMainAtlas(name:String):Image {
		var atlas:TextureAtlas = assetManager.getTextureAtlas('main');
		var tex:Texture = atlas.getTexture(name);
		return new Image(tex);
	}

	public function getTexturesFromAtlas(atlasName:String, tex_prefix:String):Vector.<Texture> {
		trace("GameAssetsManager.getTexturesFromAtlas atlasName = " + atlasName + "; tex_prefix = " + tex_prefix);

		return assetManager.getTextureAtlas(atlasName).getTextures(tex_prefix);
	}
}
}
