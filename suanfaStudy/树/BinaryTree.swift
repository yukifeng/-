//
//  BinaryTree.swift
//  suanfaStudy
//
//  Created by edz on 2021/5/13.
//  Copyright © 2021 段峰. All rights reserved.
// 二叉树

import UIKit

class BinaryTree<E: Comparable>: NSObject {
    /// 用于访问便利后的节点
    typealias Visitor = (E) -> ()
    
    // 返回节点，测试用
    typealias Visitor2 = (TreeNode<E>) -> ()
    
    /// 根节点
    var rootNode: TreeNode<E>?
    /// 比较器
    var comparator: Comparator?
    
    /// 元素的数量
    var size: Int = 0
    
    /// 树的高度
    public var height: Int {
        get {
            rootNode != nil ? calcNodeHeight(rootNode!) : 0
        }
    }
    
    override var description: String {
        if rootNode == nil {
            return ""
        }
        var string = ""
        printTree(node: rootNode!, str: &string, prefix: "")
        return string
    }
    
    init(_ compartor: @escaping Comparator) {
        self.comparator = compartor
    }
    
    override init() {}
    
    private func printTree(node: TreeNode<E>, str: inout String, prefix: String) {
        str += "\(prefix)\(node.element)___p:\(String(describing: node.parent?.element))\n"
        if node.left != nil {
            printTree(node: node.left!, str: &str, prefix: "\(prefix)[L]")
        }
        if node.right != nil {
            printTree(node: node.right!, str: &str, prefix: "\(prefix)[R]")
        }
    }
    
    /// 是否为空
    /// - Returns: <#description#>
    public func isEmpty() -> Bool {
        return size == 0
    }
    
    /// 清空所有元素
    public func clear() {
        rootNode = nil
        size = 0
    }
    
    
    
    /// 返回该节点的前驱节点
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func predecessor(_ node: TreeNode<E>) -> TreeNode<E>? {
        var child = node.left
        if child != nil { // node有左子节点
            while child?.right != nil { // node.left.right.right...
                child = child?.right
            }
            return child
        }else { // 没有左子节点
            
            var node = node
            while node.parent != nil && node == node.parent!.left {
                node = node.parent!
            }
            
            return node.parent
        }
        
    }
    
    /// 返回该节点的后继节点
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func successor(_ node: TreeNode<E>) -> TreeNode<E>? {
        var child = node.right
        if child != nil { // node有右子节点
            while child?.left != nil { // node.right.left.left...
                child = child?.left
            }
            return child
        }else { // 没有右子节点
            
            var node = node
            while node.parent != nil && node == node.parent!.right {
                node = node.parent!
            }
            
            return node.parent
        }
    }
    
    
    /// 计算一个节点的高度
    /// - Parameter node: <#node description#>
    private func calcNodeHeight(_ node: TreeNode<E>) -> Int {
        if node.hasTwoChild() { // 有两个子节点
            return max(calcNodeHeight(node.left!), calcNodeHeight(node.right!)) + 1
        }else if node.isLeafNode() { // 叶子节点
            return 1
        }else { // 只有一个子节点
            if node.left != nil { // 只有左子节点
                return calcNodeHeight(node.left!) + 1
            }else { // 只有右子节点
                return calcNodeHeight(node.right!) + 1
            }
        }
    }
    
    /// 前序遍历
    /// - Parameter visitor: <#visitor description#>
    func preorderTravelsal(visitor: Visitor) {
        preorderTravelsal(rootNode, visitor: visitor)
    }
    
    private func preorderTravelsal(_ node: TreeNode<E>?, visitor: Visitor) {
        if node == nil {
            return
        }
        
        visitor(node!.element)
//        print("\(node!.element)_前驱：\(predecessor(node!)?.element)_后继：\(successor(node!)?.element)_父节点\(node?.parent)")
        preorderTravelsal(node!.left, visitor: visitor)
        preorderTravelsal(node!.right, visitor: visitor)
    }
    
    /// 前序遍历2
    /// - Parameter visitor: <#visitor description#>
    func preorderTravelsal2(visitor: Visitor2) {
        preorderTravelsal2(rootNode, visitor: visitor)
    }
    
    private func preorderTravelsal2(_ node: TreeNode<E>?, visitor: Visitor2) {
        if node == nil {
            return
        }
        
        visitor(node!)
//        print("\(node!.element)_前驱：\(predecessor(node!)?.element)_后继：\(successor(node!)?.element)_父节点\(node?.parent)")
        preorderTravelsal2(node!.left, visitor: visitor)
        preorderTravelsal2(node!.right, visitor: visitor)
    }
    
    /// 中序遍历
    /// - Parameter visitor: <#visitor description#>
    func inorderTravelsal(visitor: Visitor) {
        inorderTravelsal(rootNode, visitor: visitor)
    }
    
    private func inorderTravelsal(_ node: TreeNode<E>?, visitor: Visitor) {
        if node == nil {
            return
        }
        inorderTravelsal(node!.left, visitor: visitor)
        visitor(node!.element)
        inorderTravelsal(node!.right, visitor: visitor)
    }
    
    
    /// 后序遍历
    /// - Parameter visitor: <#visitor description#>
    func postorderTravelsal(visitor: Visitor) {
        postorderTravelsal(rootNode, visitor: visitor)
    }
    
    private func postorderTravelsal(_ node: TreeNode<E>?, visitor: Visitor) {
        if node == nil {
            return
        }
        postorderTravelsal(node!.left, visitor: visitor)
        postorderTravelsal(node!.right, visitor: visitor)
        visitor(node!.element)
    }
    
    
    /// 层序遍历
    /// - Parameter visitor: <#visitor description#>
    func levelOrderTravelsal(visitor: Visitor) {
        levelOrderTravelsal(rootNode, visitor: visitor)
    }

    private func levelOrderTravelsal(_ node: TreeNode<E>?, visitor: Visitor) {
        if node == nil {
            return
        }
        
        let queue = Queue<TreeNode<E>>()
        queue.offer(node!)
        
        while !queue.isEmpty() {
            let node = queue.poll()
            visitor(node!.element)
            if node?.left != nil {
                queue.offer(node!.left!)
            }
            
            if node?.right != nil {
                queue.offer(node!.right!)
            }
        }
    }
    
}

class TreeNode<E>: NSObject {
    var element: E
    var left: TreeNode?
    var right: TreeNode?
    var parent: TreeNode?
    
    init(element: E, parent: TreeNode?) {
        self.element = element
        self.parent = parent
    }
    
    /// 是否是叶子节点
    func isLeafNode() -> Bool {
        return left == nil && right == nil
    }
    
    /// 是否有两个子节点
    func hasTwoChild() -> Bool {
        return left != nil && right != nil
    }
    
    /// 是否是父节点的左子节点
    /// - Returns: <#description#>
    func isLeftChild() -> Bool {
        return parent != nil && self == parent?.left
    }
    
    /// 是否是父节点的右子节点
    /// - Returns: <#description#>
    func isRightChild() -> Bool {
        return parent != nil && self == parent?.right
    }
    
//    override var description: String {
//        return "element:\(element)_left:\(String(describing: left))_right:\(String(describing: right))_parent:\(String(describing: parent))"
//    }
}
