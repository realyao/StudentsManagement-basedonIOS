//  传值类
import Foundation

class Singleton {
    
   
    var text: String!
    
    private static let _singleton = Singleton()
    
    // 获取单例实例方法
    class func sharedInstance() ->Singleton {
        return _singleton
    }
    
    // 私有化init初始化方法，防止通过此方法创建对象
    private init() {
    }
}
