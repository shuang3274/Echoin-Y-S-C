import std.env.*        // 提供 getStdIn()，用于程序末尾暂停界面
import std.collection.* // 提供 HashMap 和 ArrayList

main (): Int64{
    let intervals = [(8, 10), (1, 3), (2, 6)]

    var ordered_data = maopao(intervals)

    var date = tanxing(ordered_data)

    print_system(date)
    
    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func maopao (raw_data: Array<(Int64, Int64)>): ArrayList<(Int64, Int64)>{                //冒泡排序
    var list = ArrayList<(Int64, Int64)>(raw_data)
    
    var i = 0
    var end = list.size - 1
    while (end > 0){
        if (list[i][0] > list[i + 1][0]){                                                //进结构
            let temp = list[i]
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

func tanxing (ordered_data: ArrayList<(Int64, Int64)>): ArrayList<(Int64, Int64)>{           //贪心算法
    var max_interval = ArrayList<(Int64, Int64)>()
    if (ordered_data.size == 0) {
        return max_interval
    } 
    
    var i = 1
    var relay = ordered_data[0]
    while (i < ordered_data.size){                                                   //将区间合并后加入max_interval
        if (relay[1] >= ordered_data[i][0]){
            var a = relay[0]

            var b: Int64 = relay[1]
            if (relay[1] <= ordered_data[i][1]){
                b = ordered_data[i][1]
            }

            relay = (a, b)
        }

        else{
            max_interval.add(relay)
            
            relay = ordered_data[i]
        }

        i++
    }
    max_interval.add(relay)

    return max_interval
}

func print_system (date: ArrayList<(Int64, Int64)>): Unit{                                //输出结果
    var i = 0
    println("以下是合并后的区间:")
    print("[")
    while (i < date.size){
        print("[${date[i][0]},${date[i][1]}]")

        i++

        if (i < date.size){
            print(",")
        }
    }
    print("]\n")
}