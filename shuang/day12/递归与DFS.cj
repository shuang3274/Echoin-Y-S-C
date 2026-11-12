import std.collection.*
import std.env.*

main (): Int64{
    let nums = [1,2,3,4,5]

    var result = permute (nums)
    var n = 0 
    for (p in result) {
        print("{")
        for(number in p){
            print("${number} ")
            n++
        }
        print("} \n")

        if(n%25 == 0){
            print("\n")
            n = 0
        }
    }

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func permute (numbers: Array<Int64>): ArrayList<ArrayList<Int64>>{
    var path = ArrayList<Int64>()
    var used = Array<Bool>(numbers.size , repeat: false)
    var result = ArrayList<ArrayList<Int64>>()

    DFS(numbers, path, used, result)

    return result
}

func DFS (numbers: Array<Int64>, path: ArrayList<Int64>, used: Array<Bool> ,result: ArrayList<ArrayList<Int64>>): Unit{
    if (path.size == numbers.size){                                             //检测到到备用库数字用光，将路径计入结果
        result.add(path.clone())

        return
    }

    for (i in 0..numbers.size){
        if (!used[i]){
            path.add(numbers[i])
            used[i] = true
            
            DFS(numbers, path, used, result)

            used[i] = false
            path.remove(at: path.size - 1)
        }
    }
}