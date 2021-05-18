//
//  BinarySearchTree.swift
//  suanfaStudy
//
//  Created by edz on 2021/5/10.
//  Copyright © 2021 段峰. All rights reserved.
// 二叉搜索树

import Foundation

class BinarySearchTree<E: Comparable>: BinaryTree<E> {
    
    
    /// 创建节点
    /// - Parameters:
    ///   - element: <#element description#>
    ///   - parent: <#parent description#>
    /// - Returns: <#description#>
    func createNode(_ element: E, parent: TreeNode<E>?) -> TreeNode<E> {
        return TreeNode(element: element, parent: nil)
    }
    
    /// 添加元素
    /// - Parameter e: <#e description#>
    func add(element:E) {
        if rootNode == nil { // 添加第一个节点
            rootNode = createNode(element, parent: nil)
            afterAdd(rootNode!)
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
        
        let newNode = createNode(element, parent: parent)
        if result == .orderedAscending {
            parent?.right = newNode
        }else {
            parent?.left = newNode
        }
        
        size += 1
        
        afterAdd(newNode)
    }
    
    
    /// 删除元素
    /// - Parameter e: <#e description#>
    func remove(element:E) {
        let node = search(element)
        if node == nil {
            print("未找到元素\(element)")
            return
        }
        remove(node: node!)
    }
    
    private func remove(node: TreeNode<E>) {
        if node.isLeafNode() { // 是叶子节点，直接删除
            if node.parent == nil { // node是根节点且只有一个根节点
                clear()
            }else {
                if node == node.parent!.left { // 非根节点的叶子节点
                    node.parent?.left = nil
                }else {
                    node.parent?.right = nil
                }
            }
        }else if node.hasTwoChild() { // 度为2的节点
            let succNode = successor(node)
            node.element = succNode!.element // 度为2一定有前驱
            remove(node: succNode!)
        }else { // 度为1的节点
            if node.parent == nil { // 度为1且是node是根节点
                if node.left != nil {
                    rootNode = node.left
                    node.left?.parent = nil
                }else {
                    rootNode = node.right
                    node.right?.parent = nil
                }
            }
            if node.left != nil { // 左子节点不为空
                node.left!.parent = node.parent
                if node.parent?.left == node {
                    node.parent!.left = node.left
                }else {
                    node.parent?.right = node.left
                }
            }else { // 右子节点不为空
                node.right!.parent = node.parent
                if node.parent?.left == node {
                    node.parent!.left = node.right
                }else {
                    node.parent?.right = node.right
                }
            }
        }
        afterRemove(node)
        size -= 1
    }
    
    /// 删除节点后的逻辑处理
    /// - Parameter node: <#node description#>
    func afterRemove(_ node: TreeNode<E>) {}
    
    /// 添加节点后的逻辑处理
    /// - Parameter node: <#node description#>
    func afterAdd(_ node: TreeNode<E>) {}
    
    /// 是否包含某元素
    /// - Parameter e: <#e description#>
    /// - Returns: <#description#>
    public func contains(element:E) -> Bool {
        return search(element) == nil ? false : true
    }
    /// 比较两个数的大小，分为有传入比较器和没传入使用类自己的可比较方法
    /// - Parameters:
    ///   - e1: <#e1 description#>
    ///   - e2: <#e2 description#>
    func compare(e1: E, e2: E) -> ComparisonResult {
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
    
    /// 通过元素查找节点
    /// - Parameter element: <#element description#>
    /// - Returns: <#description#>
    func search(_ element: E) -> TreeNode<E>? {
        if rootNode == nil {
            return nil
        }
        var node = rootNode
        
        var cmp = compare(e1: element, e2: node!.element)
        
        while cmp != .orderedSame {
            if cmp == .orderedAscending {
                node = node?.left
            }else {
                node = node?.right
            }
            if node == nil {
                return nil
            }
            cmp = compare(e1: element, e2: node!.element)
        }
        return node
    }
    
}




//extension BinarySearchTree where E: Comparable {

//}
