enum Rule {
  case dies(Int,Int)
  case lives(Int,Int)
}

let directions = [(1,1),(1,-1),(-1,1),(-1,-1),(0,1),(0,-1),(1,0),(-1,0)]

class Solution {
  func gameOfLife(_ board: inout [[Int]]) {

    let m = board.count
    let n = board[0].count


    func liveNeighbors(_ i: Int,_ j: Int) -> Int {

      var neighbors = 0
      for (a,b) in directions {
        let (p,q) = (i + a,j + b)
        switch(p,q) {
        case(0..<m, 0..<n):
          neighbors += board[p][q]
        default:
          break
        }

      }
      return neighbors
    }

    var decisions: [Rule] = []
    var isLiveCell = false
    for i in 0..<m {
      for j in 0..<n {
        isLiveCell = board[i][j] == 1
        let amountNeighbors = liveNeighbors(i,j)
        switch (isLiveCell,amountNeighbors) {
        case (true,2...3) : fallthrough
        case (false,3):
          decisions.append(.lives(i,j))
        case (true,_):
          decisions.append(.dies(i,j))
        default:
          break
        }
      }
    }
    for decision in decisions {
      switch decision {
      case .lives(let i, let j):
        board[i][j] = 1
      case .dies(let i, let j):
        board[i][j] = 0
      }
    }
  }
}
