package model
{
	[RemoteClass(alias="model.Post")] 
	public class Post
	{
		public var id:int;
		public var title:String;
		public var body:String;
		public var created_at:Date;
		public var updated_at:Date;
		public var comments:Array = [];
		
		[Transient] public var test:String = 'tested';
		
	}
}