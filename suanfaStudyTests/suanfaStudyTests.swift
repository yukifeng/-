//
//  suanfaStudyTests.swift
//  suanfaStudyTests
//
//  Created by 段峰 on 2020/8/11.
//  Copyright © 2020 段峰. All rights reserved.
//

import XCTest
@testable import suanfaStudy

class suanfaStudyTests: XCTestCase {
    var array:[Int] = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testHeapCreate() throws {
        for _ in 0..<10 {
            let random = Int(arc4random()) % 100
            array.append(random)
        }
        let heap = Heap(elements: &array)
        heapVerify()
        array = heap.add(element: 333)
        heapVerify()
        array = heap.remove()
        heapVerify()
        array = heap.replace(element: 1)
        heapVerify()
    }
    
    private func heapVerify() {
        let size = array.count
        for i in 0..<size {
            if 2 * i + 1 <= size - 1 {
                let leftResult = array[i] >= array[2 * i + 1]
                if leftResult == false {
                    print("第\(i)个元素错误 节点值为：\(array[i]) 左子节点值:\(array[2 * i + 1])")
                }
            }
            if 2 * i + 2 <= size - 1 {
                let rightResult = array[i] >= array[2 * i + 2]
                if rightResult == false {
                    print("第\(i)个元素错误 节点值为：\(array[i]) 右子节点值:\(array[2 * i + 1])")
                }
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
