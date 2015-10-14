import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "UiTools"
    Depends { name: "Qt"; submodules: ["core"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: ["/usr/lib/libQt5Widgets.so.5.4.1", "/usr/lib/libQt5Gui.so.5.4.1", "/usr/lib/libQt5Core.so.5.4.1", "pthread", "GL"]
    dynamicLibsDebug: []
    dynamicLibsRelease: []
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5UiTools"
    libNameForLinkerRelease: "Qt5UiTools"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5UiTools.a"
    cpp.defines: ["QT_UITOOLS_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtUiTools"]
    cpp.libraryPaths: []
    isStaticLibrary: true
}
