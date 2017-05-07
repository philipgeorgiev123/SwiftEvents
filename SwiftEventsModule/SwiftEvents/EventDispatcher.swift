//
// Created by freezing on 27/01/15.
// Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

open class EventDispatcher : NSObject , IEventDispatcherProtocol {
    open func addEventListener(_ name: String, withFunction f: @escaping (Event) -> ()) {
         EventHub.instance.addEventListener(name: name, withFunction: f, withDispatcher: self)
    }

    open func dispatchEvent(_ e : Event)
    {
        EventHub.instance.trigger(e : e);
    }
    
    open func removeEventListener(_ name : String) {
        EventHub.instance.removeEventListener(name: name, withDispatcher : self)
    }
    
    func hasEventListener(_ name : String)-> Bool
    {
        return EventHub.instance.hasEventListener(name: name, withDispatcher: self)
    }
    
    open func removeAllListeners()
    {
        EventHub.instance.removeAllListeners(dispatcher: self)
    }
    
    deinit
    {
        removeAllListeners()	
    }
    
}
