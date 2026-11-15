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
    var temp: (Int64, Int64)
    var end = list.size - 1
    while (end > 0){
        if (list[i][0] > list[i + 1][0]){                                                //进结构
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

func tanxing(ordered_data: ArrayList<(Int64, Int64)>): ArrayList<(Int64, Int64)> {       //AI部分
    var max_interval = ArrayList<(Int64, Int64)>()
    
    for (current in ordered_data) {
        // 如果结果集是空的，或者 当前区间的开头 > 结果集最后一个区间的结尾（说明没重叠）
        if (max_interval.size == 0 || current[0] > max_interval[max_interval.size - 1][1]) {
            max_interval.add(current) // 直接放进去当新的栈顶
        } 
        else {
            // 重叠了！取出栈顶元素
            let last = max_interval[max_interval.size - 1]
            
            // 算出最大的右端点
            let new_end = if (last[1] > current[1]) { last[1] } else { current[1] }
            
            // ★ 绝杀操作：直接改栈顶元素，不需要 remove + add！
            max_interval[max_interval.size - 1] = (last[0], new_end) 
        }
    }
    
    return max_interval
}

func print_system (date: ArrayList<(Int64, Int64)>): Unit{                                //输出结果
    var i = 0
    println("以下是合并后的区间:")
    while (i < date.size){
        print("[${date[i][0]},${date[i][1]}]")

        i++

        if (i < date.size){
            print(",")
        }
    }
}