import std.fs.*
import std.collection.* // 用 ArrayList 必须导入
import std.env.*        // 用 getStdIn() 接收输入必须导入
import std.convert.*

main() :Int64{
    let yuanshujuhang = String.fromUtf8(File.readFrom("D:\\chengxu\\cangjie\\only代码\\shuang\\day10\\scores.txt")).trimAscii()
    let yuanshuju = yuanshujuhang.split("\n")
    var shuju: ArrayList<Student> = ArrayList<Student>()
    for (part in yuanshuju){                                                   //对文件内数据进行读取与分割处理
        if (part.isEmpty()){
            continue
        }

        let x = part.split(",")

        if(x.size == 4){
            let s1 = Int64.parse(x[1].trimAscii())
            let s2 = Int64.parse(x[2].trimAscii())
            let s3 = Int64.parse(x[3].trimAscii())

            let total = s1 + s2 + s3
            
            let student = Student(x[0], total)
            shuju.add(student)
        }
    }

    shuju = maopao(shuju)

    var i = 1
    for (student in shuju){    
        print("第${i}名:${student.name} - 总分${student.totalscore}\n")
        
        i++
    }

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

class Student{
    let name: String 
    let totalscore: Int64

    init(name: String, totalscore: Int64){
        this.name = name
        this.totalscore = totalscore
    }
}

func maopao (list: ArrayList<Student>): ArrayList<Student>{              //冒泡排序
    var i = 0
    var end = list.size - 1
    while (end > 0){
        if (list[i].totalscore < list[i + 1].totalscore){                                       //退结构
            let temp = list[i]
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