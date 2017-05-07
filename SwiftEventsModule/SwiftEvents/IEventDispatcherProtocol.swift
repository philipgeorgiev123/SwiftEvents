//
// Created by freezing on 27/01/15.
// Copyright (c) 2015 iccode ltd. All rights reserved.
//

import Foundation

public protocol IEventDispatcherProtocol : class
{
    func dispatchEvent(_ e:Event)
    func addEventListener(_ name : String, withFunction f : @escaping (Event)->())
    func removeEventListener(_ name : String)
    func removeAllListeners()
}
