import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_practice2/image_compress/image_compress_constants.dart';
import 'package:flutter_practice2/image_compress/time_logger.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/services.dart';

import 'time_logger.dart';

class ImageCompressDemo extends StatefulWidget {
  const ImageCompressDemo({Key? key}) : super(key: key);

  @override
  State<ImageCompressDemo> createState() => _ImageCompressDemoState();
}

class _ImageCompressDemoState extends State<ImageCompressDemo> {
  ImageProvider? provider;

  Future<void> compress() async {
    const img = AssetImage(ImageCompressConstants.IMG_SEA_JPG);
    LogUtil.e('ImageCompress 預壓縮');
    const config = ImageConfiguration();
    final AssetBundleImageKey key = await img.obtainKey(config);
    final ByteData data = await key.bundle.load(key.name);
    final beforeCompress = data.lengthInBytes;
    LogUtil.e('ImageCompress 壓縮前 = $beforeCompress');
    final result = await FlutterImageCompress.compressWithList(
      data.buffer.asUint8List(),
    );
    LogUtil.e('ImageCompress 壓縮後 = ${result.length}');
  }

  Future<Directory> getTemporaryDirectory() async {
    return Directory.systemTemp;
  }

  void _testCompressFile() async {
    const img = AssetImage(ImageCompressConstants.IMG_SEA_JPG);
    LogUtil.e('ImageCompress 預壓縮');
    const config = ImageConfiguration();
    final AssetBundleImageKey key = await img.obtainKey(config);
    final ByteData data = await key.bundle.load(key.name);
    final dir = await path_provider.getTemporaryDirectory();
    final File file = createFile('${dir.absolute.path}/test.png');
    file.writeAsBytesSync(data.buffer.asUint8List());

    final result = await testCompressFile(file);
    if (result == null) return;

    safeSetState(() {
      provider = MemoryImage(result);
    });
  }

  File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  Future<String> getExampleFilePath() async {
    const img = AssetImage(ImageCompressConstants.IMG_SEA_JPG);
    LogUtil.e('ImageCompress 預壓縮');
    const config = ImageConfiguration();
    final AssetBundleImageKey key = await img.obtainKey(config);
    final ByteData data = await key.bundle.load(key.name);
    final dir = await path_provider.getTemporaryDirectory();
    final File file = createFile('${dir.absolute.path}/test.png');
    file.createSync(recursive: true);
    file.writeAsBytesSync(data.buffer.asUint8List());
    return file.absolute.path;
  }

  void getFileImage() async {
    const img = AssetImage(ImageCompressConstants.IMG_SEA_JPG);
    LogUtil.e('ImageCompress 預壓縮');
    const config = ImageConfiguration();
    final AssetBundleImageKey key = await img.obtainKey(config);
    final ByteData data = await key.bundle.load(key.name);
    final dir = await path_provider.getTemporaryDirectory();
    final File file = createFile('${dir.absolute.path}/test.png');
    file.writeAsBytesSync(data.buffer.asUint8List());
    final targetPath = '${dir.absolute.path}/temp.jpg';
    final imgFile = await testCompressAndGetFile(file, targetPath);
    if (imgFile == null) {
      return;
    }
    safeSetState(() {
      provider = FileImage(imgFile);
    });
  }

  Future<Uint8List?> testCompressFile(File file) async {
    LogUtil.e('ImageCompress 測試壓縮');
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 180,
    );
    LogUtil.e('testCompressFile 長度:${file.lengthSync()}');
    LogUtil.e('testCompressFile 回傳長度:${result?.length}');
    return result;
  }

  Future<File?> testCompressAndGetFile(File file, String targetPath) async {
    LogUtil.e('testCompressAndGetFile 測試壓縮和取得文件');
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 90,
      minWidth: 1024,
      minHeight: 1024,
      rotate: 90,
    );
    LogUtil.e('testCompressAndGetFile 長度:${file.lengthSync()}');
    LogUtil.e('testCompressAndGetFile 回傳長度:${result?.lengthSync()}');
    return result;
  }

  Future testCompressAsset(String assetName) async {
    LogUtil.e('ImageCompress 測試壓縮資產');
    final list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    if (list == null) return;
    safeSetState(() {
      provider = MemoryImage(Uint8List.fromList(list));
    });
  }

  Future compressListExample() async {
    final data = await rootBundle.load(ImageCompressConstants.IMG_SEA_JPG);
    final memory = await testCompressList(data.buffer.asUint8List());
    safeSetState(() {
      provider = MemoryImage(memory);
    });
  }

  Future<Uint8List> testCompressList(Uint8List list) async {
    final result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1080,
      minWidth: 1080,
      quality: 96,
      rotate: 270,
      format: CompressFormat.webp,
    );
    LogUtil.e('testCompressList 長度:${list.length}');
    LogUtil.e('testCompressList 回傳長度:${result.length}');
    return result;
  }

  Future<void> writeToFile(List<int> list, String filePath) {
    return File(filePath).writeAsBytes(list, flush: true);
  }

  void _compressAssetAndAutoRotate() async {
    final result = await FlutterImageCompress.compressAssetImage(
      ImageCompressConstants.IMG_AUTO_ANGLE_JPG,
      minWidth: 1000,
      quality: 95,
      // autoCorrectionAngle: false,
    );
    if (result == null) return;
    safeSetState(() {
      provider = MemoryImage(Uint8List.fromList(result));
    });
  }

  void _compressPngImage() async {
    final result = await FlutterImageCompress.compressAssetImage(
      ImageCompressConstants.IMG_HEADER_PNG,
      minWidth: 300,
      minHeight: 500,
    );
    if (result == null) return;
    safeSetState(() {
      provider = MemoryImage(Uint8List.fromList(result));
    });
  }

  void _compressTransPNG() async {
    final bytes = await getAssetImageUint8List(
      ImageCompressConstants.IMG_TRANSPARENT_BACKGROUND_PNG,
    );
    final result = await FlutterImageCompress.compressWithList(
      bytes,
      minHeight: 100,
      minWidth: 100,
      format: CompressFormat.png,
    );
    final u8list = Uint8List.fromList(result);
    safeSetState(() {
      provider = MemoryImage(u8list);
    });
  }

  void _restoreTransPNG() async {
    setState(() {
      provider = const AssetImage(ImageCompressConstants.IMG_TRANSPARENT_BACKGROUND_PNG);
    });
  }

  void _compressImageAndKeepExif() async {
    final result = await FlutterImageCompress.compressAssetImage(
      ImageCompressConstants.IMG_AUTO_ANGLE_JPG,
      minWidth: 500,
      minHeight: 600,
      // autoCorrectionAngle: false,
      keepExif: true,
    );
    if (result == null) return;
    safeSetState(() {
      provider = MemoryImage(Uint8List.fromList(result));
    });
  }

  void _compressHeicExample() async {
    LogUtil.e('ImageCompress 開始壓縮');
    final logger = TimeLogger();
    logger.startRecorder();
    final tmpDir = (await getTemporaryDirectory()).path;
    final target = '$tmpDir/${DateTime.now().millisecondsSinceEpoch}.heic';
    final srcPath = await getExampleFilePath();
    final result = await FlutterImageCompress.compressAndGetFile(
      srcPath,
      target,
      format: CompressFormat.heic,
      quality: 90,
    );
    if (result == null) return;
    LogUtil.e('ImageCompress heic success.');
    logger.logTime();
    LogUtil.e('ImageCompress src, 路徑 = $srcPath 長度 = ${File(srcPath).lengthSync()}');
    LogUtil.e('ImageCompress heic 回傳路徑: ${result.absolute.path}, 尺寸: ${result.lengthSync()}',
    );
  }

  void _compressAndroidWebpExample() async {
    // Android compress 很好，但是 iOS 將 UIImage 編碼為 webp 很慢。
    final logger = TimeLogger();
    logger.startRecorder();
    LogUtil.e('ImageCompress 開始壓縮 webp');
    const quality = 90;
    final tmpDir = (await getTemporaryDirectory()).path;
    final target = '$tmpDir/${DateTime.now().millisecondsSinceEpoch}-$quality.webp';
    final srcPath = await getExampleFilePath();
    final result = await FlutterImageCompress.compressAndGetFile(
      srcPath,
      target,
      format: CompressFormat.webp,
      minHeight: 800,
      minWidth: 800,
      quality: quality,
    );
    if (result == null) return;
    LogUtil.e('ImageCompress webp success.');
    logger.logTime();
    LogUtil.e('ImageCompress src, 路徑 = $srcPath 長度 = ${File(srcPath).lengthSync()}');
    LogUtil.e('ImageCompress webp 會傳路徑: ${result.absolute.path}, 尺寸: ${result.lengthSync()}');
    safeSetState(() {
      provider = FileImage(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Image Compress Demo')),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: Image(
                    image: provider ?? const AssetImage(ImageCompressConstants.IMG_SEA_JPG),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: _testCompressFile,
                child: const Text('壓縮文件並旋轉 180'),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: getFileImage,
                child: const Text('壓縮並獲取文件並旋轉 90'),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                child: const Text('壓縮資產並旋轉 135'),
                onPressed: () => testCompressAsset(ImageCompressConstants.IMG_SEA_JPG),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: compressListExample,
                child: const Text('壓縮列表並旋轉 270'),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: _compressAssetAndAutoRotate,
                child: const Text('測試壓縮自動角度'),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: _compressPngImage,
                child: const Text('測試png'),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: _compressTransPNG,
                child: const Text('格式化透明PNG'),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: _restoreTransPNG,
                child: const Text('恢復透明PNG'),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: _compressImageAndKeepExif,
                child: const Text('保留exif圖片'),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: _compressHeicExample,
                child: const Text('轉換為 heic 格式並打印文件 url'),
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: _compressAndroidWebpExample,
                child: const Text('轉換成webp格式，只支持android'),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => provider = null),
          tooltip: 'Show default asset',
          child: const Icon(Icons.settings_backup_restore),
        ),
    );
  }
}

Future<Uint8List> getAssetImageUint8List(String key) async {
  final byteData = await rootBundle.load(key);
  return byteData.buffer.asUint8List();
}

double calcScale({
  required double srcWidth,
  required double srcHeight,
  required double minWidth,
  required double minHeight,
}) {
  final scaleW = srcWidth / minWidth;
  final scaleH = srcHeight / minHeight;

  final scale = math.max(1.0, math.min(scaleW, scaleH));

  return scale;
}

extension _StateExtension on State {
  /// [setState] 當它沒有構建時，請等到構建下一幀。
  FutureOr<void> safeSetState(FutureOr<dynamic> Function() fn) async {
    await fn();
    if (mounted &&
        !context.debugDoingBuild &&
        context.owner?.debugBuilding == false) {
      // ignore: invalid_use_of_protected_member
      setState(() {});
    }
    final Completer<void> completer = Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      completer.complete();
    });
    return completer.future;
  }
}