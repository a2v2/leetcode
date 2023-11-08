class Solution {

    
    func evalRPN(_ tokens: [String]) -> Int {
        var stack: [Int] = []
        var a = 0, b = 0
        for token in tokens {
            switch token {
                case "+":
                    b = stack.removeLast()
                    a = stack.removeLast()
                    stack.append(a+b)
                case "-":
                    b = stack.removeLast()
                    a = stack.removeLast()
                    stack.append(a-b)
                case "*":
                    b = stack.removeLast()
                    a = stack.removeLast()
                    stack.append(a*b)
                case "/":
                    b = stack.removeLast()
                    a = stack.removeLast()
                    stack.append(a/b)
                default: 
                    stack.append(Int(token)!)
            }
        }
        return stack.last!
    }
}
