import std.env.*
import std.collection.*
import std.convert.*

main(): Int64{

let number = ArrayList<Int64>()
var ia: Int64 = 1

while(true){                                                                             //将输入的数字存入数组中

    println("请输入数字（第${ia}个,输入0后结束):")
    let num = Int64.parse(getStdIn().readln().getOrThrow().trimAscii())

    if(num == 0){
    break
    }

    number.add(num)

    ia = ia + 1
}

if (number.size == 0) {                                                                  //检测数组是否为空
        println("没有输入有效数字")

        println("\n输入回车后关闭界面")
        getStdIn().readln().getOrThrow()

        return 0
}

var ib = 0
var max = number[ib]

while(ib < number.size - 1){                                                             //比较数字的大小+将最大的数字记录

    if(max <= number[ib +1]) {
    max = number[ib +1]
    }

    ib = ib + 1
}

var ic = 0

while(ic < number.size){                                                                 //去掉最大的数

    if(number[ic] == max){
    number[ic] = 0
    }

    ic = ic + 1
}

var id = 0
var nextmax = number[id]

while(id < number.size - 1){                                                             //比较数字的大小+将第二大的数字记录

    if(nextmax <= number[id +1]) {
    nextmax = number[id +1]
    }

    id = id + 1
}

println("\n您输入的数中第二大的为:${nextmax}")

     println("\n输入回车后关闭界面")
     getStdIn().readln().getOrThrow()

    return 0
}
