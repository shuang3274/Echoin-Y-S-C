import std.env.*        // 提供 getStdIn()，用于程序末尾暂停界面
import std.collection.* // 提供 HashMap 和 ArrayList

main (): Int64{
    let nums = [2, 7, 9, 3, 1]

    let max = Dynamic_Programming(nums)

    Print_System(max)

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func Dynamic_Programming (nums: Array<Int64>): Int64{
    var max_sum = ArrayList<Int64>()
    max_sum.add(0)
    
    if (nums.size == 0){                                                                  //若输入了零个数
        return max_sum[0]
    }

    max_sum.add(nums[0])

    if (nums.size == 1){                                                                  //若输入了一个数
        return max_sum[1]
    }

    if (nums[0] > nums[1]) {
        max_sum.add(nums[0])
    } 
    
    else {
        max_sum.add(nums[1])
    }

    for (i in 2..nums.size){                                                                   //将比较得到的大数，即局部最优，加入队尾
    let skip = max_sum[i]

    let take = max_sum[i - 1] + nums[i]

    max_sum.add(Max(skip, take))    
    }

    return max_sum[max_sum.size - 1]
}

func Max (a: Int64, b: Int64): Int64{
    if (a >= b){
        return a
    }

    else{
        return b
    }
}

func Print_System (num: Int64): Unit{
    print("最多能拿${num}元")
}