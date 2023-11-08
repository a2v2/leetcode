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
    func deleteMiddle(_ head: ListNode?) -> ListNode? {
        // Use slow fast pointer approach. 
        // When faster pointer reaches the end, means the slowest has the middle
        var dummyHead = ListNode(0) // In case
        dummyHead.next = head
        var slow: ListNode? = head
        var fast: ListNode? = head
        var slowPrev: ListNode? = dummyHead
        while fast?.next != nil {
            slowPrev = slow
            slow = slow?.next
            fast = fast?.next?.next
        }
        slowPrev?.next = slow?.next
        return dummyHead.next
    }
}
