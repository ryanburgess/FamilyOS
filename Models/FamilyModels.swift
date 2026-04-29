import Foundation
import SwiftUI

enum AppSection: String, CaseIterable, Identifiable {
    case today = "Today"
    case calendar = "Calendar"
    case reminders = "Reminders"
    case kids = "Kids"
    case chores = "Chores"
    case allowance = "Allowance"
    case dashboards = "Dashboards"
    case settings = "Settings"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .today: "calendar"
        case .calendar: "calendar.badge.clock"
        case .reminders: "checklist"
        case .kids: "person.2"
        case .chores: "checkmark.circle"
        case .allowance: "dollarsign.circle"
        case .dashboards: "rectangle.grid.2x2"
        case .settings: "gearshape"
        }
    }
}

struct FamilyMember: Identifiable, Hashable {
    let id: UUID
    var name: String
    var role: String
    var avatarSystemName: String
    var color: Color

    init(id: UUID = UUID(), name: String, role: String, avatarSystemName: String, color: Color) {
        self.id = id
        self.name = name
        self.role = role
        self.avatarSystemName = avatarSystemName
        self.color = color
    }
}

struct FamilyEvent: Identifiable, Hashable {
    let id: UUID
    var title: String
    var subtitle: String
    var date: Date
    var startTime: String
    var endTime: String?
    var location: String
    var category: EventCategory
    var people: [String]

    init(id: UUID = UUID(), title: String, subtitle: String = "", date: Date = .now, startTime: String, endTime: String? = nil, location: String = "", category: EventCategory = .family, people: [String] = []) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
        self.category = category
        self.people = people
    }
}

enum EventCategory: String, CaseIterable, Identifiable {
    case school = "School"
    case appointment = "Appointment"
    case family = "Family"
    case activity = "Activity"
    case meal = "Meal"

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .school: .blue
        case .appointment: .green
        case .family: .purple
        case .activity: .orange
        case .meal: .pink
        }
    }
}

struct FamilyReminder: Identifiable, Hashable {
    let id: UUID
    var title: String
    var owner: String
    var dueLabel: String
    var isComplete: Bool

    init(id: UUID = UUID(), title: String, owner: String, dueLabel: String, isComplete: Bool = false) {
        self.id = id
        self.title = title
        self.owner = owner
        self.dueLabel = dueLabel
        self.isComplete = isComplete
    }
}

struct AllowanceAccount: Identifiable, Hashable {
    let id: UUID
    var kidName: String
    var weeklyAmount: Decimal
    var owedAmount: Decimal
    var cashInSafe: Decimal
    var avatarSystemName: String
    var color: Color

    init(id: UUID = UUID(), kidName: String, weeklyAmount: Decimal, owedAmount: Decimal, cashInSafe: Decimal, avatarSystemName: String, color: Color) {
        self.id = id
        self.kidName = kidName
        self.weeklyAmount = weeklyAmount
        self.owedAmount = owedAmount
        self.cashInSafe = cashInSafe
        self.avatarSystemName = avatarSystemName
        self.color = color
    }
}

struct AllowanceActivity: Identifiable, Hashable {
    let id: UUID
    var dateLabel: String
    var title: String
    var kidName: String
    var amount: Decimal
    var status: String

    init(id: UUID = UUID(), dateLabel: String, title: String, kidName: String, amount: Decimal, status: String) {
        self.id = id
        self.dateLabel = dateLabel
        self.title = title
        self.kidName = kidName
        self.amount = amount
        self.status = status
    }
}

struct Chore: Identifiable, Hashable {
    let id: UUID
    var kidName: String
    var title: String
    var frequency: String
    var completedDays: Set<Int>

    init(id: UUID = UUID(), kidName: String, title: String, frequency: String, completedDays: Set<Int>) {
        self.id = id
        self.kidName = kidName
        self.title = title
        self.frequency = frequency
        self.completedDays = completedDays
    }
}

struct EventDestination: Identifiable, Hashable {
    let id: UUID
    var title: String
    var subtitle: String
    var icon: String
    var isEnabled: Bool

    init(id: UUID = UUID(), title: String, subtitle: String = "", icon: String, isEnabled: Bool) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.isEnabled = isEnabled
    }
}
