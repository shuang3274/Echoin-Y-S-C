import std.collection.* // 用 ArrayList 必须导入
import std.env.*        // 用 getStdIn() 接收输入必须导入

main(): Int64{
    var nums = [11, 2, 15, 7]
    var n = 0
    var numbers = HashMap<Int64, Int64>()
    var over = false
    while (n < nums.size){
        let other = 9 - nums[n]

        if (numbers.contains(other)){
            let otherin = numbers.get(other).getOrThrow()
            println("找到了:${otherin},${n}")
            over = true
            break   
        }

        numbers.add(nums[n], n)
        n++
    }

    if (!over){
        println("未找到符合的数")
    }

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}