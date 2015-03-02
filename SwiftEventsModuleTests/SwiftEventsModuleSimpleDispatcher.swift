//
//  SwiftEventsModuleTests.swift
//  SwiftEventsModuleTests
//
//  Created by freezing on 01/03/2015.
//  Copyright (c) 2015 iccode. All rights reserved.
//

import UIKit
import XCTest

class SwiftEventsModuleSimpleDispatcher: XCTestCase {
    var event : Event?
    var eventHandled : Event?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.event = Event(type: "test_handler_event")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDispatchingEvent() {
        // This is an example of a functional test case.
        var dispatcher : EventDispatcher = EventDispatcher()
        dispatcher.addEventListener("test_handler_event", withFunction: handler)
        EventHub.instance.trigger(self.event!)
        XCTAssert(event === eventHandled, "Handled event should execute and match the dispatched event")
    }
    
    func handler(e : Event) -> ()
    {
        eventHandled = e
    }
    
}
