package game.utils {
import flash.events.IOErrorEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.utils.Dictionary;

/**
 * Just play mp3 from specifed URL in streaming.
 * Sound objects are remembered (by URL) and reused.
 *
 * Handy for short, no-infinite-loop sounds.
 *
 * created:2009-11-14
 * @author Marek Brun
 */
public class MP3Manager {

	static private var instance:MP3Manager;
	private var dictURLRequest_Sound:Dictionary = new Dictionary();
	// 0 to 1
	private static var volumeForAll:Number = 1;

	public function MP3Manager() {
	}

	private function _play(stream:URLRequest, loops:uint = 0):SoundChannel {
		var sound:Sound;
		if(!dictURLRequest_Sound[stream.url]) {
			sound = new Sound();
			sound.load(stream);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onSound_IOError);
			dictURLRequest_Sound[stream.url] = sound;
		}
		sound = dictURLRequest_Sound[stream.url];
		var channel:SoundChannel = sound.play(0, loops);
		if(!isNaN(volumeForAll)) {
			var st:SoundTransform = channel.soundTransform;
			st.volume = volumeForAll;
			channel.soundTransform = st;
		}
		return channel;
	}

	public static function play(url:URLRequest, loops:uint = 0):SoundChannel {
		return getInstance()._play(url, loops);
	}

	public static function setVolumeforAll(volume:Number):void {
		volumeForAll = volume;
	}

	static public function getInstance():MP3Manager {
		if(!instance) {
			return new MP3Manager();
		}
		return instance;
	}

	private function onSound_IOError(event:IOErrorEvent):void {
		trace('onSound_IOError(' + event + ')');
	}
}
}
