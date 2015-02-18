//
//  CustomEvent.swift
//  SwiftEvents
//
//  Created by freezing on 18/02/2015.
//  Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

class CustomEvent : Event
{
    private struct EventTypeStruct { static var type : String = "CUSTOM_EVENT_TYPE" }
    
    class var CUSTOM_TYPE : String
    {
        get { return EventTypeStruct.type }
    }
    
    var customAttribute : String;
    
    init(attribute : String)
    {
        self.customAttribute = attribute
        super.init(type : CustomEvent.CUSTOM_TYPE)
    }
}
	