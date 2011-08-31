

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import mx.core.IPropertyChangeNotifier;
import mx.events.PropertyChangeEvent;
import mx.utils.ObjectProxy;
import mx.utils.UIDUtil;

import flexunit.flexui.FlexUnitTestRunnerUI;

class BindableProperty
{
	/*
	 * generated bindable wrapper for property testRunner (public)
	 * - generated setter
	 * - generated getter
	 * - original public var 'testRunner' moved to '_1699928674testRunner'
	 */

    [Bindable(event="propertyChange")]
    public function get testRunner():flexunit.flexui.FlexUnitTestRunnerUI
    {
        return this._1699928674testRunner;
    }

    public function set testRunner(value:flexunit.flexui.FlexUnitTestRunnerUI):void
    {
    	var oldValue:Object = this._1699928674testRunner;
        if (oldValue !== value)
        {
            this._1699928674testRunner = value;
           if (this.hasEventListener("propertyChange"))
               this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "testRunner", oldValue, value));
        }
    }



}
