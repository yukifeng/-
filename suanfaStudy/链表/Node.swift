//
//  Node.swift
//  suanfaStudy
//
//  Created by edz on 2021/4/20.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class Node<E>: NSObject {
    
    
    
    override var description: String{
        return debugPrint()
    }
    
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
    
    private func debugPrint() -> String{
        return "\(String(describing: prev?.element) )_\(element)_\(String(describing: next?.element))"
    }
    
    deinit {
        print("node 内存被释放掉了，没有溢出")
    }
}
