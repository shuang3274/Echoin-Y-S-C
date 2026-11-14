import std.collection.* // 提供 HashMap 和 ArrayList
import std.convert.*    // 提供 Int64.parse，用于把时间字符串转成数字
import std.env.*        // 提供 getStdIn()，用于程序末尾暂停界面

main(): Int64{
    let loglist = [
    "[10:00] [192.168.1.1] [500]",
    "[10:02] [192.168.1.1] [500]",
    "[10:05] [192.168.1.1] [500]",
    "[10:08] [192.168.1.1] [500]",  // 1.1 号 IP 满足条件，拉黑
    "[10:00] [192.168.1.2] [500]",
    "[10:20] [192.168.1.2] [500]",
    "[10:40] [192.168.1.2] [500]",
    "[11:00] [192.168.1.2] [500]",  // 1.2 号虽然也有 4 次 500，但跨度超过 10 分钟，不拉黑
    "[10:00] [192.168.1.3] [200]",  // 状态码不是 500，忽略
    "[10:01] [192.168.1.3] [404]",  // 状态码不是 500，忽略
    "[10:00] [192.168.1.4] [500]",
    "[10:05] [192.168.1.4] [500]",
    "[10:09] [192.168.1.4] [500]"   // 1.4 号只有 3 次，不满足“超过 3 次”，不拉黑
    ]

    var logs = ArrayList<String>()
    for (p in loglist){
        logs.add(p.replace("[", "").replace("]", ""))
    }

    var log = ArrayList<(String, String, String)>()
    for (path1 in logs){
        let path2 = path1.split(" ")
        log.add((path2[0], path2[1], path2[2]))
    }

    let blacklist = Blacklist(log)

    printSystem(blacklist)

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func Blacklist (logs: ArrayList<(String, String, String)>): ArrayList<String>{
    var coordinatelist = HashMap<String, ArrayList<Int64>>()
    for (p in logs){
        if (p[2].trimAscii() != "500"){                                                  //判断是否是报错
            continue
        }
        
        let time = p[0].split(":")
        let coordinate = Int64.parse(time[0]) * 60 + Int64.parse(time[1])

        if (coordinatelist.contains(p[1])){                                              //将时间坐标存入哈希表
            var timelist = coordinatelist.get(p[1]).getOrThrow()
            timelist.add(coordinate)
            /*coordinatelist.add(p[1], timelist)*/                                       //多余，原理是54行得到的timelist指向哈希表内的内存，所以对它的更改会直接作用到哈希表内
        }

        else{
            var timelist = ArrayList<Int64>()
            timelist.add(coordinate)
            coordinatelist.add(p[1], timelist)
        }
    }

    var blacklist = ArrayList<String>()
    for ((IP1, coordinate1) in coordinatelist){                  //将哈希表内的值进行条件判断，将符合条件的IP存入黑名单
        var coordinate = maopao(coordinate1)
        
        var i = 0
        while (i <= coordinate.size - 4){
            if (coordinate[i + 3] - coordinate[i] <= 10){
                blacklist.add(IP1)
                break
            }
            i++
        }
    }

    return blacklist
}

func maopao (list: ArrayList<Int64>): ArrayList<Int64>{                                  //冒泡排序
    var i = 0
    var temp: Int64
    var end = list.size - 1
    while (end > 0){
        if (list[i] > list[i + 1]){                                                       //进结构
            temp = list[i]
            list[i] = list[i + 1]
            list[i + 1] = temp
        }

        if (i == end - 1){
            i = 0
            end--
        }

        else{
            i++
        }
    }

    return list
}

func printSystem (list: ArrayList<String>): Unit{
    println("黑名单IP:")
    for (p in list){
        println("${p}")
    }
}