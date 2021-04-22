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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        jejos()
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
