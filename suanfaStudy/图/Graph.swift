//
//  Graph.swift
//  suanfaStudy
//
//  Created by edz on 2021/6/17.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

protocol WeightCalcu: Comparable {
    
//    associatedtype E
}

enum shortPathType {
    case dijkstra
    case bellmanford
}

class Graph<V: Hashable, E: Equatable>  {
    /// 边的数量
    func edgesSize() -> Int { return 0 }
    
    /// 顶点的数量
    func verticesSize() -> Int { return 0 }
    
    /// 添加顶点
    /// - Parameter v: <#v description#>
    func addVertex(_ v: V) {}
    
    /// 添加边
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    ///   - weight: 权重
    func addEdge(from: V, to: V, weight: E?) {}
    
    /// 添加边
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    func addEdge(from: V, to: V) {}
    
    /// 删除顶点
    /// - Parameter v: <#v description#>
    func removeVertex(_ v: V) {}
    
    /// 删除边
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    ///   - weight: 权重
    func removeEdge(from: V, to: V, weight: E?) {}
    
    /// 删除边
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    func removeEdge(from: V, to: V) {}
    
    /// 广度优先搜索
    func bfs(begin: V, visitor: (V) -> ()) {}
    
    /// 深度优先搜索
    /// - Parameter begin: <#begin description#>
    func dfs(begin: V, visitor: (V) -> ()) {}
    
    /// 最小生成树
    /// - Returns: <#description#>
    func mst() -> Set<EdgeInfo<V, E>> { return Set() }
    
    /// 最短路径
    /// - Parameter begin: <#begin description#>
    /// - Returns: <#description#>
    func shortPath(_ begin: V, type: shortPathType = .bellmanford) -> [V: PathInfo<V, E>] { return [:] }
    
    struct EdgeInfo<V:Hashable, E: Equatable>: Hashable {
        var from: V
        var to: V
        var weight: E?
        
        static func == (lhs: EdgeInfo, rhs: EdgeInfo) -> Bool {
            return lhs.from == rhs.from && lhs.to == rhs.to && lhs.weight == rhs.weight
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(from)
            hasher.combine(to)
        }
    }
    
    /// 路径模型，存放总路径长度和经过的所有边的信息
    struct PathInfo<V:Hashable, E: Equatable>: CustomStringConvertible {
        var weight: E
        var edgeInfos = [EdgeInfo<V, E>]()
        
        
        var description: String {
            return "PathInfo [weight= \(weight) , edgeInfos= \(edgeInfos)  ]"
        }
    }
}
