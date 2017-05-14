//
//  SwiftEventsStressTest.swift
//  SwiftEventsModule
//
//  Created by PhilipGG on 14/05/2017.
//  Copyright © 2017 iccode. All rights reserved.
//

import XCTest

class SwiftEventsStressTest: XCTestCase {
    var custom : CustomEvent?
    var customOther : CustomEvent?
    var customThird : CustomEvent?
    var compare : CustomEvent?
    var eventHandled : Event?
    var view1 : EventDispatcher = EventDispatcher()
    var view2 : EventDispatcher = EventDispatcher()
    var totalCount : Int = 100000
    var totalReceived : Int = 0
    var perfromanceCalled : Int = 0
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        // polute listner hub
        for (_) in (1...1000)
        {
            EventHub.instance.addEventListener(name: random(length: 20), withFunction: dummyListener(e:))
        }
        
        view1.addEventListener("type1", withFunction: testCallback1)
        view2.addEventListener("type2", withFunction: testCallBack2)
        
        for (_) in (1...self.totalCount)
        {
            self.view1.dispatchEvent(Event(type:"type1"))
            self.view2.dispatchEvent(Event(type:"type2"))
        }
        
        XCTAssert(totalCount*2 == totalReceived, "unable to fetch all")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            let viewPerformance = EventDispatcher()
            viewPerformance.addEventListener("performanceEvent", withFunction: self.performanceListener)
            
            for (_) in (0...self.totalCount)
            {
                EventHub.instance.trigger(e: Event(type: "performanceEvent"))
            }
        }
    }
    
    func dummyListener(e : Event)
    {
        // wont be called
    }
    
    func performanceListener(e : Event)
    {
        perfromanceCalled+=1
    }
    
    func testCallback1(e : Event)
    {
        totalReceived+=1
    }
    
    func testCallBack2(e : Event)
    {
        totalReceived+=1
    }
    
    // stakoverflowed
    func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
            
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
