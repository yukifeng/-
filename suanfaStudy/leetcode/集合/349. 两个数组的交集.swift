//
//  349. 两个数组的交集.swift
//  suanfaStudy
//
//  Created by edz on 2021/6/2.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class Intersection {
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        var results = [Int]()
        for i in 0..<nums2.count {
            if nums1.contains(nums2[i]) {
                results.append(nums2[i])
            }
        }
        
        let set: Set = Set(results)
        let array = Array(set)
        
        return array
    }
}
