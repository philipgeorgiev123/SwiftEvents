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
        view1.addEventListener("handle1", withFunction: view1.handler1)
        view2.addEventListener("handle2", withFunction: view2.handler2)
        
        // adding events to external handlers
        view1.addEventListener("outerListener", withFunction : test)
        
        // view dispatching to another view
        view2.dispatchEvent(Event(type: "outerListener"))
        
        // dispatching trough the global dispatcher
        EventHub.instance.trigger(Event(type: "handle1"))
        EventHub.instance.trigger(Event(type: "handle2"))
        
        // removing all event listeners
        view1.removeEventListener("handle1")
        view2.removeEventListener("handle2")
        view1.removeEventListener("outerListener")
        
        // triger stuff
        EventHub.instance.trigger(Event(type :"outerListener"));
        view1.dispatchEvent(Event(type: "handle1"))
        view2.dispatchEvent(Event(type: "handle1"))
        
        // sorry silencio
    }
    
    func test(e : Event)
    {
        println("outerListener")
    }


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
}
