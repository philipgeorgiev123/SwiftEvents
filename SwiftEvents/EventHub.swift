//
// Created by freezing on 19/01/15.
// Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

private let _eventHubInstance : EventHub = EventHub()

class EventHub {
    class var instance : EventHub
    {
        return _eventHubInstance;
    }
    
    private var _eventFunctionMap : [String : Array<(Event)->()>] = [String : Array<(Event)->()>]()
    
    init ()
    {
        
    }
    
    func addEventListener(name : String, withFunction f : (Event)->())
    {
        var arrayListeners : Array<(Event)->()>? = _eventFunctionMap[name]
        
        if arrayListeners==nil {
            arrayListeners = Array<(Event)->()>();
        }
        
        arrayListeners!.append(f)
        _eventFunctionMap.updateValue(arrayListeners! , forKey : name)
    }
    
    func removeEventListener(name :String, withFunction f:(Event)->())
    {
        if var arrayListeners: Array<(Event)->()> = _eventFunctionMap[name]
        {
            for (index, listener) in enumerate(arrayListeners)
            {
                
                    if unsafeBitCast(listener, AnyObject.self) === unsafeBitCast(f, AnyObject.self)
                    {
                        let element = arrayListeners.removeAtIndex(index)
                        // println(element)
                        removeEventListener(name, withFunction : f)
                        break;
                    }
                
            }
            
        }
    }
    
    func trigger(name : String, withEvent e : Event)
    {
        if let arrayListeners: Array<(Event)->()> = _eventFunctionMap[name]
        {
            for f : (Event)->() in arrayListeners
            {
                f(e)
            }
        }
    }
    

}