# 👩‍💻 VeggieMama - Vodič za razvijalce

Kompletni vodič za razvijalce, ki se pridružijo VeggieMama projektu. Vsebuje najboljše prakse, kodne smernice in navodila za dodajanje novih funkcionalnosti.

## 🎯 Osnovna načela

### 💚 UX Empatija - Prva prioriteta
Vsaka funkcionalnost mora biti zasnovana z mislijo na čustveno varnost mamice:

```dart
// ❌ Napačen pristop
if (dailyWaterIntake < targetAmount) {
  showMessage("Nisi dosegla cilja tekočin!");
}

// ✅ Pravilni pristop  
if (dailyWaterIntake < targetAmount) {
  final progress = (dailyWaterIntake / targetAmount * 100).round();
  showMessage("Odličen napredek!  ${progress}% cilja doseženo 💧");
}
```

### 🔄 State Management Vzorec
Vedno uporabi Provider pattern za state management:

```dart
// 1. Definiraj provider
class TrackingProvider extends ChangeNotifier {
  // State
  // Methods
  // notifyListeners()
}

// 2. Registriraj v app.dart
ChangeNotifierProvider(create: (_) => TrackingProvider()),

// 3. Uporabi v widget-u
Consumer<TrackingProvider>(
  builder: (context, provider, child) {
    return YourWidget();
  },
)
```

### 🧩 Komponente Načela
- **Ena komponenta = ena datoteka**
- **Reusable komponente v `widgets/`**
- **Screen-specifične komponente v `screens/*/widgets/`**

## 🛠️ Setup razvojnega okolja

### Zahtevani tools
```bash
# Flutter
flutter --version  # >= 3.13.0

# Dart
dart --version     # >= 3.1.0

# Dodatni tools
flutter pub global activate dartdoc
flutter pub global activate dhttpd
```

### VSCode Extensions
```json
{
  "recommendations": [
    "dart-code.flutter",
    "dart-code.dart-code",
    "usernamehw.errorlens",
    "esbenp.prettier-vscode",
    "ms-vscode.vscode-json"
  ]
}
```

### VSCode Settings
```json
{
  "dart.flutterHotReloadOnSave": "always",
  "dart.previewFlutterUiGuides": true,
  "dart.closeDevTools": false,
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  }
}
```

## 📝 Kodne smernice

### 🏗️ Struktura datoteke
```dart
// 1. Imports (dart: first, then package:, then relative)
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';

// 2. Class definition
class YourWidget extends StatefulWidget {
  // Public fields first
  final String title;
  final VoidCallback? onTap;
  
  // Constructor
  const YourWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  State<YourWidget> createState() => _YourWidgetState();
}

// 3. State class
class _YourWidgetState extends State<YourWidget> {
  // Private fields
  late AnimationController _controller;
  bool _isLoading = false;
  
  // Lifecycle methods
  @override
  void initState() {
    super.initState();
    // Initialization
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  // Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UI
    );
  }
  
  // Private methods
  void _privateMethod() {
    // Implementation
  }
}
```

### 🎨 Styling smernice
```dart
// ✅ Uporabi named colors
const primaryColor = Color(0xFF2E7D32);
const secondaryColor = Color(0xFF81C784);

// ✅ Uporabi konstante za spacing
const kPaddingSmall = 8.0;
const kPaddingMedium = 16.0;
const kPaddingLarge = 24.0;

// ✅ Uporabi theme colors
color: Theme.of(context).colorScheme.primary,

// ✅ Uporabi BorderRadius.circular za consistency
borderRadius: BorderRadius.circular(16),

// ✅ Dodaj box shadows za depth
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 8,
    offset: const Offset(0, 2),
  ),
],
```

### 📱 Responsive Design
```dart
// ✅ Uporabi MediaQuery za responsive design
final screenWidth = MediaQuery.of(context).size.width;
final isTablet = screenWidth > 600;

// ✅ Uporabi LayoutBuilder za adaptive layouts
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return TabletLayout();
    }
    return PhoneLayout();
  },
)

// ✅ Uporabi Flexible/Expanded za flexible layouts
Row(
  children: [
    Expanded(flex: 2, child: LeftWidget()),
    Expanded(flex: 3, child: RightWidget()),
  ],
)
```

## 🔄 Dodajanje novih funkcionalnosti

### 1. Nova Screen
```bash
# 1. Ustvari datoteko
touch lib/screens/new_feature/new_feature_screen.dart

# 2. Dodaj v router
# lib/routes/app_router.dart
GoRoute(
  path: '/new-feature',
  name: 'new-feature',
  builder: (context, state) => const NewFeatureScreen(),
),
```

```dart
// Template za novo screen
class NewFeatureScreen extends StatefulWidget {
  const NewFeatureScreen({super.key});

  @override
  State<NewFeatureScreen> createState() => _NewFeatureScreenState();
}

class _NewFeatureScreenState extends State<NewFeatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VeggieMamaAppBar(
        title: 'Nova funkcionalnost',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Dodaj MotivationalBanner
              MotivationalBanner(
                message: EmotionalFeedback.getFeedback('context'),
              ),
              
              const SizedBox(height: 24),
              
              // Tvoja vsebina
            ],
          ),
        ),
      ),
    );
  }
}
```

### 2. Nov Provider
```dart
// lib/providers/new_feature_provider.dart
class NewFeatureProvider extends ChangeNotifier {
  // Private state
  List<DataModel> _data = [];
  bool _isLoading = false;
  String? _error;

  // Public getters
  List<DataModel> get data => _data;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => _data.isNotEmpty;

  // Public methods
  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _data = await _service.getData();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addItem(DataModel item) {
    _data.add(item);
    notifyListeners();
  }
}

// Registracija v app.dart
ChangeNotifierProvider(create: (_) => NewFeatureProvider()),
```

### 3. Nova Widget komponenta
```dart
// lib/widgets/new_component.dart
class NewComponent extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const NewComponent({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontFamily: 'Poppins',
            color: const Color(0xFF2E7D32),
          ),
        ),
      ),
    );
  }
}
```

## 🧪 Testing strategija

### Unit testi
```dart
// test/unit/providers/new_feature_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('NewFeatureProvider', () {
    late NewFeatureProvider provider;
    
    setUp(() {
      provider = NewFeatureProvider();
    });
    
    test('should load data successfully', () async {
      // Arrange
      
      // Act
      await provider.loadData();
      
      // Assert
      expect(provider.hasData, true);
      expect(provider.isLoading, false);
    });
  });
}
```

### Widget testi
```dart
// test/widget/new_component_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('NewComponent displays title', (tester) async {
    // Arrange
    const title = 'Test Title';
    
    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: NewComponent(title: title),
      ),
    );
    
    // Assert
    expect(find.text(title), findsOneWidget);
  });
}
```

### Integration testi
```dart
// integration_test/new_feature_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('New Feature Integration', () {
    testWidgets('complete user flow', (tester) async {
      // Test celoten user flow
    });
  });
}
```

## 🔧 Debug in Profiling

### Debugging tools
```dart
// Debug print with conditional logging
import 'package:flutter/foundation.dart';

void debugLog(String message) {
  if (kDebugMode) {
    print('[VeggieMama] $message');
  }
}

// Widget inspection
import 'package:flutter/rendering.dart';

// V main()
debugPaintSizeEnabled = true; // Pokaže widget boundaries
```

### Performance monitoring
```dart
// Timeline event tracking
import 'dart:developer' as developer;

Future<void> expensiveOperation() async {
  developer.Timeline.startSync('ExpensiveOperation');
  
  // Your code here
  
  developer.Timeline.finishSync();
}
```

## 🎨 Animacije in Transitions

### Osnovne animacije
```dart
class AnimatedComponent extends StatefulWidget {
  @override
  State<AnimatedComponent> createState() => _AnimatedComponentState();
}

class _AnimatedComponentState extends State<AnimatedComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: YourWidget(),
        );
      },
    );
  }
}
```

### Page transitions
```dart
// Custom page route
class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  
  SlidePageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            
            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}

// Uporaba
Navigator.push(
  context,
  SlidePageRoute(child: NewScreen()),
);
```

## 💾 Data Persistence

### Hive setup
```dart
// models/user_model.dart
import 'package:hive/hive.dart';

part 'user_model.g.dart';  // Generated file

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String firstName;
  
  // ... other fields
}

// services/database_service.dart
class DatabaseService {
  static const String userBoxName = 'users';
  
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(userBoxName);
  }
  
  static Box<UserModel> get userBox => Hive.box<UserModel>(userBoxName);
  
  static Future<void> saveUser(UserModel user) async {
    await userBox.put(user.id, user);
  }
  
  static UserModel? getUser(String id) {
    return userBox.get(id);
  }
}
```

## 🔔 Lokalizacija

### Dodajanje novih prevodov
```dart
// lib/l10n/app_si.arb
{
  "welcomeMessage": "Dobrodošla v VeggieMama!",
  "waterGoalReached": "Odlično! Dosegla si cilj tekočin! 💧",
  "achievementUnlocked": "Nov dosežek odklenjen! 🎉"
}

// lib/l10n/app_en.arb  
{
  "welcomeMessage": "Welcome to VeggieMama!",
  "waterGoalReached": "Great! You've reached your water goal! 💧",
  "achievementUnlocked": "New achievement unlocked! 🎉"
}

// Uporaba v kodi
Text(AppLocalizations.of(context)!.welcomeMessage)
```

## 🚀 Deployment

### Android Release
```bash
# 1. Update version in pubspec.yaml
version: 1.0.1+2

# 2. Build release APK
flutter build apk --release

# 3. Build App Bundle (za Google Play)
flutter build appbundle --release

# 4. Lokacija datotek
# build/app/outputs/flutter-apk/app-release.apk
# build/app/outputs/bundle/release/app-release.aab
```

### iOS Release
```bash
# 1. Build iOS release
flutter build ios --release

# 2. Odpri v Xcode za upload
open ios/Runner.xcworkspace
```

## 📊 Monitoring in Analytics

### Error tracking
```dart
// utils/error_handler.dart
class ErrorHandler {
  static void handleError(dynamic error, StackTrace stackTrace) {
    // Log to console in debug
    if (kDebugMode) {
      print('Error: $error');
      print('Stack trace: $stackTrace');
    }
    
    // Send to crash reporting service
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }
}

// Uporaba
try {
  // Risky operation
} catch (e, stackTrace) {
  ErrorHandler.handleError(e, stackTrace);
}
```

## 🏁 Checklist pred release

### Pre-release checklist
- [ ] Vsi testi passed
- [ ] Performance profiling completed
- [ ] Memory leaks checked
- [ ] Accessibility tested
- [ ] Different screen sizes tested
- [ ] Android and iOS tested
- [ ] Network error scenarios tested
- [ ] Offline functionality tested
- [ ] Privacy policy updated
- [ ] App store descriptions ready

### Code review checklist
- [ ] Follows project structure
- [ ] Includes emotional feedback where appropriate
- [ ] Proper error handling
- [ ] No hardcoded strings (use l10n)
- [ ] Responsive design
- [ ] Accessibility considerations
- [ ] Performance optimized
- [ ] Tests written

## 📚 Koristni ressources

### Flutter Documentation
- [Flutter Docs](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design 3](https://m3.material.io/)

### State Management
- [Provider Documentation](https://pub.dev/packages/provider)
- [Flutter State Management](https://docs.flutter.dev/development/data-and-backend/state-mgmt)

### Testing
- [Flutter Testing](https://docs.flutter.dev/testing)
- [Mockito for Dart](https://pub.dev/packages/mockito)

### Performance
- [Flutter Performance](https://docs.flutter.dev/perf)
- [Memory Usage](https://docs.flutter.dev/development/tools/devtools/memory)

---

*Happy coding! 💚 Vedno pomisli na mamica, ki bo uporabljala aplikacijo.* 