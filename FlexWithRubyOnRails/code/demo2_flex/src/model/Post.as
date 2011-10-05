package model
{
	import active_resource.ActiveResource;
	
	// [Bindable]
	dynamic public class Post extends ActiveResource
	{
		public function Post(attributes:Object=null)
		{
			super(attributes);
		}
		
		public var id:*;
		public var title:String;
		public var body:String;
		public var created_at:Date;
		public var updated_at:Date;
		
		/* static block */               resource("posts", Post);    		
	}
}