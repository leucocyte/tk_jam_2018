/**
 * Created by Drygu on 2018-03-02.
 */
package game.server {
import game.Game;
import game.GameController;
import game.objects.Hero;
import game.objects.ObjectController;
import game.utils.Settings;

public class ActionServer {
    public function ActionServer() {
    }

    public static function onData(tab : Array) : void {

        switch(parseInt(tab[1])){
            case 0:
                ObjectController.instance().onFramePack(tab[2]);
                break;
            case 1:
                Game.instance.onInitPack(tab[2],tab[3],tab[4],parseInt(tab[5]));
//                Game.instance.onInitPack(tab[2],tab[3],tab[4]);
                break;
            case 2:
                ObjectController.instance().onNewHero(tab[2]);
                break;
            case 3:
                ObjectController.instance().onHeroRemoved(tab[2]);
                break;
            case 4:
                ObjectController.instance().onNewPump(tab[2]);
                break;
            case 5:
                GameController.getInstance().onHitMyHero(tab[2],tab[3]);
                break;
            case 6:
                ObjectController.instance().onHitEffect(parseInt(tab[2]),parseInt(tab[3]),parseInt(tab[4]));
                break;
            case 7:
                ObjectController.instance().onKillEffectPump(parseInt(tab[2]));
                break;
            case 8:
                Settings.DIFFICULTY = parseFloat(tab[2]);
                break;
            case 9:
                Game.instance.startRound();
                break;
            case 10:
                Game.instance.resetRound(tab[2]);
                break;
            case 11:
                Game.instance.trainScene.conductor.play();
                break;
            case 12:
                Game.instance.winner(tab[2]);
                break;
        }
    }



    public static function updatePosition(x:Number,y:Number,state:int,direction:int){
        send("1;1;"+int(x)+";"+int(y)+";"+state+";"+direction);
    }

    public static function hit(attackerId:Number,victimId:Number,attackType:int,direction:int){
        send("1;2;"+attackerId+";"+victimId+";"+attackType+";"+direction);
    }

    public static function killedPump():void {
        send("1;3;")
    }


    private static function send(msg:String):void{
        GameServer.getInstance().send(msg);
    }


}
}
