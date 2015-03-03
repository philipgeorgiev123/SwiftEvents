//
// Created by freezing on 27/01/15.
// Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

class EventDispatcher : IEventDispatcherProtocol {
    func dispatchEvent(e : Event)
    {
        EventHub.instance.trigger(e);
    }
    
    func addEventListener(name :String, withFunction f : (Event)->()) {
        EventHub.instance.addEventListener(name, withFunction: f, withDispatcher: self)
    }
    
    func removeEventListener(name : String) {
        EventHub.instance.removeEventListener(name, withDispatcher : self)
    }
    
    func hasEventListener(name : String)-> Bool
    {
        return EventHub.instance.hasEventListener(name, withDispatcher: self)
    }
    
    func removeAllListeners()
    {
        EventHub.instance.removeAllListeners(self)
    }
    
    deinit
    {
        removeAllListeners()	
    }
    
}
