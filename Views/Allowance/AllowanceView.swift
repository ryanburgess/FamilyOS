import SwiftUI

struct AllowanceView: View {
    @EnvironmentObject private var store: FamilyOSStore

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Allowance")
                    .font(.largeTitle.bold())
                Spacer()
                Picker("View", selection: .constant("Overview")) {
                    Text("Overview").tag("Overview")
                    Text("History").tag("History")
                }
                .pickerStyle(.segmented)
                .frame(width: 170)
                Button { } label: { Label("Add Adjustment", systemImage: "plus") }
                    .buttonStyle(.borderedProminent)
            }

            VStack(spacing: 0) {
                ForEach(store.allowanceAccounts) { account in
                    HStack(spacing: 12) {
                        AccountAvatarView(account: account, size: 42)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(account.kidName).font(.system(size: 13, weight: .semibold))
                            Text("Weekly allowance: \(money(account.weeklyAmount))").font(.system(size: 11)).foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 3) {
                            Text("Owed").font(.system(size: 10)).foregroundStyle(.secondary)
                            Text(money(account.owedAmount)).foregroundStyle(.red).fontWeight(.bold)
                        }
                        .frame(width: 80)
                        VStack(alignment: .trailing, spacing: 3) {
                            Text("Cash in safe").font(.system(size: 10)).foregroundStyle(.secondary)
                            Text(money(account.cashInSafe)).foregroundStyle(.green).fontWeight(.bold)
                        }
                        .frame(width: 90)
                    }
                    .padding(14)
                    if account.id != store.allowanceAccounts.last?.id { Divider() }
                }
            }
            .background(Color.white.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            VStack(alignment: .leading, spacing: 12) {
                Text("Recent Activity").font(.headline)
                ForEach(store.allowanceActivity) { activity in
                    HStack {
                        Text(activity.dateLabel).frame(width: 58, alignment: .leading).foregroundStyle(.secondary)
                        Text(activity.title)
                        Spacer()
                        Text(activity.kidName).foregroundStyle(.secondary)
                        Text(money(activity.amount)).frame(width: 55, alignment: .trailing).foregroundStyle(.green)
                        Text(activity.status).frame(width: 55, alignment: .trailing).foregroundStyle(.secondary)
                    }
                    .font(.system(size: 12))
                    Divider()
                }
            }
            .padding(16)
            .background(Color.white.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            Spacer()
        }
        .padding(26)
    }

    private func money(_ value: Decimal) -> String { "$\(NSDecimalNumber(decimal: value).intValue)" }
}
