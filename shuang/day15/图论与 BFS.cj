import std.env.*        // 提供 getStdIn()，用于程序末尾暂停界面
import std.collection.* // 提供 HashMap 和 ArrayList

main (): Int64{
    let maze = [
        [0, 0, 0],
        [0, 1, 0],
        [0, 0, 0]
    ]

    let short_est = BFS(maze)

    print_system(short_est)

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func BFS (maze: Array<Array<Int64>>): Int64{
    let n = maze.size
    let m = maze[0].size

    if (maze[0][0] == 1 || maze[n - 1][m - 1] == 1) {                                    //起点或终点就是墙则无解
        return -1
    }

    if (n == 1 && m == 1) {                                                              //起点和终点重合，只需零步
        return 0
    }

    var location = ArrayList<(Int64, Int64)>()                                           //BFS三工具
    location.add((0,0))
    var step = 0
    var dist = ArrayList<ArrayList<Int64>>()
    for (i in 0..n) {
        var row = ArrayList<Int64>()
        for (j in 0..m) {
            row.add(-1)
        }
        dist.add(row)
    }
    dist[0][0] = 0
    let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    while (step < location.size){                                                        //广度优先搜索（BFS）
        var n1 = location[step][0]
        var m1 = location[step][1]

        step++

        for (dir in dirs){
            let n2 = n1 + dir[0]
            let m2 = m1 + dir[1]

            if (n2 >= 0 && n2 < n && m2 >= 0 && m2 < m){                                 //边界 检测
                if (maze[n2][m2] == 0 && dist[n2][m2] == -1){                            //路+未走过 检测
                    location.add((n2, m2))
                    dist[n2][m2] = dist[n1][m1] + 1

                    if ((n2, m2) == (n - 1, m - 1)){
                        return dist[n2][m2]
                    }
                }
            }
        }
    }

    return -1
}

func print_system(short_est: Int64): Unit{
    println("以下是结果:")
    if (short_est == -1){
        println("无解")
    }

    else{
        println("步数最少为:${short_est}")
    }
}