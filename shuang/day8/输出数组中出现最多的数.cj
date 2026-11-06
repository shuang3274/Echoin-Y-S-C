import std.collection.* // 用 ArrayList 必须导入
import std.env.*        // 用 getStdIn() 接收输入必须导入

func zuiduo(numbers: Array<Int64>): ArrayList<(Int64,Int64)>{
    if (numbers.size == 0){
        return ArrayList<(Int64, Int64)>() 
    }

    var timewith = HashMap<Int64, Int64>()

    for (num in numbers){                                                                //编辑哈希表
        if (timewith.contains(num)){
            let count = timewith.get(num).getOrThrow()                         //将哈希表里符合的项的第二值加一
            timewith.add(num,count + 1)
        }

        else{
            timewith.add(num,1)                                                //初始化哈希表内第一次出现的值
        }
    }

    var maxtime: Int64 = 0
    var max = ArrayList<(Int64,Int64)>()
    for ((a,b) in timewith){                                                             //将哈希表里的每个最多出现的数带着次数返回
        if (b > maxtime){
            maxtime = b

            max.clear()
            max.add((a,b))
        }

        else if (b == maxtime){
            max.add((a,b))
        }

        else {}
    }

    return max
}

main(): Int64{
    let nums = [3,4,5,5,3,8,7,6,3,4,4,5,8,3,5]

    let maxnumbers = zuiduo(nums)

    if (maxnumbers.size == 0){
        print("您没有输入数字")

        println("\n输入回车后关闭界面")
        getStdIn().readln().getOrThrow()

        return 0
    }

    for (i in maxnumbers){
        println("${i[0]}最多，出现了${i[1]}次")
    }

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}
