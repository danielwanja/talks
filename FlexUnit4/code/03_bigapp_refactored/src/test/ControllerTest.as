package test
{
	import mockolate.runner.MockolateRunner; 
	MockolateRunner;
	
	import flash.events.Event;
	
	import flashx.textLayout.debug.assert;
	
	import flexunit.framework.Assert;
	
	import mockolate.mock;
	import mockolate.prepare;
	
	import mx.events.PropertyChangeEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.async.Async;
	
	import test.fixtures.SenatorFixture;
	import mx.rpc.AsyncToken;
	import mockolate.stub;
	import big_app.Model;
	import big_app.ServiceLocator;
	import org.hamcrest.object.nullValue;
	import org.flexunit.asserts.assertNull;
	
	/**
	 * http://mockolate.org/stubbing_and_mocking.html
	 * http://groups.google.com/group/mockolate
	 * Can only mock instances...
	 * 
	 * mock(flavour).method("combine").args(yummy);
	 * stub(flavour).getter("name").returns("Butterscotch");
	 * stub(flavour).setter("name").arg(true);
	 * stub(flavour).method("toString").returns("Butterscotch");
	 * 
	 * mock(httpService).asHTTPService().method("GET").send(hasProperties({command : "time"})).result(expectedData);
	 */
	[RunWith("mockolate.runner.MockolateRunner")]
	public class ControllerTest
	{		
		protected var model:Model;
		protected var services:ServiceLocator;
		protected var controller:Controller;
		
		// see http://mockolate.org/preparing_and_creating_easier.html
		[Mock] public var memberList:HTTPService;
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			model = new Model();
			services = new ServiceLocator();
			services.memberList = memberList;
			controller = new Controller(model, services);			
		}
		
		[After]
		public function tearDown():void
		{
		}

		
		[Test(async)]
		public function testLoadSenators():void
		{
			mock(services.memberList)
					.asHTTPService()
						.send({})   // TODO: figure out how to get matcher working without params?
						.result(new SenatorFixture().senators);
			Async.handleEvent(this, model, PropertyChangeEvent.PROPERTY_CHANGE, function(event:Event, data:Object):void {
				assertNotNull(model.list);
				assertEquals(100, model.list.length);
			});
			controller.loadSenators();
		}
		
		[Test(async)]
		public function testLoadSenatorsFailure():void
		{
			mock(services.memberList)
			.asHTTPService()
				.send({}) 
				.fault("error", "error", "error")
			Async.handleEvent(this, model, PropertyChangeEvent.PROPERTY_CHANGE, function(event:Event, data:Object):void {
				assertNull(model.list);
				assertEquals("Failed to load list", model.lastError);
			});
			controller.loadSenators();
		}
		
	}
}