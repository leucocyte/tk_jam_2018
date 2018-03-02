/**
 * Created by flashdeveloper.pl on 2017-03-04.
 */
package game.objects
{

import game.Background;
import game.GameController;
import game.load.GameAssetsManager;

import starling.core.Starling;

import starling.display.MovieClip;
import starling.display.Quad;

import starling.display.Sprite;

public class Hero extends Sprite
{

    public static const RUN_SPEED:Number = 5;

    public static const HEIGHT:Number = 100;
    public static const WIDTH:Number = 150;

    protected var _idle:MovieClip;
    protected var _walk:MovieClip;
    protected var _cut:MovieClip;
    protected var _fail:MovieClip;
    protected var _win:MovieClip;


    protected var _currentAnim:String = "";
    protected var _character:MovieClip;

    protected var _cutting:Boolean = false;
    public static const POLICEMAN_LURE_RANGE:Number = 200;

//    protected var _character:Quad;

    private var _gameOver:Boolean = false;


    public function Hero()
    {
        super();
        initAnimations();

    }

    protected function initAnimations():void
    {
//        _idle = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("ludzik_test", Anim.IDLE));
        _walk = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("lumberjack", "drwal_walk"));
        _walk.fps = 60;
        _walk.loop = true;

        _cut = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("lumberjack", "drwal_cut"));
        _cut.fps = 60;
        _cut.loop = true;

        _fail = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("lumberjack", "death"));
        _fail.fps = 60;
        _fail.loop = false;

        _idle = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("lumberjack", "drwal_idle"));
        _idle.fps = 60;
        _idle.loop = true;

        _win = new MovieClip(GameAssetsManager.getInstance().getTexturesFromAtlas("lumberjack", "drwal_win"));
        _win.fps = 60;
        _win.loop = true;

        _walk.x = _cut.x = _fail.x = _idle.x = _win.x = - WIDTH / 2;
        _walk.y = _cut.y = _fail.y = _idle.y = _win.y = - HEIGHT;


        _character = _idle;
        _character.play();
        addChild(_character);
        Starling.juggler.add(_character);
        _currentAnim = Anim.IDLE;

    }



    public function playAnimation(anim:String):void
    {
        if(_currentAnim != anim)
        {
            _character.stop();
            Starling.juggler.remove(_character);
            removeChild(_character);

            switch (anim)
            {
                case Anim.IDLE:
                        _character = _idle;
                    break;

                case Anim.WALK:
                        _character = _walk;
                    break;

                case Anim.WIN:
                        _character = _win;
                    break;

                case Anim.CUT:
                        _character = _cut;
                    break;

                case Anim.FAIL:
                        _character = _fail;
                    break;
            }

            _character.play();
            addChild(_character);

            Starling.juggler.add(_character);
            _currentAnim = anim;
        }

    }

    public function updateHeroBehaviour():void
    {
        if(!_gameOver)
        {
            if(isMoving())
                updateMove();
            else
                playStandingAnim();
        }
        else
        {
            playAnimation(Anim.FAIL);

        }


    }

    protected function playStandingAnim():void
    {
        if(isCutting())
            playAnimation(Anim.CUT);
        else
            playAnimation(Anim.IDLE);
    }

    protected function isMoving():Boolean
    {
        if(GameController.getInstance().speedX != 0 || GameController.getInstance().speedY != 0)
            return true;
        else
            return false;
    }

    protected function isCutting():Boolean
    {
        return _cutting;
    }

    public function updateMove():void
    {
        playAnimation(Anim.WALK);

        if (GameController.getInstance().speedX < 0)
        {
            if(x > Background.MARGIN + Hero.WIDTH/2)
            {
                this.x += GameController.getInstance().speedX;
                this.scaleX = -1;
            }

        }
        else if (GameController.getInstance().speedX > 0)
        {
            if(x < Background.BACKGROUND_WIDTH - Background.MARGIN - Hero.WIDTH/2)
            {
                this.x += GameController.getInstance().speedX;
                this.scaleX = 1;
            }
        }

        if (GameController.getInstance().speedY < 0)
        {
            if(y > Background.MARGIN + Hero.HEIGHT)
                this.y += GameController.getInstance().speedY;
        }
        else if (GameController.getInstance().speedY > 0)
        {
            if(y < Background.BACKGROUND_HEIGHT - Background.MARGIN)
                this.y += GameController.getInstance().speedY;
        }


    }


    public function destroy():void
    {
    //        Game.instance.removeObjectFromScreen(_armatureClip);
    //        Game.instance.removeObjectFromScreen(_nameLabel);
    }

    public function isInRange(tree:Tree):Boolean {
        if (!tree.fallen) {
            if(Math.abs(tree.x - x)<40 && Math.abs(tree.y - y)<40){
                return true;
            }
        }
        return false;
    }

    public function set cutting(value:Boolean):void
    {
        _cutting = value;
    }

    public function get gameOver():Boolean
    {
        return _gameOver;
    }

    public function set gameOver(value:Boolean):void
    {
        _gameOver = value;
    }
}
}
