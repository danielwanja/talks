package views.v23
{
	/**
	 * This class counts time.
	 */
	public class Chrono
	{
		private var startTime:Number=0;
		private var elapse:Number=0;
		
		public function Chrono()
		{
			start();
		}
		
		public function start():void {
			if (startTime>0) stop();
			startTime = new Date().time;	
		}
		
		public function stop():void {
 			elapse = new Date().time-startTime;
		}
		
		public function getStopTime():Number {
			return elapse;
		}
		
		public function getRunningTime():Number {
			return new Date().time-startTime;;
		}
		
	}
}