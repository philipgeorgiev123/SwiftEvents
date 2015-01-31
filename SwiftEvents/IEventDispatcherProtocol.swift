//
// Created by freezing on 27/01/15.
// Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

protocol IEventDispatcherProtocol
{
    func dispatchEvent(e:Event)
    func addEventListener(name : String, withFunction f : (Event)->())
    func removeEventListener(name : String)
}