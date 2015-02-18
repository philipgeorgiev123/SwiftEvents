# SwiftEvents
Coming from actionscript 3 i have decided to integrate event system into swift. Since swift does not support function pointers, it was required to change the passing also the object self.

Extend the EventDispatcher into your dispatching classes. Also you can implement the IEventDispatcherProtocol into any classes for example any views that cannot extend the EventDispatcher.

Usage : 

	1. Adding events listeners to internal handlers
       
	view1.addEventListener("someEvent1", withFunction: view1.handler1)
        view1.addEventListener("someEvent2", withFunction: view1.handler2)
        view2.addEventListener("someEvent2", withFunction: view2.handler2)
        
        2. View1 will not be interested in any events after this line
        view1.removeAllListeners()
        
	3. Triggering events
        view1.dispatchEvent(Event(type: "someEvent1")) // won't trigger anything
        view1.dispatchEvent(Event(type: "someEvent2")) // executes handler 2 in view2
        
        4. We can use the global dispatcher
        EventHub.instance.trigger(Event(type :"someEvent2")); // executes handler 2 in view2
        
	5. Removing just one event type from the listening
        view2.removeEventListener("someEvent2")
        
        6. Using the global dispatcher again ( just to check if we have removed it )
        EventHub.instance.trigger(Event(type :"someEvent2")); // silence, no one is interested in that event
        
        7. Custom events (supporting custom data)
        view2.addEventListener(CustomEvent.CUSTOM_TYPE, withFunction: customEventHandler)
        
        var customEvent : CustomEvent = CustomEvent(attribute: "someCustomType")
        EventHub.instance.trigger(customEvent)

Limitations :

Since swift cannot compare the pointers of functions it is not possible to have two different handlers for one event type for one object.

Example : Have only one handler per event type per object, the following example will not work. Only the first handler should trigger.
	view1.addEventListener("someEvent1", withFunction: view1.handler1)
	view1.addEventListener("someEvent1", withFunction: view1.handler2)	

