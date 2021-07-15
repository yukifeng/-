//
//  最长上升子序列.swift
//  suanfaStudy
//
//  Created by 段峰 on 2021/7/13.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class LongestSubsequence {
    
    /**
    定义状态: dp(n)是以list[n]结尾的最长子序列
     dp[0] =  1             [10]
     dp[1] = 1              [2]
     dp[2] = 1              [2]
     dp[3] = 2              [2,5]
     dp[4] = 1              [1]
     dp[5] = 3              [2,5,7]
     dp[6] = 4              [2,5,7,101]
     dp[7] = 4              [2,5,7,18]
    
     初始状态： dp[0] = 1
     状态转移方程： 遍历j  [0,i)，当list[ i] > list[j]  dp[i] = max(dp[j] + 1,dp[i]) 否则跳过
     - Returns: <#description#>
     */
    class func longestRisingSubseq() -> Int {
        let list = [10,2,2,5,1,7,101,18]
        var dp = Array(repeating: 0, count: list.count)
        dp[0] = 1
        var longList = 1
        for i in 1..<list.count {
            for j in 0..<i {
                if list[i] < list[j] { continue }
                dp[i] = max(dp[j] + 1, dp[i])
            }
            longList = max(dp[i], longList)
        }
        return longList
    }

}
