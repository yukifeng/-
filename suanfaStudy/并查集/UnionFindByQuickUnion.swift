//
//  UnionFindByQuickUnion.swift
//  UnionFind
//
//  Created by 段峰 on 2020/10/2.
//

import Foundation

class UnionFindByQuickUnion:UnionFind {
    override func find(e: Int) -> Int {
        checkRange(e: e)
        
        var v = e
        while parents[v] != v {
            v = parents[v]
        }
        return v
    }
    
    override func union(e1: Int, e2: Int) {
        checkRange(e: e1)
        checkRange(e: e2)
        
        let p1 = find(e: e1)
        let p2 = find(e: e2)
        
        if p1 == p2 {
            return
        }
        parents[p1] = p2
    }
}

class UnionFindByQuickUnionUseSize: UnionFindByQuickUnion {
    /// 记录节点数量
    var sizes = [Int]()
    
    override init(count: Int) {
        super.init(count: count)
        for _ in 0..<count {
            sizes.append(1)
        }
    }
    
    override func union(e1: Int, e2: Int) {
        checkRange(e: e1)
        checkRange(e: e2)
        
        let p1 = find(e: e1)
        let p2 = find(e: e2)
        
        if p1 == p2 {
            return
        }
        
        if sizes[p1] < sizes[p2] {
            parents[p1] = p2
            sizes[p2] += sizes[p1]
        }else{
            parents[p2] = p1
            sizes[p1] += sizes[p2]
        }
    }
}
