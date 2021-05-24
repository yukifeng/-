//
//  110. 平衡二叉树.swift
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
 *
 *给定一个二叉树，判断它是否是高度平衡的二叉树。
 
 本题中，一棵高度平衡二叉树定义为：
 
 一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1 。
 
  
 
 示例 1：
 
 
 输入：root = [3,9,20,null,null,15,7]
 输出：true
 示例 2：
 
 
 输入：root = [1,2,2,3,3,null,null,4,4]
 输出：false
 示例 3：
 
 输入：root = []
 输出：true
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/balanced-binary-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class IsBalanced {
    
    typealias Visitor = (TreeNode<Int>)->()
    
    func isBalanced(_ root: TreeNode<Int>?) -> Bool {
        var flag = true
        if root == nil {
            return true
        }
        
        travlal(root) { (node) in
            let left = node.left
            let right = node.right
            let leftHeight = left == nil ? 0 : height(left!)
            let rightHeight = right == nil ? 0 : height(right!)
            
            if abs(leftHeight - rightHeight) > 1 {
                flag = false
            }
        }
        return flag
    }
    
    func travlal(_ node: TreeNode<Int>?, visitor: Visitor) {
        
        if node == nil {
            return
        }
        
        visitor(node!)
        travlal(node?.left, visitor: visitor)
        travlal(node?.right, visitor: visitor)
    }
    
    func height(_ node: TreeNode<Int>?) -> Int {
        let left = node?.left
        let right = node?.right
        let leftHeight = left == nil ? 0 : height(left!)
        let rightHeight = right == nil ? 0 : height(right!)
        
        return max(leftHeight, rightHeight) + 1
    }
}
