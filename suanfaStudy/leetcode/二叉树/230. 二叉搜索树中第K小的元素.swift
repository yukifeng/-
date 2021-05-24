//
//  230. 二叉搜索树中第K小的元素.swift
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
 *给定一个二叉搜索树的根节点 root ，和一个整数 k ，请你设计一个算法查找其中第 k 个最小元素（从 1 开始计数）。
 
   

 示例 1：


 输入：root = [3,1,4,null,2], k = 1
 输出：1
 示例 2：


 输入：root = [5,3,6,2,4,null,null,1], k = 3
 输出：3
  

  

 提示：

 树中的节点数为 n 。
 1 <= k <= n <= 104
 0 <= Node.val <= 104
  

 进阶：如果二叉搜索树经常被修改（插入/删除操作）并且你需要频繁地查找第 k 小的值，你将如何优化算法？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/kth-smallest-element-in-a-bst
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class KthSmallest {
    func kthSmallest(_ root: TreeNode<Int>?, _ k: Int) -> Int {
        var list = [Int]()
        
        trvalCenter(root) { (element) in
            list.append(element)
        }
        
        return list[k - 1]
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
