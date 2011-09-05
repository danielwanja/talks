package test
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.async.Async;
	import org.fluint.sequence.SequenceCaller;
	import org.fluint.sequence.SequenceDelay;
	import org.fluint.sequence.SequenceEventDispatcher;
	import org.fluint.sequence.SequenceRunner;
	import org.fluint.sequence.SequenceSetter;
	import org.fluint.sequence.SequenceWaiter;
	import org.fluint.uiImpersonation.UIImpersonator;
	
	import spark.events.TextOperationEvent;

	/**
	 * See http://tutorials.digitalprimates.net/flexunit/Unit-14.html
	 */
	public class AccountCreationFormTest
	{	
		static public const LONG_TIME:Number = 1000;
		public var form:AccountCreationForm;
		
		[Before(async,ui)]
		public function setUp():void
		{
			form = new AccountCreationForm;
			Async.proceedOnEvent(this, form, FlexEvent.CREATION_COMPLETE);
			UIImpersonator.addChild(form);
		}
		
		[After(async)]
		public function tearDown():void
		{
			UIImpersonator.removeAllChildren();
			form = null;
		}

		[Test]
		public function testSubmitButtonShouldBeDisabledByDefault():void {
			assertFalse(form.create.enabled);
		}
		
		[Test(async,ui)]
		public function testPasswordShouldMatchConfirmation():void {
			var sequence:SequenceRunner = new SequenceRunner( this );
			sequence.addStep( new SequenceSetter( form.password, {text:"abc"} ) );
			sequence.addStep( new SequenceWaiter( form.password, FlexEvent.VALUE_COMMIT, LONG_TIME ) );
			sequence.addStep( new SequenceSetter( form.confirmation, {text:"def"} ) );
			sequence.addStep( new SequenceWaiter( form.confirmation, FlexEvent.VALUE_COMMIT, LONG_TIME ) );
			// Need to manually trigger change in this case?
			sequence.addStep( new SequenceEventDispatcher(  form.confirmation, new TextOperationEvent(TextOperationEvent.CHANGE) ) );
			sequence.addAssertHandler( assertPasswordShouldMatchConfirmation, null );	
			sequence.run();
		}
		
		protected function assertPasswordShouldMatchConfirmation( event:Event, passThroughData:Object ):void {
			assertEquals("Password must match confirmation.", form.confirmation.errorString);
		}
		
		[Test(async,ui)]
		public function testLoginEventDispatchedWhenUserClickCreate():void {
			form.addEventListener(CreateAccountEvent.CREATE, function (event:CreateAccountEvent):void {
				lastEvent = event;
			} );  
			
			var sequence:SequenceRunner = new SequenceRunner( this );
			sequence.addStep( new SequenceSetter( form.username, {text:"daniel"} ) );
			sequence.addStep( new SequenceWaiter( form.username, FlexEvent.VALUE_COMMIT, LONG_TIME ) );
			sequence.addStep( new SequenceSetter( form.password, {text:"abc"} ) );
			sequence.addStep( new SequenceWaiter( form.password, FlexEvent.VALUE_COMMIT, LONG_TIME ) );
			sequence.addStep( new SequenceSetter( form.confirmation, {text:"abc"} ) );
			sequence.addStep( new SequenceWaiter( form.confirmation, FlexEvent.VALUE_COMMIT, LONG_TIME ) );
			sequence.addStep( new SequenceEventDispatcher(  form.confirmation, new TextOperationEvent(TextOperationEvent.CHANGE) ) );			
			sequence.addStep( new SequenceEventDispatcher(  form.create, new MouseEvent(MouseEvent.CLICK) ) );
//			sequence.addStep( new SequenceWaiter( form, CreateAccountEvent.CREATE, LONG_TIME ) );
			sequence.addAssertHandler( assertLoginEventDispatchedWhenUserClickCreate, null );	
			
			sequence.run();

		}

		protected var lastEvent:CreateAccountEvent;
		protected function assertLoginEventDispatchedWhenUserClickCreate( event:Event, passThroughData:Object ):void {
			assertEquals("", form.username.errorString);
			assertEquals("daniel", lastEvent.username );
			assertEquals("abc", lastEvent.passworkd );
		}		
	}
}