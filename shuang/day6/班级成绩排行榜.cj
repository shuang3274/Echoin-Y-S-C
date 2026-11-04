import std.env.*

class Student{
    let name: String
    let score: Int64

    public init(name : String , score : Int64){
        this.name = name
        this.score = score
    }
}

main(): Int64 {
    
    let students = [                                                                     //学生名录
        Student("张三", 95),
        Student("李四", 88),
        Student("王五", 92),
        Student("赵六", 76)
    ]

    let overstu = studentsmaopao(students)

    var i = overstu.size - 1
    while(i >= 0){                                                                       //打印结构                                       
        print("${overstu[i].name}:${overstu[i].score}\n")

        i--
    }
    
    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}

func studentsmaopao(students: Array<Student>): Array<Student> {
    if (students.size == 0) {                                                              //检测数组是否为空
        println("没有输入学生信息")

        println("\n输入回车后关闭界面")
        getStdIn().readln().getOrThrow()

        return students
    }

    var i = 0
    var temp: Student
    var over = false
    var end = students.size - 1
    while(!over){                                                                        //冒泡循环
        if (i < end){
            if (students[i].score > students[i + 1].score){                    //进结构
                temp = students[i]
                students[i] = students[i + 1]
                students[i + 1] = temp
            }

            i++
        }

        else{
            i = 0
            end--
            while (true){
                if (i < end && students[i].score <= students[i + 1].score){
                    i++
                }

                else if (i < end && students[i].score > students[i + 1].score){
                    break
                }

                else{
                    over = true
                    break
                }
            }
            i = 0
        }
    }

    return students
}