import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "QuickTest"
    Depends { name: "Qt"; submodules: ["core", "widgets"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/usr/lib/libQt5Widgets.so.5.4.1", "/usr/lib/libQt5Gui.so.5.4.1", "/usr/lib/libQt5Core.so.5.4.1", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5QuickTest"
    libNameForLinkerRelease: "Qt5QuickTest"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5QuickTest.so.5.4.1"
    cpp.defines: ["QT_QMLTEST_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtQuickTest"]
    cpp.libraryPaths: []
    
}
