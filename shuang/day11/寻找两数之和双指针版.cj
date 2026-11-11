import std.collection.* // 用 ArrayList 必须导入
import std.env.*        // 用 getStdIn() 接收输入必须导入

main(): Int64{
    var nums = [11, 2, 15, 7]
    var numbers= ArrayList<(Int64, Int64)>()
    var i = 0
    for (num in nums){                                                                   //将数字和原下底绑定
        numbers.add((num, i))
        i++
    }

    numbers = maopao(numbers)

    var left = 0
    var right = numbers.size - 1
    var over = false
    while (left < right){                                                                //输出可以满足条件的数字下底
        if (numbers[left][0] + numbers[right][0] == 9){
            println("找到了: ${numbers[left][1]} , ${numbers[right][1]}\n")
            over = true
            break
        }

        else if (numbers[left][0] + numbers[right][0] > 9){
            right--
        }

        else {
            left++
        }
    }

    if (!over){
        println("未找到符合的数")
    }

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func maopao (list: ArrayList<(Int64, Int64)>): ArrayList<(Int64, Int64)>{                //冒泡排序
    var i = 0
    var temp: (Int64, Int64)
    var end = list.size - 1
    while (end > 0){
        if (list[i][0] > list[i + 1][0]){                                       //进结构
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