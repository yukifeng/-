//
//  203. 移除链表元素.swift
//  算法题
//
//  Created by edz on 2021/4/15.
//

import Foundation

class RemoveElements {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        if head == nil {
            return head
        }
        
        let sentinel = ListNode()
        sentinel.next = head
        var prev = sentinel, current = head
        while current != nil {
            if current?.val == val {
                prev.next = current?.next
            }else{
                prev = current!
            }
            current = current?.next
        }
        
        return sentinel.next
    }
}
