package big_app
{
	import spark.components.gridClasses.GridColumn;

	public class MainHelper
	{
		static public function senatorLabelFunction(item:Object, column:GridColumn):String {
			return item ? item.name.first+" "+item.name.last : "";	
		}
		static public function committeeName(item:Object, column:GridColumn):String {
			return item.toString();
		}
	}
}