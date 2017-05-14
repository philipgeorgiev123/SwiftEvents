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
    class var CUSTOM_TYPE : String
    {
        get { return "CUSTOM_EVENT_TYPE" }
    }
    
    class var CUSTOM_TYPE_OTHER : String
    {
        get {return "CUSTOM_TYPE_OTHER" }
    }
    
    class var CUSTOM_TYPE_THIRD : String
    {
        get {return "CUSTOM_TYPE_THIRD" }
    }
    
    var customAttribute : String;
    
    init(type : String, customAttribute : String)
    {
        self.customAttribute = customAttribute
        super.init(type : type)
    }
}
	
