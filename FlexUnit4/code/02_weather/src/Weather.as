package
{
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	[Bindable]
	public class Weather
	{
		private var _location:String;
		private var _weather:XML;
		
		public function Weather(location:String)
		{
			this.location = location;
			load();
		}
		
		public function set weather(value:XML):void
		{
			_weather = value;
		}

		public function get location():String
		{
			return _location;
		}

		public function set location(value:String):void
		{
			_location = value;
		}

		public function load():void {
			_weather = null;
			var service:HTTPService = new HTTPService("http://www.google.com/ig/api?weather="+location);
			service.resultFormat = "e4x";
			var call:AsyncToken = service.send();
			call.addResponder(new AsyncResponder(resultHandler, faultHandler));
		}

		protected function resultHandler(event:ResultEvent, token:Object=null):void
		{  
			_weather = event.result as XML;
		}
		
		protected function faultHandler(event:FaultEvent, token:Object=null):void
		{
		}		
		
	}
}