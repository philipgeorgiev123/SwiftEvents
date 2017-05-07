//
// Created by freezing on 19/01/15.
// Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

private let _eventHubInstance : EventHub = EventHub()
private let _eventHubListener : EventDispatcher = EventDispatcher()

// class definition to capture event->function relationship
class ObjectFunction {
    var listener : (Event)->()
    var dispatcher : IEventDispatcherProtocol
    var isOnce : Bool
    
    init(f : @escaping (Event)->(),obj : IEventDispatcherProtocol, isOnce : Bool = false)
    {
        self.listener = f
        self.dispatcher = obj
        self.isOnce = isOnce
    }
}

public class EventHub {
    class var instance : EventHub
    {
        return _eventHubInstance
    }
    
    class var listener : IEventDispatcherProtocol
    {
        return _eventHubListener
    }
    
    var _eventFunctionMap : [String : Array<ObjectFunction>] = [String : Array<ObjectFunction>]()
    
    init ()
    {
        
    }
    
    func addEventListener(name : String, withFunction f : @escaping (Event)->())
    {
        addEventListener(name: name, withFunction: f, withDispatcher: _eventHubListener)
    }
    
    func addEventListenerOnce(name : String,
                              withFunction f : @escaping (Event)->(),
                              withDispatcher d : IEventDispatcherProtocol) {
        addEventListener(name: name, withFunction: f, withDispatcher: d, isOnce: true)
    }
    
    func addEventListener(name : String,
                          withFunction f : @escaping (Event)->(),
                          withDispatcher d : IEventDispatcherProtocol,
                          isOnce : Bool = false
        )
    {
        if var objectListeners: Array<ObjectFunction> = _eventFunctionMap[name]
        {
            for (_, o) in objectListeners.enumerated()
            {
                if o.dispatcher === d
                {
                    print("multiple listeners are not supported by the framework :", name , " for ", d)
                    return
                }
            }
            
            objectListeners.append(ObjectFunction(f: f, obj: d, isOnce : isOnce))
            _eventFunctionMap[name] = objectListeners
            
            // add it to the list if not found
        } else {
            var objectListeners = Array<ObjectFunction>()
            objectListeners.append(ObjectFunction(f: f, obj: d, isOnce : isOnce))
            _eventFunctionMap[name] = objectListeners
        }
    }
    
    func removeEventListener(name:String)
    {
        removeEventListener(name: name, withDispatcher: _eventHubListener)
    }
    
    func removeEventListener(name :String, withDispatcher dispatcher : IEventDispatcherProtocol)
    {
        if var objectListeners: Array<ObjectFunction> = _eventFunctionMap[name]
        {
            for (index, o) in objectListeners.enumerated()
            {
                // they can be only on dispatcher so bail after that
                if o.dispatcher === dispatcher
                {
                    objectListeners.remove(at:index)
                    break
                }
            }
            
            _eventFunctionMap[name] = objectListeners
            
        }
    }
    
    func hasEventListener(name : String, withDispatcher d : IEventDispatcherProtocol)->Bool
    {
        if let objectListeners: Array<ObjectFunction> = _eventFunctionMap[name]
        {
            for (_ , o) in objectListeners.enumerated()
            {
                if o.dispatcher === d
                {
                    return true
                }
            }
        }
        return false
    }
    
    func removeAllListeners()
    {
        removeAllListeners(dispatcher: _eventHubListener)
    }
    
    func removeAllListeners(dispatcher : IEventDispatcherProtocol)
    {
        for (name, var objectFunctions) in _eventFunctionMap
        {
            for (index, o) in objectFunctions.enumerated()
            {
                if (o.dispatcher === dispatcher)
                {
                    objectFunctions.remove(at:index)
                    
                    if objectFunctions.count == 0
                    {
                        _eventFunctionMap.removeValue(forKey:name)
                    
                    } else
                    {
                        _eventFunctionMap[name] = objectFunctions
                    }
                    break
                }
            }
        }
    }
    
    func trigger(e : Event)
    {
        if let arrayListeners: Array<ObjectFunction> = _eventFunctionMap[e.type]
        {
            for o : ObjectFunction in arrayListeners
            {
                o.listener(e)
                
                if (o.isOnce)
                {
                    removeEventListener(name: e.type, withDispatcher: o.dispatcher)
                    o.isOnce = false
                }
            }
        }
    }
}
