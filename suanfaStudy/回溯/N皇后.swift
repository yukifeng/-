//
//  N皇后.swift
//  suanfaStudy
//
//  Created by 段峰 on 2021/7/6.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class NEmpress {
    
    /// 数组索引是行号，数组元素是列号
    var cols = [Int?]()
    
    /// 一共有多少种摆法
    var ways = 0
    
    /// 入口，设置皇后数量
    /// - Parameter num: <#num description#>
    func setQueenNum(_ num: Int) {
        guard num > 0 else { return }
        for _ in 0..<num {
            cols.append(nil)
        }
        placeQueen(onRow: 0)
        print("有\(ways)种摆法")
        
    }
    
    /// 放置第n行皇后
    /// - Parameter onRow: n
    private func placeQueen(onRow: Int) {
        
        // 摆到了没有的行
        if onRow == cols.count {
            ways += 1
            show()
            return
        }
        
        for i in 0..<cols.count {
            if isValidate(row: onRow, col: i) {
                cols[onRow] = i
                placeQueen(onRow: onRow + 1)
            }
        }
    }
    
    /// 判断row行col列是否可以放皇后
    /// - Parameters:
    ///   - row: <#row description#>
    ///   - col: <#col description#>
    /// - Returns: <#description#>
    private func isValidate(row: Int, col: Int) -> Bool {
        for i in 0..<row {
            // i行的col列已经有皇后了
            if cols[i] == col {
//                print("第\(row)行第\(col)列不能放")
                return false
            }
            if let c = cols[i] {
                // 与i行在斜线上相交
                if row - i == abs(col - c) {
//                    print("第\(row)行第\(col)列不能放")
                    return false
                }
            }
        }
//        print("第\(row)行第\(col)列可以放")
        return true
    }
    
    /// 打印整个棋盘
    private func show() {
        for i in 0..<cols.count {
            for j in 0..<cols.count {
                if j == cols[i] {
                    print("1", separator: "", terminator: "")
                }else {
                    print("0", separator: "", terminator: "")
                }
            }
            print("")
        }
        print("-------------")
    }
}
