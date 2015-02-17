//
// Created by freezing on 19/01/15.
// Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

private let _eventHubInstance : EventHub = EventHub()

class ObjectFunction {
    var listener : (Event)->()?
    var dispatcher : EventDispatcher?
    
    init(f : (Event)->(), withObject obj : EventDispatcher)
    {
        self.listener = f
        self.dispatcher = obj
    }
}

class EventHub {
    class var instance : EventHub
    {
        return _eventHubInstance;
    }
    
    private var _eventFunctionMap : [String : Array<ObjectFunction>] = [String : Array<ObjectFunction>]()
    
    init ()
    {
        
    }
    
    func addEventListener(name : String, withFunction f : (Event)->(), withDispatcher d : EventDispatcher)
    {
        if var objectListeners: Array<ObjectFunction> = _eventFunctionMap[name]
        {
            for (index, o) in enumerate(objectListeners)
            {
                if o.dispatcher === d
                {
                    println("multiple listeners are not supported by the framework :", name , " for ", d)
                    return
                }
            }
            
            objectListeners.append(ObjectFunction(f: f, withObject: d))
            _eventFunctionMap[name] = objectListeners
            
            // add it to the list if not found
        } else {
            var objectListeners = Array<ObjectFunction>()
            objectListeners.append(ObjectFunction(f: f, withObject: d))
            _eventFunctionMap[name] = objectListeners
        }
    }
    
    func removeEventListener(name :String, withDispatcher dispatcher : EventDispatcher)
    {
        if var objectListeners: Array<ObjectFunction> = _eventFunctionMap[name]
        {
            for (index, o) in enumerate(objectListeners)
            {
                // they can be only on dispatcher so bail after that
                if o.dispatcher === dispatcher
                {
                    objectListeners.removeAtIndex(index)
                    break
                }
                
            }
            
            _eventFunctionMap[name] = objectListeners
            
        }
    }
    
    func removeAllListeners(dispatcher : EventDispatcher)
    {
        for (name, var objectFunctions : Array<ObjectFunction>) in _eventFunctionMap
        {
            for (index, o) in enumerate(objectFunctions)
            {
                if (o.dispatcher === dispatcher)
                {
                    objectFunctions.removeAtIndex(index)
                    
                    if objectFunctions.count == 0
                    {
                        _eventFunctionMap.removeValueForKey(name)
                    
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
            }
        }
    }
}