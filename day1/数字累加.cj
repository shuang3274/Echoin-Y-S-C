import std.env.*
import std.convert.*

main(): Int64 {

    var sum: Int64 = 0
    var num: Int64 = 1

    do {
        print("请输入您要累加的数(输入0后结束):")

         num = Int64.parse(getStdIn().readln().getOrThrow())
         sum += num
    }while(num !=0)

    println("\n您的累加结果为${sum}")

     println("\n输入回车后关闭界面")
     getStdIn().readln().getOrThrow()

    return 0
}