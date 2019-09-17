

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var cname: String?
    @NSManaged public var cnum: String?
    @NSManaged public var ccredit: String?

}
