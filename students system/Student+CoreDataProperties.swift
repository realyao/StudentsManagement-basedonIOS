

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var snum: String?
    @NSManaged public var sname: String?
    @NSManaged public var ssex: String?
    @NSManaged public var sage: String?
    @NSManaged public var stel: String?

}
