//
//  ViewController.swift
//  SwiftEvents
//
//  Created by freezing on 27/01/15.
//  Copyright (c) 2015 iccode ltd. All rights reserved.
//


import UIKit


class ViewController: UIViewController {


    override func viewDidLoad() {
    super.viewDidLoad()
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
        
        // using the global dispatcher/Users/freezing/projects/SwiftEvents/README.md
        EventHub.instance.trigger(Event(type :"someEvent2")); // silence, no one is interested in that event
        
        // custom events (supporting custom data)
        view2.addEventListener(CustomEvent.CUSTOM_TYPE, withFunction: customEventHandler)
        
        var customEvent : CustomEvent = CustomEvent(attribute: "someCustomType")
        EventHub.instance.trigger(customEvent)
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


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
}
