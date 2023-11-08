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
    func pairSum(_ head: ListNode?) -> Int {
        // Get the middle of the list
        // Reverse it and compare it to the other middle
        // then head to head begin iterating and calculate the maximun
        // Time O(N+1/2N) Space O(1)
        var current: ListNode? = head
        var fast: ListNode? = head
        // 
        var previous: ListNode? = nil
        while fast?.next != nil {
            previous = current
            fast = fast!.next!.next
            current = current!.next
        }
        previous?.next = nil // the last element of the first middle should point to nil
        // // Now begin reversing, current is in the middle
        previous = nil

        var next: ListNode? = nil
        while current != nil {
            next = current?.next
            current?.next = previous
            previous = current
            current = next
        }
        // previous holds the beginning of reversed list, now calculate sum
        current = head 
        var maximumPair = 0
        while current != nil {
            maximumPair = max(maximumPair,current!.val+previous!.val)
            current = current?.next
            previous = previous?.next
        }
        return maximumPair
    }
}
