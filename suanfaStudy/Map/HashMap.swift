//
//  HashMap.swift
//  suanfaStudy
//
//  Created by edz on 2021/6/3.
//  Copyright © 2021 段峰. All rights reserved.
//

import Foundation

class HashMap<K: Hashable, V>: NSObject {
    typealias Visitor = (HashMapNode<K,V>) -> ()
    /// 存放数据的表
    var table = [HashMapNode<K, V>?]()
    /// 容量
    var capacity = 1 << 4
    /// 扩容因子
    let loadFactor = 0.75
    private(set) var size = 0
    
    override var description: String {
        var str = ""
        for i in 0..<table.count {
            printMap(node: table[i], str: &str, prefix: "")
            str += "\n================table[\(i)]====================\n"
        }
        return str
    }
    
    private func printMap(node:HashMapNode<K,V>?, str: inout String, prefix: String) {
        if node != nil {
            str += "\(prefix)key:\(node!.key)---value:\(node!.value)\n"
            if node!.left != nil {
                printMap(node: node!.left!, str: &str, prefix: "\(prefix)[L]")
            }
            if node!.right != nil {
                printMap(node: node!.right!, str: &str, prefix: "\(prefix)[R]")
            }
        }
    }
    
    override init() {
        for _ in 0..<capacity {
            table.append(nil)
        }
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    func clear() {
        if size == 0 {
            return
        }
        size = 0
        for i in 0..<capacity {
            table[i] = nil
        }
    }
    
    /// 前序遍历
    /// - Parameter visitor: <#visitor description#>
    func preorderTravelsal(rootNode:HashMapNode<K,V>, visitor: (HashMapNode<K,V>)->()) {
        
        preorderTravelsal(rootNode, visitor: visitor)
    }
    
    private func preorderTravelsal(_ node: HashMapNode<K,V>?, visitor: (HashMapNode<K,V>)->()) {
        if node == nil {
            return
        }
        
        visitor(node!)
//        print("\(node!.element)_前驱：\(predecessor(node!)?.element)_后继：\(successor(node!)?.element)_父节点\(node?.parent)")
        preorderTravelsal(node!.left, visitor: visitor)
        preorderTravelsal(node!.right, visitor: visitor)
    }
    
    /// 扩容
    private func resize() {
        if Double(size) / Double(table.count) <= loadFactor { return }
        
        var oldTable = [HashMapNode<K,V>?]()
        
        for i in 0..<table.count {
            oldTable.append(table[i])
        }
        
        table.removeAll()
        for _ in 0..<oldTable.count * 2 {
            table.append(nil)
        }
        
        let queue = Queue<HashMapNode<K,V>>()
        for i in 0..<oldTable.count {
            if oldTable[i] == nil { continue }
            queue.offer(oldTable[i]!)

            while !queue.isEmpty() {
                let node = queue.poll()
                if node?.left != nil {
                    queue.offer(node!.left!)
                }

                if node?.right != nil {
                    queue.offer(node!.right!)
                }

                moveNode(node!)
            }
        }

    }
    
    private func moveNode(_ newNode: HashMapNode<K,V>) {
        newNode.left = nil
        newNode.right = nil
        newNode.parent = nil
        newNode.color = .Red
        
        put(newNode.key, value: newNode.value)
    }
    
    
    /// 根据key生成对应的索引（在桶数组中的位置）
    /// - Parameter key: <#key description#>
    /// - Returns: <#description#>
    private func getIndex(key: K) -> Int {
        return hash(key: key) & (table.count - 1)
    }
    
    private func getIndex(node: HashMapNode<K,V>) -> Int {
        return getIndex(key: node.key)
    }
    
    private func hash(key: K?) -> Int {
        let hash = key == nil ? 0 : key.hashValue
        return hash ^ (hash >>> 16)
    }
    
    func put(_ key: K, value: V) {
        resize()
        
        let index = getIndex(key: key)
        var rootNode = table[index]
        
        if rootNode == nil { // 添加第一个节点
            rootNode = createNode(key, value: value, parent: nil)
            table[index] = rootNode
            fixAfterPut(rootNode!)
            size += 1
            return
        }
        // 添加之后的节点
        var parent = rootNode
        var currentNode = rootNode
        var result: ComparisonResult = .orderedSame
        /// put的key的hash值
        let h1 = hash(key: key)
        /// 标记是否已经搜索过该key
        var searched = false
        // 查到element应该插到哪个位置
        while currentNode != nil {
            parent = currentNode
            let key2 = currentNode!.key
            let h2 = hash(key: key2)
            if h1 > h2 {
                result = .orderedAscending
            } else if (h1 < h2) {
                result = .orderedDescending
            } else if (key == key2) {
                result = .orderedSame
            } else if (searched) {
                // 已经扫描过了，随机放到左侧或右侧
                result = getRandom()
            }else {
                if (currentNode!.left != nil && currentNode!.left!.key == key) {
                    result = .orderedSame
                    currentNode = currentNode!.left
                }else if currentNode?.right != nil && currentNode!.right!.key == key {
                    result = .orderedSame
                    currentNode = currentNode!.right
                }else {
                    // 已经搜索过了没搜到，随机放到左侧或者右侧
                    searched = true
                    result = getRandom()
                }
            }
            if result == .orderedAscending {
                currentNode = currentNode?.right
            }else if result == .orderedDescending {
                currentNode = currentNode?.left
            }else {
                currentNode?.key = key
                currentNode?.value = value
                return
            }
        }
        
        let newNode = createNode(key, value: value, parent: parent)
        if result == .orderedAscending {
            parent?.right = newNode
        }else {
            parent?.left = newNode
        }
        
        size += 1
        
        fixAfterPut(newNode)
    }
    
    func getRandom() -> ComparisonResult {
        let random = arc4random() % 10
        return random > 4 ? .orderedAscending : .orderedDescending
    }
    
    func search(_ key: K) -> HashMapNode<K, V>? {
        let root = table[getIndex(key: key)]
        return root == nil ? nil : getNode(root, key: key)
    }
    
    func get(_ key: K) -> V? {
        let root = table[getIndex(key: key)]
        return get(node: root, key: key)
    }
    
    private func getNode(_ node: HashMapNode<K,V>?, key: K) -> HashMapNode<K,V>? {
        var result: ComparisonResult = .orderedSame
        var currentNode: HashMapNode<K,V>? = node
        let h1 = hash(key: key)
        
        while currentNode != nil {
            let key2 = currentNode?.key
            let h2 = hash(key: key2)
            if h1 > h2 {
                result = .orderedAscending
            } else if (h1 < h2) {
                result = .orderedDescending
            } else if (key == key2) {
                result = .orderedSame
            }else {
                if (currentNode?.left != nil && currentNode?.left?.key == key) {
                    result = .orderedSame
                    currentNode = currentNode?.left
                }else if currentNode?.right != nil && currentNode?.right?.key == key {
                    result = .orderedSame
                    currentNode = currentNode?.right
                }else {
                    result = getRandom()
                }
            }
            if result == .orderedAscending {
                currentNode = currentNode?.right
            }else if result == .orderedDescending {
                currentNode = currentNode?.left
            }else {
                return currentNode!
            }
        }
        return nil
    }
    
    private func get(node: HashMapNode<K,V>?, key: K) -> V? {
        return getNode(node, key: key)?.value
    }
    
    func remove(_ key: K) {
        let node = search(key)
        if node == nil {
            print("未找到元素\(key)")
            return
        }
        remove(node: node!)
    }
    
    func containsKey(_ key: K) -> Bool {
        return search(key) != nil
    }
    
    
    // MARK: Tree
    
    /// 左旋转
    /// - Parameter node: <#node description#>
    func rorateLeft(_ grand: HashMapNode<K,V>) {
        let parent = grand.right!
        let child = parent.left
        grand.right = child
        parent.left = grand
        
        afterRorate(grand, parent: parent, child: child)
    }
    
    /// 右旋转
    /// - Parameter node: <#node description#>
    func rorateRight(_ grand: HashMapNode<K,V>) {
        let parent = grand.left!
        let child = parent.right
        grand.left = child
        parent.right = grand
        
        afterRorate(grand, parent: parent, child: child)
    }
    
    func afterRorate(_ grand: HashMapNode<K,V>, parent: HashMapNode<K,V>,child: HashMapNode<K,V>?) {
        // 让parent成为这棵树的根节点
        if grand.isLeftChild() {
            grand.parent?.left = parent
        }else if grand.isRightChild() {
            grand.parent?.right = parent
        }else { // grand没有父节点，根节点设置成parent
            table[getIndex(node: grand)] = parent
        }
        
        child?.parent = grand
        parent.parent = grand.parent
        grand.parent = parent
    }
    /// 返回该节点的前驱节点
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func predecessor(_ node: HashMapNode<K,V>) -> HashMapNode<K,V>? {
        var child = node.left
        if child != nil { // node有左子节点
            while child?.right != nil { // node.left.right.right...
                child = child?.right
            }
            return child
        }else { // 没有左子节点
            
            var node = node
            while node.parent != nil && node == node.parent!.left {
                node = node.parent!
            }
            
            return node.parent
        }
        
    }
    
    /// 返回该节点的后继节点
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func successor(_ node: HashMapNode<K, V>) -> HashMapNode<K, V>? {
        var child = node.right
        if child != nil { // node有右子节点
            while child?.left != nil { // node.right.left.left...
                child = child?.left
            }
            return child
        }else { // 没有右子节点
            
            var node = node
            while node.parent != nil && node == node.parent!.right {
                node = node.parent!
            }
            
            return node.parent
        }
    }
    
    
    private func remove(node: HashMapNode<K, V>) {
        if node.isLeafNode() { // 是叶子节点，直接删除
            if node.parent == nil { // node是根节点且只有一个根节点
                table[getIndex(key: node.key)] = nil
            }else {
                if node == node.parent!.left { // 非根节点的叶子节点
                    node.parent?.left = nil
                }else {
                    node.parent?.right = nil
                }
            }
            afterRemove(node, replacement: nil)
        }else if node.hasTwoChild() { // 度为2的节点
            let succNode = successor(node)
            node.key = succNode!.key // 度为2一定有前驱
            node.value = succNode!.value
            remove(node: succNode!)
        }else { // 度为1的节点
            let replacement = node.left != nil ? node.left : node.right
            if node.parent == nil { // 度为1且是node是根节点
                if node.left != nil {
                    table[getIndex(key: node.key)] = replacement
                    node.left?.parent = nil
                }else {
                    table[getIndex(key: node.key)] = replacement
                    node.right?.parent = nil
                }
                afterRemove(node, replacement: replacement)
            }else if node.left != nil { // 左子节点不为空
                node.left!.parent = node.parent
                if node.parent?.left == node {
                    node.parent!.left = node.left
                }else {
                    node.parent?.right = node.left
                }
                afterRemove(node, replacement: replacement)
            }else { // 右子节点不为空
                node.right!.parent = node.parent
                if node.parent?.left == node {
                    node.parent!.left = node.right
                }else {
                    node.parent?.right = node.right
                }
                afterRemove(node, replacement: replacement)
            }
        }
        size -= 1
    }
    func createNode(_ key: K, value: V, parent: HashMapNode<K, V>?) -> HashMapNode<K, V> {
        return HashMapNode(key: key, value: value, parent: parent)
    }
    
    /// 添加节点后的操作
    /// - Parameter node: 新创建的节点
    func fixAfterPut(_ node: HashMapNode<K, V>) {
        if node.parent == nil { // node是根节点
            let _ = setColorToBlack(node)
            return
        }
        let node = setColorToRed(node)!
        if isBlack(node.parent) { // 父节点是黑色，无需处理
            return
        }
        let parent = node.parent!
        let grand = parent.parent!
        if !isRed(node.parent!.sibling()) {
            // uncle节点不是红色，需要把父节点染黑，祖父节点染红，然后根据3个节点的位置进行旋转
            
            let _ = setColorToRed(grand) // 不会上溢的添加，祖父节点一定会被染成红色
            if parent.isLeftChild() {
                if node.isLeftChild() { // LL
                    let _ = setColorToBlack(parent)
                    rorateRight(grand)
                }else { // LR
                    let _ = setColorToBlack(node)
                    rorateLeft(parent)
                    rorateRight(grand)
                }
            }else{
                if node.isLeftChild() { //RL
                    let _ = setColorToBlack(node)
                    rorateRight(parent)
                    rorateLeft(grand)
                }else { // RR
                    let _ = setColorToBlack(parent)
                    rorateLeft(grand)
                }
            }
        }else { // uncle节点是红色，需要上溢， LL LR RL RR的操作是一样的
            let uncle = parent.sibling()!
            let _ = setColorToBlack(parent)
            let _ = setColorToBlack(uncle)
            let _ = setColorToRed(grand)
            fixAfterPut(grand)
        }
        
    }
    
    
    /// 删除节点后的逻辑处理
    /// - Parameter node: <#node description#>
    func afterRemove(_ node: HashMapNode<K, V>, replacement: HashMapNode<K, V>?) {
        if isRed(node) { // 删除的节点是红色，无事发生
            return
        }
        // 删除度为1的黑色节点
        // 替代的节点是红色的
        if isRed(replacement) {
            let _ = setColorToBlack(replacement!) // replacement是红色一定不nil
            return
        }
        
        // 删除的是根节点，无事发生
        if node.parent == nil {
            return
        }
        
        /// node 在父节点的左边还是右边,
        let isLeft = node.parent?.left == nil || node.parent!.left == node
        var sibling = isLeft ? node.parent?.right : node.parent?.left
        if isLeft { // 被删除的节点在左边，兄弟节点在右边
            if isRed(sibling) { // 兄弟节点是红色
                // 兄弟节点染成黑色，父节点染成红色，左旋转变为兄弟节点是黑色的情况
                let _ = setColorToBlack(sibling)
                let _ = setColorToRed(node.parent)
                rorateLeft(node.parent!)
                
                // 将兄弟节点重新赋值
                sibling = node.parent?.right
            }
            
            // 兄弟节点是黑色
            // 兄弟节点的左右子节点都是黑色
            if isBlack(sibling?.left) && isBlack(sibling?.right) {
                let parentIsBlack = isBlack(node.parent)
                let _ = setColorToBlack(node.parent!)
                let _ = setColorToRed(sibling)
                if parentIsBlack {
                    afterRemove(node.parent!, replacement: nil)
                }
            }else { // 兄弟节点至少有一个红色子节点的情况，可以向兄弟节点借元素
                if isBlack(sibling?.right) {
                    rorateRight(sibling!)
                    sibling = node.parent?.right
                }
                let _ = setNodeTo((node.parent!).color, node:  sibling)
                let _ = setColorToBlack(sibling?.right)
                let _ = setColorToBlack(node.parent)
                rorateLeft(node.parent!)
            }
        }else {
            // 被删除的节点在右边
            if isRed(sibling) { // 兄弟节点是红色
                let _ = setColorToBlack(sibling)
                let _ = setColorToRed(node.parent)
                rorateRight(node.parent!) // 为了将兄弟节点的子节点变为兄弟节点，看作LL的情况右旋父节点
                
                // 重置sibling的值
                sibling = node.parent?.left
            }
            
            // 兄弟节点是黑色
            // 兄弟节点的左右子节点都是黑色,没有元素可以借，父节点下溢
            if isBlack(sibling?.left) && isBlack(sibling?.right) {
                let parentIsBlack = isBlack(node.parent)
                let _ = setColorToBlack(node.parent!)
                let _ = setColorToRed(sibling)
                if parentIsBlack {
                    afterRemove(node.parent!, replacement: nil)
                }
            }else { // 兄弟节点至少有一个红色子节点的情况，可以向兄弟节点借元素
                if isBlack(sibling?.left) { // 也就是兄弟节点的左边是nil 右边是红色子节点
                    rorateLeft(sibling!) // 这是LR的旋转 先左旋转兄弟，后右旋转父节点
                    sibling = node.parent?.left
                }
                let _ = (node.parent!.color, node:  sibling)
                let _ = setColorToBlack(sibling?.left)
                let _ = setColorToBlack(node.parent)
                rorateRight(node.parent!) // 两种情况都会右旋转
            }
        }
    }
    
    /// 将节点染成黑色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func setColorToBlack(_ node: HashMapNode<K, V>?) -> HashMapNode<K, V>? {
        return setNodeTo(.Black, node: node)
    }
    
    /// 将节点染成红色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func setColorToRed(_ node: HashMapNode<K, V>?) -> HashMapNode<K, V>? {
        return setNodeTo(.Red, node: node)
    }
    
    /// 节点染色
    /// - Parameters:
    ///   - color: <#color description#>
    ///   - node: <#node description#>
    /// - Returns: <#description#>
    func setNodeTo(_ color: RBNodeColor, node: HashMapNode<K, V>?) -> HashMapNode<K, V>? {
        if node == nil {
            return nil
        }
        node!.color = color
        return node
    }
    
    /// 获取节点的颜色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func colorOf(_ node: HashMapNode<K, V>?) -> RBNodeColor {
//        let node = node as? RBNode<K, V>
        return node == nil ? .Black : node!.color
    }
    
    /// 节点是否时黑色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func isBlack(_ node: HashMapNode<K, V>?) -> Bool {
//        let node = node as? RBNode
        return  node == nil || node?.color == .Black
    }
    
    /// 节点是否时红色
    /// - Parameter node: <#node description#>
    /// - Returns: <#description#>
    func isRed(_ node: HashMapNode<K, V>?) -> Bool {
        return !isBlack(node)
    }
}

extension HashMap where K: Comparable {
   
}

class HashMapNode<K: Hashable,V>: NSObject {
    var color: RBNodeColor = .Black
    var key: K
    var value: V
    var left: HashMapNode?
    var right: HashMapNode?
    var parent: HashMapNode?
    
    init(key: K, value: V, parent: HashMapNode<K, V>?) {
        self.key = key
        self.value = value
        self.parent = parent
        super.init()
    }
    
    /// 返回兄弟节点
    /// - Returns: <#description#>
    func sibling() -> HashMapNode<K, V>? {
        if parent == nil {
            return nil
        }
        
        if isLeftChild() {
            return parent!.right
        }else {
            return parent!.left
        }
    }
    
    /// 是否是叶子节点
    func isLeafNode() -> Bool {
        return left == nil && right == nil
    }
    
    /// 是否有两个子节点
    func hasTwoChild() -> Bool {
        return left != nil && right != nil
    }
    
    /// 是否是父节点的左子节点
    /// - Returns: <#description#>
    func isLeftChild() -> Bool {
        return parent != nil && self == parent?.left
    }
    
    /// 是否是父节点的右子节点
    /// - Returns: <#description#>
    func isRightChild() -> Bool {
        return parent != nil && self == parent?.right
    }
}


infix operator >>> :  BitwiseShiftPrecedence
extension Int {
    static func >>>(lhs:Int, rhs: Int) -> Int {
        if lhs >= 0 {
                return lhs >> rhs
            } else {
                return (Int.max + lhs + 1) >> rhs | (1 << (63-rhs))
            }
    }
}
