//
//  JSONParsing.swift
//  Freddy
//
//  Created by Matthew D. Mathias on 3/17/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

import Foundation

// MARK: - Deserialize JSON

/// Protocol describing a backend parser that can produce `JSON` from `NSData`.
public protocol JSONParserType {

    /// Creates an instance of `JSON` from `NSData`.
    /// - parameter data: An instance of `NSData` to use to create `JSON`.
    /// - throws: An error that may arise from calling `JSONObjectWithData(_:options:)` on `NSJSONSerialization` with the given data.
    /// - returns: An instance of `JSON`.
    static func createJSONFromData(data: NSData) throws -> JSON

}
#if swift(>=3.0) // #swift3-1st-arg
extension JSONParserType {
  static func createJSONFromData(_ data: NSData) throws -> JSON {
    return try createJSONFromData(data: data)
  }
}
#endif

extension JSON {

    /// Create `JSON` from UTF-8 `data`. By default, parses using the
    /// Swift-native `JSONParser` backend.
    public init(data: NSData, usingParser parser: JSONParserType.Type = JSONParser.self) throws {
        self = try parser.createJSONFromData(data)
    }

    /// Create `JSON` from UTF-8 `string`.
    public init(jsonString: Swift.String, usingParser parser: JSONParserType.Type = JSONParser.self) throws {
#if swift(>=3.0) // #swift3-fd
        self = try parser.createJSONFromData((jsonString as NSString).data(using: NSUTF8StringEncoding) ?? NSData())
#else
        self = try parser.createJSONFromData((jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding) ?? NSData())
#endif
    }
}
