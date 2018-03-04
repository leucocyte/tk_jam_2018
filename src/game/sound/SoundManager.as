/**
 * Created by flashdeveloper.pl on 2016-02-28.
 */
package game.sound
{
import com.eclecticdesignstudio.motion.Actuate;

import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

public class SoundManager
{


    [Embed(source = "../../../embed/sound/train_loop.mp3")]
    public static const AmbientMp3:Class;



    [Embed(source = "../../../embed/sound/punch.mp3")]
    public static const Punch:Class;
    [Embed(source = "../../../embed/sound/death_pump.mp3")]
    public static const DeathPump:Class;
    [Embed(source = "../../../embed/sound/death_fall.mp3")]
    public static const DeathFall:Class;

    [Embed(source = "../../../embed/sound/txt/say_one_more.mp3")]
    public static const RandomTxt1:Class;
    [Embed(source = "../../../embed/sound/txt/watch_where.mp3")]
    public static const RandomTxt2:Class;
    [Embed(source = "../../../embed/sound/txt/you_talking_to_me.mp3")]
    public static const RandomTxt3:Class;
    [Embed(source = "../../../embed/sound/txt/dont_push.mp3")]
    public static const RandomTxt4:Class;

//    [Embed(source = "../../../embed/sound/ambient.mp3")]
//    public static const MusicMp3:Class;

    private var _music:Sound;
    private var _ambient:Sound;

    private static var _instance:SoundManager;
    private var _musicChannel:SoundChannel;
    private var _ambientChannel:SoundChannel;


    private var _randomTxt:Array;
    //petla pociagowa
    private var _soundTransformAmbient:SoundTransform;
    private var _soundTransformMyHits:SoundTransform;
    private var _soundTransformOtherHits:SoundTransform;

    public function SoundManager()
    {
        _randomTxt =[RandomTxt1,RandomTxt2,RandomTxt3,RandomTxt4];

        _soundTransformMyHits = new SoundTransform();
        _soundTransformMyHits.volume = 0.6;

        _soundTransformOtherHits = new SoundTransform();
        _soundTransformOtherHits.volume = 0.4;
    }

    public static function getInstance():SoundManager
    {
        if(_instance == null)
            _instance = new SoundManager();

        return _instance;
    }

    public function playChangeSound():void
    {
        /*var sound:Sound = (new ChangeMp3()) as Sound ;
        sound.play();*/
    }

    public function playMusic():void
    {

        /*if (_musicChannel==null) {
            _music = (new MusicMp3()) as Sound;
            _musicChannel = _music.play(0, 9999999);
        }else
            _music.play(0,999999);*/
    }

    public function stopMusic():void
    {
        if (_musicChannel!=null) {
            _musicChannel.stop();
        }
//        var sound:Sound = (new MusicMp3()) as Sound ;
//        sound.play(0, 9999999);
    }


    public function playAmbient():void
    {
        _soundTransformAmbient = new SoundTransform();
        _soundTransformAmbient.volume = 0.5;
        if (_ambientChannel==null) {
            _ambient = (new AmbientMp3()) as Sound;
            _ambientChannel = _ambient.play(0, 9999999,_soundTransformAmbient);
//            _ambient.
         }else
            _music.play(0,999999);
    }

    public function stopAmbient():void
    {
        if (_ambientChannel!=null) {
            _ambientChannel.stop();
        }
//        var sound:Sound = (new MusicMp3()) as Sound ;
//        sound.play(0, 9999999);
    }

    public function playShotByType(type:int):void
    {
/*

        {
            case Hero.WAR_OF_MINE:
                var single:Sound = (new ShotSingleMp3()) as Sound;
                single.play();
                break;

        }*/
    }




    public function randomTxt():void
    {
        var nr:int = int(Math.random()*_randomTxt.length);
        var single:Sound = (new _randomTxt[nr]) as Sound;
        single.play();
    }


    public function playRandomTxt(init:Boolean=false):void {
        if (!init)
            randomTxt();
        Actuate.tween(this, int(5+10*Math.random()),{}).onComplete(playRandomTxt);
    }


    public function punch(my:Boolean=false):void
    {
        var single:Sound = (new Punch()) as Sound;
        if (my)
            single.play(0,0,_soundTransformMyHits);
        else
            single.play(0,0,_soundTransformOtherHits);
    }


    public function killedByConductor(my:Boolean=false):void
    {
        var single:Sound = (new DeathFall()) as Sound;
        if (my)
            single.play(0,0,_soundTransformMyHits);
        else
            single.play(0,0,_soundTransformOtherHits);
    }

    public function killedByDrop(my:Boolean=false):void
    {
        var single:Sound = (new DeathFall()) as Sound;
        if (my)
            single.play(0,0,_soundTransformMyHits);
        else
            single.play(0,0,_soundTransformOtherHits);
    }

    public function killedByPump(my:Boolean=false):void
    {
        var single:Sound = (new DeathPump()) as Sound;
        if (my)
            single.play(0,0,_soundTransformMyHits);
        else
            single.play(0,0,_soundTransformOtherHits);
    }


    public function stop():void {
        Actuate.stop(this);
    }

}
}
