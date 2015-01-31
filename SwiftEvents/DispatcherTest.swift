//
//  ViewTest.swift
//  SwiftEvents
//
//  Created by freezing on 27/01/2015.
//  Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

class DispatcherTest : EventDispatcher
{
    override init() {
        super.init()
    }
    
    func handler1(e : Event)->()
    {
        println("execute handler1")
    }
    
    func handler2(e : Event)->()
    {
        println("execute handler2")
    }
}