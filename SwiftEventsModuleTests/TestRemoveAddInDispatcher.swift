//
//  TestRemoveAddInDispatcher.swift
//  SwiftEventsModule
//
//  Created by PhilipGG on 13/05/2017.
//  Copyright © 2017 iccode. All rights reserved.
//

import XCTest

class TestRemoveAddInDispatcher: XCTestCase {
    var custom : CustomEvent?
    var customOther : CustomEvent?
    var customThird : CustomEvent?
    var compare : CustomEvent?
    var eventHandled : Event?
    var view : EventDispatcher = EventDispatcher()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.custom = CustomEvent(type: CustomEvent.CUSTOM_TYPE, customAttribute: "data1" )
        self.customOther = CustomEvent(type: CustomEvent.CUSTOM_TYPE_OTHER, customAttribute: "data2" )
        self.customThird = CustomEvent(type: CustomEvent.CUSTOM_TYPE_THIRD, customAttribute: "data3" )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddRemoveInDispatcher() {
        view.addEventListener(CustomEvent.CUSTOM_TYPE, withFunction: handleCustomEvent)
        view.addEventListener(CustomEvent.CUSTOM_TYPE_OTHER, withFunction: handleCustomOther)
        view.addEventListener(CustomEvent.CUSTOM_TYPE_THIRD, withFunction: handleCustomOther)
        
        view.dispatchEvent(self.custom!)
        view.dispatchEvent(self.customThird!)
        
        XCTAssert(self.compare === self.customThird, "Events are not matching, removing events in dispatcher seem to break the loop" )
    }
    
    func handleCustomEvent(_ e : Event)
    {
        let c : CustomEvent = e as! CustomEvent
        self.eventHandled = c
        
        // trying to remove events to see if the cycling will break the loop
        view.removeEventListener(CustomEvent.CUSTOM_TYPE)
        view.removeEventListener(CustomEvent.CUSTOM_TYPE_OTHER)
    }
    
    func handleCustomOther(_ e : Event)
    {
        self.compare = e as? CustomEvent
    }
}
