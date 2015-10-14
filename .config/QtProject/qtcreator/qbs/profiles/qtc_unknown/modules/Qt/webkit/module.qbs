import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "WebKit"
    Depends { name: "Qt"; submodules: ["core", "gui", "network"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/usr/lib/libQt5Gui.so.5.4.0", "/usr/lib/libQt5Core.so.5.4.0", "pthread", "pthread", "/usr/lib/libQt5Network.so.5.4.0", "/usr/lib/libQt5Core.so.5.4.0", "pthread", "pthread", "/usr/lib/libQt5Core.so.5.4.0", "pthread", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5WebKit"
    libNameForLinkerRelease: "Qt5WebKit"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5WebKit.so.5.4.0"
    cpp.defines: ["QT_WEBKIT_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtWebKit"]
    cpp.libraryPaths: []
    
}
