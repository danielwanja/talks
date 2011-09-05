package
{
	import flash.events.Event;
	
	public class CreateAccountEvent extends Event
	{
		static public const CREATE:String = "createAccountEvent";
		
		public var username:String;
		public var passworkd:String;
		
		public function CreateAccountEvent(type:String, username:String, password:String)
		{
			super(type, true, true);
			this.username = username;
			this.passworkd = password;
		}
	}
}