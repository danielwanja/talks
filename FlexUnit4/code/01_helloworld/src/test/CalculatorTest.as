package test
{
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.onrails.model.Calculator;
	
	public class CalculatorTest
	{		
		private var calc:Calculator;
		
		[Before]
		public function setUp():void
		{
			calc = new Calculator;
		}
		
		[After]
		public function tearDown():void
		{
			calc = null
		}
		
		[Test]
		public function testAdd():void
		{
			calc.set(1);
			assertEquals(2, calc.add(1));
		}
		
		[Test]
		public function testDivide():void
		{
			calc.set(8);
			assertEquals(2, calc.divide(4));
		}

		[Test(expected="TypeError")]
		public function testDivideByZeroShouldThrowException():void
		{
			calc.set(4);
			calc.divide(0);
		}
		
		[Test]
		public function testRemove():void
		{
			calc.set(3);			
			assertEquals(2, calc.remove(1));
		}
	}
}