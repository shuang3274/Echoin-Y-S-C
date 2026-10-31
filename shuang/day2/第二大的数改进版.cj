import std.env.*
import std.collection.*
import std.convert.*

main(): Int64{

let number = ArrayList<Int64>()
var ia: Int64 = 1

while(true){                                                                             //将输入的数字存入数组中

    print("请输入数字（第${ia}个,输入非数字后结束):")
    let num = getStdIn().readln().getOrThrow().trimAscii()
    match(Int64.tryParse(num)){

        case Some(n) => 

        number.add(n)

        ia = ia + 1

        case None => 
            println("您输入的不是数字，结束录入")
            break
        
    }


}

if (number.size == 0) {                                                                  //检测数组是否为空
    println("没有输入有效数字")

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

if (number.size == 1) {                                                                  //检测数组是有第二个数
    println("没有第二大的数")

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

var ie = 0
var min = number[ie]

while(ie < number.size - 1){                                                             //比较数字的大小+将最小的数字记录

    if(min >= number[ie +1]) {
        min = number[ie +1]
        }

    ie = ie + 1
}

var ic = 0

while(ic < number.size){                                                                 //去掉最大的数

    if(number[ic] == max){
        number[ic] = min - 1
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