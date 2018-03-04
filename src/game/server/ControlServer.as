/**
 * Created by Drygu on 2018-03-04.
 */
package game.server {
public class ControlServer {
    public function ControlServer() {
    }

    public static function onData(tab : Array) : void {

    }

    public static function startRound():void {
        send("2;0;")
    }

    public static function reset():void {
        send("2;1;")
    }




    private static function send(msg:String):void{
        GameServer.getInstance().send(msg);
    }
}
}
