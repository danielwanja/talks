package test
{
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.hamcrest.collection.hasItems;
	import test.fixtures.SenatorFixture;
	import big_app.Model;
	
	public class ModelTest
	{		
		protected var model:Model;
		
		[Before]
		public function setUp():void
		{
			model = new Model;
			model.loadXML(new SenatorFixture().senators);  // Synchrone!
		}
		
		[After]
		public function tearDown():void
		{
			model = null;
		}
		
		[Test]
		public function testLoadXML():void
		{
			assertEquals(100, model.list.length);
			assertEquals(0, model.committees.length);
		}
		
		[Test]
		public function testSelectedSenator():void
		{
			model.selectedSenator = model.list.getItemAt(0) as XML;
			assertEquals(5, model.committees.length);
			assertEquals("Committee on Indian Affairs", model.committees.getItemAt(0).toString());
			assertEquals("Chairman", model.committees.getItemAt(0).@position);
		}
		
		[Test]
		public function testStateFilter():void
		{
			model.stateFilter = "CO";
			assertEquals(2, model.list.length);
			var senatorNames:Array = [model.list.getItemAt(0).name.last, model.list.getItemAt(1).name.last];
			assertThat(senatorNames, hasItems("Bennet", "Udall"));
		}
	}
}