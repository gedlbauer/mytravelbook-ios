//
//  OptionalExtensions.swift
//  myTravelBook
//
//  Created by Georg Edlbauer on 23.12.24.
//

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}
