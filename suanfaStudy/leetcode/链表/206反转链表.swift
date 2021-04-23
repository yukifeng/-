//
//  206反转链表.swift
//  算法题
//
//  Created by edz on 2021/4/15.
//

import Foundation

  
 
class ReverseList {
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let newHead = reverseList(head?.next)
        head?.next?.next = head
        head?.next = nil
        
        return newHead
    }
}
