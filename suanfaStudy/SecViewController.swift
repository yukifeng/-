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
        rbTree()
    }
    
    private func rbTree() {
        let rb = RBTree<Int>()
        let arr = [52, 33, 29, 73, 37, 55, 3, 36, 49, 82, 23, 10, 4, 92, 95]
        for i in 0..<arr.count {
            rb.add(element: arr[i])
            print(rb)
            print("======================")
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


class Person {
    var age = 0
}
