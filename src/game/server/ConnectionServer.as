/**
 * Created with IntelliJ IDEA.
 * User: Drygu
 * Date: 23.02.16
 * Time: 20:13
 * To change this template use File | Settings | File Templates.
 */
package game.server {
import org.osflash.signals.Signal;

public class ConnectionServer {

    public static var onConnectedSignal:Signal = new Signal();
    public static var onDisconnectedSignal:Signal = new Signal();
    public static var onConnectionProblemSignal:Signal = new Signal();

    public function ConnectionServer() {
    }


    private static function send(msg:String):void{
        GameServer.getInstance().send(msg);
    }

//---------------------------------
    public static function onData(tab : Array) : void {

        switch(parseInt(tab[1])){
            case 0:
                trace("waiting in queue");
                break;
            case 1:
                trace("on logged in: "+tab[2]);
                break;
            case 2:
                break;
        }
    }

    public static function connect():void{
        GameServer.getInstance().connection();
    }

    public static function onConnected():void {
        onConnectedSignal.dispatch();
        Main.instance.onConnected();
    }

    public static function onDisconnected():void {
        onDisconnectedSignal.dispatch();
    }

    public static function onConnectionProblem():void {
        onConnectionProblemSignal.dispatch();
    }


    public static function login(name:String,pass:String=""):void {
        //send ("0;0;"+heroNazwa+";"+email+";"+haslo+";"+user_id+";"+_level0.cookieOwn+";"+_level0.cookieUrl+";"+getCookieNameSWF()+";"+getVersion()+";"+escape(tab[0])+";"+escape(tab[1])+";"+new Date().getTime()+";");
        send ("0;0;"+name+";"+pass+";");
    }

    public static function joinRoomAuto():void{
        send ("0;2;");
    }



}
}
