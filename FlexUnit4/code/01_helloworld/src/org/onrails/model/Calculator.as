package org.onrails.model
{
	public class Calculator
	{
		protected var total:Number = 0;;
		public function set(value:Number):void {
			total = value;
		}
		
		public function add(value:Number):Number {
			return total=total+value;
		}
		
		public function remove(value:Number):Number {
			return total=total-value;
		}
		
		public function divide(value:Number):Number {
			if (value==0) throw new TypeError("Cannot divide by Zero");
			return total=total/value;
		}
	}
}