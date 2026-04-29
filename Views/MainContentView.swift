import SwiftUI
import Foundation

struct MainContentView: View {
    @EnvironmentObject private var store: FamilyOSStore

    var body: some View {
        switch store.selectedSection {
        case .today:
            TodayDashboardView()
        case .calendar:
            PlaceholderSectionView(title: "Calendar", subtitle: "Upcoming family events will live here.", icon: "calendar.badge.clock")
        case .reminders:
            PlaceholderSectionView(title: "Reminders", subtitle: "Create once, route to FamilyOS, Apple Reminders, or kid dashboards.", icon: "checklist")
        case .kids:
            PlaceholderSectionView(title: "Kids", subtitle: "Profiles for Austin and Phoenix, including dashboard visibility rules.", icon: "person.2")
        case .chores:
            ChoresView()
        case .allowance:
            AllowanceView()
        case .dashboards:
            PlaceholderSectionView(title: "Dashboards", subtitle: "Future exports for Austin's existing web dashboard JSON.", icon: "rectangle.grid.2x2")
        case .settings:
            PlaceholderSectionView(title: "Settings", subtitle: "Family members, integrations, and local data paths.", icon: "gearshape")
        }
    }
}

struct PlaceholderSectionView: View {
    let title: String
    let subtitle: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.secondary)
                Text(title)
                    .font(.largeTitle.bold())
            }

            Text(subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding(28)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
