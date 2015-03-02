//
//  ViewController.swift
//  SwiftEvents
//
//  Created by freezing on 27/01/15.
//  Copyright (c) 2015 iccode ltd. All rights reserved.
//


class ViewController {

    func viewDidLoad() {
    // Do any additional setup after loading the view, typically from a nib.
        let view1 = DispatcherTest()
        let view2 = DispatcherTest()
        
        // adding events listeners to internal handlers
        view1.addEventListener("someEvent1", withFunction: view1.handler1)
        view1.addEventListener("someEvent2", withFunction: view1.handler2)
        view2.addEventListener("someEvent2", withFunction: view2.handler2)
        
        // view1 will not be interested in any events after this line
        view1.removeAllListeners()
        
        view1.dispatchEvent(Event(type: "someEvent1")) // won't trigger anything
        
        view1.dispatchEvent(Event(type: "someEvent2")) // executes handler 2 in view2
        
        // using the global dispatcher
        EventHub.instance.trigger(Event(type :"someEvent2")); // executes handler 2 in view2
        
        view2.removeEventListener("someEvent2")
        
        // using the global dispatcher
        EventHub.instance.trigger(Event(type :"someEvent2")); // silence, no one is interested in that event
        
        view2.addEventListener(CustomEvent.CUSTOM_TYPE, withFunction: customEventHandler)
        
        var customEvent : CustomEvent = CustomEvent(attribute: "someCustomType")
        EventHub.instance.trigger(customEvent)
        
        // too lazy to extend the EventDispatcher ?
        EventHub.instance.addEventListener("some_generic_event", withFunction: test)
        EventHub.instance.trigger(Event(type: "some_generic_event")) // --> outerListener
        EventHub.instance.removeEventListener("some_generic_event")
        EventHub.instance.trigger(Event(type: "some_generic_event")) // --> silence
        
        // test limitations here
        view1.addEventListener("test_limitations", withFunction: limitations1)
        view1.addEventListener("test_limitations", withFunction: limitations2)
        view2.addEventListener("test_limitations", withFunction: limitations2) // However this is fine
        
        EventHub.instance.trigger(Event(type:"test_limitations")) // dispatched once with warning
    }
    
    func test(e : Event)
    {
        println("outerListener")
    }
    
    func customEventHandler (e : Event)
    {
        var event : CustomEvent = e as CustomEvent
        println(event.customAttribute)
    }
    
    func limitations1(e : Event)
    {
        println("limitations1")
    }
    
    func limitations2(e : Event)
    {
        println("limitations2")
    }
}
