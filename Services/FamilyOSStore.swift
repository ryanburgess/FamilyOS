import Foundation
import SwiftUI
import Combine

@MainActor
final class FamilyOSStore: ObservableObject {
    @Published var selectedSection: AppSection = .today
    @Published var showingCreateEvent = true
    @Published var familyMembers: [FamilyMember] = []
    @Published var events: [FamilyEvent] = []
    @Published var reminders: [FamilyReminder] = []
    @Published var allowanceAccounts: [AllowanceAccount] = []
    @Published var allowanceActivity: [AllowanceActivity] = []
    @Published var chores: [Chore] = []
    @Published var destinations: [EventDestination] = []

    static let preview: FamilyOSStore = {
        let store = FamilyOSStore()
        store.loadPreviewData()
        return store
    }()

    func loadPreviewData() {
        familyMembers = [
            FamilyMember(name: "Ryan", role: "Family Administrator", avatarSystemName: "person.crop.circle.fill", color: .blue),
            FamilyMember(name: "Lisa", role: "Parent", avatarSystemName: "person.crop.circle.fill", color: .purple),
            FamilyMember(name: "Austin", role: "Kid", avatarSystemName: "face.smiling.fill", color: .green),
            FamilyMember(name: "Phoenix", role: "Kid", avatarSystemName: "heart.circle.fill", color: .orange)
        ]

        events = [
            FamilyEvent(title: "Austin – School", subtitle: "", startTime: "8:30 AM", location: "School", category: .school, people: ["Austin"]),
            FamilyEvent(title: "Lunch with Lisa", subtitle: "Joan’s on Third", startTime: "12:00 PM", location: "Joan’s on Third", category: .meal, people: ["Ryan", "Lisa"]),
            FamilyEvent(title: "Austin – Dentist Appt", subtitle: "Studio City Dental", startTime: "3:15 PM", endTime: "4:00 PM", location: "Studio City Dental", category: .appointment, people: ["Austin"]),
            FamilyEvent(title: "Soccer Practice", subtitle: "Sports Academy", startTime: "5:30 PM", location: "Sports Academy", category: .activity, people: ["Austin"]),
            FamilyEvent(title: "Family Dinner", subtitle: "Home", startTime: "7:00 PM", location: "Home", category: .family, people: ["Ryan", "Lisa", "Austin", "Phoenix"])
        ]

        reminders = [
            FamilyReminder(title: "Bring library books", owner: "Austin", dueLabel: "Tomorrow, 7:30 AM"),
            FamilyReminder(title: "Pack swim gear", owner: "Phoenix", dueLabel: "Tomorrow, 8:00 AM"),
            FamilyReminder(title: "Move allowance cash", owner: "Ryan", dueLabel: "Today"),
            FamilyReminder(title: "Sign field trip permission slip", owner: "Austin", dueLabel: "May 2")
        ]

        allowanceAccounts = [
            AllowanceAccount(kidName: "Austin", weeklyAmount: 5, owedAmount: 15, cashInSafe: 20, avatarSystemName: "face.smiling.fill", color: .green),
            AllowanceAccount(kidName: "Phoenix", weeklyAmount: 3, owedAmount: 6, cashInSafe: 9, avatarSystemName: "heart.circle.fill", color: .orange)
        ]

        allowanceActivity = [
            AllowanceActivity(dateLabel: "Apr 27", title: "Weekly allowance earned", kidName: "Austin", amount: 5, status: "Owed"),
            AllowanceActivity(dateLabel: "Apr 27", title: "Weekly allowance earned", kidName: "Phoenix", amount: 3, status: "Owed"),
            AllowanceActivity(dateLabel: "Apr 20", title: "Moved to cash", kidName: "Austin", amount: 10, status: "Cash"),
            AllowanceActivity(dateLabel: "Apr 20", title: "Moved to cash", kidName: "Phoenix", amount: 6, status: "Cash")
        ]

        chores = [
            Chore(kidName: "Austin", title: "Make bed", frequency: "Daily", completedDays: [0,1,2,3,4]),
            Chore(kidName: "Austin", title: "Homework", frequency: "Daily", completedDays: [0,2,3,4]),
            Chore(kidName: "Austin", title: "Feed Oliver", frequency: "Daily", completedDays: [0,1,2]),
            Chore(kidName: "Austin", title: "Take out trash", frequency: "Weekly", completedDays: [1]),
            Chore(kidName: "Austin", title: "Reading", frequency: "Daily", completedDays: [0,1]),
            Chore(kidName: "Phoenix", title: "Clean toys", frequency: "Daily", completedDays: [0,2,3,4]),
            Chore(kidName: "Phoenix", title: "Put pajamas away", frequency: "Daily", completedDays: [0,1,3]),
            Chore(kidName: "Phoenix", title: "Help set the table", frequency: "Daily", completedDays: [0,2,4]),
            Chore(kidName: "Phoenix", title: "Brush teeth", frequency: "Daily", completedDays: [0,1,2,3,4])
        ]

        destinations = [
            EventDestination(title: "Ryan Google Calendar", icon: "g.circle.fill", isEnabled: true),
            EventDestination(title: "Invite Lisa", icon: "person.crop.circle.badge.plus", isEnabled: true),
            EventDestination(title: "Family Dashboard", icon: "person.2", isEnabled: true),
            EventDestination(title: "Austin Dashboard", icon: "face.smiling", isEnabled: true),
            EventDestination(title: "Phoenix Dashboard", icon: "heart.circle", isEnabled: false),
            EventDestination(title: "Add reminder (1 day before)", icon: "bell", isEnabled: true),
            EventDestination(title: "Add reminder (1 hour before)", icon: "calendar.badge.clock", isEnabled: true)
        ]
    }
}
