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
        
        view1.addEventListener("handle1", withFunction: view1.handler1)
        view2.addEventListener("handle2", withFunction: view2.handler2)
        
        
        EventHub.instance.trigger(Event(type: "handle1"))
        EventHub.instance.trigger(Event(type: "handle2"))
        
        view1.removeEventListener("handle1")
        view2.removeEventListener("handle2")
        
        EventHub.instance.trigger(Event(type :"handle1"));
        
        
        println("WOHHAAA !")
    }


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }




}
