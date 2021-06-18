//
//  Graph.swift
//  suanfaStudy
//
//  Created by edz on 2021/6/17.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

protocol Graph {
    
    associatedtype E
    associatedtype V
    
    /// 边的数量
    func edgesSize() -> Int
    
    /// 顶点的数量
    func verticesSize() -> Int
    
    /// 添加顶点
    /// - Parameter v: <#v description#>
    func addVertex(_ v: V)
    
    /// 添加边
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    ///   - weight: 权重
    func addEdge(from: V, to: V, weight: E?)
    
    /// 添加边
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    func addEdge(from: V, to: V)
    
    /// 删除顶点
    /// - Parameter v: <#v description#>
    func removeVertex(_ v: V)
    
    /// 删除边
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    ///   - weight: 权重
    func removeEdge(from: V, to: V, weight: E?)
    
    /// 删除边
    /// - Parameters:
    ///   - from: <#from description#>
    ///   - to: <#to description#>
    func removeEdge(from: V, to: V)
    
    /// 广度优先搜索
    func bfs(begin: V, visitor: (V) -> ())
    
    /// 深度优先搜索
    /// - Parameter begin: <#begin description#>
    func dfs(begin: V, visitor: (V) -> ())
}
