import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "QmlDevTools"
    Depends { name: "Qt"; submodules: ["core"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: ["/usr/lib/libQt5Core.so.5.4.1", "pthread"]
    dynamicLibsDebug: []
    dynamicLibsRelease: []
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5QmlDevTools"
    libNameForLinkerRelease: "Qt5QmlDevTools"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5QmlDevTools.a"
    cpp.defines: ["QT_QMLDEVTOOLS_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtQml", "/usr/include/qt/QtQml/5.4.1", "/usr/include/qt/QtQml/5.4.1/QtQml"]
    cpp.libraryPaths: ["/usr/lib"]
    isStaticLibrary: true
}
