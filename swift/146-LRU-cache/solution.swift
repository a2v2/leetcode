public typealias NodeValue = (key: Int, value: Int)
let NodeValueZero = (key: -1, value: -1)

public class ListNode {
  public var val: NodeValue
  public var next: ListNode?
  public var prev: ListNode?
  public init() { self.val = NodeValueZero; self.next = nil; }
  public init(_ val: NodeValue) { self.val = val; self.next = nil; }
  public init(_ val: NodeValue, _ next: ListNode?) { self.val = val; self.next = next; }
}


class LRUCache {

    let capacity: Int 
    let dummyHead: ListNode
    let dummyTail: ListNode
    var items: Int
    var cache: [Int: ListNode]

    init(_ capacity: Int) {
        self.capacity = capacity
        self.dummyHead = ListNode()
        self.dummyTail = ListNode()
        items = 0
        cache = [:]
    }

    private func evictLeastRecentlyUsedIfNeeded() {
        guard 
            let head = dummyHead.next,
            capacity - items == 0 else {
            return 
        }
        // Remove the head of the list
        let next: ListNode? = head.next
        dummyHead.next = next
        next?.prev = dummyHead

        // Invalidate element
        head.next = nil
        head.prev = nil
        cache[head.val.key] = nil
        // Update items amount
        items -= 1
    }

    private func updateMostRecentlyUsed(_ node: ListNode) {
        guard 
            let previous = node.prev,
            let next = node.next,
            let tail = dummyTail.prev,
            !(node === dummyTail.prev) 
        else {
            return 
        }
        // Update the place where the node was
        previous.next = next
        next.prev = previous

        // Update tail where node was
        tail.next = node
        node.next = dummyTail
        node.prev = tail
        dummyTail.prev = node
    }
    
    
    func get(_ key: Int) -> Int {
        guard let node = cache[key] else {
            return -1
        } 
        updateMostRecentlyUsed(node)
        return node.val.value
    }
    
    func put(_ key: Int, _ value: Int) {

        if let node = cache[key] {
            node.val = (key: key, value: value)
            updateMostRecentlyUsed(node)
        } else {
            evictLeastRecentlyUsedIfNeeded()
            let nodeValue: NodeValue = (key: key, value: value)
            let newNode = ListNode(nodeValue)
            if items == 0 {
                dummyHead.next = newNode
                dummyTail.prev = newNode
                newNode.prev = dummyHead
                newNode.next = dummyTail
            } else {
                let tail = dummyTail.prev
                tail?.next = newNode
                newNode.next = dummyTail
                newNode.prev = tail
                dummyTail.prev = newNode
            }
            cache[key] = newNode
            items += 1
        }
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
