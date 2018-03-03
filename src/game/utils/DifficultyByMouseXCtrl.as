/** Created by Marek Brun on 03 marzec 2018 */
package game.utils {
import flash.display.Stage;

public class DifficultyByMouseXCtrl {

	public function DifficultyByMouseXCtrl() {
		WorldTime.frameSignal.add(onWorldTime_Time);
	}

	private function onWorldTime_Time(frameTime:Number):void {
		var stage:Stage = Stage2DAbuser.getStage();
		Settings.DIFFICULTY = 1 + 4 * (stage.mouseX / stage.stageWidth);
	}

}
}
