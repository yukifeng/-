//
//  最长公共子序列.swift
//  suanfaStudy
//
//  Created by 段峰 on 2021/7/14.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class LonggestCommonSubsequence {
    /**
     定义状态： dp[i][j]是nums1[0-i]和nums2[0-j]的最长公共子序列的长度
     初始值： dp[0][j] 和dp[i][0] = 0
     状态转移方程： if num1[i - 1] == num2[j - 1] dp[i][j] = dp[i - 1][j - 1] + 1
                 else num1[i - 1] != num2[j - 1]  dp[i][j] = max(dp[i][ j - 1],dp[ i - 1 ][j])
     - Parameters:
     - nums1: <#nums1 description#>
     - nums2: <#nums2 description#>
     - Returns: <#description#>
     */
    func longgestCommonSubsequence(nums1: [Int], nums2: [Int]) -> Int {
        var dp = Array(repeating: Array(repeating: 0, count: nums2.count + 1), count: nums1.count + 1)
        for i in 1...nums1.count {
            for j in 1...nums2.count {
                dp[i][0] = 0
                dp[0][j] = 0
                if nums1[i - 1] == nums2[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                }else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }
        return dp[nums1.count][nums2.count]
    }
}
