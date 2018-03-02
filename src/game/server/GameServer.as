package game.server {

import flash.events.DataEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.XMLSocket;

/**
	 * @author Drygu
	 */
	public class GameServer extends XMLSocket
    {

        protected static var _instance:GameServer;

		protected var _connected:Boolean;

        protected var _nazwa : String;
        protected var _port:Number    = 8345;
		protected var _ip:String 		= "localhost";

	
		public function GameServer():void
        {
		}

        public static function getInstance():GameServer
        {
            if(_instance == null)
                _instance = new GameServer();

            return _instance;
        }

        public static function set instance(value:GameServer):void
        {
            _instance = value;
        }

        public function init(nazwa:String,ip:String,port:Number):void
        {
            this._nazwa=nazwa;
            if (ip!=null)
                this._ip=ip;
            this._port=port;

            timeout = 600 * 1000;
            addEventListener("connect", onConnect);
            addEventListener(Event.CLOSE, onClose);
            addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            addEventListener(DataEvent.DATA, onData);
            addEventListener(ProgressEvent.PROGRESS, progressHandler);
        }


        protected function closeHandler(event:Event):void
        {
           // trace("closeHandler: " + event);
        }

        protected function connectHandler(event:Event):void
        {
            //trace("connectHandler: " + event);
        }

        protected function dataHandler(event:DataEvent):void
        {
            //trace("dataHandler: " + event);
        }

        protected function ioErrorHandler(event:IOErrorEvent):void
        {
            trace("ioErrorHandler: " + event);
            ConnectionServer.onConnectionProblem();
//            MainInitializer.instance.connectingBox.onConnectionError();

        }

        protected function progressHandler(event:ProgressEvent):void {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }

        protected function securityErrorHandler(event:SecurityErrorEvent):void {
            ConnectionServer.onConnectionProblem();
            trace("securityErrorHandler: " + event);
        }




		public function connection():void
        {
            trace("connecting");
            if (!_connected)
			    this.connect(_ip,_port);
		}
		
		protected function onConnect(ok:Boolean):void
        {
			if (ok)
            {
				trace("----CONNECTED----");
//                MainInitializer.instance.onConnected();
				_connected=true;
                ConnectionServer.onConnected();
			}
            else
            {
		        trace("----SERVER TURNED OFF---- ");
			}
		}
		
		public function onClose(e:Event):void
		{
            _connected=false;
            ConnectionServer.onDisconnected();
			trace("----DISCONNECTED-----");
		}

        public function disconnect():void
        {
            close();
            onClose(null);
        }


		protected function onData(event:DataEvent) : void
        {
			var data:String=event.text;//.SOCKET_DATA;
			var tab:Array = data.split(";");
//            trace("onData: "+data);
//            trace("onData: "+tab[0]);
			switch(parseInt(tab[0]))
			{
                case 99:
                    //ping
                    break;
				case 0: //connections
                    ConnectionServer.onData(tab);
					break;
			}
		}

        public function pingSend(sredni : Number, minPing:Number, maxPing:Number) : void
        {
            super.send("98;"+sredni+";"+minPing+";"+maxPing+";");
        }


        public function ping():void{
            if (_connected)
                super.send("99;");
        }


        public function afk() : void {
            trace("-------AFK------");
            super.send("5;11;");
        }

        public function set ip(value:String):void {
            _ip = value;
        }

        public function get port():Number {
            return _port;
        }

        public function set port(value:Number):void {
            _port = value;
        }


        override public function send(object:*):void {
            if (_connected){
                super.send(object+";");
            }
        }





}
}
