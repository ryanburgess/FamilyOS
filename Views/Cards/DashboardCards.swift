import SwiftUI

struct ScheduleCard: View {
    let events: [FamilyEvent]

    var body: some View {
        CardView(title: "Today’s Schedule", systemImage: "calendar") {
            VStack(spacing: 13) {
                ForEach(events) { event in
                    HStack(alignment: .top, spacing: 12) {
                        Text(event.startTime)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                            .frame(width: 58, alignment: .leading)
                        Circle().fill(event.category.color).frame(width: 7, height: 7).padding(.top, 5)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(event.title).font(.system(size: 12, weight: .medium))
                            if !event.subtitle.isEmpty { Text(event.subtitle).font(.system(size: 11)).foregroundStyle(.secondary) }
                        }
                        Spacer()
                    }
                }
            }
            LinkRow(title: "View full calendar")
        }
    }
}

struct RemindersCard: View {
    let reminders: [FamilyReminder]

    var body: some View {
        CardView(title: "Reminders", systemImage: "bell") {
            VStack(spacing: 13) {
                ForEach(reminders) { reminder in
                    HStack(alignment: .top, spacing: 10) {
                        Circle().stroke(Color.secondary.opacity(0.5), lineWidth: 1.2).frame(width: 14, height: 14).padding(.top, 2)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(reminder.title).font(.system(size: 12, weight: .medium))
                            Text(reminder.owner).font(.system(size: 11)).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(reminder.dueLabel)
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(reminder.dueLabel == "Today" ? .blue : .orange)
                    }
                }
            }
            LinkRow(title: "View all reminders")
        }
    }
}

struct AllowanceOverviewCard: View {
    let accounts: [AllowanceAccount]

    var body: some View {
        CardView(title: "Allowance Overview", systemImage: "dollarsign.circle") {
            VStack(spacing: 12) {
                ForEach(accounts) { account in
                    HStack(spacing: 10) {
                        AccountAvatarView(account: account, size: 40)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(account.kidName).font(.system(size: 12, weight: .semibold))
                            Text("Weekly allowance: \(money(account.weeklyAmount))").font(.system(size: 11)).foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Owed").font(.system(size: 10)).foregroundStyle(.secondary)
                            Text(money(account.owedAmount)).font(.system(size: 12, weight: .bold)).foregroundStyle(.red)
                            Text("Cash in safe").font(.system(size: 10)).foregroundStyle(.secondary)
                            Text(money(account.cashInSafe)).font(.system(size: 12, weight: .bold)).foregroundStyle(.green)
                        }
                    }
                    if account.id != accounts.last?.id { Divider() }
                }
            }
            LinkRow(title: "View allowance")
        }
    }
}

struct WeatherCard: View {
    let weather: CurrentWeather?
    let isLoading: Bool
    let errorMessage: String?

    var body: some View {
        CardView(title: "Studio City, CA", systemImage: "") {
            HStack(alignment: .center, spacing: 20) {
                Text(weather?.symbol ?? "☀️")
                    .font(.system(size: 46))

                VStack(alignment: .leading, spacing: 4) {
                    Text(weather.map { "\($0.temperature)°" } ?? "--°")
                        .font(.system(size: 42, weight: .light))
                    Text(statusText)
                        .font(.system(size: 12))
                    Text(weather.map { "H: \($0.highTemperature)°   L: \($0.lowTemperature)°" } ?? "H: --°   L: --°")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
            }

            HStack {
                WeatherHour(label: "Now", temperature: weather.map { "\($0.temperature)°" } ?? "--°", symbol: weather?.symbol ?? "☀️")
                WeatherHour(label: "10AM", temperature: "--°", symbol: "☀️")
                WeatherHour(label: "11AM", temperature: "--°", symbol: "☀️")
                WeatherHour(label: "12PM", temperature: "--°", symbol: "☀️")
                WeatherHour(label: "1PM", temperature: "--°", symbol: "☀️")
            }
        }
    }

    private var statusText: String {
        if let weather {
            return weather.condition
        }

        if isLoading {
            return "Loading…"
        }

        if let errorMessage {
            return errorMessage
        }

        return "Loading…"
    }
}

private struct WeatherHour: View {
    let label: String
    let temperature: String
    let symbol: String

    var body: some View {
        VStack(spacing: 6) {
            Text(symbol)
                .font(.system(size: 14))
            Text("\(label)\n\(temperature)")
                .multilineTextAlignment(.center)
                .font(.system(size: 10))
        }
        Spacer()
    }
}

struct WeekCard: View {
    var body: some View {
        CardView(title: "This Week", systemImage: "calendar") {
            VStack(spacing: 11) {
                weekRow("Thu", "May 1", "School Event", "All day")
                weekRow("Fri", "May 2", "Pizza Night", "6:30 PM")
                weekRow("Sat", "May 3", "Soccer Game", "10:00 AM")
                weekRow("Sun", "May 4", "Family Hike", "9:00 AM")
            }
            LinkRow(title: "View full week")
        }
    }

    private func weekRow(_ day: String, _ date: String, _ title: String, _ time: String) -> some View {
        HStack {
            Text(day).font(.system(size: 11, weight: .semibold)).frame(width: 28, alignment: .leading)
            Text(date).font(.system(size: 11)).foregroundStyle(.secondary).frame(width: 42, alignment: .leading)
            Text(title).font(.system(size: 12, weight: .medium))
            Spacer()
            Text(time).font(.system(size: 10)).foregroundStyle(.secondary)
        }
    }
}

struct ChoresAtGlanceCard: View {
    let chores: [Chore]

    var body: some View {
        CardView(title: "Chores at a Glance", systemImage: "checkmark.circle") {
            VStack(spacing: 18) {
                kidProgress("Austin", done: 3, total: 5, color: .green)
                kidProgress("Phoenix", done: 2, total: 4, color: .green)
            }
            LinkRow(title: "View all chores")
        }
    }

    private func kidProgress(_ name: String, done: Int, total: Int, color: Color) -> some View {
        HStack(spacing: 10) {
            Circle().fill(Color.orange.opacity(0.15)).frame(width: 38, height: 38).overlay(Image(systemName: "face.smiling.fill").foregroundStyle(.orange))
            VStack(alignment: .leading, spacing: 7) {
                HStack { Text(name).font(.system(size: 12, weight: .semibold)); Spacer(); Text("\(done) / \(total) done").font(.system(size: 11)) }
                ProgressView(value: Double(done), total: Double(total)).tint(color)
            }
        }
    }
}

private func money(_ value: Decimal) -> String { "$\(NSDecimalNumber(decimal: value).intValue)" }
