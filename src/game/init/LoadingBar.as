/**
 * Created with IntelliJ IDEA.
 * User: Drygu
 * Date: 15.04.14
 * Time: 12:45
 * To change this template use File | Settings | File Templates.
 */
package game.init {

import com.bit101.components.ProgressBar;

import flash.events.Event;


public class LoadingBar extends ProgressBar{

    private var _active:Boolean=false;

    public function LoadingBar() {

    }

    private function onEnterFrame(e:Event):void {
        if (_active){
            value+=0.01;
            if (value>=1)
                value=0;
        }
    }

    public function deactivate():void{
       _active=false;
        removeEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    public function activate():void {
        _active=true;
        addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }
}
}
