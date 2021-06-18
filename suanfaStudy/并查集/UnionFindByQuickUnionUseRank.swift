//
//  UnionFindByQuickUnionUseRank.swift
//  UnionFind
//
//  Created by 段峰 on 2020/10/2.
//

import Foundation

class UnionFindByQuickUnionUseRank: UnionFindByQuickUnion {
    /// 记录树的高度
    var ranks = [Int]()
    
    override init(count: Int) {
        super.init(count: count)
        for _ in 0..<count {
            ranks.append(1)
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
        
        if ranks[p1] < ranks[p2] {
            parents[p1] = p2
        }else if ranks[p1] > ranks[p2]{
            parents[p2] = p1
        }else{
            parents[p1] = p2
            ranks[p2] += 1
        }
    }
}

/// 并查集基于rank和path Compression路径压缩的优化
class UnionFindByQuickUnionUseRank_PC: UnionFindByQuickUnionUseRank{
    override func find(e: Int) -> Int {
        checkRange(e: e)
        
        if parents[e] != e {
            parents[e] = find(e: parents[e])
        }
        
        return parents[e]
    }
}


/// 并查集基于rank和path Spliting路径分裂的优化
class UnionFindByQuickUnionUseRank_PS: UnionFindByQuickUnionUseRank{
    override func find(e: Int) -> Int {
        checkRange(e: e)
        var v = e
        
        while parents[v] != v {
            let f = parents[v]
            parents[v] = parents[f]
            v = f
        }
        return v
    }
}


/// 并查集基于rank和path Halving路径减半的优化
class UnionFindByQuickUnionUseRank_PH: UnionFindByQuickUnionUseRank{
    override func find(e: Int) -> Int {
        checkRange(e: e)
        
        var v = e
        
        while parents[v] != v {
            parents[v] = parents[parents[v]]
            v = parents[parents[v]]
        }
        
        return v
    }
}
