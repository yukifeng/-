//
//  LinkList.swift
//  suanfaStudy
//
//  Created by edz on 2021/4/14.
//  Copyright © 2021 段峰. All rights reserved.
//  单向链表

import Foundation

class LinkList<E>: CustomStringConvertible {
    var description: String{
        return "当前链表的size为：\(size)个，其中的元素：\(self.findAllNode())"
    }
    
    var size: Int = 0
    var head: Node<E>?
    
    /// 添加节点到最后的位置
    /// - Parameter element: <#element description#>
    func add(_ element: E) {
        add(element, index: size)
    }
    
    /// 添加节点到index的位置
    /// - Parameters:
    ///   - element: <#element description#>
    ///   - index: <#index description#>
    func add(_ element: E, index: Int){
        let node = Node(element: element)
        if index == 0 {
            node.next = head
            head = node
        }else{
            let preNode = try! self.node(index: index - 1)
            node.next = preNode?.next
            preNode?.next = node
        }
        size += 1
    }
    
    /// 移除第index位置的节点
    /// - Parameter index: <#index description#>
    /// - Returns: <#description#>
    func remove(index: Int) -> E?{
        let node = try! self.node(index: index)
        
        if index == 0 {
            head = node?.next
        }else{
            let preNode = try! self.node(index: index - 1)
            preNode?.next = node?.next
        }
        
        size -= 1
        return node?.element
    }
    
    /// 清空元素
    func clear(){
        size = 0
        head = nil
    }
    
    /// 获取index位置的node节点
    /// - Parameter index: <#index description#>
    /// - Throws: <#description#>
    /// - Returns: <#description#>
    func node(index: Int) throws -> Node<E>?{
        if rangeCheck(index: index) {
            throw NSError(domain: "越界", code: -999, userInfo: nil)
        }
        var node = head
        if index != 0 {
            for _ in 0..<index {
                node = node?.next
            }
        }
        return node
    }
    
    private func rangeCheck(index: Int) -> Bool{
        if index < 0 || index >= size {
            return true
        }
        return false
    }
    
    private func findAllNode() -> [E]{
        var node = head
        var list = [E]()
        
        while node != nil {
            if node != nil {
                list.append(node!.element)
                node = node?.next
            }
        }
        return list
    }
    
}

class Node<E> {
    var element: E
    var next: Node?
    var prev: Node?
    
    init(element: E, next: Node?) {
        self.element = element
        self.next = next
    }
    
    init(element: E, next: Node?, prev: Node?) {
        self.element = element
        self.next = next
        self.prev = prev
    }
    
    init(element: E) {
        self.element = element
    }
    
    deinit {
        print("node 内存被释放掉了，没有溢出")
    }
}
