//
//  RBTree.swift
//  suanfaStudy
//
//  Created by edz on 2021/5/21.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class RBTree<E: Comparable>: BBST<E> {
    
    override var description: String {
        if rootNode == nil {
            return ""
        }
        var string = ""
        printTree(node: rootNode!, str: &string, prefix: "")
        return string
    }
    
    private func printTree(node: TreeNode<E>, str: inout String, prefix: String) {
        str += "\(prefix)\(node.element)___p:\(String(describing: node.parent?.element))"
        if isRed(node) {
            str += "___红\n"
        }else {
            str += "\n"
        }
        if node.left != nil {
            printTree(node: node.left!, str: &str, prefix: "\(prefix)[L]")
        }
        if node.right != nil {
            printTree(node: node.right!, str: &str, prefix: "\(prefix)[R]")
        }
    }
    
    override func createNode(_ element: E, parent: TreeNode<E>?) -> TreeNode<E> {
        return RBNode(element: element, parent: parent as? RBNode<E>)
    }
    
    /// 添加节点后的操作
    /// - Parameter node: 新创建的节点
    override func afterAdd(_ node: TreeNode<E>) {
        if node.parent == nil { // node是根节点
            let _ = setColorToBlack(node)
            return
        }
        let node = setColorToRed(node)!
        if isBlack(node.parent) { // 父节点是黑色，无需处理
            return
        }
        let parent = node.parent!
        let grand = parent.parent!
        if !isRed(node.parent!.sibling()) {
            // uncle节点不是红色，需要把父节点染黑，祖父节点染红，然后根据3个节点的位置进行旋转
            
            let _ = setColorToRed(grand) // 不会上溢的添加，祖父节点一定会被染成红色
            if parent.isLeftChild() {
                if node.isLeftChild() { // LL
                    let _ = setColorToBlack(parent)
                    rorateRight(grand)
                }else { // LR
                    let _ = setColorToBlack(node)
                    rorateLeft(parent)
                    rorateRight(grand)
                }
            }else{
                if node.isLeftChild() { //RL
                    let _ = setColorToBlack(node)
                    rorateRight(parent)
                    rorateLeft(grand)
                }else { // RR
                    let _ = setColorToBlack(parent)
                    rorateLeft(grand)
                }
            }
        }else { // uncle节点是红色，需要上溢， LL LR RL RR的操作是一样的
            let uncle = parent.sibling()!
            let _ = setColorToBlack(parent)
            let _ = setColorToBlack(uncle)
            let _ = setColorToRed(grand)
            afterAdd(grand)
        }
        
    }
    
    
    /// 删除节点后的逻辑处理
    /// - Parameter node: <#node description#>
    override func afterRemove(_ node: TreeNode<E>, replacement: TreeNode<E>?) {
        if isRed(node) { // 删除的节点是红色，无事发生
            return
        }
        // 删除度为1的黑色节点
        // 替代的节点是红色的
        if isRed(replacement) {
            let _ = setColorToBlack(replacement!) // replacement是红色一定不nil
            return
        }
        
        // 删除的是根节点，无事发生
        if node.parent == nil {
            return
        }
        
        /// node 在父节点的左边还是右边,
        let isLeft = node.parent?.left == nil || node.parent!.left == node
        var sibling = isLeft ? node.parent?.right : node.parent?.left
        if isLeft { // 被删除的节点在左边，兄弟节点在右边
            if isRed(sibling) { // 兄弟节点是红色
                // 兄弟节点染成黑色，父节点染成红色，左旋转变为兄弟节点是黑色的情况
                let _ = setColorToBlack(sibling)
                let _ = setColorToRed(node.parent)
                rorateLeft(node.parent!)
                
                // 将兄弟节点重新赋值
                sibling = node.parent?.right
            }
            
            // 兄弟节点是黑色
            // 兄弟节点的左右子节点都是黑色
            if isBlack(sibling?.left) && isBlack(sibling?.right) {
                let parentIsBlack = isBlack(node.parent)
                let _ = setColorToBlack(node.parent!)
                let _ = setColorToRed(sibling)
                if parentIsBlack {
                    afterRemove(node.parent!, replacement: nil)
                }
            }else { // 兄弟节点至少有一个红色子节点的情况，可以向兄弟节点借元素
                if isBlack(sibling?.right) {
                    rorateRight(sibling!)
                    sibling = node.parent?.right
                }
                let _ = setNodeTo((node.parent as! RBNode).color, node:  sibling)
                let _ = setColorToBlack(sibling?.right)
                let _ = setColorToBlack(node.parent)
                rorateLeft(node.parent!)
            }
        }else {
            // 被删除的节点在右边
            if isRed(sibling) { // 兄弟节点是红色
                let _ = setColorToBlack(sibling)
                let _ = setColorToRed(node.parent)
                rorateRight(node.parent!) // 为了将兄弟节点的子节点变为兄弟节点，看作LL的情况右旋父节点
                
                // 重置sibling的值
                sibling = node.parent?.left
            }
            
            // 兄弟节点是黑色
            // 兄弟节点的左右子节点都是黑色,没有元素可以借，父节点下溢
            if isBlack(sibling?.left) && isBlack(sibling?.right) {
                let parentIsBlack = isBlack(node.parent)
                let _ = setColorToBlack(node.parent!)
                let _ = setColorToRed(sibling)
                if parentIsBlack {
                    afterRemove(node.parent!, replacement: nil)
                }
            }else { // 兄弟节点至少有一个红色子节点的情况，可以向兄弟节点借元素
                if isBlack(sibling?.left) { // 也就是兄弟节点的左边是nil 右边是红色子节点
                    rorateLeft(sibling!) // 这是LR的旋转 先左旋转兄弟，后右旋转父节点
                    sibling = node.parent?.left
                }
                let _ = setNodeTo((node.parent as! RBNode).color, node:  sibling)
                let _ = setColorToBlack(sibling?.left)
                let _ = setColorToBlack(node.parent)
                rorateRight(node.parent!) // 两种情况都会右旋转
            }
        }
    }
    
    /// 将节点染成黑色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func setColorToBlack(_ node: TreeNode<E>?) -> RBNode<E>? {
        return setNodeTo(.Black, node: node)
    }
    
    /// 将节点染成红色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func setColorToRed(_ node: TreeNode<E>?) -> RBNode<E>? {
        return setNodeTo(.Red, node: node)
    }
    
    /// 节点染色
    /// - Parameters:
    ///   - color: <#color description#>
    ///   - node: <#node description#>
    /// - Returns: <#description#>
    func setNodeTo(_ color: RBNodeColor, node: TreeNode<E>?) -> RBNode<E>? {
        if node == nil {
            return nil
        }
        let node  = node as! RBNode
        node.color = color
        return node
    }
    
    /// 获取节点的颜色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func colorOf(_ node: TreeNode<E>?) -> RBNodeColor {
        let node = node as? RBNode<E>
        return node == nil ? .Black : node!.color
    }
    
    /// 节点是否时黑色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func isBlack(_ node: TreeNode<E>?) -> Bool {
        let node = node as? RBNode
        return  node == nil || node?.color == .Black
    }
    
    /// 节点是否时红色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func isRed(_ node: TreeNode<E>?) -> Bool {
        return !isBlack(node)
    }
}

enum RBNodeColor {
    case Black
    case Red
}
class RBNode<E: Comparable>: TreeNode<E> {
    
    var color: RBNodeColor = .Black
    
    init(element: E, parent: RBNode<E>?) {
        super.init(element: element, parent: parent)
    }
}
