//
//  SwiftEventsModuleTestListenOnce.swift
//  SwiftEventsModule
//
//  Created by PhilipGG on 07/05/2017.
//  Copyright © 2017 iccode. All rights reserved.
//

import XCTest

class SwiftEventsModuleTestListenOnce: XCTestCase {
    var triggered : Int = 0
    
    override func setUp() {
        super.setUp()
        
        self.triggered = 0;
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSingleListener() {
        
        let dispatcher : EventDispatcher = EventDispatcher()
        let event = Event(type : "test_event")
        
        dispatcher.addEventListenerOnce(event.type, withfunction: self.handler);
        dispatcher.dispatchEvent(event);
        dispatcher.dispatchEvent(event);
        
        XCTAssertTrue(self.triggered == 1, "Listner was not removed succesfully after first dispatch")
    }
    
    func handler(_ e : Event)
    {
        self.triggered = self.triggered+1;
    }
    
}
