// https://leetcode.com/problems/odd-even-linked-list

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func oddEvenList(_ head: ListNode?) -> ListNode? {
        guard let head = head, let firstEven = head.next else {
            return head
        }
        // Keep track of a current pointer and if it is even or odd ocasion
        var odd = true //the first element is odd, the second it is not
        var dummyHead: ListNode = ListNode(0)
        var lastOdd: ListNode? = dummyHead
        var lastEven: ListNode? = firstEven
        var current: ListNode? = head
        // when checking for an odd, added to the lastOdd and reconnect to the next
        while current != nil {
            var next = current?.next
            if odd {
                lastOdd?.next = current
                lastOdd = current
                
            } else {
                lastEven?.next = current
                lastEven = current
            }
            current = next
            odd = !odd
        }
        lastOdd?.next = firstEven
        lastEven?.next = nil
        return dummyHead.next
    }
}
