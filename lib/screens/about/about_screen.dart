import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';

// Thông tin cố định của nhóm 
const String _repoUrl =
    'https://github.com/Hieuu066/2026_2027_1_1_LTTBDD_N02_Nhom_05';
const String _lecturerName = 'ThS. Nguyễn Xuân Quế';
const String _lecturerEmail = 'que.nguyenxuan@phenikaa-uni.edu.vn';

// Thành viên của nhóm
class _Member {
  final String name;
  final String studentId;
  final String github;
  final String role;

  const _Member({
    required this.name,
    required this.studentId,
    required this.github,
    required this.role,
  });
}

// Màn Giới thiệu nhóm: thông tin app, thành viên, giảng viên, link GitHub.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // Sao chép link vào bộ nhớ tạm rồi báo cho người dùng
  Future<void> _copyLink(BuildContext context, String message) async {
    await Clipboard.setData(const ClipboardData(text: _repoUrl));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Danh sách thành viên, vai trò lấy từ file .arb nên đổi theo ngôn ngữ
    final members = <_Member>[
      _Member(
        name: 'Đỗ Đình Hiệu',
        studentId: '24100183',
        github: 'Hieuu066',
        role: t.aboutRoleA,
      ),
      _Member(
        name: 'Phạm Năng Khang',
        studentId: '24100032',
        github: 'khangpham',
        role: t.aboutRoleB,
      ),
      _Member(
        name: 'Vũ Bá Huân',
        studentId: '24100134',
        github: 'HuanVu3003',
        role: t.aboutRoleC,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(t.aboutTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Thông tin app và môn học
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text('🌈', style: TextStyle(fontSize: 56)),
                  const SizedBox(height: 12),
                  Text(
                    t.appTitle,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.aboutAppDesc,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.aboutCourse,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    t.aboutSchool,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.aboutGroup,
                    style: textTheme.titleMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Thành viên
          Text(t.aboutMembers, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final m in members)
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: scheme.primaryContainer,
                  foregroundColor: scheme.onPrimaryContainer,
                  // Chữ cái đầu của tên
                  child: Text(m.name.split(' ').last[0]),
                ),
                title: Text(m.name),
                subtitle: Text(
                  '${t.aboutStudentId}: ${m.studentId}\n'
                  '${m.role}\n'
                  'GitHub: @${m.github}',
                ),
                isThreeLine: true,
              ),
            ),
          const SizedBox(height: 24),

          // Giảng viên
          Text(t.aboutLecturer, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          const Card(
            child: ListTile(
              leading: Icon(Icons.school_outlined),
              title: Text(_lecturerName),
              subtitle: Text(_lecturerEmail),
            ),
          ),
          const SizedBox(height: 24),

          // Link GitHub
          Card(
            child: ListTile(
              leading: const Icon(Icons.code),
              title: Text(t.aboutRepo),
              subtitle: const Text(_repoUrl),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                tooltip: t.aboutCopyLink,
                onPressed: () => _copyLink(context, t.aboutCopied),
              ),
              onTap: () => _copyLink(context, t.aboutCopied),
            ),
          ),
        ],
      ),
    );
  }
}