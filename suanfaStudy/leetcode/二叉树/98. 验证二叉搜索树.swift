//
//  98. 验证二叉搜索树.swift
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
 * 给定一个二叉树，判断其是否是一个有效的二叉搜索树。
 
 假设一个二叉搜索树具有如下特征：

 节点的左子树只包含小于当前节点的数。
 节点的右子树只包含大于当前节点的数。
 所有左子树和右子树自身必须也是二叉搜索树。
 示例 1:

 输入:
     2
    / \
   1   3
 输出: true
 示例 2:

 输入:
     5
    / \
   1   4
      / \
     3   6
 输出: false
 解释: 输入为: [5,1,4,null,null,3,6]。
      根节点的值为 5 ，但是其右子节点值为 4 。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/validate-binary-search-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class IsValidBST {
    func isValidBST(_ root: TreeNode<Int>?) -> Bool {
        if root == nil {
            return true
        }
        var result = [Int]()
        trvalCenter(root) { (element) in
            result.append(element)
        }
        for i in 0..<result.count {
            if i != result.count - 1 && result[i] >= result[i+1] {
                return false
            }
        }
        return true
    }
    
    func trvalCenter(_ node: TreeNode<Int>?, visitor: (Int)->()) {
        if node == nil {
            return
        }
        trvalCenter(node?.left, visitor: visitor)
        visitor(node!.element)
        trvalCenter(node?.right,visitor: visitor)
    }
}
