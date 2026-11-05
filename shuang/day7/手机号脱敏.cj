import std.collection.* // 用 ArrayList 必须导入
import std.env.*        // 用 getStdIn() 接收输入必须导入

func tuoming(log:String): String{
    var back = ArrayList<String>()
    let fix = "手机号: "
    let parts = log.split(",")                                                 //将输入的值以逗号分割
    for (part in parts){
        let phone = part.trimAscii()                                               //整理格式，去除空格
        if (phone.startsWith(fix)){                                            //寻找有“手机号：”的一项
            let phonenumber = phone[fix.size..]
            if(phonenumber.size == 11){                                        //将带有“手机号：”的一项的保留部分赋予
                let before = phonenumber[..3]
                let after = phonenumber[7..11]

                back.add ("手机号: ${before}****${after}")                      //将保留部分以限定格式赋予
            }
            
            else{                                                              //将非更改部分赋予
                back.add (part)
            }
        }

        else{                                                                  //返回经过处理的元组
            back.add (part)
        }
    }

    return String.join(back.toArray(), delimiter:",")
}

main(): Int64 {
    let log = "用户: 张三, 手机号: 13812345678, 登录IP: 192.168.1.1"

    let puser = tuoming(log)

    print("${puser}")

    println("\n输入回车后关闭界面")
    getStdIn().readln().getOrThrow()

    return 0
}