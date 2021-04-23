//
//  856. 括号的分数.swift
//  suanfaStudy
//
//  Created by edz on 2021/4/22.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

/**
 给定一个平衡括号字符串 S，按下述规则计算该字符串的分数：

 () 得 1 分。
 AB 得 A + B 分，其中 A 和 B 是平衡括号字符串。
 (A) 得 2 * A 分，其中 A 是平衡括号字符串。
  

 示例 1：

 输入： "()"
 输出： 1
 示例 2：

 输入： "(())"
 输出： 2
 示例 3：

 输入： "()()"
 输出： 2
 示例 4：

 输入： "(()(()))"
 输出： 6
  

 提示：

 S 是平衡括号字符串，且只含有 ( 和 ) 。
 2 <= S.length <= 50


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/score-of-parentheses
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class ScoreOfParentheses {
    
    func scoreOfParentheses(_ S: String) -> Int {
        let stack = Stack<Int>()
        stack.push(0)
        for c in S {
            if c == "(" {
                stack.push(0)
            }else {
                if stack.peek() == 0 { //栈顶为0即栈顶为左括号，此时为()的情况，得1分
                    stack.pop()
                    stack.push(1)
                }else { //栈顶不为左括号即为(ABC)的情况，得分为(A+B+C)*2
                    var t = 0
                    while !stack.isEmpty() && stack.peek() != 0 {
                        t += stack.pop()!
                    }
                    stack.pop()
                    stack.push(t * 2)
                }
            }
        }
        var result = 0
        while !stack.isEmpty() {
            result += stack.pop()!
        }
        return result
    }
}
