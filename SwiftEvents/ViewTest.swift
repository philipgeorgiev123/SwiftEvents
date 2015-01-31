//
//  ViewTest.swift
//  SwiftEvents
//
//  Created by freezing on 27/01/2015.
//  Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

class ViewTest : View
{
    override init() {
        super.init()
        addEventListener("test", withFunction : test)
    }
    
    func test(e : Event)->()
    {
        println("execute test")
    }
}