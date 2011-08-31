package test
{
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	
	import test.fixtures.SenatorFixture;
	import big_app.MainHelper;
	import big_app.Model;
	
	public class MainHelperTest
	{		
		protected var model:Model;
		protected var senator:XML;
		
		[Before]
		public function setUp():void
		{
			model = new Model;
			model.loadXML(new SenatorFixture().senators);  // Synchrone!
			senator = model.list.getItemAt(0) as XML;
		}
		
		[After]
		public function tearDown():void
		{
			model = null;
			senator = null;
		}
		
		[Test]
		public function testCommitteeName():void
		{
			var committee:XML = senator.committees.committee[0];
			assertEquals("Committee on Indian Affairs", MainHelper.committeeName(committee, null));
		}
		
		[Test]
		public function testSenatorLabelFunction():void
		{
			assertEquals("Daniel K. Akaka", MainHelper.senatorLabelFunction(senator, null));
			assertEquals("", MainHelper.senatorLabelFunction(null, null));
		}
	}
}