//
//  背包问题.swift
//  suanfaStudy
//
//  Created by 段峰 on 2021/7/16.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class PackagePrice {
    /**
     
      定义状态：dp(i,j) 是第前i个物品中 最大能承受 j 重量 的背包的最大价值
      初始状态：  dp[0][n]   dp[n][0] == 0
      状态转移：  如果第 i 个物品的重量 > 背包能承受的重量 dp(i,j) = dp(i - 1,j)
               如果第 i 个物品的重量 < 背包能承受的重量 两种情况
                1. 不选最后一件物品： dp(i, j) = dp(i - 1, j)
                2. 选最后一件： dp(i, j) = prices[i - 1] + max(i - 1, j - weights[i])
                选1，2的最大值
     
     - Parameters:
     - weights: 重量数组
     - prices: 价值数组
     - target: 最大承重
     - Returns: 最大价值
     */
    func packageBiggestPrice(weights: [Int], prices: [Int], target: Int) -> Int {
        guard weights.count == prices.count && weights.count > 0 && prices.count > 0 && target > 0 else { return 0 }
        var dp = Array(repeating: Array(repeating: 0, count: target + 1), count: weights.count + 1)
        var maxValue = 0
        for i in 1...weights.count {
            for j in 1...target {
                if j < weights[i - 1] {
                    dp[i][j] = dp[i - 1][j]
                }else {
                    dp[i][j] = max(dp[i - 1][j], prices[i - 1] + dp[i - 1][j - weights[i - 1]])
                }
                maxValue = dp[i][j]
            }
        }
        print(dp)
        return maxValue
    }
}
