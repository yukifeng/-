//
//  SecViewController.swift
//  suanfaStudy
//
//  Created by edz on 2021/4/19.
//  Copyright © 2021 段峰. All rights reserved.
//

import UIKit

class SecViewController: UIViewController {

    var doubleLink = DoubleLinkList<Int>()
    var singleCircleLink = SingleCircleLinkList<Int>()
    var doubleCircleLink = DoubleCircleLinkList<Int>()
    var stack = Stack<Int>()
    var queue = Queue<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hashMap2()
    }
    
    private func hashMap2() {
        let hashmap = HashMap()
        hashmap.put(Person(name: "zhang", age: 10), value: "10")
        hashmap.put(Person(name: "wang", age: 11), value: "11")
        hashmap.put("li", value: "12")
        hashmap.put(Person(name: "zhang", age: 10), value: "15")
        
        print(hashmap.get(Person(name: "zhang", age: 10)))
        print(hashmap.get(Person(name: "wang", age: 11)))
        print(hashmap.get("li"))
    }
    
    private func hashMap() {
        let hashmap = HashMap()
        for i in 0..<30 {
            hashmap.put("\(i)", value: i)
        }
        
        hashmap.put("20", value: 222222)
        
        print(hashmap)

        for i in 0..<15 {
            hashmap.remove("\(i)")
        }
        for i in 0..<30 {
            print("key:\(i)_value:\(hashmap.get("\(i)"))")
        }
        print("=============================")
        for i in 15..<30 {
            hashmap.remove("\(i)")
        }

        for i in 15..<30 {
            print("key:\(i)_value:\(hashmap.get("\(i)"))")
        }
    }
    
    private func treeMap() {
        let treemap = TreeMap<String, String>()
        treemap.put("zhang", value: "san")
        treemap.put("wang", value: "wu")
        treemap.put("li", value: "4")
        treemap.put("zhao", value: "6")
        
        print(treemap.get("zhang"))
        print(treemap.get("li"))
        print(treemap.get("wang"))
        print(treemap.get("zhao"))
        print("size:\(treemap.size)")
        
        treemap.traversal { (node) in
            print("key:\(node.key)_value:\(node.value)")
        }
        
        treemap.put("li", value: "10")
        print(treemap.get("li"))
        
        print("containsValue4:\(treemap.containsValue("4"))")
        print("containsValue10:\(treemap.containsValue("10"))")
        
        print(treemap.containsKey("li"))
        treemap.remove("li")
        print("size:\(treemap.size)")
        print(treemap.containsKey("li"))
        
        
        print(treemap.isEmpty())
        treemap.clear()
        print(treemap.isEmpty())
        
        
    }
    
    private func rbTree() {
        let rb = RBTree<Int>()
//        let arr = [52, 33, 29, 73, 37, 55, 3, 36, 49, 82, 23, 10, 4, 92, 95]
        let arr = [16, 88, 46, 70, 97, 73, 29, 30, 13, 91, 2, 6, 61, 40, 100]
        for i in 0..<arr.count {
            rb.add(element: arr[i])
        }
        print(rb)
        
        for i in 0..<arr.count {
            rb.remove(element: arr[i])
            print("删除\(arr[i])======================================")
            print(rb)
        }
    }
    
    private func avl() {
        let avl = AVLTree<Int>()
        let arr = [18, 57, 13, 22, 31, 73, 4, 25, 36, 72, 74, 8, 90, 30, 89, 44, 11, 41]
        
        for i in 0..<arr.count {
            avl.add(element: arr[i])
        }
        for i in 0..<arr.count {
            avl.remove(element: arr[i])
            print("================")
            print(avl)
        }
    }
    
    private func bst(){
        let bst = BinarySearchTree<Int>()
        let arr = [39, 74, 83, 32, 54, 98, 6, 63, 94, 59, 29]
        
        for i in 0..<arr.count {
            bst.add(element: arr[i])
        }
        
        bst.remove(element: 94)
        print(bst)
        
//        let node = bst.search(6)
//        print(asdf(node: node))
//        
//        let node2 = bst.search(29)
//        print(asdf(node: node2))
//        
//        let node3 = bst.search(94)
//        print(asdf(node: node3))
//        
//        let node4 = bst.search(74)
//        print(asdf(node: node4))
//        
//        let node5 = bst.search(39)
//        print(asdf(node: node5))
//        
//        let node6 = bst.search(1111)
//        print(asdf(node: node6))
//        print("-------------\(bst.height)")
//        bst.preorderTravelsal { (e) in
//
//        }
    }
    
    func asdf(node: TreeNode<Int>?) -> String {
        return "element:\(node?.element)_left:\(node?.left?.element)_right:\(node?.right?.element)_parent:\(node?.parent?.element)"
    }
    
    private func orderTree(tree: BinarySearchTree<Int>){
        let queue = Queue<TreeNode<Int>>()
        var array = Array<Int>()
        
        var node = tree.rootNode
        if node == nil {
            return
        }
        
        queue.offer(node!)
        
        while !queue.isEmpty() {
             node = queue.poll()
            array.append(node!.element)
            if node?.left != nil {
                queue.offer(node!.left!)
            }
            if node?.right != nil {
                queue.offer(node!.right!)
            }
        }
        print(array)
    }
    
    private func kuohaoScroe() {
        let reuslt = ScoreOfParentheses().scoreOfParentheses("()")
        print(reuslt)
    }
    
    private func queueTest(){
        queue.offer(11)
        queue.offer(22)
        queue.offer(33)
        queue.offer(44)
        queue.offer(55)
        
        while !queue.isEmpty() {
            print(queue.poll())
        }
    }
    
    private func stackTest() {
        for i in 0..<10 {
            stack.push(i)
        }
        while !stack.isEmpty() {
            let e = stack.pop()
            print("size:\(stack.size)  element:\(String(describing: e)) 顶部\(stack.peek())")
        }
        
    }
    
    private func jejos(){
        let double = DoubleCircleLinkList<Int>()
        for i in 1...8 {
            double.add(i)
        }
        double.reset()
        
        while double.head != nil {
            double.next()
            double.next()
            let r = double.remove()
            print(r!) // 最后一个节点的内存没有释放掉
        }
        
    }
    
    private func doubleCiycle() {
        doubleCircleLink.add(11) // 11
        print(doubleCircleLink)
        print("------------")
        doubleCircleLink.add(22) // 11, 22
        print(doubleCircleLink)
        print("------------")
        doubleCircleLink.add(33) // 11, 22, 33
        print(doubleCircleLink)
        print("------------")
        doubleCircleLink.add(44, index: 0) // 44, 11, 22,33
        print(doubleCircleLink)
        print("------------")
        doubleCircleLink.add(55, index: 2)// 44,11,55,22,33
        print(doubleCircleLink)
        print("------------")
        doubleCircleLink.remove(index: 0) // 11,55,22,33
        print(doubleCircleLink)
        print("------------")
        doubleCircleLink.remove(index: doubleCircleLink.size - 1) // 11,55,22
        print(doubleCircleLink)
        print("------------")
        doubleCircleLink.remove(index: 1) // 11,22
        print(doubleCircleLink)
        print("------------")
        doubleCircleLink.remove(index: 0) // 22
        print(doubleCircleLink)
        print("------------")
        doubleCircleLink.remove(index: 0) // []
        print(doubleCircleLink)
        print("------------")
        
//        doubleCircleLink.add(33)
//        doubleCircleLink.add(33)
//        doubleCircleLink.add(33)
//        doubleCircleLink.add(33)
//        doubleCircleLink.add(33)
//        doubleCircleLink.add(33)
//        doubleCircleLink.add(33)
//
//        doubleCircleLink.clear()
//        print(doubleCircleLink)
//        print("------------")
    }
    
    private func signleCircleList(){
        singleCircleLink.add(10)
        print(singleCircleLink)
        print("------------")
        singleCircleLink.add(20, index: 0)
        print(singleCircleLink)
        print("------------")
        singleCircleLink.add(30, index: singleCircleLink.size)
        print(singleCircleLink)
        print("------------")
        singleCircleLink.add(40, index: 0)
        singleCircleLink.add(55, index: 0)
        singleCircleLink.add(66, index: 0)
        singleCircleLink.add(77, index: 0)
        singleCircleLink.clear()
        print(singleCircleLink)
        print("------------")
    }

    private func doubleL(){
        doubleLink.add(10)
        doubleLink.add(20)
        doubleLink.add(30)
        doubleLink.add(40, index: 0)
        doubleLink.add(50, index: doubleLink.size)
        
        print(doubleLink)
        print("------------")
        
        doubleLink.remove(index: 0)
        print(doubleLink)
        print("------------")
        
        doubleLink.remove(index: doubleLink.size - 1)
        print(doubleLink)
        print("------------")
        
        doubleLink.remove(index: 1)
        print(doubleLink)
        print("------------")
        
        doubleLink.clear()
        print(doubleLink)
        print("------------")
        print("+++++++++++")
    }

}


class Person: Hashable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.age == rhs.age && lhs.name == rhs.name
    }
    
    var hashValue: Int {
        return age / 10
    }
    
    var age = 0
    var name = ""
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
