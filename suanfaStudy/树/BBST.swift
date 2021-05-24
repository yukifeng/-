//
//  BBST.swift
//  suanfaStudy
//
//  Created by edz on 2021/5/21.
//  Copyright © 2021 段峰. All rights reserved.
//

import UIKit

class BBST<E: Comparable>: BinarySearchTree<E> {
    /// 左旋转
    /// - Parameter node: <#node description#>
    func rorateLeft(_ grand: TreeNode<E>) {
        let parent = grand.right!
        let child = parent.left
        grand.right = child
        parent.left = grand
        
        afterRorate(grand, parent: parent, child: child)
    }
    
    /// 右旋转
    /// - Parameter node: <#node description#>
    func rorateRight(_ grand: TreeNode<E>) {
        let parent = grand.left!
        let child = parent.right
        grand.left = child
        parent.right = grand
        
        afterRorate(grand, parent: parent, child: child)
    }
    
    func afterRorate(_ grand: TreeNode<E>, parent: TreeNode<E>,child: TreeNode<E>?) {
        // 让parent成为这棵树的根节点
        if grand.isLeftChild() {
            grand.parent?.left = parent
        }else if grand.isRightChild() {
            grand.parent?.right = parent
        }else { // grand没有父节点，根节点设置成parent
            rootNode = parent
        }
        
        child?.parent = grand
        parent.parent = grand.parent
        grand.parent = parent
    }
}
