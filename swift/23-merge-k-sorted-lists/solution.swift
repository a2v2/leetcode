/** 
 * 23. Merge k Sorted Lists
 * Solved
 * Hard

 * Topics
 * Companies
 * You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

 * Merge all the linked-lists into one sorted linked-list and return it.
 */

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

    let fakeHead = ListNode(-10001)
    var previousMin: ListNode? = nil
    var greatestMax: ListNode? = nil
    var localMin: ListNode? = nil

    // The idea would be to iterate over every list and verifiying the node reference 
    // For heach list, create a pointer to iterate over them
    // Calculate for each cycle which element is the minimum and which is the maximum (last)
    // Update the greaterMinimun to the current minimum because that indicates a new localminium

    func listToArray(_ list: ListNode?) -> [Int] {
        var array: [Int] = []
        var current: ListNode? = list

        while current != nil {
            array.append(current!.val)
            current = current?.next
        }

        return array
    }
 
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard !lists.isEmpty else { return nil }
        var listsNextNodes = lists.map { $0 }
        var referencesArray = listsNextNodes
        var reference: ListNode? = nil
        var iterator: ListNode? = nil
        var nextIterator: ListNode? = nil
        previousMin = fakeHead
        greatestMax = fakeHead
        while !referencesArray.isEmpty {
            listsNextNodes = []
            // Reinitialize localMin
            localMin = previousMin
            for i in 0..<referencesArray.count {
                reference = referencesArray[i]
                // either the reference has a value greater than to the previousMin
                // or has a value greater than greatestMax a.k.a last element
                
                if let unwrapped = reference {
                    // print("List:\(i+1)->: (\(unwrapped.val)), lMin:\(localMin!.val)  pMin:\(previousMin!.val), gMax::\(greatestMax!.val)")
                    if unwrapped.val >= greatestMax!.val {
                        // print("Greater")
                        greatestMax!.next = ListNode(unwrapped.val)
                        greatestMax = greatestMax!.next
                        greatestMax!.next = nil
                    } else {
                        // print("Inside")
                        // print(listToArray(previousMin))
                        // find the right spot, it would be >= node to check, next to this
                        iterator = previousMin
                        while iterator!.next != nil && iterator!.next!.val < unwrapped.val {
                            iterator = iterator!.next 
                        }
                        nextIterator = iterator!.next
                        iterator!.next = ListNode(unwrapped.val, nextIterator)
                        // update localMin, even if is the same value because would be the correct
                        // node connection to make. 
                        
                    }
                    reference = reference!.next
                    localMin = localMin!.val >= unwrapped.val ? unwrapped : localMin
                    listsNextNodes.append(reference)
                }
            }
            // update previousMin with localMin
            previousMin = localMin
            referencesArray = listsNextNodes
        }   
        return fakeHead.next
    }
}
