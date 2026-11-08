import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../l10n/app_localizations.dart';

// Màu chữ cố định vì nền luôn sáng
const Color _textDark = Color(0xFF2B2B3A);
const Color _textBody = Color(0xFF4A4A5A);

// Màu nhấn của từng trang
const Color _orange = Color(0xFFE8590C);
const Color _blue = Color(0xFF1971C2);
const Color _purple = Color(0xFF7048E8);

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  static const int _pageCount = 3;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _finish() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.main);
  }

  void _next() {
    if (_page == _pageCount - 1) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isLast = _page == _pageCount - 1;

    final pages = <_PageData>[
      _PageData(
        gradient: const [Color(0xFFFFE29F), Color(0xFFFFA99F)],
        accent: _orange,
        title: t.onboard1Title,
        body: t.onboard1Body,
        main: const Text('😄', style: TextStyle(fontSize: 84)),
        bubbles: const [
          Text('🙂', style: TextStyle(fontSize: 30)),
          Text('😐', style: TextStyle(fontSize: 30)),
          Text('😢', style: TextStyle(fontSize: 30)),
          Text('😡', style: TextStyle(fontSize: 30)),
        ],
      ),
      _PageData(
        gradient: const [Color(0xFFA1C4FD), Color(0xFFC2E9FB)],
        accent: _blue,
        title: t.onboard2Title,
        body: t.onboard2Body,
        main: const Icon(Icons.calendar_month_rounded, size: 84, color: _blue),
        bubbles: const [
          Icon(Icons.bar_chart_rounded, size: 30, color: _blue),
          Icon(Icons.pie_chart_rounded, size: 30, color: _blue),
          Icon(Icons.show_chart_rounded, size: 30, color: _blue),
          Icon(Icons.today_rounded, size: 30, color: _blue),
        ],
      ),
      _PageData(
        gradient: const [Color(0xFFC3B1FF), Color(0xFFFFC1E3)],
        accent: _purple,
        title: t.onboard3Title,
        body: t.onboard3Body,
        main: const Icon(Icons.favorite_rounded, size: 84, color: _purple),
        bubbles: const [
          Icon(Icons.light_mode, size: 30, color: _purple),
          Icon(Icons.dark_mode, size: 30, color: _purple),
          Icon(Icons.language, size: 30, color: _purple),
          Icon(Icons.notifications_active, size: 30, color: _purple),
        ],
      ),
    ];
    final current = pages[_page];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: current.gradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Nút Bỏ qua, trang cuối thì ẩn
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: isLast
                      ? const SizedBox(height: 48)
                      : TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: _textDark,
                          ),
                          onPressed: _finish,
                          child: Text(t.onboardSkip),
                        ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _page = i),
                  children: [
                    for (final p in pages) _OnboardingPage(data: p),
                  ],
                ),
              ),
              // Chấm chỉ trang hiện tại
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pageCount, (i) {
                  final active = i == _page;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: active ? 28 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: active
                          ? current.accent
                          : Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: current.accent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _next,
                  child: Text(isLast ? t.onboardStart : t.onboardNext),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dữ liệu của một trang
class _PageData {
  final List<Color> gradient;
  final Color accent;
  final String title;
  final String body;
  final Widget main; // hình lớn ở giữa
  final List<Widget> bubbles; // 4 hình nhỏ ở 4 góc

  const _PageData({
    required this.gradient,
    required this.accent,
    required this.title,
    required this.body,
    required this.main,
    required this.bubbles,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _PageData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Illustration(main: data.main, bubbles: data.bubbles),
            const SizedBox(height: 40),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: _textDark,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              data.body,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                color: _textBody,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Hình minh họa: vòng tròn trắng ở giữa, 4 bong bóng ở các góc
class _Illustration extends StatelessWidget {
  final Widget main;
  final List<Widget> bubbles;

  const _Illustration({required this.main, required this.bubbles});

  Widget _bubble(Widget child) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.35),
            ),
          ),
          Container(
            width: 190,
            height: 190,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: main,
          ),
          Positioned(top: 8, left: 8, child: _bubble(bubbles[0])),
          Positioned(top: 8, right: 8, child: _bubble(bubbles[1])),
          Positioned(bottom: 8, left: 8, child: _bubble(bubbles[2])),
          Positioned(bottom: 8, right: 8, child: _bubble(bubbles[3])),
        ],
      ),
    );
  }
}