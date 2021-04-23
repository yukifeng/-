//
//  剑指 Offer 06. 从尾到头打印链表.swift
//  算法题
//
//  Created by edz on 2021/4/21.
//

import Foundation

class ReversePrint {
    func reversePrint(_ head: ListNode?) -> [Int] {
        var list = [Int]()
        var head = head
        while head != nil {
            list.append(head!.val)
            head = head?.next
        }
        return list.reversed()
    }
}
