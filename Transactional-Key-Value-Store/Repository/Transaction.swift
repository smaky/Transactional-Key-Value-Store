//
//  Transaction.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

final public class Transaction: NSObject, NSCopying, NSSecureCoding {
    private static var codingKey = "bucket"
    public static var supportsSecureCoding: Bool = true
    private var bucket: Dictionary<String, String> = [:]
    
    public init?(coder: NSCoder) {
        bucket = coder.decodeObject(of: [NSDictionary.self, NSString.self], forKey: Self.codingKey) as! Dictionary<String, String>? ?? [:]
    }
    
    public override init() {}
    
    private init(bucket: Dictionary<String, String>) {
        self.bucket = bucket
    }
    
    func set(value: String, for key: String) {
        bucket[key] = value
    }
    
    func delete(for key: String) {
        bucket[key] = nil
    }
    
    func getValue(for key: String) -> String? {
        return bucket[key]
    }
    
    func count(value: String) -> Int? {
        bucket.filter { $0.value == value }.count
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return Transaction(bucket: bucket)
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(bucket as NSDictionary, forKey: Self.codingKey)
    }
    
}
