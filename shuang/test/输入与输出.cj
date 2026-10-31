import std.env.*
import std.convert.*

main(): Int64 {
    print("请输入文本：")
    var num = Int64.parse(getStdIn().readln().getOrThrow())
    println("您输入了:${num}")

        print("按回车键退出...")
    getStdIn().readln().getOrThrow()

    return 0
}