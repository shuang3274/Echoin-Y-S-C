import std.fs.*
import std.collection.* // 用 ArrayList 必须导入
import std.env.*        // 用 getStdIn() 接收输入必须导入

main() :Int64{
    let yuanshujuhang = String.fromUtf8(File.readFrom("D:\\chengxu\\cangjie\\only代码\\shuang\\day9\\records.txt")).trimAscii()
    let yuanshuju = yuanshujuhang.split("\n")
    var shuju: ArrayList<(String, String, String)> = ArrayList<(String, String, String)>()
    for (part in yuanshuju){
        if (part.isEmpty()) {                                                  // 跳过空行
            continue 
        }

        let x = part.split(",")

        if (x.size == 3){
            let a = x[0].trimAscii()
            let b = x[1].trimAscii()
            let c = x[2].trimAscii()

            shuju.add((a, b, c))
        }
    }

    var timewith = HashMap<String, Int64>()
    for (part in shuju){                                                       //编辑哈希表
        if (timewith.contains(part[0])){
            let count = timewith.get(part[0]).getOrThrow()
            timewith.add(part[0], count + 1)
        }

        else{
            timewith.add(part[0], 1)
        }
    }

    var timelist= ArrayList<(String, Int64)>()                                 //将哈希表导出为动态数组
    for ((userID, count) in timewith){
        timelist.add((userID, count))
    }

    timelist = maopao(timelist)

    for (part in timelist){
        for (dian in shuju){
            if(dian[0] == part[0]){
                println("${dian[0]},${dian[1]},${dian[2]}")
            }
        }
        print("\n")
    }

    var giveresult = StringBuilder()
    for(give in timelist){
        giveresult.append("${give[0]}: ${give[1]}\n")
    }
    File.writeTo("D:\\chengxu\\cangjie\\only代码\\shuang\\day9\\result.txt", giveresult.toString().toArray())
    println("已将频次写入 result.txt")
    

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func maopao (list: ArrayList<(String, Int64)>): ArrayList<(String, Int64)>{
    var i = 0
    var temp: (String, Int64)
    var end = list.size - 1
    while (end > 0){
        if (list[i][1] <list[i + 1][1]){                                       //退结构
            temp = list[i]
            list[i] = list[i + 1]
            list[i + 1] = temp
        }

        if (i == end - 1){
            i = 0
            end--
        }

        else{
            i++
        }
    }

    return list
}