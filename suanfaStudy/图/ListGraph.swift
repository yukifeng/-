//
//  ListGraph.swift
//  suanfaStudy
//
//  Created by edz on 2021/6/17.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class ListGraph<V: Hashable, E: Comparable & Numeric>: Graph<V, E> {
    
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
    
    override func edgesSize() -> Int {
        return edges.count
    }
    
    override func verticesSize() -> Int {
        return vertices.count
    }
    
    override func addVertex(_ v: V) {
        // 已经存在顶点return
        if vertices.contains(where: { (key,value) -> Bool in
            v == key
        }) {
            return
        }
        
        // 不存在创建新顶点
        vertices[v] = Vertex(value: v)
    }
    
    override func addEdge(from: V, to: V, weight: E?) {
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
    
    override func addEdge(from: V, to: V) {
        addEdge(from: from, to: to, weight: nil)
    }
    
    override func removeVertex(_ v: V) {
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
    
    override func removeEdge(from: V, to: V, weight: E?) {
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
    
    override func removeEdge(from: V, to: V) {
        removeEdge(from: from, to: to, weight: nil)
    }
    
    override func bfs(begin: V, visitor: (V) -> ()) {
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
    
    override func dfs(begin: V, visitor: (V) -> ()) {
        let beginVertex = vertices[begin]
        guard beginVertex != nil else { return }
        var visitedVertex = Set<Vertex<V, E>>() // 记录已经遍历过的节点
        if beginVertex!.value != nil {
            visitedVertex.insert(beginVertex!)
            visitor(beginVertex!.value!)
        }
        dfs(begin: beginVertex!, visitor: visitor, visitedVertex: &visitedVertex)
    }
    
      func topologicalSort() -> [V] {
        var result = [V]()
        // 顶点: 入度的map，模拟有几条入度边
        var tempMap = [Vertex<V, E>: Int]()
        // 队列放顶点
        var queue = [Vertex<V, E>]()
        vertices.forEach { (key, vertex) in
            if vertex.inEdges.count == 0 {
                queue.append(vertex)
            }else {
                tempMap[vertex] = vertex.inEdges.count
            }
        }
        
        while !queue.isEmpty {
            // 出队
            let vertex = queue[0]
            result.append(vertex.value!)
            queue.remove(at: 0)
            // 更新出度的节点
            vertex.outEdges.forEach { (edge) in
                let toVertex = edge.to // 顶点指向的点
                let newCount = tempMap[toVertex]! - 1 // 模拟删除入度
                if newCount == 0 {
                    queue.append(toVertex) // 度为0入队
                }else {
                    tempMap[toVertex] = newCount // 更新入度
                }
            }
        }
        return result
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
    
    override func mst() -> Set<EdgeInfo<V, E>> {
        return arc4random() % 10 > 4 ? prim() : kruskal()
    }
    
    private func prim() -> Set<EdgeInfo<V, E>> {
        guard vertices.count > 0 else { return Set() }
        // 已经被添加过的顶点集合
        var addedVertices = Set<Vertex<V, E>>()
        // 返回结果集合
        var edgeInfos = Set<EdgeInfo<V, E>>()
        let vertex = vertices.first!.value
        var array = [Edge<V, E>]()
        addedVertices.insert(vertex)
        // 将第一个顶点的出边建堆
        vertex.outEdges.forEach { (edge) in
            array.append(edge)
        }
        let minHeap = Heap(elements: &array, rule: .SmallTop)
        // 最小生成树顶点是图顶点的数量-1
        while !minHeap.isEmpty() && addedVertices.count < vertices.count {
            // 拿出最小边
            let edge = minHeap.remove()!
            if addedVertices.contains(edge.to) { continue }
            edgeInfos.insert(edge.convertToEdgeInfo())
            addedVertices.insert(edge.to)
            // 将该边的顶点的所有出边加入堆中
            edge.to.outEdges.forEach { (e) in
                minHeap.add(element: e)
            }
        }
        
        return edgeInfos
    }
    
    private func kruskal() -> Set<EdgeInfo<V, E>> {
        guard vertices.count > 0 else { return Set() }
        // 返回结果集合
        var edgeInfos = Set<EdgeInfo<V, E>>()
        let unionFind = UnionFindObj<Vertex<V, E>>()
        var edgeList = [Edge<V, E>]()
        // 所有边加入堆
        edges.forEach { (edge) in
            edgeList.append(edge)
        }
        let minHeap = Heap(elements: &edgeList, rule: .SmallTop)
        vertices.forEach { (key,vertex) in
            // 每条边自成一个并查集集合
            unionFind.makeSet(e: vertex)
        }
        
        while !minHeap.isEmpty() && edgeInfos.count < vertices.count - 1 {
            let e = minHeap.remove()!
            let v1 = e.to
            let v2 = e.from
            // 如果最小边的头尾在同一集合证明该边和树形成了环
            if unionFind.isSame(e1: v1, e2: v2) { continue }
            // 合并成同一集合
            unionFind.union(e1: v1, e2: v2)
            edgeInfos.insert(e.convertToEdgeInfo())
        }
        
        
        return edgeInfos
    }
    
    override func shortPath(_ begin: V, type: shortPathType = .bellmanford) -> [V: PathInfo<V, E>] {
        if type == .dijkstra {
            return dijkstra(begin)
        }
        return bellmanFord(begin)
    }
    
    private func dijkstra(_ begin: V) -> [V: PathInfo<V, E>] {
        guard vertices[begin] != nil else { return [:] }
        let beginVertex = vertices[begin]!
        // 被选中的最短路径map
        var selectedPaths = [V: PathInfo<V, E>]()
        
        // 保存所有待选择的路径
        var paths = [Vertex<V, E>: PathInfo<V, E>]()
        
        // 将目标的直连的顶点放入待选择paths中
        beginVertex.outEdges.forEach { (edge) in
            // 起始点都是直连线，edge的weight就是path的weight
            var pathInfo = PathInfo<V, E>(weight: edge.weight!)
            pathInfo.edgeInfos.append(edge.convertToEdgeInfo())
            paths[edge.to] = pathInfo
        }
        while !paths.isEmpty {
            // 返回最短路径元组（顶点，pathInfo）
            let minPath = getMinPath(paths: paths)
            selectedPaths[minPath.0.value!] = minPath.1
            // 已选好的顶点和路径信息从待选paths中移除
            paths.removeValue(forKey: minPath.0)
            
            // 选出最短路径后，纳刀最短路径的出度的边进行松弛操作
            for edge in minPath.0.outEdges {
                // 出度的点已经保存在已经选中的最短路径内，跳过
                if selectedPaths.keys.contains(edge.to.value!) { continue }
                relaxDijkstra(minPath: minPath, paths: &paths, edge: edge)
            }
        }
        // 移除自己
        selectedPaths.removeValue(forKey: begin)
        return selectedPaths
    }
    
    /// 松弛
    /// - Parameters:
    ///   - minPath: <#minPath description#>
    ///   - paths: <#paths description#>
    ///   - edge: <#edge description#>
    private func relaxDijkstra(minPath: (Vertex<V, E>, PathInfo<V, E>), paths: inout [Vertex<V, E>: PathInfo<V, E>], edge: Edge<V, E>) {
        // 选出的最短边和出度的边相加算出新的可选路径权重
        let newWeight = minPath.1.weight + edge.weight!
        // 拿出原顶点保存的路径权重
        let oldWeight = paths[edge.to]?.weight
        // 对比
        if oldWeight == nil || newWeight < oldWeight! {
            var newPathInfo = PathInfo<V, E>(weight: newWeight)
            newPathInfo.edgeInfos.append(contentsOf: minPath.1.edgeInfos)
            newPathInfo.edgeInfos.append(edge.convertToEdgeInfo())
            paths[edge.to] = newPathInfo
        }
    }
    
    /// 从paths中选出一个最小的路径
    /// - Parameter paths: <#paths description#>
    /// - Returns: <#description#>
    private func getMinPath(paths: [Vertex<V, E>: PathInfo<V, E>]) -> (Vertex<V, E>, PathInfo<V, E>) {
        var minTuples: (Vertex<V, E>, PathInfo<V, E>)?
        paths.forEach { (key,value) in
            if minTuples == nil || value.weight < minTuples!.1.weight {
                minTuples = (key, value)
            }
        }
        return minTuples!
    }
    
    private func bellmanFord(_ begin: V) -> [V: PathInfo<V, E>] {
        guard vertices[begin] != nil else { return [:] }
        // 被选中的最短路径map
        var selectedPaths = [V: PathInfo<V, E>]()
        
        selectedPaths[begin] = PathInfo(weight: 0)
        
        for _ in 0..<vertices.count - 1 {
            for edge in edges {
                let fromPath = selectedPaths[edge.from.value!]
                if fromPath == nil { continue }
                relaxBellmanFord(edge: edge, fromPath: fromPath!, paths: &selectedPaths)
            }
        }
        
        for edge in edges {
            let fromPath = selectedPaths[edge.from.value!]
            if fromPath == nil { continue }
            if (relaxBellmanFord(edge: edge, fromPath: fromPath!, paths: &selectedPaths)) {
                print("有负权环")
                selectedPaths.removeAll()
                break
            }
        }
        // 移除自己
        selectedPaths.removeValue(forKey: begin)
        return selectedPaths
    }
    
    /// 松弛
    /// - Parameters:
    ///   - edge: 需要进行松弛的边
    ///   - fromPath: edge的from的最短路径信息
    ///   - paths: 存放着其他点的最短路径信息
    /// - Returns: <#description#>
    @discardableResult
    private func relaxBellmanFord(edge: Edge<V, E>, fromPath: PathInfo<V, E>, paths: inout [V: PathInfo<V, E>]) -> Bool {
        // 选出的最短边和出度的边相加算出新的可选路径权重
        let newWeight = fromPath.weight + edge.weight!
        // 拿出原顶点保存的路径权重
        let oldWeight = paths[edge.to.value!]?.weight
        // 对比
        if oldWeight == nil || oldWeight == 0 || newWeight < oldWeight! {
            var newPathInfo = PathInfo<V, E>(weight: newWeight)
            newPathInfo.edgeInfos.append(contentsOf: fromPath.edgeInfos)
            newPathInfo.edgeInfos.append(edge.convertToEdgeInfo())
            paths[edge.to.value!] = newPathInfo
            return true
        }
        return false
    }
    
    private class Vertex<V: Hashable, E: Comparable & Numeric>: Hashable,CustomStringConvertible {
        
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
    
    private class Edge<V: Hashable, E: Comparable & Numeric>: Hashable,CustomStringConvertible,Comparable {
        
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
        
        static func < (lhs: Edge<V, E>, rhs: Edge<V, E>) -> Bool {
            return lhs.weight! < rhs.weight!
        }
        
        static func + (lhs: Edge<V, E>, rhs: Edge<V, E>) -> E {
            return lhs.weight! + rhs.weight!
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(from)
            hasher.combine(to)
        }
        
        func convertToEdgeInfo() -> EdgeInfo <V, E> {
            return EdgeInfo(from: from.value!, to: to.value!, weight: weight)
        }
    }
}
