//
//  SingleCircleLinkList.swift
//  suanfaStudy
//
//  Created by edz on 2021/4/20.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class SingleCircleLinkList<E>: CustomStringConvertible {
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
        size += 1
        let node = Node(element: element)
        if index == 0 {
            node.next = head
            head = node
            
            if size == 0 { // 第一次添加节点，指向自己
                head?.next = head
            }else{
                let tail = try! self.node(index: size - 1)
                tail?.next = head
            }
        }else{
            let preNode = try! self.node(index: index - 1)
            node.next = preNode?.next
            preNode?.next = node
            
            let tail = try! self.node(index: size - 1)
            tail?.next = head
        }
        
        
    }
    
    /// 移除第index位置的节点
    /// - Parameter index: <#index description#>
    /// - Returns: <#description#>
    func remove(index: Int) -> E?{
        let node = try! self.node(index: index)
        let tail = try! self.node(index: size - 1)
        
        if index == 0 {
            head = node?.next
            tail?.next = node?.next
            if size == 1 {
                self.clear()
            }
        }else{
            let preNode = try! self.node(index: index - 1)
            preNode?.next = node?.next
        }
        
        size -= 1
        return node?.element
    }
    
    /// 清空元素
    func clear(){
        let tail = try! self.node(index: size - 1)

        size = 0
        tail?.next = nil
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
