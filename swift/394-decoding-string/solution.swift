// https://leetcode.com/problems/decode-string/

extension String {
    static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else {
            return ""
        }

        var result = lhs
        for _ in 1..<rhs {
            result += lhs
        }

        return result
    }

    func intValue () -> Int {
        return Int(self)!
    }
}

class Solution {
    func decodeString(_ s: String) -> String {
        let array = Array(s)
        var encodedStack:[String] = []
        var currentRepetition: [Int] = [1]
        var currentEncoded = ""
        var repetionString = ""
        for char in array {
            switch (char) {
                case "0"..."9":
                    repetionString.append(char)
                case "[": 
                    currentRepetition.append(repetionString.intValue())
                    repetionString = ""
                    encodedStack.append(currentEncoded)
                    currentEncoded = ""
                case "]": 
                // When closing, direct apply the repeation of current encoded 
                // Take the first of the stack and attach it at its tail and continue
                    currentEncoded = currentEncoded * currentRepetition.removeLast()
                    currentEncoded = encodedStack.removeLast() + currentEncoded
                default: 
                    currentEncoded.append(char)
            }
        }
        return currentEncoded
    }
}
