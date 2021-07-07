//
//  Recursion.swift
//  suanfaStudy
//
//  Created by 段峰 on 2021/7/7.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation


class Recursion {
    
    private var fibResult = [Int]()
    
    // 斐波那契数列，数组保存已经计算过的数据
    func fib(_ num: Int) -> Int {
        if num <= 2 {
            return 1
        }
        fibResult = Array(repeating: 0, count: num + 1)
        fibResult[1] = 1
        fibResult[2] = 1
        return fib(array: &fibResult, num: num)
    }
    
    private func fib(array: inout [Int], num: Int ) -> Int {
        if array[num] == 0 {
            array[num] = fib(array: &array, num: num - 1) + fib(array: &array, num: num - 2)
        }
        return array[num]
    }
    
    /// 汉诺塔
    /// - Parameters:
    ///   - n: 有n个盘子
    ///   - p1: 1号柱子
    ///   - p2: 2号柱子
    ///   - p3: 3号柱子
    func hanNuoTa(_ n: Int, p1: String, p2: String, p3: String) {
        if n <= 1 {
            move(i: n, from: p1, to: p3)
            return
        }
        
        hanNuoTa(n - 1, p1: p1, p2: p3, p3: p2)
        move(i: n, from: p1, to: p3)
        hanNuoTa(n - 1, p1: p2, p2: p1, p3: p3)
    }
    
    private func move(i: Int, from: String, to: String) {
        print("第\(i)个盘子从\(from)移动到\(to)")
    }
}
