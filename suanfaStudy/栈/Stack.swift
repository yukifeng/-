//
//  Stack.swift
//  suanfaStudy
//
//  Created by edz on 2021/4/21.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class Stack<E> {
    
    private var linkList: DoubleLinkList<E> = DoubleLinkList<E>()
    
    var size: Int {
        get{
            return linkList.size
        }
    }
    func isEmpty() -> Bool {
        return linkList.size == 0
    }
    
    /// 入栈
    /// - Parameter element: <#element description#>
    func push(_ element: E) {
        linkList.add(element, index: 0)
    }
    
    /// 出栈
    /// - Returns: <#description#>
    func pop() -> E? {
        if linkList.size == 0 {
            return nil
        }
        return linkList.remove(index: 0)
    }
    
    /// 拿出栈顶元素
    /// - Returns: <#description#>
    func peek() -> E? {
        if isEmpty() {
            return nil
        }
        return try! linkList.node(index: 0)?.element
    }
    
    func clear() {
        linkList.clear()
    }
}
