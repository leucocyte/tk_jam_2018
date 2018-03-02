/**
 * Created with IntelliJ IDEA.
 * User: Drygu
 * Date: 15.04.14
 * Time: 11:26
 * To change this template use File | Settings | File Templates.
 */
package game.init {
import com.bit101.components.ComboBox;
import com.bit101.components.InputText;
import com.bit101.components.Style;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.TouchEvent;
import flash.net.SharedObject;
import flash.text.TextFormat;
import flash.ui.Keyboard;

import game.server.ConnectionServer;

import game.server.GameServer;

public class ConnectingLoginBox extends ConnectingBox{

    public var server:ComboBox;
    public var login:InputText;

    public function ConnectingLoginBox()
    {

        server=new ComboBox();
        server.addItem("localhost:8345");
        server.addItem("146.185.28.156:9355");
//        server.addItem("192.168.1.101");
        server.addItem("10.0.0.64");
        server.selectedColor=0x008800;
//        server.rolloverColor=0x0000aa;
        addChild(server);

    //    server.selectedIndex=1;

        login=new InputText();
        addChild(login);

        logButt.addEventListener(TouchEvent.TOUCH_TAP, loginR);
        login.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);

        var mySo:SharedObject = SharedObject.getLocal("taernLogin");
        if (mySo!=null && mySo.data.login!=null){
            login.text=mySo.data.login;
            server.selectedIndex=parseInt(mySo.data.server);
        }
        else
        {
            login.text="PanMamut";
            server.selectedIndex=1;
        }

//        if (!Settings.isMobile())
//            pcSkin();
//        else
            mobileSkin();
    }


    protected function pcSkin():void{

        _width=200;
        _height=135;

        server.x=10;
        server.y=10;
        server.width=180;

        login.x=10;
        login.y=server.y+25;
        login.width=180;


        logButt.y=login.y+25;
        progressBar.y=logButt.y+25;
        txt.y=progressBar.y+10;


    }

    protected function mobileSkin():void{

        var dw:int=360;

        var tf:TextFormat = new TextFormat();
        tf.size = 16;
        tf.color = 0xFFFFFF;
        tf.font = Style.fontName;

        _width=400;
        _height=240;

        server.x=10;
        server.y=10;
        server.width=dw;
        server.height=40;
        server.listItemHeight=40;


        login.x=10;
        login.y=server.y+50;
        login.width=dw;
        login.height=40;
        login.textField.defaultTextFormat=tf;


        logButt.y=login.y+55;
        logButt.height=40;
        logButt.width=dw;


        progressBar.y=logButt.y+55;
        progressBar.width=dw;
        progressBar.height=20;

        txt.y=progressBar.y+30;


    }


    override protected function onLoad(event:Event):void {
        stage.focus=login.textField;
        login.textField.setSelection(login.textField.length,login.textField.length);

        super.onLoad(event);
    }

    private function keyDown(event:KeyboardEvent):void {
        if(event.keyCode == Keyboard.ENTER)
            loginR();
    }


    override protected function loginR(event:Event=null):void {
        logButt.enabled=false;
        server.enabled=false;


        var arr:Array=String(server.selectedItem).split(":");
        var ip:String=arr[0];
        var port:String="9345";
        if (arr.length>1)
            port=arr[1];

        GameServer.getInstance().init("GameServer",ip,parseInt(port));
//        GameServer.getInstance().ip = ip;
//        GameServer.getInstance().port = parseInt(port);
        progressBar.activate();
//        MainInitializer.instance.connect();
        ConnectionServer.onConnectedSignal.addOnce(onConnected);
        ConnectionServer.onConnectionProblemSignal.addOnce(onConnectionError);

        ConnectionServer.connect();

        txt.text="Connecting..";

        var mySo:SharedObject = SharedObject.getLocal("taernLogin");
        mySo.data.login = login.text;
        mySo.data.server = server.selectedIndex;
        trace("server: "+server.selectedIndex);

    }

    public function onConnected(){
        ConnectionServer.login(login.text);
//        destroy();
        progressBar.deactivate();
        txt.text="Connected!";
    }

    public override function onConnectionError():void {
        logButt.enabled=true;
        server.enabled=true;
        progressBar.deactivate();
        txt.text="Server turned off";
    }

    override public function destroy():void {
        login.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown);
        super.destroy();
    }
}
}
