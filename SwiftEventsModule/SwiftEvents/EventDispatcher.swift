//
// Created by freezing on 27/01/15.
// Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

public class EventDispatcher : IEventDispatcherProtocol {
    public func dispatchEvent(e : Event)
    {
        EventHub.instance.trigger(e);
    }
    
    public func addEventListener(name :String, withFunction f : (Event)->()) {
        EventHub.instance.addEventListener(name, withFunction: f, withDispatcher: self)
    }
    
    public func removeEventListener(name : String) {
        EventHub.instance.removeEventListener(name, withDispatcher : self)
    }
    
    func hasEventListener(name : String)-> Bool
    {
        return EventHub.instance.hasEventListener(name, withDispatcher: self)
    }
    
    public func removeAllListeners()
    {
        EventHub.instance.removeAllListeners(self)
    }
    
    deinit
    {
        removeAllListeners()	
    }
    
}
