// Generated by CoffeeScript 1.10.0
(function() {
  var UIComponent, root;

  UIComponent = (function() {
    UIComponent.prototype.iframeElement = null;

    UIComponent.prototype.iframePort = null;

    UIComponent.prototype.showing = null;

    UIComponent.prototype.options = null;

    UIComponent.prototype.shadowDOM = null;

    UIComponent.prototype.styleSheetGetter = null;

    function UIComponent(iframeUrl, className, handleMessage) {
      var base, ref, shadowWrapper, styleSheet;
      this.handleMessage = handleMessage;
      styleSheet = DomUtils.createElement("style");
      styleSheet.type = "text/css";
      styleSheet.innerHTML = "iframe {display: none;}";
      if ((base = UIComponent.prototype).styleSheetGetter == null) {
        base.styleSheetGetter = new AsyncDataFetcher(this.fetchFileContents("content_scripts/vimium.css"));
      }
      this.styleSheetGetter.use(function(styles) {
        return styleSheet.innerHTML = styles;
      });
      this.iframeElement = DomUtils.createElement("iframe");
      extend(this.iframeElement, {
        className: className,
        seamless: "seamless"
      });
      shadowWrapper = DomUtils.createElement("div");
      this.shadowDOM = (ref = typeof shadowWrapper.createShadowRoot === "function" ? shadowWrapper.createShadowRoot() : void 0) != null ? ref : shadowWrapper;
      this.shadowDOM.appendChild(styleSheet);
      this.shadowDOM.appendChild(this.iframeElement);
      this.showing = true;
      this.hide(false);
      this.iframePort = new AsyncDataFetcher((function(_this) {
        return function(setIframePort) {
          _this.iframeElement.src = chrome.runtime.getURL(iframeUrl);
          document.documentElement.appendChild(shadowWrapper);
          return _this.iframeElement.addEventListener("load", function() {
            return chrome.storage.local.get("vimiumSecret", function(arg) {
              var port1, port2, ref1, vimiumSecret;
              vimiumSecret = arg.vimiumSecret;
              ref1 = new MessageChannel, port1 = ref1.port1, port2 = ref1.port2;
              port1.onmessage = function(event) {
                return _this.handleMessage(event);
              };
              _this.iframeElement.contentWindow.postMessage(vimiumSecret, chrome.runtime.getURL(""), [port2]);
              return setIframePort(port1);
            });
          });
        };
      })(this));
      chrome.runtime.onMessage.addListener((function(_this) {
        return function(request) {
          if (_this.showing && request.name === "frameFocused" && request.focusFrameId !== frameId) {
            _this.postMessage("hide");
          }
          return false;
        };
      })(this));
    }

    UIComponent.prototype.postMessage = function(message, continuation) {
      if (message == null) {
        message = null;
      }
      if (continuation == null) {
        continuation = null;
      }
      return this.iframePort.use((function(_this) {
        return function(port) {
          if (message != null) {
            port.postMessage(message);
          }
          return typeof continuation === "function" ? continuation() : void 0;
        };
      })(this));
    };

    UIComponent.prototype.activate = function(options) {
      this.options = options;
      return this.postMessage(this.options, (function(_this) {
        return function() {
          if (!_this.showing) {
            _this.show();
          }
          return _this.iframeElement.focus();
        };
      })(this));
    };

    UIComponent.prototype.show = function(message) {
      return this.postMessage(message, (function(_this) {
        return function() {
          _this.iframeElement.classList.remove("vimiumUIComponentHidden");
          _this.iframeElement.classList.add("vimiumUIComponentVisible");
          window.focus();
          window.addEventListener("focus", _this.onFocus = function(event) {
            if (event.target === window) {
              window.removeEventListener("focus", _this.onFocus);
              _this.onFocus = null;
              return _this.postMessage("hide");
            }
          });
          return _this.showing = true;
        };
      })(this));
    };

    UIComponent.prototype.hide = function(focusWindow) {
      var ref;
      if (focusWindow == null) {
        focusWindow = true;
      }
      if (focusWindow) {
        this.refocusSourceFrame((ref = this.options) != null ? ref.sourceFrameId : void 0);
      }
      if (this.onFocus) {
        window.removeEventListener("focus", this.onFocus);
      }
      this.onFocus = null;
      this.iframeElement.classList.remove("vimiumUIComponentVisible");
      this.iframeElement.classList.add("vimiumUIComponentHidden");
      this.options = null;
      return this.showing = false;
    };

    UIComponent.prototype.refocusSourceFrame = function(sourceFrameId) {
      var handler, refocusSourceFrame;
      if (this.showing && (sourceFrameId != null) && sourceFrameId !== frameId) {
        refocusSourceFrame = function() {
          return chrome.runtime.sendMessage({
            handler: "sendMessageToFrames",
            message: {
              name: "focusFrame",
              frameId: sourceFrameId,
              highlight: false,
              highlightOnlyIfNotTop: false
            }
          });
        };
        if (windowIsFocused()) {
          return refocusSourceFrame();
        } else {
          return window.addEventListener("focus", handler = function(event) {
            if (event.target === window) {
              window.removeEventListener("focus", handler);
              return refocusSourceFrame();
            }
          });
        }
      }
    };

    UIComponent.prototype.fetchFileContents = function(file) {
      return function(callback) {
        var request;
        request = new XMLHttpRequest();
        request.onload = function() {
          if (request.status === 200) {
            return callback(request.responseText);
          } else {
            return request.onerror();
          }
        };
        request.onerror = function() {
          return chrome.runtime.sendMessage({
            handler: "fetchFileContents",
            fileName: file
          }, callback);
        };
        request.open("GET", chrome.runtime.getURL(file), true);
        return request.send();
      };
    };

    return UIComponent;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.UIComponent = UIComponent;

}).call(this);
