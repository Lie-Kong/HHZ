class UserInfo {
  final int balance;
  final int commissionBalance;
  final String? expiryDate;
  final String? joinDate;
  final bool isActive;
  final String? inviteCode;
  
  UserInfo({
    required this.balance,
    required this.commissionBalance,
    this.expiryDate,
    this.joinDate,
    required this.isActive,
    this.inviteCode,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      balance: json['balance'] as int? ?? 0,
      commissionBalance: json['commission_balance'] as int? ?? 0,
      expiryDate: json['expiry_date'] as String?,
      joinDate: json['join_date'] as String?,
      isActive: json['is_active'] as bool? ?? false,
      inviteCode: json['invite_code'] as String?,
    );
  }
}
    required this.commissionBalance,
    required this.planId,
    this.discount,
    this.commissionRate,
    this.telegramId,
    required this.uuid,
    required this.avatarUrl,
  });

  // 从 JSON 创建 UserInfo 实例
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      // 字符串字段，如果为 null，返回空字符串
      email: json['email'] as String? ?? '',

      // 转换为 double，如果为 null，返回 0.0
      transferEnable: (json['transfer_enable'] as num?)?.toDouble() ?? 0.0,

      // 时间字段可以为 null
      lastLoginAt: json['last_login_at'] as int?,

      // 确保 createdAt 为 int，并提供默认值
      createdAt: json['created_at'] as int? ?? 0,

      // 处理布尔值
      banned: (json['banned'] as int? ?? 0) == 1,
      remindExpire: (json['remind_expire'] as int? ?? 0) == 1,
      remindTraffic: (json['remind_traffic'] as int? ?? 0) == 1,

      // 允许 expiredAt 为 null
      expiredAt: json['expired_at'] as int?,

      // 转换 balance 为 double，并处理 null
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,

      // 转换 commissionBalance 为 double，并处理 null
      commissionBalance:
          (json['commission_balance'] as num?)?.toDouble() ?? 0.0,

      // 保证 planId 是 int，提供默认值 0
      planId: json['plan_id'] as int? ?? 0,

      // 允许 discount 和 commissionRate 为 null
      discount: (json['discount'] as num?)?.toDouble(),
      commissionRate: (json['commission_rate'] as num?)?.toDouble(),

      // 允许 telegramId 为 null
      telegramId: json['telegram_id'] as String?,

      // uuid 和 avatarUrl，如果为 null 返回空字符串
      uuid: json['uuid'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
    );
  }
}
