package game.utils {
public class ArrayUtils {
	private static var sortingVarName:String;

	/**
	 * @param vect - should be Vector.<T>
	 * @return
	 */
	public static function vectorToArray(vect:*):Array {
		var arr:Array = [];
		for each (var o:* in vect) {
			arr.push(o);
		}
		return arr;
	}

	/**
	 * @param array - Array or Vector
	 * @param value
	 * @return true if value was added
	 */
	public static function pushUnique(array:*, value:*):Boolean {
		if(array.indexOf(value) == -1) {
			array.push(value);
			return true;
		}
		return false;
	}

	public static function remove(array:*, value:*):Boolean {
		var i:uint, isRemove:Boolean;
		while((i = array.indexOf(value)) > -1) {
			isRemove = true;
			array.removeAt(i);
		}
		return isRemove;
	}

	public static function getRandom(arr:*):* {
		return arr[getRandomIndex(arr)];
	}

	public static function removeRandom(arr:*):* {
		var index:uint = getRandomIndex(arr);
		return arr.splice(index, 1)[0];
	}

	public static function getRandomIndex(arr:*):uint {
		return int(Math.random() * arr.length);
	}

	public static function sortOn(vect:*, varName:String):void {
		sortingVarName = varName;
		vect.sort(sortDesc);
	}

	private static function sortDesc(p1:Object, p2:Object):Number {
		var p1v:* = p1[sortingVarName];
		var p2v:* = p2[sortingVarName];
		if(p1v > p2v)
			return 1;
		else if(p1v < p2v)
			return -1;

		return 0;
	}

	public static function getNextByValue(arr:Array, value:*):* {
		return arr[getNextIndexByValue(arr, value)];
	}

	public static function getPrevByValue(arr:Array, value:*):* {
		return arr[getPrevIndexByValue(arr, value)];
	}

	public static function getNextIndexByValue(arr:Array, value:*):uint {
		return getNextIndex(arr, arr.indexOf(value));
	}

	public static function getNextIndex(arr:Array, index:uint):uint {
		if(index == arr.length - 1) {
			return 0;
		}
		return index + 1;
	}

	public static function getPrevIndexByValue(arr:Array, value:*):uint {
		return getPrevIndex(arr, arr.indexOf(value))
	}

	public static function getPrevIndex(arr:Array, index:uint):uint {
		if(index == 0) {
			return arr.length - 1;
		}
		return index - 1;
	}

	public static function clear(arr:Array):void {
		if (arr != null)
			arr.splice(0, arr.length - 1);
	}

	public static function clearVector(vec:Vector.<*>):void {
		vec.splice(0, vec.length - 1);
	}

}

}