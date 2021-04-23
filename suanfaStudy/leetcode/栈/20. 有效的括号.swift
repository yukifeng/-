//
//  20. 有效的括号.swift
//  suanfaStudy
//
//  Created by edz on 2021/4/22.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

/**
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

 有效字符串需满足：

 左括号必须用相同类型的右括号闭合。
 左括号必须以正确的顺序闭合。
  

 示例 1：

 输入：s = "()"
 输出：true
 示例 2：

 输入：s = "()[]{}"
 输出：true
 示例 3：

 输入：s = "(]"
 输出：false
 示例 4：

 输入：s = "([)]"
 输出：false
 示例 5：

 输入：s = "{[]}"
 输出：true
  

 提示：

 1 <= s.length <= 104
 s 仅由括号 '()[]{}' 组成


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/valid-parentheses
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class IsValid {
    func isValid(_ s: String) -> Bool {
        if s.count % 2 != 0 {
            return false
        }
        let stack = Stack<Character>()
        for c in s {
            if c == "(" || c == "{" || c == "[" {
                stack.push(c)
            }
            if c == ")" || c == "}" || c == "]" {
                if let r = stack.pop() {
                    guard (r == "(" && c == ")") || (r == "{" && c == "}") || (r == "[" && c == "]") else {
                        return false
                    }
                }else { // 遇到右字符串时候，栈已经空了
                    return false
                }
                
            }
        }
        return stack.isEmpty()
    }
}
