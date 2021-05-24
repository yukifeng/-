//
//  File.swift
//  suanfaStudy
//
//  Created by edz on 2021/5/18.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 * 翻转一棵二叉树。
 
 示例：

 输入：

    4
    /   \
   2     7
  / \   / \
 1   3 6   9
 输出：

    4
    /   \
   7     2
  / \   / \
 9   6 3   1

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/invert-binary-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class InvertTree {
    func invertTree(_ root: TreeNode<Int>?) -> TreeNode<Int>? {
        let queue = Queue<TreeNode<Int>>()
        if root == nil {
            return nil
        }
        queue.offer(root!)
        
        while !queue.isEmpty() {
            let node = queue.poll()
            if node!.left != nil {
                queue.offer(node!.left!)
            }
            if node!.right != nil {
                queue.offer(node!.right!)
            }
            let temp = node!.left
            node!.left = node!.right
            node!.right = temp
        }
        return root
    }
}
