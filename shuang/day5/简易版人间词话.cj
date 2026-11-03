import std.collection.*
import std.env.*

func findWords(verse: String, words: Array<String>): Array<String> {
    
    var yeswords = ArrayList<String> ()
    var wnum = 0
    
    while (wnum < words.size){                                                           //程序主体

        if (verse.contains(words[wnum])){
            var ynum = 0
            var over = false
            while (ynum < yeswords.size){
                if (words[wnum] ==yeswords[ynum]){                             //去重
                    over = true
                    break
                }

                ynum++
            }
            
            if (!over){
                yeswords.add(words[wnum])                                          //将符合条件的词存入动态数组
            }
        }
        
        wnum++
    }

    return yeswords.toArray() 
}

// ============================================================
// 以下全部是判题系统，不需要改
// ============================================================

// 复制并排序（冒泡），不修改原数组
func sortedCopy(a: Array<String>): Array<String> {
    var list = ArrayList<String>()
    for (x in a) {
        list.add(x)
    }
    var n = list.size
    var i = 0
    while (i < n - 1) {
        var j = 0
        while (j < n - 1 - i) {
            if (list[j] > list[j + 1]) {
                let t = list[j]
                list[j] = list[j + 1]
                list[j + 1] = t
            }
            j = j + 1
        }
        i = i + 1
    }
    return list.toArray()
}

// 比较两个数组是否"元素集合相同"（顺序无关，重复敏感）
func sameSet(a: Array<String>, b: Array<String>): Bool {
    if (a.size != b.size) {
        return false
    }
    let sa = sortedCopy(a)
    let sb = sortedCopy(b)
    var i = 0
    while (i < a.size) {
        if (sa[i] != sb[i]) {
            return false
        }
        i = i + 1
    }
    return true
}

// 把数组打印成 ["a", "b"] 的样子
func show(a: Array<String>): String {
    var s = "["
    var i = 0
    while (i < a.size) {
        if (i > 0) {
            s = s + ", "
        }
        s = s + "\"" + a[i] + "\""
        i = i + 1
    }
    return s + "]"
}

// 跑一个测试用例
func runTest(name: String, verse: String, words: Array<String>, expected: Array<String>): Bool {
    let actual = findWords(verse, words)
    if (sameSet(actual, expected)) {
        println("✅ PASS  ${name}")
        return true
    } else {
        println("❌ FAIL  ${name}")
        println("   verse    = \"${verse}\"")
        println("   words    = ${show(words)}")
        println("   期望     = ${show(expected)}")
        println("   实际返回 = ${show(actual)}")
        return false
    }
}

main(): Int64 {
    var passed = 0
    var total = 0

    // 1. 题目示例
    total = total + 1
    if (runTest("题目示例",
        "山外青山楼外楼",
        ["青山", "人", "楼", "山外"],
        ["青山", "楼", "山外"])) { passed = passed + 1 }

    // 2. 重复词去重（基础版会 FAIL，去重版才 PASS）
    total = total + 1
    if (runTest("重复词去重",
        "山外青山楼外楼",
        ["楼", "楼", "青山"],
        ["楼", "青山"])) { passed = passed + 1 }

    // 3. 空词库
    total = total + 1
    if (runTest("空词库",
        "山外青山楼外楼",
        [],
        [])) { passed = passed + 1 }

    // 4. 单字匹配 + 不匹配
    total = total + 1
    if (runTest("单字匹配",
        "山外青山楼外楼",
        ["山", "楼", "水"],
        ["山", "楼"])) { passed = passed + 1 }

    // 5. 词比诗句长，不应匹配
    total = total + 1
    if (runTest("词长于诗句",
        "楼",
        ["楼外楼", "楼"],
        ["楼"])) { passed = passed + 1 }

    // 6. 空诗句
    total = total + 1
    if (runTest("空诗句",
        "",
        ["山", "楼"],
        [])) { passed = passed + 1 }

    // 7. 重复词 + 部分不匹配
    total = total + 1
    if (runTest("重复且部分不匹配",
        "春眠不觉晓",
        ["春", "春", "秋", "眠"],
        ["春", "眠"])) { passed = passed + 1 }

    println("")
    println("通过 ${passed}/${total}")

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}