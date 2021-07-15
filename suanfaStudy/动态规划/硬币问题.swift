//
//  硬币问题.swift
//  suanfaStudy
//
//  Created by 段峰 on 2021/7/9.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation


class Coin {
    let coinsType = [1,5,20,25]
    /// 暴力递归
    /// - Parameter n: <#n description#>
    /// - Returns: <#description#>
    func minCoins(money n: Int) -> Int {
        if n < 0 { return Int.max }
        if n == 1 || n == 5 || n == 20 || n == 25 { return 1 }
        var minValue = Int.max
        minValue = min(min(minCoins(money: n - 5), minCoins(money: n - 1)), min(minCoins(money: n - 25), minCoins(money: n - 20)))
        return minValue + 1
    }
    
    /// 优化暴力递归，使用array存储已经计算过的值
    /// - Parameter n: <#n description#>
    /// - Returns: <#description#>
    func minCoins2(money n: Int) -> Int {
        var dp = Array(repeating: 0, count: n + 1)
        if n > 0 { dp[1] = 1 }
        if n > 4 { dp[5] = 1 }
        if n > 20 { dp[20] = 1 }
        if n > 24 { dp[25] = 1 }
        return minCoins2(money: n, dp: dp)
    }
    
    private func minCoins2(money n: Int, dp: [Int]) -> Int {
        var dp = dp
        if n <= 0 {
            return Int.max
        }
        if dp[n] == 0 {
            dp[n] = min(min(minCoins2(money: n - 25, dp: dp), minCoins2(money: n - 20, dp: dp)), min(minCoins2(money: n - 5, dp: dp), minCoins2(money: n - 1, dp: dp))) + 1
        }
        
        return dp[n]
    }
    
    
    /// 递推，从1开始计算，时间复杂度O(n)
    /// - Parameter n: <#n description#>
    /// - Returns: <#description#>
    func minCoins3(money n: Int) -> Int {
        var dp = Array(repeating: 0, count: n + 1)
        for i in 1...n {
            var minValue = dp[i - 1]
            if i >= 25 { minValue = min(dp[i - 25], minValue) }
            if i >= 20 { minValue = min(dp[i - 20], minValue) }
            if i >= 5 { minValue = min(dp[i - 5], minValue) }
            if i >= 1 { minValue = min(dp[i - 1], minValue) }
            dp[i] = minValue + 1
        }
        return dp[n]
    }
    
    /// 自己传入目标硬币和硬币种类
    /// - Parameters:
    ///   - n: <#n description#>
    ///   - nums: <#nums description#>
    /// - Returns: <#description#>
    func minCoins4(money n: Int, nums: [Int]) -> Int {
        if n == 0 { return 0 }
        if n < 0 || nums.count == 0 {
            return -1
        }
        var dp = Array(repeating: 0, count: n + 1)
        for i in 1...n {
            var min = Int.max
            for num in nums {
                if i < num { continue }
                let v = dp[i - num]
                if v == -1 || v > min { continue }
                min = v
            }
            if min == Int.max {
                dp[i] = -1
            }else {
                dp[i] = min + 1
            }
        }
        return dp[n]
    }
}
