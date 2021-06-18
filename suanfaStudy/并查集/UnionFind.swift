//
//  UnionFind.swift
//  UnionFind
//
//  Created by 段峰 on 2020/10/1.
//

import Foundation

class UnionFind {
    var parents:[Int] = []
    
    init(count:Int) {
        for i in 0..<count {
            parents.append(i)
        }
    }
    
    func checkRange(e:Int) {
        assert(e >= 0, "\(e)元素越界")
    }
    
    func find(e:Int) -> Int{
        checkRange(e: e)
        return 0
    }
    
    func union(e1:Int,e2:Int){
        checkRange(e: e1)
        checkRange(e: e2)
    }
    
    func isSame(e1:Int,e2:Int) -> Bool {
        return find(e: e1) == find(e: e2)
    }
}

class UnionFindByQuickFind:UnionFind{
    
    /// 返回根节点
    /// - Parameter e: <#e description#>
    /// - Returns: <#description#>
    override func  find(e:Int) -> Int {
        checkRange(e: e)
        
        return parents[e]
    }
    
    override func union(e1:Int,e2:Int) {
        checkRange(e: e1)
        checkRange(e: e2)
        
        let p1 = find(e: e1)
        let p2 = find(e: e2)
        if p1 == p2 {
            return
        }
        
        for i in 0..<parents.count {
            if parents[i] == p1 {
                parents[i] = p2
            }
        }
    }
}
