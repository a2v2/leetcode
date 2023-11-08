class Solution {

  enum Direction {
    case left, right, top, bottom

    func rotate() -> Direction {
      switch self {
        case .left: return .top
        case .bottom: return .left
        case .right: return .bottom
        case .top: return .right
      }
    }

    func pairIncrement() -> (i: Int, j: Int) {
      switch self {
        case .right: return (i: 0, j:+1)
        case .bottom: return (i: 1, j:0)
        case .left: return (i: 0, j:-1)
        case .top: return (i: -1, j:0)
      }
    }

  }

  func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    var m = matrix.count
    var n = matrix[0].count
    var direction: Direction = .right
    var a = 0, b = 0
    var spiralOrderArray: [Int] = [matrix[a][b]]
    var visited = Array(repeating: Array(repeating: false, count: n), count: m)
    visited[0][0] = true
    var justRotated = false
    while true {
      let (i,j) = direction.pairIncrement()

      let x = a + i, y = b + j

      if 0..<m ~= x, 0..<n ~= y, !visited[x][y]   {
        a = x
        b = y
        justRotated = false
        visited[a][b] = true
        spiralOrderArray.append(matrix[a][b])
      } else {
        if justRotated {
          break
        }
        direction = direction.rotate()
        justRotated = true
      }
    }
    return spiralOrderArray

  }
}
