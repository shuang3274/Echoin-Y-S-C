import std.fs.*
import std.collection.*
import std.env.*

main(): Int64 {
    // ★ 核心修复：用 try-catch 包住可能崩溃的代码，如果报错会打印出来，而不是直接闪退
    try {
        let yuanshujuhang = String.fromUtf8(File.readFrom("D:\\chengxu\\cangjie\\only代码\\shuang\\day9\\records.txt")).trimAscii()
        let yuanshuju = yuanshujuhang.split("\n")
        var shuju = ArrayList<(String, String, String)>()
        
        for (part in yuanshuju) {
            if (part.isEmpty()) {                                                  // 跳过空行
                continue 
            }

            let x = part.split(",")
            if (x.size == 3) {
                let a = x[0].trimAscii()
                let b = x[1].trimAscii()
                let c = x[2].trimAscii()
                shuju.add((a, b, c))
            }
        }

        var timewith = HashMap<String, Int64>()
        for (part in shuju) {                                                      // 编辑哈希表
            if (timewith.contains(part[0])) {
                let count = timewith.get(part[0]).getOrThrow()
                timewith.add(part[0], count + 1)
            } else {
                timewith.add(part[0], 1)
            }
        }

        var timelist = ArrayList<(String, Int64)>()                                // 将哈希表导出为动态数组
        for ((userID, count) in timewith) {
            timelist.add((userID, count))
        }

        // 排序
        if (timelist.size > 0) {
            timelist = maopao(timelist)
        }

        // ==========================================
        // 🌟 队长任务：写入 result.txt
        // ==========================================
        var resultBuilder = StringBuilder()
        for (item in timelist) {
            resultBuilder.append("${item[0]}: ${item[1]}\n")
        }
        File.writeTo("result.txt", resultBuilder.toString().toArray())
        println("✅ 队长任务完成：统计结果已写入 result.txt")

        // ==========================================
        // 🌟 你的附加需求：按频次倒序打印原始记录
        // ==========================================
        var i = timelist.size - 1
        while (i >= 0) {
            for (dian in shuju) {
                if (dian[0] == timelist[i][0]) {
                    println("${dian[0]},${dian[1]},${dian[2]}")
                }
            }
            print("\n")
            i--
        }

    } catch (e: Exception) {
        // 如果发生任何错误，把错误信息打出来，这样你就知道为什么闪退了！
        println("❌ 程序运行发生错误！")
        println("错误原因: ${e.message}")
        println("请检查 records.txt 是否在正确的目录下，或者数据格式是否全部正确。")
    }

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func maopao(list: ArrayList<(String, Int64)>): ArrayList<(String, Int64)> {
    var i = 0
    var temp: (String, Int64)
    var end = list.size - 1
    while (end > 0) {
        if (list[i][1] > list[i + 1][1]) {                                     // 进结构
            temp = list[i]
            list[i] = list[i + 1]
            list[i + 1] = temp
        }

        if (i == end - 1) {
            i = 0
            end--
        } else {
            i++
        }
    }

    return list
}