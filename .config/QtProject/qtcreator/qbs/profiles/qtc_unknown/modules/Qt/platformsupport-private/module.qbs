import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "PlatformSupport"
    Depends { name: "Qt"; submodules: ["core-private", "gui-private"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: ["fontconfig", "freetype", "/usr/lib/libQt5Gui.so.5.4.0", "/usr/lib/libQt5DBus.so.5.4.0", "/usr/lib/libQt5Core.so.5.4.0", "pthread", "gthread-2.0", "glib-2.0", "Xrender", "Xext", "X11", "m", "udev", "mtdev", "EGL", "GL"]
    dynamicLibsDebug: []
    dynamicLibsRelease: []
    linkerFlagsDebug: []
    linkerFlagsRelease: ["-pthread"]
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5PlatformSupport"
    libNameForLinkerRelease: "Qt5PlatformSupport"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5PlatformSupport.a"
    cpp.defines: ["QT_PLATFORMSUPPORT_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtPlatformSupport", "/usr/include/qt/QtPlatformSupport/5.4.0", "/usr/include/qt/QtPlatformSupport/5.4.0/QtPlatformSupport"]
    cpp.libraryPaths: []
    isStaticLibrary: true
}
