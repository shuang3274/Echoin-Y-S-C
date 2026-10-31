import std.env.*
import std.collection.*
import std.convert.*

main(): Int64 {
    let number = ArrayList<Int64>()
    var ia: Int64 = 1

                                                                                         // 1. 录入数据
    while (true) {
        println("请输入数字（第${ia}个,输入非数字后结束):")
        let num = getStdIn().readln().getOrThrow().trimAscii()
        
        match (Int64.tryParse(num)) {
            case Some(n) =>
                if (n == 0) {
                    break                                                                // 输入 0 正常结束
                }
                number.add(n)
                ia = ia + 1
            case None =>
                println("您输入的不是数字，结束录入")
                break                                                                    // 输入非数字异常结束
        }
    }

                                                                                         // 2. 拦截空数组情况
    if (number.size == 0) {
        println("没有输入有效数字")
        println("\n输入回车后关闭界面")
        getStdIn().readln().getOrThrow()
        return 0
    }

                                                                                         // 3. 核心逻辑：一遍遍历找出 老大 和 老二
    var max = number[0]
    var nextmax = number[0]
    var hasSecond = false                                                                // 标记是否存在第二大的数（防全部相同）

    for (i in 1..number.size) {
        if (number[i] > max) {
            nextmax = max                                                                // 原来的老大退位当老二
            max = number[i]                                                              // 新老大诞生
            hasSecond = true                                                             // 因为有数字超越了原老大，说明肯定有老二
        } else if (number[i] < max) {
                                                                                         // 如果没超过老大，看看有没有资格当老二
            if (!hasSecond || number[i] > nextmax) {
                nextmax = number[i]
                hasSecond = true
            }
        }
    }

                                                                                         // 4. 输出结果
    if (hasSecond) {
        println("\n您输入的数中第二大的为:${nextmax}")
    } else {
        println("\n没有第二大的数（所有输入的数字都相同）")
    }

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}