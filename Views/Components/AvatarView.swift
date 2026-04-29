import SwiftUI

struct AvatarView: View {
    let member: FamilyMember
    var size: CGFloat = 42

    var body: some View {
        ZStack {
            Circle().fill(member.color.opacity(0.15))
            Image(systemName: member.avatarSystemName)
                .font(.system(size: size * 0.48, weight: .semibold))
                .foregroundStyle(member.color)
        }
        .frame(width: size, height: size)
    }
}

struct AccountAvatarView: View {
    let account: AllowanceAccount
    var size: CGFloat = 42

    var body: some View {
        ZStack {
            Circle().fill(account.color.opacity(0.15))
            Image(systemName: account.avatarSystemName)
                .font(.system(size: size * 0.48, weight: .semibold))
                .foregroundStyle(account.color)
        }
        .frame(width: size, height: size)
    }
}
