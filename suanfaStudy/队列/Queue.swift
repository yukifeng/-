//
//  Queue.swift
//  suanfaStudy
//
//  Created by edz on 2021/4/23.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class Queue<E> {
    private var linkList: DoubleLinkList<E> = DoubleLinkList()
    
    var size: Int {
        get{
            return linkList.size
        }
    }
    
    /// 入队
    func offer(_ element: E) {
        linkList.add(element)
    }
    
    /// 出队
    func poll() -> E? {
        if isEmpty() {
            return nil
        }
        return linkList.remove(index: 0)
    }
    
    /// 返回队头元素
    func peek() -> E? {
        if isEmpty() {
            return nil
        }
        return try! linkList.node(index: 0)?.element
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
}
