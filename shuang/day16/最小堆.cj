import std.env.*        // 提供 getStdIn()，用于程序末尾暂停界面
import std.collection.* // 提供 HashMap 和 ArrayList
import std.convert.*    // 提供 parse

main (): Int64{
    let scores = [99, 92, 85, 78, 99, 88, 95]
    
    print("要输出前几位:")
    let number: Int64 = Int64.parse(getStdIn().readln().getOrThrow().trimAscii())

    let top = Heap_Screening(scores, number)

    print_system (top)

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func Heap_Screening (scores: Array<Int64>, number: Int64): Array<Int64>{
    if (number >= scores.size) {                                                         //防止数字不足
        var all_scores = scores.clone() 
        return maopao(all_scores)
    }

    var top = Array<Int64>(number, repeat: 0)

    var i = 0
    while (i < top.size){
        top[i] = scores[i]
    
        i++
    }

    top = maopao(top)

    for (j in number..scores.size){
        let score = scores[j]
        
        if (score > top[0]){                                                             //当top中出现新数字
            top[0] = score
            top = maopao (top)                                                           //重新排序
        }
    }

    return top
}

func maopao (list: Array<Int64>): Array<Int64>{                //冒泡排序
    var i = 0
    var end = list.size - 1
    while (end > 0){
        if (list[i] > list[i + 1]){                                       //进结构
            var temp = list[i]
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

func print_system (list: Array<Int64>): Unit{
    var i = list.size - 1
    print("前${list.size}位的分数为:[")
    while (i >= 0){
        print("${list[i]}")

        i--

        if (i >= 0){
            print(",")
        }
    }
    print ("]")
}