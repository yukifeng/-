//
//  ListGraph.swift
//  suanfaStudy
//
//  Created by edz on 2021/6/17.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class ListGraph<V: Hashable, E: Equatable>: Graph {
    
    typealias E = E
    
    typealias V = V
    
    /// 保存图中所有的边
    private var edges = Set<Edge<V, E>>()
    
    /// 保存图中所有的顶点
    private var vertices = [V: Vertex<V, E>]()
    
    
//    var value: V
//    
//    init(value: V) {
//        self.value = value
//    }
    
    func graphPrint() {
        print("[顶点]-------------------")
        vertices.forEach { (key,vertex) in
            print(vertex)
            print("out-------------")
            print(vertex.outEdges)
            print("in-------------")
            print(vertex.inEdges)
        }
        print("[边]-------------------")
        edges.forEach { (edge) in
            print(edge)
        }
    }
    
    func edgesSize() -> Int {
        return edges.count
    }
    
    func verticesSize() -> Int {
        return vertices.count
    }
    
    func addVertex(_ v: V) {
        // 已经存在顶点return
        if vertices.contains(where: { (key,value) -> Bool in
            v == key
        }) {
            return
        }
        
        // 不存在创建新顶点
        vertices[v] = Vertex(value: v)
    }
    
    func addEdge(from: V, to: V, weight: E?) {
        // 顶点集合查找顶点
        var fromVertex = vertices[from]
        // 不存在创建新顶点
        if fromVertex == nil {
            let vertex = Vertex<V, E>(value: from)
            vertices[from] = vertex
            fromVertex = vertex
        }
        
        var toVertxt = vertices[to]
        if toVertxt == nil {
            let vertex = Vertex<V, E>(value: to)
            vertices[to] = vertex
            toVertxt = vertex
        }
        
        // 创建边
        let edge = Edge(from: fromVertex!, to: toVertxt!)
        edge.weight = weight
        
        // 移除原来hash值相同的边
        if fromVertex!.outEdges.remove(edge) != nil {
            toVertxt!.inEdges.remove(edge)
            edges.remove(edge)
        }
        
        // 添加新边
        fromVertex!.outEdges.insert(edge)
        toVertxt!.inEdges.insert(edge)
        edges.insert(edge)
    }
    
    func addEdge(from: V, to: V) {
        addEdge(from: from, to: to, weight: nil)
    }
    
    func removeVertex(_ v: V) {
        let vertex = vertices[v]
        guard vertex != nil else {
            return
        }
        // 顶点map内移除该顶点
        vertices.removeValue(forKey: v)
        // 把顶点的所有出边和入边移除
        vertex!.inEdges.forEach { (edge) in
            edges.remove(edge) // 边集合内移除该顶点的入边
            vertices.forEach { (v, vertex) in
                vertex.inEdges.remove(edge)
                vertex.outEdges.remove(edge)
            } // 删除的是经过该条边的其他顶点内保存的该条边的信息
        }
        vertex!.outEdges.forEach { (edge) in
            edges.remove(edge)
            vertices.forEach { (v, vertex) in
                vertex.inEdges.remove(edge)
                vertex.outEdges.remove(edge)
            }
        }
        
    }
    
    func removeEdge(from: V, to: V, weight: E?) {
        let fromVertex = vertices[from]
        let toVertex = vertices[to]
        // 找到该条边
        let edge = edges.filter { (edge) -> Bool in
            edge.from == fromVertex && edge.to == toVertex && edge.weight == weight
        }
        edge.forEach { (e) in
            // 边集合内移除该条边
            edges.remove(e)
            // 出入顶点边集合内移除该条边
            fromVertex?.outEdges.remove(e)
            toVertex?.inEdges.remove(e)
        }
    }
    
    func removeEdge(from: V, to: V) {
        removeEdge(from: from, to: to, weight: nil)
    }
    
    func bfs(begin: V, visitor: (V) -> ()) {
        let beginVertex = vertices[begin]
        guard beginVertex != nil else { return }
        var visitedVertex = Set<Vertex<V, E>>() // 记录已经遍历过的节点
        var array = [Vertex<V, E>]() // 当作队列
        array.append(beginVertex!) // 入队
        visitedVertex.insert(beginVertex!)
        
        while !array.isEmpty {
            let head = array[0]
            array.remove(at: 0) // 出队
            visitor(head.value!)
            for edge in head.outEdges {
                if visitedVertex.contains(edge.to) { continue }
                array.append(edge.to)
                visitedVertex.insert(edge.to)
            }
        }
    }
    
    func dfs(begin: V, visitor: (V) -> ()) {
        let beginVertex = vertices[begin]
        guard beginVertex != nil else { return }
        var visitedVertex = Set<Vertex<V, E>>() // 记录已经遍历过的节点
        if beginVertex!.value != nil {
            visitedVertex.insert(beginVertex!)
            visitor(beginVertex!.value!)
        }
        dfs(begin: beginVertex!, visitor: visitor, visitedVertex: &visitedVertex)
    }
    
    private func dfs(begin: Vertex<V, E>, visitor: (V) -> (), visitedVertex: inout Set<Vertex<V, E>>) {
        for edge in begin.outEdges {
            if visitedVertex.contains(edge.to) { continue }
            visitedVertex.insert(edge.to)
            if edge.to.value != nil {
                visitor(edge.to.value!)
            }
            dfs(begin: edge.to, visitor: visitor, visitedVertex: &visitedVertex)
        }
    }
    
    private class Vertex<V: Hashable, E: Equatable>: Hashable,CustomStringConvertible {
        
        var value: V?
        var inEdges = Set<Edge<V, E>>()
        var outEdges = Set<Edge<V, E>>()
        
        init(value: V?) {
            self.value = value
        }
        
        var description: String{
            return value == nil ? "" : "\(value!)"
        }
        
        static func == (lhs: Vertex<V, E>, rhs: Vertex<V, E>) -> Bool {
            return lhs.value == rhs.value
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }
    }
    
    private class Edge<V: Hashable, E: Equatable>: Hashable,CustomStringConvertible {
        
        var from: Vertex<V, E>
        var to: Vertex<V, E>
        var weight: E?
        
        init(from: Vertex<V, E>, to: Vertex<V, E>) {
            self.from = from
            self.to = to
        }
        
        var description: String {
            return "Edge [from= \(from), to= \(to) , weight= \(String(describing: weight)) ]"
        }
        
        static func == (lhs: Edge<V, E>, rhs: Edge<V, E>) -> Bool {
            return lhs.from == rhs.from && lhs.to == rhs.to && lhs.weight == rhs.weight
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(from)
            hasher.combine(to)
        }
    }
}
