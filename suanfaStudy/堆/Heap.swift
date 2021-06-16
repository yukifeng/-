//
//  Heap.swift
//  SortAlgor
//
//  Created by 段峰 on 2020/8/10.
//  Copyright © 2020 段峰. All rights reserved.
//

import Foundation

class Heap<E:Comparable> {
    var elements:[E] = []
    var size:Int = 10
    
    init(elements:inout [E]) {
        if elements.count == 0 {
            self.elements = Array()
        }else{
            size = elements.count
            for i in 0..<elements.count {
                self.elements.append(elements[i])
            }
            heapify()
            // 排序好的数组覆盖inout参数
            elements = self.elements
        }
    }
    
    /// 是否为空
    /// - Returns: <#description#>
    func isEmpty() -> Bool {
        return size == 0
    }
    
    /// 清空
    func clear() {
        size = 0
        self.elements.removeAll()
    }
    
    
    /// 添加元素
    /// - Parameter element: <#element description#>
    /// - Returns: <#description#>
    func add(element:E) -> [E] {
        size += 1
        elements.append(element)
        siftUp(indexShape: size - 1)
        return elements
    }
    
    /// 获取堆顶元素
    /// - Returns: <#description#>
    func get() -> E? {
        return elements.first
    }
    
    /// 删除堆顶元素
    /// - Returns: <#description#>
    func remove() -> [E] {
        guard elements.count > 1 else {
            return []
        }
        elements[0] = elements.last!
        elements.remove(at: elements.count - 1)
        size -= 1
        siftDown(indexShape: 0)
        return elements
    }
    
    /// // 删除堆顶元素的同时插入一个新元素
    /// - Parameter element: <#element description#>
    /// - Returns: <#description#>
    func replace(element:E) -> [E] {
        if elements.count == 0 {
            elements.append(element)
            size += 1
        }else{
            elements[0] = element
            siftDown(indexShape: 0)
        }
        return elements
    }
    
    /// 原地建堆
    private func heapify(){
        var index = 1
        while index < size{
            siftUp(indexShape:index)
            index += 1
        }
        
//        var index = (size >> 1) - 1
//        while index >= 0 {
//            siftDown(indexShape: index)
//            index = index - 1
//        }
    }
    
    /// 让index位置的元素上滤
    /// - Parameter index: <#index description#>
    private func siftUp(indexShape:Int){
        var index = indexShape
        let element = elements[index]
        
        while index > 0{
            let fatherIndex = (index - 1) >> 1
            if elements[fatherIndex] > element {
                break
            }
            elements[index] = elements[fatherIndex]
            index = fatherIndex
        }
        elements[index] = element
    }
    
    /// 让index位置的元素下滤
    /// - Parameter index: <#index description#>
    private func siftDown(indexShape:Int){
        var index = indexShape
        let element = elements[index]
        let half = size >> 1
        // 第一个叶子节点的索引 == 非叶子节点的数量
        // index < 第一个叶子节点的索引
        // 必须保证index位置是非叶子节点
        while index < half {
            // index的节点有2种情况
            // 1.只有左子节点
            // 2.同时有左右子节点
            
            // 左子节点
            var leftChildIndex = (index << 1) + 1
            var leftChild = elements[leftChildIndex]
            // 右子节点
            let rightChildIndex = (index << 1) + 2
            // 默认左子节点与父节点进行比较
            if rightChildIndex < size && elements[rightChildIndex] > elements[leftChildIndex] {
                leftChild = elements[rightChildIndex]
                leftChildIndex = rightChildIndex
            }
            if element > leftChild {
                break
            }
            // 将子节点存放到index位置
            elements[index] = leftChild
            // 重新设置index
            index = leftChildIndex
            }
        elements[index] = element
    }
}
