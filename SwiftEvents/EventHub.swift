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
        var arrayListeners : Array<ObjectFunction>? = _eventFunctionMap[name]
        
        if arrayListeners==nil {
            arrayListeners = Array<ObjectFunction>();
        }
        
        arrayListeners?.append(ObjectFunction(f: f, withObject: d))
        _eventFunctionMap[name] = arrayListeners
    }
    
    func removeEventListener(name :String, withDispatcher dispatcher : EventDispatcher)
    {
        if var objectListeners: Array<ObjectFunction> = _eventFunctionMap[name]
        {
            for (index, o) in enumerate(objectListeners)
            {
                if o.dispatcher === dispatcher
                {
                    objectListeners.removeAtIndex(index)
                }
            }
            
            _eventFunctionMap[name] = objectListeners
            
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