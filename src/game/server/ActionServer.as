/**
 * Created by Drygu on 2018-03-02.
 */
package game.server {
public class ActionServer {
    public function ActionServer() {
    }

    public static function onData(tab : Array) : void {

        switch(parseInt(tab[1])){
            case 0:
                trace("waiting in queue");                break;
            case 1:
                trace("on logged in: "+tab[2]);
                break;
            case 2:
                break;
        }
    }

    public static function updatePosition(x:Number,y:Number,state:int){

    }
}
}
