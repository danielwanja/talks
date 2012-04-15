package views.v23
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectUtil;
	import mx.utils.UIDUtil;

	
	/**
	 * This class performs a serie of remote calls.
	 */	
	public class SpeedRun
	{
		public var uuid:String;
		public var complete:Boolean=true;
		public var errors:Boolean;
		public var last_response_time:Number;
		public var url:String = "http://localhost:3000";
		
		protected var chrono:Chrono;
		protected var currentCall:AsyncToken;
		protected var requestId:Number=0;
		protected var expectedDurationInSeconds:Number;
		protected var expectedIterations:Number;
		protected var iterationCounter:Number;
		protected var cancel:Boolean = false;
		protected var sizeInBytes:Number;
		
		
		protected var callbackFunction:Function;
		
		/**
		 * Note that <code>durationInSeconds</code> can be specified at the same time than <code>iteriations</code>.
		 * Specifying zero for either of these parameters will simply ignore them.
		 * 
		 * @params sizeInBytes the requested number of bytes.
		 * @params durationInSeconds the number of seconds this runs will last. Note the run only checks this parameters after a server response. Thus the run can be longer than requested duration.
		 * @params iterations the number of times the remote calls will be performed.
		 * 		 
	    */
		public function SpeedRun(sizeInBytes:Number=0, durationInSeconds:Number=0, iterations:Number=0) {
			this.uuid = UIDUtil.createUID();
			this.expectedDurationInSeconds = durationInSeconds;
			this.expectedIterations = iterations;
			this.sizeInBytes = sizeInBytes;
		}
		
		/**
		 * Provide a handler function that is invoked after each call result
		 * 
		 * @params handler the callback function to be invoked after each call result.
		 *                 the callback is in the form function(success:Boolean):void 
		 */ 
		public function setResultCallBackHandler(handler:Function):void {
			callbackFunction = handler;
		}
		
		/**
		 * Starts the run.
		 */
		public function start():void {
			stop();
			cancel = complete = errors = false;
			iterationCounter = 0;
			last_response_time = 0;
			chrono = new Chrono();
			chrono.start();
			nextCall();
		}
		
		public function setByteSize(bytes:Number):void {
			this.sizeInBytes = bytes;
		}
		
		public function get averageRpm():Number {
			return rpmForTime(iterationCounter, chrono.getRunningTime());		
		}
		
		public function get rpm():Number {
			return rpmForTime(1, last_response_time);		
		}
		
		// in: millesonds, out: request/ per second 
		protected function rpmForTime(counter:Number, responseTime:Number):Number {
			var time:Number = responseTime / 1000;
			if (cancel||complete||time==0) return 0;
			var result:Number = counter * 60 / time; 
			return Math.floor(result*1000)/1000;  // 3 decimals precision				
		}
		
		protected function nextCall():void
		{			
				sizeCall()
		}
		
		protected function sizeCall():void {
			var service:HTTPService = new HTTPService();
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.addEventListener(FaultEvent.FAULT,onFault);
			service.url = url+"/ping";
			service.resultFormat = "text";
			var params:Object = {run_id:uuid, request_id:requestId++, size:sizeInBytes, last_response_time:last_response_time};
			
			currentCall = service.send(params);
			currentCall.chrono = new Chrono();
			trace("Calling size:"+ObjectUtil.toString(params));			
		}
		
		protected function onResult(event:ResultEvent):void
		{
			last_response_time = currentCall.chrono.getRunningTime();			
			if (!cancel && 
				(expectedIterations==0 || iterationCounter++ < expectedIterations) && 
				(expectedDurationInSeconds==0 || chrono.getRunningTime() < expectedDurationInSeconds*1000) ) {
				nextCall();
			} else {
				complete = true;
			}
			if (callbackFunction!=null) callbackFunction(true);
		}
		
		protected function onFault(event:FaultEvent):void
		{
			cancel = true;
			trace(event);
			errors = true;
			if (callbackFunction!=null) callbackFunction(false);
		}
		
		/**
		 * Stops the run.
		 */
		public function stop():void {
			cancel = true;
		}
		
		public function runnig():Boolean {
			return !cancel;
		}
		
		
	}
}