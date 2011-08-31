package big_app
{
	import mx.rpc.http.HTTPService;

	public class ServiceLocator
	{
		public var memberList:HTTPService;
		public function ServiceLocator()
		{
		}
		
		public function setup():void {
			memberList = new HTTPService();
			memberList.url = "http://www.senate.gov/legislative/LIS_MEMBER/cvc_member_data.xml";
			memberList.resultFormat = "e4x";				
		}
	}
}