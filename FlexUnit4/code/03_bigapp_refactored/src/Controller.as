package
{
	import mx.controls.Alert;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import big_app.Model;
	import big_app.ServiceLocator;

	public class Controller
	{
		protected var services:ServiceLocator;
		
		[Bindable] public var model:Model;		
		public function Controller(model:Model, services:ServiceLocator)
		{
			this.model = model; // Use Injection instead
			this.services = services;
		}
		
		// This could have a MessageHandler in Swiz or be a command in RobotsLegs
		public function loadSenators():void {
			model.lastError = null;
			var call:AsyncToken = services.memberList.send({});
			call.addResponder(new AsyncResponder(resultHandler, faultHandler));
		}
		
		protected function resultHandler(event:ResultEvent, token:Object=null):void
		{
			model.loadXML(event.result as XML);
		}
		
		protected function faultHandler(event:FaultEvent, token:Object=null):void
		{
			alert("Failed to load list");
		}			
			
		public function alert(message:String):void {
			model.lastError = message;
			Alert.show(message);
		}
		
	}
}