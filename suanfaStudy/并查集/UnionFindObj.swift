//
//  UnionFindObj.swift
//  UnionFind
//
//  Created by 段峰 on 2020/10/3.
//

import Foundation

class UnionFindObj<E: Hashable> {
    
    var map = [E: UFNode<E>]()
    
    func makeSet(e:E){
        let node = UFNode(value: e)
        node.parent = node
        map[e] = node
    }
    
    private func changeToNode(e:E) -> UFNode<E>{
        return map[e]!
    }
    
    private func findNode(e:E) -> UFNode<E>{
        var node = changeToNode(e: e)
        
        
        while node.parent!.value != node.value {
            node.parent = node.parent!.parent!
            node = node.parent!
        }
        
        return node
    }
    
    func find(e:E) -> E{
        let node = findNode(e: e)
        
        return node.value
    }
    
    func union(e1:E,e2:E){
        let p1 = findNode(e: e1)
        let p2 = findNode(e: e2)
        if p1.value == p2.value  { return }
        
        if p1.rank < p2.rank {
            p1.parent = p2
        }else if p1.rank > p2.rank{
            p2.parent = p1
        }else{
            p1.parent = p2
            p2.rank += 1
        }
    }
    
    func isSame(e1:E,e2:E) -> Bool{
        return findNode(e: e1) == findNode(e: e2)
    }
    
    
    class UFNode<E: Equatable>: Equatable {
        
        var parent:UFNode?
        var value:E
        var rank:Int
        
        
        init(value:E) {
            self.value = value
            rank = 1
        }
        
        static func == (lhs: UFNode<E>, rhs: UFNode<E>) -> Bool {
            return lhs.value == rhs.value
        }
    }
}


