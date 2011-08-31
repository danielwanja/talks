package big_app
{
	import mx.collections.ListCollectionView;
	import mx.collections.XMLListCollection;

	[Bindable]
	public class Model
	{
		public var list:ListCollectionView;
		public var committees:ListCollectionView;
		
		protected var _selectedSenator:XML;
		protected var _stateFilter:String="";
		public var lastError:String;
		
		public function get selectedSenator():XML
		{
			return _selectedSenator;
		}

		public function set selectedSenator(value:XML):void
		{
			_selectedSenator = value;
			committees = new XMLListCollection(_selectedSenator ? _selectedSenator.committees.committee : null);
		}

		public function get stateFilter():String
		{
			return _stateFilter;
		}

		public function set stateFilter(value:String):void
		{
			_stateFilter = value;
			if (list) list.refresh();
		}

		public function loadXML(xml:XML):void {
			list = new XMLListCollection(xml.senator);
			list.filterFunction = filterByState;
			list.refresh();	
			committees = new XMLListCollection();
		}
		
		protected function filterByState(item:Object):Boolean {
			return stateFilter == "" || item.state.toString() == stateFilter;
		}

	}
}