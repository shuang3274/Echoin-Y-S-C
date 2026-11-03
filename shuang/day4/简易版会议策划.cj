import std.collection.*
import std.env.*
import std.convert.*

main(): Int64 {

    var s = ArrayList<Int64>()
    var o = ArrayList<Int64>()
    var i: Int64 = 0
    while(true){                                                                         //将输入的数字存入数组中
        print("请以(起始时间,结束时间)格式输入会议信息(第${i + 1}个,输入非限定格式后结束):")
        let huiyi = getStdIn().readln().getOrThrow().trimAscii()

        let cleaned = huiyi                                                    //标准输入，方便处理
            .replace("（", "(")
            .replace("）", ")")
            .replace("，", ",")
            .replace("(", "")
            .replace(")", "")

            .trimAscii( )
        let parts = cleaned.split(",")                                         //以逗号为界分割
        if (parts.size != 2 ) {
            println("格式错误：需要 (a,b)形式,结束输入")
            break
        }

        let parta = Int64.tryParse(parts[0].trimAscii())                       //将分割的来的两部分分别赋与
        let partb = Int64.tryParse(parts[1].trimAscii())



        match((parta,partb)){                                                  //将会议的开始与结束记录
            case (Some(a),Some(b)) =>

            if (a >= b){
            println("需要a<b,结束输入")
            break
        }
            s.add(a)
            o.add(b)

            i = i + 1
    
            case _ =>

            println("您的输入无效,结束输入")
           
            break
        }

    }

    if (s.size == 0){                                                                    //若数组为空
        println("您输入了0个会议信息,无法比较")
        println("\n输入回车后关闭界面")
        getStdIn().readln().getOrThrow()
        return 0
    }

    if (s.size == 1){                                                                    //若数组为一
        println("您输入了1个会议信息,无法比较")
        println("\n输入回车后关闭界面")
        getStdIn().readln().getOrThrow()
        return 0
    }
    
    i = 0
    var n: Int64 = 0
    var over = false
    while(!over){                                                                        //判断主体
        if(i == s.size - 1){
            println("会议之间无冲突")
            break
        }
        
        while(true){
            n++

            if (s[i] < o[n] && s[n] < o[i]){
                println("会议之间有冲突")
                over = true
                break
            }

            if (n == s.size - 1){
                i++
                n = i
                break
            }
        }
    }

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}