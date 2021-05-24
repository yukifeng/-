//
//  530. 二叉搜索树的最小绝对差.swift
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
 *给你一棵所有节点为非负值的二叉搜索树，请你计算树中任意两节点的差的绝对值的最小值。
 
   

 示例：

 输入：

    1
     \
      3
     /
    2

 输出：
 1

 解释：
 最小绝对差为 1，其中 2 和 1 的差的绝对值为 1（或者 2 和 3）。
  

 提示：

 树中至少有 2 个节点。
 本题与 783 https://leetcode-cn.com/problems/minimum-distance-between-bst-nodes/ 相同


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/minimum-absolute-difference-in-bst
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class GetMinimumDifference {
    func getMinimumDifference(_ root: TreeNode<Int>?) -> Int {
        
        var min = Int.max
        var lists = [Int]()
        trvalCenter(root) { (element) in
            lists.append(element)
        }
        for i in 0..<lists.count {
            if i == 0 {
                continue
            }
            min = (min - abs(lists[i] - lists[i - 1])) < 0 ? min : abs(lists[i] - lists[i - 1])
        }
        return min
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
