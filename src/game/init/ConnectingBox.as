/**
 * Created with IntelliJ IDEA.
 * User: Drygu
 * Date: 15.04.14
 * Time: 13:09
 * To change this template use File | Settings | File Templates.
 */
package game.init {
import com.bit101.components.Label;
import com.bit101.components.PushButton;
import com.bit101.components.Window;

import flash.events.Event;

import game.server.ConnectionServer;

public class ConnectingBox extends Window
{
    public var progressBar:LoadingBar;
    public var logButt:PushButton;
    public var txt:Label;

    public function ConnectingBox()
    {
        _width=200;

        logButt=new PushButton(null,0,0,"login");
        addChild(logButt);
        logButt.x=10;
        logButt.y=30;
        logButt.width=180;

        progressBar=new LoadingBar();
        addChild(progressBar);
        progressBar.x=10;
        progressBar.y=60;
        progressBar.width=180;

        txt=new Label();
        addChild(txt);
        txt.x=10;
        txt.y=progressBar.y+20;
        txt.width=180;

        logButt.addEventListener("click",loginR);

        addEventListener(Event.ADDED_TO_STAGE,onLoad);
    }

    protected function onLoad(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE,onLoad);
        this.x=stage.stageWidth/2-this.width/2;
        this.y=stage.stageHeight/2-this.height/2;
    }



    protected function loginR(event:Event=null):void
    {
    //  DrServer.getInstance().loginData=new LoginData(login.text+";;-666");
        logButt.enabled=false;
        progressBar.activate();
        ConnectionServer.connect();
//        MainInitializer.instance.connect();
    }

    public function onConnectionError():void {
        logButt.enabled=true;
        progressBar.deactivate();
        txt.text="Server turned off";
    }

    public function destroy():void{
        progressBar.deactivate();
    }

    public function communicate(s:String):void {
        txt.text=s;
    }
}
}
