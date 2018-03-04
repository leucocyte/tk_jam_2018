/**
 * Created by Drygu on 2018-03-04.
 */
package game {
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import game.server.ControlServer;
import game.utils.Stage2DAbuser;

public class AdminControlPanel {
    public function AdminControlPanel() {
        Stage2DAbuser.getStage().addEventListener(KeyboardEvent.KEY_DOWN, onKeyEventHandler);
    }

    private function onKeyEventHandler(e:KeyboardEvent):void {
            switch (e.keyCode) {
                case Keyboard.NUMBER_1:
                    ControlServer.startRound();
                    break;
                case Keyboard.NUMBER_0:
                    ControlServer.reset();
                    break;
            }

    }

}
}
