//
//  237删除链表中给定的节点.swift
//  算法题
//
//  Created by edz on 2021/4/15.
//

import Foundation

/**
 237.请编写一个函数，使其可以删除某个链表中给定的（非末尾）节点。传入函数的唯一参数为 要被删除的节点 。
 提示：
 
 链表至少包含两个节点。
 链表中所有节点的值都是唯一的。
 给定的节点为非末尾节点并且一定是链表中的一个有效节点。
 不要从你的函数中返回任何结果。
 */
class DeleteNode {
    func deleteNode(_ node: ListNode?) {
        node?.val = (node?.next)!.val
        node?.next = node?.next?.next
    }
}
