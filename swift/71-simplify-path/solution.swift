class Solution {
    var simplifiedPath: [String] = []
    var pathElements: [String] = []
    func simplifyPath(_ path: String) -> String {
        pathElements = path.components(separatedBy: "/").filter { !$0.isEmpty }
        for element in pathElements {
            switch element {
                case ".": 
                    continue
                case "..":
                    if !simplifiedPath.isEmpty {
                        simplifiedPath.removeLast()
                    }
                default: 
                    simplifiedPath.append(element)
            }
        }
        return "/\(simplifiedPath.joined(separator: "/"))"
    }
}
