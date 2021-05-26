//
//  AVLTree.swift
//  suanfaStudy
//
//  Created by edz on 2021/5/14.
//  Copyright © 2021 段峰. All rights reserved.
// AVL树

import UIKit

class AVLTree<E: Comparable>: BBST<E> {
    
    override func createNode(_ element: E, parent: TreeNode<E>?) -> TreeNode<E> {
        return AVLNode(element: element, parent: parent)
    }
    
    /// 添加节点后的操作
    /// - Parameter node: 新创建的节点
    override func afterAdd(_ node: TreeNode<E>) {
        var parent = node.parent
        while parent != nil {
            if isBlance(parent!) {
                // 更新高度
                updateHeight(parent!)
            }else {
                // 回复平衡
                reblance(parent!)
                break
            }
            parent = parent!.parent
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - node: <#node description#>
    ///   - replacement: 红黑树使用，AVL树不用
    override func afterRemove(_ node: TreeNode<E>,replacement: TreeNode<E>?) {
        var parent = node.parent
        while parent != nil {
            if isBlance(parent!) {
                // 更新高度
                updateHeight(parent!)
            }else {
                // 回复平衡
                reblance(parent!)
            }
            parent = parent!.parent
        }
    }
    
    /// 重新将失衡节点回复平衡
    /// - Parameter grand: 高度最低的不平衡节点
    private func reblance(_ grand: TreeNode<E>) {
        let parent = (grand as! AVLNode).tallerChild()
        let node = (parent as! AVLNode).tallerChild()
        if parent.isLeftChild() {
            if node.isLeftChild() { // LL
                rorateRight(grand)
            }else { // LR
                rorateLeft(parent)
                rorateRight(grand)
            }
        }else {
            if node.isLeftChild() { // RL
                rorateRight(parent)
                rorateLeft(grand)
            }else { // RR
                rorateLeft(grand)
            }
        }
    }
    
    override func afterRorate(_ grand: TreeNode<E>, parent: TreeNode<E>,child: TreeNode<E>?) {
        super.afterRorate(grand, parent: parent, child: child)
        updateHeight(grand)
        updateHeight(parent)
    }
    
    /// 查看该节点是否平衡
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func isBlance(_ node: TreeNode<E>) -> Bool {
        return abs((node as! AVLNode<E>).getBlanceFactor()) <= 1
    }
    
    func updateHeight(_ node: TreeNode<E>) {
        (node as! AVLNode).updateHeight()
    }
    
}

class AVLNode<E>: TreeNode<E> {
    /// 节点的高度
    var height = 1
    
    /// 获取该节点的平衡因子，左右子树的高度差
    /// - Returns: <#description#>
    func getBlanceFactor() -> Int {
        let leftHeight = left == nil ? 0 : (self.left as! AVLNode).height
        let rightHeight = right == nil ? 0 : (self.right as! AVLNode).height
        return leftHeight - rightHeight
    }
    
    /// 更新节点高度
    func updateHeight() {
        let leftHeight = left == nil ? 0 : (self.left as! AVLNode).height
        let rightHeight = right == nil ? 0 : (self.right as! AVLNode).height
        height = max(leftHeight, rightHeight) + 1
    }
    
    /// 获取子节点中高度最高的节点
    /// - Returns: <#description#>
    func tallerChild() -> TreeNode<E> {
        let leftHeight = left == nil ? 0 : (self.left as! AVLNode).height
        let rightHeight = right == nil ? 0 : (self.right as! AVLNode).height
        
        if leftHeight > rightHeight {
            return left!
        }else if leftHeight < rightHeight {
            return right!
        }else {
            if isLeftChild() { // 出现不平衡时调用，在绝对值 > 1的时候出现不平衡，不会存在空值
                return left!
            }else {
                return right!
            }
        }
    }
}
