import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:camera/camera.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/utils/ui_helper.dart';

enum ScanMode { qr, document, receipt }

class ScanController extends StatefulWidget {
  const ScanController({super.key});

  @override
  State<ScanController> createState() => _ScanControllerState();
}

class _ScanControllerState extends State<ScanController> {
  ScanMode _currentMode = ScanMode.qr;
  bool _isFlashing = false;

  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isCameraError = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        final backCamera = _cameras!.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.back,
          orElse: () => _cameras!.first,
        );
        _cameraController = CameraController(
          backCamera,
          ResolutionPreset.medium,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      } else {
        setState(() {
          _isCameraError = true;
        });
      }
    } catch (e) {
      debugPrint("Camera initialization error: $e");
      if (mounted) {
        setState(() {
          _isCameraError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _onModeChanged(ScanMode mode) {
    if (_currentMode == mode) return;
    HapticFeedback.selectionClick();
    setState(() {
      _currentMode = mode;
    });
  }

  Future<void> _captureImage() async {
    HapticFeedback.mediumImpact();
    setState(() {
      _isFlashing = true;
    });
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        _isFlashing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Scan captured successfully!"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }



  String _getModeInstruction(ScanMode mode) {
    switch (mode) {
      case ScanMode.qr:
        return "Position the QR code within the frame";
      case ScanMode.document:
        return "Align the document edges inside the box";
      case ScanMode.receipt:
        return "Center your receipt to scan automatically";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double targetWidth;
    final double targetHeight;

    switch (_currentMode) {
      case ScanMode.qr:
        targetWidth = size.width * 0.7;
        targetHeight = size.width * 0.7;
        break;
      case ScanMode.document:
        targetWidth = size.width * 0.82;
        targetHeight = size.width * 0.52;
        break;
      case ScanMode.receipt:
        targetWidth = size.width * 0.62;
        targetHeight = size.width * 0.85;
        break;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _isCameraInitialized && _cameraController != null
              ? Positioned.fill(
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: size.width,
                          height: size.width * _cameraController!.value.aspectRatio,
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                    ),
                  ),
                )
              : AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.0,
                      colors: [Color(0xFF0A0A0A), Colors.black],
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.12,
                        child: GridPaper(
                          color: Colors.white.withAlpha(20),
                          divisions: 1,
                          subdivisions: 1,
                          interval: 40,
                        ),
                      ),
                      if (!_isCameraError)
                        const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      if (_isCameraError)
                        Positioned(
                          top: size.height / 2 - targetHeight / 2 - 145,
                          child: Text(
                            "Camera Hardware Offline\n(Simulated View)",
                            textAlign: TextAlign.center,
                            style: UIHelper.current.funnelTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withAlpha(120),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

          // Viewport Cutout and Semi-Transparent Mask
          AnimatedBuilder(
            animation: Listenable.merge([]),
            builder: (context, _) {
              return CustomPaint(
                size: Size(size.width, size.height),
                painter: ScanMaskPainter(
                  targetWidth: targetWidth,
                  targetHeight: targetHeight,
                ),
              );
            },
          ),

          // Animated Scanning Corners
          AnimatedBuilder(
            animation: Listenable.merge([]),
            builder: (context, _) {
              return CustomPaint(
                size: Size(size.width, size.height),
                painter: ScanTargetPainter(
                  targetWidth: targetWidth,
                  targetHeight: targetHeight,
                ),
              );
            },
          ),

          // Scanning Line (Sweeping Laser)
          Center(
            child: Transform.translate(
              offset: const Offset(0, -100),
              child: SizedBox(
                width: targetWidth,
                height: targetHeight,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: targetHeight / 2,
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ColorFactory.accentColor.withAlpha(200),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ],
                          gradient: LinearGradient(
                            colors: [
                              ColorFactory.accentColor.withAlpha(0),
                              ColorFactory.accentColor,
                              ColorFactory.accentColor.withAlpha(0),
                            ],
                          ),
                        ),
                      ),
                    )
                        .animate(onPlay: (controller) => controller.repeat(reverse: true))
                        .moveY(
                          begin: -targetHeight / 2 + 10,
                          end: targetHeight / 2 - 10,
                          duration: 1800.milliseconds,
                          curve: Curves.easeInOut,
                        ),
                  ],
                ),
              ),
            ),
          ),

          // Top Overlay Panel (Instructions Only)
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    key: ValueKey(_currentMode),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      _getModeInstruction(_currentMode),
                      style: UIHelper.current.funnelTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Mode Selector Controls (above shutter button)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 220,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildModeTab("QR CODE", ScanMode.qr),
                    const SizedBox(width: 12),
                    _buildModeTab("DOCUMENT", ScanMode.document),
                    const SizedBox(width: 12),
                    _buildModeTab("RECEIPT", ScanMode.receipt),
                  ],
                ),
              ],
            ),
          ),

          // Shutter Button (Centered below mode tabs)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 120,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _captureImage,
                child: Container(
                  height: 76,
                  width: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4.5),
                  ),
                  child: Center(
                    child: Container(
                      height: 58,
                      width: 58,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Full-screen Camera Flash Animation Overlay
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: _isFlashing ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 150),
                child: Container(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeTab(String label, ScanMode mode) {
    final isSelected = _currentMode == mode;
    return GestureDetector(
      onTap: () => _onModeChanged(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? ColorFactory.accentColor : Colors.black.withAlpha(120),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white.withAlpha(30),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: UIHelper.current.funnelTextStyle(
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? Colors.white : Colors.white.withAlpha(160),
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class ScanMaskPainter extends CustomPainter {
  final double targetWidth;
  final double targetHeight;

  ScanMaskPainter({required this.targetWidth, required this.targetHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withAlpha(160);
    final bgPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2 - 100),
            width: targetWidth,
            height: targetHeight,
          ),
          const Radius.circular(24),
        ),
      );
    final path = Path.combine(PathOperation.difference, bgPath, cutoutPath);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ScanMaskPainter oldDelegate) {
    return oldDelegate.targetWidth != targetWidth || oldDelegate.targetHeight != targetHeight;
  }
}

class ScanTargetPainter extends CustomPainter {
  final double targetWidth;
  final double targetHeight;

  ScanTargetPainter({required this.targetWidth, required this.targetHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorFactory.accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 - 100),
      width: targetWidth,
      height: targetHeight,
    );

    const double len = 24;
    const double r = 24;

    // Top-Left corner bracket
    canvas.drawPath(
      Path()
        ..moveTo(rect.left, rect.top + len)
        ..lineTo(rect.left, rect.top + r)
        ..arcToPoint(Offset(rect.left + r, rect.top), radius: const Radius.circular(r))
        ..lineTo(rect.left + len, rect.top),
      paint,
    );

    // Top-Right corner bracket
    canvas.drawPath(
      Path()
        ..moveTo(rect.right - len, rect.top)
        ..lineTo(rect.right - r, rect.top)
        ..arcToPoint(Offset(rect.right, rect.top + r), radius: const Radius.circular(r))
        ..lineTo(rect.right, rect.top + len),
      paint,
    );

    // Bottom-Left corner bracket
    canvas.drawPath(
      Path()
        ..moveTo(rect.left, rect.bottom - len)
        ..lineTo(rect.left, rect.bottom - r)
        ..arcToPoint(Offset(rect.left + r, rect.bottom), radius: const Radius.circular(r))
        ..lineTo(rect.left + len, rect.bottom),
      paint,
    );

    // Bottom-Right corner bracket
    canvas.drawPath(
      Path()
        ..moveTo(rect.right - len, rect.bottom)
        ..lineTo(rect.right - r, rect.bottom)
        ..arcToPoint(Offset(rect.right, rect.bottom - r), radius: const Radius.circular(r))
        ..lineTo(rect.right, rect.bottom - len),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant ScanTargetPainter oldDelegate) {
    return oldDelegate.targetWidth != targetWidth || oldDelegate.targetHeight != targetHeight;
  }
}
