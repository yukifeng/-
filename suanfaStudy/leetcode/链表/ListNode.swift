//
//  ListNode.swift
//  算法题
//
//  Created by edz on 2021/4/19.
//

import Foundation

public class ListNode: CustomStringConvertible {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
    public var description: String{
        return d()
    }
    
    private func d() -> String{
        var node: ListNode? = self
        var result = ""
        while node != nil && next != nil {
            result += String(node!.val)
            node = node?.next
        }
        return result
    }
   
}
