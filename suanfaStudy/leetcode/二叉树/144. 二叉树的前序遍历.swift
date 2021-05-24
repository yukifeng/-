//
//  144. 二叉树的前序遍历.swift
//  suanfaStudy
//
//  Created by edz on 2021/5/20.
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
 */
class PreorderTraversal {
    func preorderTraversal(_ root: TreeNode<Int>?) -> [Int] {
        var result = [Int]()
        let stack = Stack<TreeNode<Int>>()
        
        if root == nil {
            return []
        }
        stack.push(root!)
        
        var node = root!
        while !stack.isEmpty() {
            node = stack.pop()!
            result.append(node.element)
            if node.right != nil {
                stack.push((node.right)!)
            }
            if node.left != nil {
                stack.push((node.left)!)
            }
        }
        return result
    }
}
