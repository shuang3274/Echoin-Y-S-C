import std.collection.*
import std.env.* 
import std.convert.*

main(): Int64 {

var number = ArrayList<Int64>()
var i: Int64 = 0

while(true){                                                                             //将输入的数字存入数组中
    print("请输入数字(第${i + 1}个,输入非数字后结束):")
    let num = getStdIn().readln().getOrThrow().trimAscii()
    match(Int64.tryParse(num)){
        case Some(n) =>
            
            number.add(n)

            i = i + 1
    
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

let length = i
var temp: Int64
i = 1

while (true){                                                                            //神秘排序算法
    
    if (i > 0 && number[i] < number[i - 1]){                         //退结构
        temp = number[i]
        number[i] = number[i - 1]
        number [i - 1] = temp
        i--
    }
    
    else if (i < length - 1 && number [i] > number[i + 1]){          //进结构
        temp = number[i + 1]
        number[i + 1] = number[i]
        number [i] = temp
    }

    else{
        i++
        if (i == length){
            break
        }
    }
}

i = 0
while(i < length){                                                                       //打印结构
    print("${number[i]},")

    i = i + 1
}

println("\n输入回车后关闭界面")    
getStdIn().readln().getOrThrow()

return 0
}