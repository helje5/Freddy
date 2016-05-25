//
//  Swift3.swift
//  Noze.io
//
//  Created by Helge Heß on 5/25/16.
//  Copyright © 2016 ZeeZide GmbH. All rights reserved.
//

#if swift(>=3.0) // #swift3-fd
  
public typealias ErrorType      = ErrorProtocol
public typealias BooleanType    = Boolean
public typealias CollectionType = Collection
public typealias SequenceType   = Sequence
public typealias OptionSetType  = OptionSet

#endif


// MOVE TO RIGHT PLACE

import class Foundation.NSData

public extension JSON {
  
  // TODO: remove me, just for testing
  public init(data inData: NSData) throws {
    //private init<T>(buffer: UnsafeBufferPointer<UInt8>, owner: T) {
    
    let data   = inData.copy() as! NSData
    let buffer = UnsafeBufferPointer(start: UnsafePointer<UInt8>(data.bytes),
                                     count: data.length)
    
    var parser = JSONParser(buffer: buffer, owner: data)
    self = try parser.parse()
  }
  public init<T>(data inData: NSData, usingParser dummy: T) throws {
    try self.init(data: inData)
  }
  
}

import class Foundation.NSString
import var   Foundation.NSUTF8StringEncoding

public extension JSON {
    // FIXME: this can be rewritten in generic Swift
  
    public init(jsonString: Swift.String) throws {
#if swift(>=3.0) // #swift3-fd
        let data = (jsonString as NSString).data(using: NSUTF8StringEncoding) ?? NSData()
#else
        let data = (jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding) ?? NSData()
#endif
        try self.init(data: data)
    }
  
}

public extension JSONParser {

#if swift(>=3.0) // #swift3-1st-kwarg
  public static func createJSONFromData(_ data: NSData) throws -> JSON {
    return try JSON(data: data)
  }
#else
  public static func createJSONFromData(data: NSData) throws -> JSON {
    return try JSON(data: data)
  }
#endif
}

public extension JSONParser {

    /// Creates a `JSONParser` ready to parse UTF-8 encoded `NSData`.
    ///
    /// If the data is mutable, it is copied before parsing. The data's lifetime
    /// is extended for the duration of parsing.
    init(utf8Data inData: NSData) {
        let data = inData.copy() as! NSData
        let buffer = UnsafeBufferPointer(start: UnsafePointer<UInt8>(data.bytes), count: data.length)
        self.init(buffer: buffer, owner: data)
    }

}

