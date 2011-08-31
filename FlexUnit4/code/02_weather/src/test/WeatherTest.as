package test
{
	import flash.events.IEventDispatcher;
	
	import flexunit.framework.Assert;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.PropertyChangeEvent;
	
	import org.flexunit.async.Async;
	
	public class WeatherTest
	{		
		protected var weather:Weather;
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(async)]
		public function testSetWeather():void
		{
			var weather:Weather = new Weather("Denver");
			(weather as IEventDispatcher).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, 
				Async.asyncHandler(this, weatherChanged, 1500));
			//BindingUtils.bindSetter(Async.asyncHandler(this, setWeather, 1500), weather, "weather");
		}
		
		protected function weatherChanged(event:PropertyChangeEvent):void {
			trace(event);
		}
		protected function setWeather(value:Object):void
		{
			trace(value);
		}
	}
}