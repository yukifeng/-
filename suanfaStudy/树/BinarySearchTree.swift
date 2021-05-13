//
//  BinarySearchTree.swift
//  suanfaStudy
//
//  Created by edz on 2021/5/10.
//  Copyright © 2021 段峰. All rights reserved.
// 二叉搜索树

import Foundation

class BinarySearchTree<E: Comparable>: NSObject {
    /// 用于访问便利后的节点
    typealias Visitor = (E) -> ()
    
    /// 根节点
    var rootNode: TreeNode<E>?
    /// 比较器
    private var comparator: Comparator?
    
    /// 元素的数量
    private(set) var size: Int = 0
    
    /// 树的高度
    var height: Int {
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
        str += "\(prefix)\(node.element)\n"
        if node.left != nil {
            printTree(node: node.left!, str: &str, prefix: "\(prefix)[L]")
        }
        if node.right != nil {
            printTree(node: node.right!, str: &str, prefix: "\(prefix)[R]")
        }
    }
    
    /// 是否为空
    /// - Returns: <#description#>
    func isEmpty() -> Bool {
        return false
    }
    
    /// 清空所有元素
    func clear() {
        
    }
    
    /// 添加元素
    /// - Parameter e: <#e description#>
    func add(element:E) {
        if rootNode == nil { // 添加第一个节点
            rootNode = TreeNode(element: element, parent: nil)
            return
        }
        // 添加之后的节点
        var parent = rootNode
        var currentNode = rootNode
        var result: ComparisonResult = .orderedSame
        // 查到element应该插到哪个位置
        while currentNode != nil {
            parent = currentNode
            result = compare(e1: parent!.element, e2: element)
            switch result {
            case .orderedAscending: // e1 < e2
                currentNode = parent?.right
            case .orderedDescending: // e1 > e2
                currentNode = parent?.left
            case .orderedSame: // ==
                parent?.element = element
            }
        }
        
        let newNode = TreeNode(element: element, parent: parent)
        if result == .orderedAscending {
            parent?.right = newNode
        }else {
            parent?.left = newNode
        }
        
        
    }
    
    /// 删除元素
    /// - Parameter e: <#e description#>
    func remove(element:E) {
        
    }
    
    /// 是否包含某元素
    /// - Parameter e: <#e description#>
    /// - Returns: <#description#>
    func contains(element:E) -> Bool {
        return false
    }
    /// 比较两个数的大小，分为有传入比较器和没传入使用类自己的可比较方法
    /// - Parameters:
    ///   - e1: <#e1 description#>
    ///   - e2: <#e2 description#>
    private func compare(e1: E, e2: E) -> ComparisonResult {
        if (comparator != nil) { // 传入了比较器的情况下
            return comparator!(e1,e2)
        }
        
        if e1 > e2 {
            return .orderedDescending
        }else if e1 < e2 {
            return .orderedAscending
        }else {
            return .orderedSame
        }
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
            while child != nil { // node.right.left.left...
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
        preorderTravelsal(node!.left, visitor: visitor)
        preorderTravelsal(node!.right, visitor: visitor)
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
}


//extension BinarySearchTree where E: Comparable {

//}
