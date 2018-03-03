package game.utils {
import flash.utils.Dictionary;

public class ObjectPooling {

	public static const dictType_Pooling:Dictionary = new Dictionary();
	private var _dictObj_IsRecycled:Dictionary = new Dictionary(true);
	private var _type:Class;
	private var _bin:Vector.<Object> = new <Object>[];
	private var _countRecycle:Number = 0;
	private var _countNew:Number = 0;
	private var _countGett:Number = 0;

	/**
	 * Universal object poling for objects with no arguments in constructors.
	 * @param Type - class (constructor) you want to pool
	 */
	public function ObjectPooling(Type:Class) {
		this._type = Type;
	}

	public function justCreate():* {
		return new _type();
	}

	public function gett():* {
		_countGett++;
		if(_bin.length) {
			var obj:* = _bin.pop();
			delete _dictObj_IsRecycled[obj];
			//if (obj is IResetable) IResetable(obj).reset();
			return obj
		}
		_countNew++;
		return new _type()
	}

	public function recycle(obj:Object):void {
		if(Object(obj).constructor != _type)
			throw new ArgumentError("Wrong class type of passed object");

		if(_dictObj_IsRecycled[obj]) {
			//throw new ArgumentError("obj is already recycled");
			//GlobalDbg.d.logv(' pool ' + _name + ' ' + htmlRedB('WARN: obj is already recycled'));
		}
		_dictObj_IsRecycled[obj] = true;
		_bin.push(obj);
		_countRecycle++;
	}

	public function recycleArr(arr:Array):void {
		var obj:Object;
		while(arr.length) {
			obj = arr.pop();
			// if (Object(obj).constructor != Type) throw new ArgumentError("Wrong class type of passed object");
			if(_dictObj_IsRecycled[obj]) {
				throw new ArgumentError("obj is already recycled");
				//GlobalDbg.d.logv(' pool ' + _name + ' ' + htmlRedB('WARN: obj is already recycled'))
			}
			_dictObj_IsRecycled[obj] = true;
			_bin.push(obj);
			_countRecycle++
		}
	}

	public static function forType(typ:Class):ObjectPooling {
		if(!dictType_Pooling[typ]) {
			dictType_Pooling[typ] = new ObjectPooling(typ);
		}
		return ObjectPooling(dictType_Pooling[typ])
	}
}
}
