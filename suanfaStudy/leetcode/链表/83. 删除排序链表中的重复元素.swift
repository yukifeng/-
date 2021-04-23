//
//  83. 删除排序链表中的重复元素.swift
//  算法题
//
//  Created by edz on 2021/4/15.
//

import Foundation

/**
 存在一个按升序排列的链表，给你这个链表的头节点 head ，请你删除所有重复的元素，使每个元素 只出现一次 。

 返回同样按升序排列的结果链表。
 链表中节点数目在范围 [0, 300] 内
 -100 <= Node.val <= 100
 题目数据保证链表已经按升序排列
 */
class DeleteDuplicates {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        let sentail = ListNode()
        sentail.val = -101
        sentail.next = head
        
        var prev = sentail, current = head
        while current != nil {
            if current?.val == prev.val{
                prev.next = current?.next
            }else{
                prev = current!
            }
            current = current?.next
        }
        
        return sentail.next
    }
}
