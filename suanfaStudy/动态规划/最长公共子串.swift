//
//  最长公共子串.swift
//  suanfaStudy
//
//  Created by 段峰 on 2021/7/16.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class LonggestCommonSubString {
    /**
            定义状态：dp[i][j]是str1[i - 1]和str2[j - 1]的最长公共子串
            初始值：str1[0] && str2[n]      str1[n]&&str2[0] 初始值为0
            状态转移方程： 如果str1[i - 1] str2[j - 1]相等 dp[i][j] = dp[i - 1][j - 1] + 1
     */
    func longgestCommonSubString(_ str1: String, _ str2:String) -> Int {
        guard str1.count > 0 && str2.count > 0 else { return 0 }
        let list1 = Array(str1)
        let list2 = Array(str2)
        var dp = Array(repeating: Array(repeating: 0, count: list2.count + 1), count: list1.count + 1)
        var maxValue = 0
        for i in 1...list1.count {
            for j in 1...list2.count {
                if list1[i - 1] != list2[j - 1] { continue }
                dp[i][j] = dp[i - 1][j - 1] + 1
                maxValue = max(maxValue, dp[i][j])
            }
        }
        
        return maxValue
    }
}
