//
//  WeakContainer.swift
//  RedditCommon
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

public class WeakContainer<T> {
    private weak var _value: AnyObject?
    public var value: T? {
        set { self._value = newValue as AnyObject }
        get { _value as? T }
    }
    
    public init(value: T) {
        self._value = value as AnyObject
    }
}
