//
//  2. 两数相加.swift
//  算法题
//
//  Created by edz on 2021/4/19.
//

import Foundation
/**
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。

 请你将两个数相加，并以相同形式返回一个表示和的链表。

 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/add-two-numbers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[7,0,8]
 解释：342 + 465 = 807.
 示例 2：

 输入：l1 = [0], l2 = [0]
 输出：[0]
 示例 3：

 输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 输出：[8,9,9,9,0,0,0,1]
  

 提示：

 每个链表中的节点数在范围 [1, 100] 内
 0 <= Node.val <= 9
 题目数据保证列表表示的数字不含前导零

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/add-two-numbers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class AddTwoNumbers {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var head: ListNode? = nil
        var tail: ListNode? = nil
        var left = l1, right = l2
        var temp = 0
        var sum = 0
        
        // [9,9,9,9,9,9,9]
        // [9,9,9,9]
        
        
        // [2,4,3]
        // [5,6,4]
        // [7,0,8]
        while left != nil || right != nil {
            sum = (left?.val ?? 0) + (right?.val ?? 0) + temp
            if head == nil {
                tail = ListNode(sum % 10)
                head = tail
            }else{
                tail?.next = ListNode(sum % 10)
                tail = tail?.next
            }
            
            temp = sum / 10
            
            left = left?.next
            right = right?.next
            // 8,9,9,9,
            print("")
        }
        
        if temp > 0 {
            tail?.next = ListNode(temp)
        }
        
        return head
    }
}

