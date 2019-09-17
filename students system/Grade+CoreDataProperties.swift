
import Foundation
import CoreData


extension Grade {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grade> {
        return NSFetchRequest<Grade>(entityName: "Grade")
    }

    @NSManaged public var cname: String?
    @NSManaged public var sname: String?
    @NSManaged public var grade: String?

}
