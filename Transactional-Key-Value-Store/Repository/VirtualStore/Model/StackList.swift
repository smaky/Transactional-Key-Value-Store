//
//  StackList.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import Foundation

struct StackList<T> {
    fileprivate var head: Node<T>? = nil
    private var _count: Int = 0
    init() {}

    mutating func push(element: T) {
        let node = Node<T>(data: element)
        node.next = head
        head = node
        _count += 1
    }
     
    @discardableResult
    mutating func pop() -> T? {
        if isEmpty() {
            return nil
        }
        let item = head?.data
        head = head?.next
        _count -= 1
         
        return item
    }
 
    func peek() -> T? {
        return head?.data
    }
 
    func isEmpty() -> Bool {
        return count == 0
    }
     
    var count: Int {
        return _count
    }
}
 
private class Node<T> {
    fileprivate var next: Node<T>?
    fileprivate var data: T
     
    init(data: T) {
        next = nil
        self.data = data
    }
}
