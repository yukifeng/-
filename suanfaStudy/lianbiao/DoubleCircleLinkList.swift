//
//  DoubleCircleLinkList.swift
//  suanfaStudy
//
//  Created by edz on 2021/4/21.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class DoubleCircleLinkList<E>: CustomStringConvertible {
    var description: String{
        return "当前链表的size为：\(size)个，其中的元素：\(self.findAllNode())"
    }
    
    var size: Int = 0
    var head: Node<E>?
    var tail: Node<E>?
    
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
        if index == size { // 添加到链表最后一个位置
            tail = Node(element: element, next: head, prev: tail)
            if size == 0 { // 链表为空，第一次添加节点
                head = tail
            }else{
                tail?.prev?.next = tail
            }
            head?.prev = tail
            tail?.next = head
        }else{
            let node = Node(element: element,next: try! self.node(index: index))
            if index == 0 { // 添加到第0个位置
                head = node
                node.prev = tail
                tail?.next = node
            }else{
                node.prev = node.next?.prev
                node.prev?.next = node
            }
            node.next?.prev = node
        }
        size += 1
    }
    
    /// 移除第index位置的节点
    /// - Parameter index: <#index description#>
    /// - Returns: <#description#>
    func remove(index: Int) -> E?{
        let node = try! self.node(index: index)
        
        if index == 0 { // 第一个元素
            head = node?.next
            node?.next?.prev = tail
            tail?.next = node?.next
        }else {
            node?.prev?.next = node?.next
        }
        
        if index == size - 1 { // 最后一个元素
            tail = node?.prev
            node?.prev?.next = head
            head?.prev = node?.prev
        }else{
            node?.next?.prev = node?.prev
        }
        
        size -= 1
        return node?.element
    }
    
    /// 清空元素
    func clear(){
        var node = tail
        while node != nil {
            let old = node
            node = node?.prev
            old?.prev = nil
            old?.next = nil
        }
        
        head = nil
        tail = nil
        size = 0
        
    }
    
    deinit {
        print("内存被释放掉了，没有溢出")
    }
    
    /// 获取index位置的node节点
    /// - Parameter index: <#index description#>
    /// - Throws: <#description#>
    /// - Returns: <#description#>
    func node(index: Int) throws -> Node<E>?{
        if rangeCheck(index: index) {
            throw NSError(domain: "越界", code: -999, userInfo: nil)
        }
        var node: Node<E>?
        if index >= (size >> 1) { // 在后半部分
            node = tail
            for _ in (index..<size - 1).reversed() {
                node = node?.prev
            }
        }else{ // 在前半部分
            node = head
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
    
    private func findAllNode() -> [Node<E>]{
        var node = head
        var list = [Node<E>]()
        
        var idx = 0
        while node != nil {
            if idx == size {
                break
            }
            list.append(node!)
            node = node?.next
            idx += 1
            
        }
        return list
    }
}
