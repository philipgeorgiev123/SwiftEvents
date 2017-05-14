//
//  SwiftEventsModuleCustomEvent.swift
//  SwiftEventsModule
//
//  Created by freezing on 03/03/2015.
//  Copyright (c) 2015 iccode. All rights reserved.
//

import UIKit
import XCTest

class SwiftEventsModuleCustomEvent: XCTestCase {
    var event : CustomEvent?
    var eventHandled : CustomEvent?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.event = CustomEvent(type: CustomEvent.CUSTOM_TYPE, customAttribute: "data")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        let view : EventDispatcher = EventDispatcher()
        view.addEventListener(CustomEvent.CUSTOM_TYPE, withFunction: handleCustomEvent)
        view.dispatchEvent(self.event!)
        
        XCTAssert(self.event === self.eventHandled, "couldn't fetch custom event")
    }
    
    func handleCustomEvent(_ e : Event)
    {
        let c : CustomEvent = e as! CustomEvent;
        self.eventHandled = c
    }

}


