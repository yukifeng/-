//
//  最大连续子序列和.swift
//  suanfaStudy
//
//  Created by 段峰 on 2021/7/13.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class BiggestSubsequenceSum {
    /**
     定义状态：dp(n):是以list[n]结尾的最大连续子序列的和
     dp[0] = -2
     dp[1] = 1
     dp[2] = -2
     dp[3] = 4
     dp[4] = 3
     dp[5] = 5
     dp[6] = 6
     dp[7] = 1
     dp[8] =5
  
     状态转移方程：
         dp(n) = dp(n - 1) > 0 ? dp(n - 1) + list[n] : list[n]
  
     初始状态：
         dp[0] = list[0]
     - Returns: <#description#>
     */
    class func subSeqSum(_ list:[Int]) -> Int {
        var maxValue = list.first!
        var dp = Array(repeating: 0, count: list.count)
        dp[0] = list[0]
        for i in 1..<list.count {
            if dp[i - 1] < 0 {
                dp[i] = list[i]
            }else {
                dp[i] = dp[i - 1] + list[i]
            }
            maxValue = maxValue < dp[i] ? dp[i] : maxValue
        }
        return maxValue
    }
}
