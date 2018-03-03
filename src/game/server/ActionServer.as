/**
 * Created by Drygu on 2018-03-02.
 */
package game.server {
import game.Game;
import game.GameController;
import game.objects.Hero;
import game.objects.ObjectController;

public class ActionServer {
    public function ActionServer() {
    }

    public static function onData(tab : Array) : void {

        switch(parseInt(tab[1])){
            case 0:
                ObjectController.instance().onFramePack(tab[2]);
                break;
            case 1:
                Game.instance.onInitPack(tab[2],tab[3],tab[4]);
//                Game.instance.onInitPack(tab[2],tab[3],tab[4]);
                break;
            case 2:
                ObjectController.instance().onNewHero(tab[2]);
                break;
            case 3:
                ObjectController.instance().onHeroRemoved(tab[2]);
                break;
            case 4:
                ObjectController.instance().onNewObstacle(tab[2]);
                break;
            case 5:
                GameController.getInstance().onHit(tab[2],tab[3]);
                break;
        }
    }



    public static function updatePosition(x:Number,y:Number,state:int,direction:int){
        send("1;1;"+int(x)+";"+int(y)+";"+state+";"+direction);
    }

    public static function hit(attackerId:Number,victimId:Number,attackType:int,direction:int){
        send("1;2;"+attackerId+";"+victimId+";"+attackType+";"+direction);
    }

    private static function send(msg:String):void{
        GameServer.getInstance().send(msg);
    }
}
}
