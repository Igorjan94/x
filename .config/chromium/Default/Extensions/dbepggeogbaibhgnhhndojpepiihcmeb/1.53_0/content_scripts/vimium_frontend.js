// Generated by CoffeeScript 1.10.0
(function() {
  var CursorHider, GrabBackFocus, KeydownEvents, bgLog, checkEnabledAfterURLChange, checkIfEnabledForUrl, currentCompletionKeys, executePageCommand, findAndFocus, findAndFollowLink, findAndFollowRel, focusFoundLink, followLink, frameId, getLinkFromSelection, handleShowHUDforDuration, hideHelpDialog, initializeOnDomReady, initializePreDomReady, installListener, installedListeners, isEnabledForUrl, isIncognitoMode, isShowingHelpDialog, isValidFirstKey, keyPort, keyQueue, onFocus, onKeydown, onKeypress, onKeyup, passKeys, registerFrame, root, selectFoundInputElement, setScrollPosition, textInputXPath, toggleHelpDialog, unregisterFrame, validFirstKeys, windowIsFocused,
    slice = [].slice,
    extend1 = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  isShowingHelpDialog = false;

  keyPort = null;

  isEnabledForUrl = true;

  isIncognitoMode = chrome.extension.inIncognitoContext;

  passKeys = null;

  keyQueue = null;

  currentCompletionKeys = "";

  validFirstKeys = "";

  windowIsFocused = (function() {
    var windowHasFocus;
    windowHasFocus = document.hasFocus();
    window.addEventListener("focus", function(event) {
      if (event.target === window) {
        windowHasFocus = true;
      }
      return true;
    });
    window.addEventListener("blur", function(event) {
      if (event.target === window) {
        windowHasFocus = false;
      }
      return true;
    });
    return function() {
      return windowHasFocus;
    };
  })();

  textInputXPath = (function() {
    var inputElements, textInputTypes;
    textInputTypes = ["text", "search", "email", "url", "number", "password", "date", "tel"];
    inputElements = [
      "input[" + "(" + textInputTypes.map(function(type) {
        return '@type="' + type + '"';
      }).join(" or ") + "or not(@type))" + " and not(@disabled or @readonly)]", "textarea", "*[@contenteditable='' or translate(@contenteditable, 'TRUE', 'true')='true']"
    ];
    return DomUtils.makeXPath(inputElements);
  })();

  frameId = 1 + Math.floor(Math.random() * 999999999);

  bgLog = function() {
    var arg, args;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    args = (function() {
      var j, len, results;
      results = [];
      for (j = 0, len = args.length; j < len; j++) {
        arg = args[j];
        results.push(arg.toString());
      }
      return results;
    })();
    return chrome.runtime.sendMessage({
      handler: "log",
      frameId: frameId,
      message: args.join(" ")
    });
  };

  GrabBackFocus = (function(superClass) {
    extend1(GrabBackFocus, superClass);

    function GrabBackFocus() {
      GrabBackFocus.__super__.constructor.call(this, {
        name: "grab-back-focus",
        keydown: (function(_this) {
          return function() {
            return _this.alwaysContinueBubbling(function() {
              return _this.exit();
            });
          };
        })(this)
      });
      this.push({
        _name: "grab-back-focus-mousedown",
        mousedown: (function(_this) {
          return function() {
            return _this.alwaysContinueBubbling(function() {
              return _this.exit();
            });
          };
        })(this)
      });
      Settings.use("grabBackFocus", (function(_this) {
        return function(grabBackFocus) {
          if (grabBackFocus) {
            _this.push({
              _name: "grab-back-focus-focus",
              focus: function(event) {
                return _this.grabBackFocus(event.target);
              }
            });
            if (document.activeElement) {
              return _this.grabBackFocus(document.activeElement);
            }
          } else {
            return _this.exit();
          }
        };
      })(this));
    }

    GrabBackFocus.prototype.grabBackFocus = function(element) {
      if (!DomUtils.isEditable(element)) {
        return this.continueBubbling;
      }
      element.blur();
      return this.suppressEvent;
    };

    return GrabBackFocus;

  })(Mode);

  handlerStack.push({
    _name: "GrabBackFocus-pushState-monitor",
    click: function(event) {
      var ref, target;
      if (DomUtils.isFocusable(document.activeElement)) {
        return true;
      }
      target = event.target;
      while (target) {
        if (target.tagName === "A" && target.origin === document.location.origin && (target.pathName !== document.location.pathName || target.search !== document.location.search) && (((ref = target.target) === "" || ref === "_self") || (target.target === "_parent" && window.parent === window) || (target.target === "_top" && window.top === window))) {
          return new GrabBackFocus();
        } else {
          target = target.parentElement;
        }
      }
      return true;
    }
  });

  window.initializeModes = function() {
    var NormalMode;
    NormalMode = (function(superClass) {
      extend1(NormalMode, superClass);

      function NormalMode() {
        NormalMode.__super__.constructor.call(this, {
          name: "normal",
          indicator: false,
          keydown: (function(_this) {
            return function(event) {
              return onKeydown.call(_this, event);
            };
          })(this),
          keypress: (function(_this) {
            return function(event) {
              return onKeypress.call(_this, event);
            };
          })(this),
          keyup: (function(_this) {
            return function(event) {
              return onKeyup.call(_this, event);
            };
          })(this)
        });
      }

      return NormalMode;

    })(Mode);
    new NormalMode;
    new PassKeysMode;
    new InsertMode({
      permanent: true
    });
    return Scroller.init();
  };

  initializePreDomReady = function() {
    var requestHandlers;
    checkIfEnabledForUrl();
    refreshCompletionKeys();
    keyPort = chrome.runtime.connect({
      name: "keyDown"
    });
    keyPort.onDisconnect.addListener(function() {
      isEnabledForUrl = false;
      chrome.runtime.sendMessage = function() {};
      chrome.runtime.connect = function() {};
      return window.removeEventListener("focus", onFocus);
    });
    requestHandlers = {
      showHUDforDuration: handleShowHUDforDuration,
      toggleHelpDialog: function(request) {
        return toggleHelpDialog(request.dialogHtml, request.frameId);
      },
      focusFrame: function(request) {
        if (frameId === request.frameId) {
          return focusThisFrame(request);
        }
      },
      refreshCompletionKeys: refreshCompletionKeys,
      getScrollPosition: function() {
        return {
          scrollX: window.scrollX,
          scrollY: window.scrollY
        };
      },
      setScrollPosition: setScrollPosition,
      executePageCommand: executePageCommand,
      currentKeyQueue: function(request) {
        keyQueue = request.keyQueue;
        return handlerStack.bubbleEvent("registerKeyQueue", {
          keyQueue: keyQueue
        });
      },
      frameFocused: function() {},
      checkEnabledAfterURLChange: checkEnabledAfterURLChange
    };
    return chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
      var ref, ref1, shouldHandleRequest;
      if (sender.tab && !sender.tab.url.startsWith('chrome-extension://')) {
        return;
      }
      if ((ref = request.handler) === "registerFrame" || ref === "frameFocused" || ref === "unregisterFrame" || ref === "setIcon") {
        return;
      }
      shouldHandleRequest = isEnabledForUrl;
      shouldHandleRequest || (shouldHandleRequest = (ref1 = request.name) === "executePageCommand" || ref1 === "checkEnabledAfterURLChange");
      if (request.frameId === 0 && DomUtils.isTopFrame()) {
        request.frameId = frameId;
        shouldHandleRequest = true;
      }
      if (shouldHandleRequest) {
        sendResponse(requestHandlers[request.name](request, sender));
      }
      return false;
    });
  };

  installListener = function(element, event, callback) {
    return element.addEventListener(event, function() {
      if (isEnabledForUrl) {
        return callback.apply(this, arguments);
      } else {
        return true;
      }
    }, true);
  };

  installedListeners = false;

  window.installListeners = function() {
    var fn, j, len, ref, type;
    if (!installedListeners) {
      initializeModes();
      ref = ["keydown", "keypress", "keyup", "click", "focus", "blur", "mousedown", "scroll"];
      fn = function(type) {
        return installListener(window, type, function(event) {
          return handlerStack.bubbleEvent(type, event);
        });
      };
      for (j = 0, len = ref.length; j < len; j++) {
        type = ref[j];
        fn(type);
      }
      installListener(document, "DOMActivate", function(event) {
        return handlerStack.bubbleEvent('DOMActivate', event);
      });
      installedListeners = true;
      FindModeHistory.init();
      if (isEnabledForUrl) {
        return new GrabBackFocus;
      }
    }
  };

  onFocus = function(event) {
    if (event.target === window) {
      chrome.runtime.sendMessage({
        handler: "frameFocused",
        frameId: frameId
      });
      return checkIfEnabledForUrl(true);
    }
  };

  window.addEventListener("focus", onFocus);

  window.addEventListener("hashchange", onFocus);

  initializeOnDomReady = function() {
    chrome.runtime.connect({
      name: "domReady"
    });
    CursorHider.init();
    if (DomUtils.isTopFrame()) {
      Vomnibar.init();
    }
    return HUD.init();
  };

  registerFrame = function() {
    var ref;
    if (((ref = document.body) != null ? ref.tagName.toLowerCase() : void 0) !== "frameset") {
      return chrome.runtime.sendMessage({
        handler: "registerFrame",
        frameId: frameId
      });
    }
  };

  unregisterFrame = function() {
    return chrome.runtime.sendMessage({
      handler: "unregisterFrame",
      frameId: frameId,
      tab_is_closing: DomUtils.isTopFrame()
    });
  };

  executePageCommand = function(request) {
    var commandType, i, j, ref;
    commandType = request.command.split(".")[0];
    if (commandType === "Vomnibar") {
      if (DomUtils.isTopFrame()) {
        Utils.invokeCommandString(request.command, [request.frameId, request.registryEntry]);
        refreshCompletionKeys(request);
      }
      return;
    }
    if (!(frameId === request.frameId && isEnabledForUrl)) {
      return;
    }
    if (request.registryEntry.passCountToFunction) {
      Utils.invokeCommandString(request.command, [request.count]);
    } else {
      for (i = j = 0, ref = request.count; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
        Utils.invokeCommandString(request.command);
      }
    }
    return refreshCompletionKeys(request);
  };

  handleShowHUDforDuration = function(arg1) {
    var duration, text;
    text = arg1.text, duration = arg1.duration;
    if (DomUtils.isTopFrame()) {
      return DomUtils.documentReady(function() {
        return HUD.showForDuration(text, duration);
      });
    }
  };

  setScrollPosition = function(arg1) {
    var scrollX, scrollY;
    scrollX = arg1.scrollX, scrollY = arg1.scrollY;
    if (DomUtils.isTopFrame()) {
      return DomUtils.documentReady(function() {
        window.focus();
        document.body.focus();
        if (0 < scrollX || 0 < scrollY) {
          Marks.setPreviousPosition();
          return window.scrollTo(scrollX, scrollY);
        }
      });
    }
  };

  DomUtils.documentReady(function() {
    var _frameEl, _shadowDOM, _styleSheet, highlightedFrameElement, ref;
    highlightedFrameElement = DomUtils.createElement("div");
    _shadowDOM = (ref = typeof highlightedFrameElement.createShadowRoot === "function" ? highlightedFrameElement.createShadowRoot() : void 0) != null ? ref : highlightedFrameElement;
    _styleSheet = DomUtils.createElement("style");
    _styleSheet.innerHTML = "@import url(\"" + (chrome.runtime.getURL("content_scripts/vimium.css")) + "\");";
    _shadowDOM.appendChild(_styleSheet);
    _frameEl = DomUtils.createElement("div");
    _frameEl.className = "vimiumReset vimiumHighlightedFrame";
    _shadowDOM.appendChild(_frameEl);
    return window.focusThisFrame = function(request) {
      var shouldHighlight;
      if (window.innerWidth < 3 || window.innerHeight < 3) {
        chrome.runtime.sendMessage({
          handler: "nextFrame",
          frameId: frameId
        });
        return;
      }
      window.focus();
      shouldHighlight = request.highlight;
      shouldHighlight || (shouldHighlight = request.highlightOnlyIfNotTop && !DomUtils.isTopFrame());
      if (shouldHighlight) {
        document.documentElement.appendChild(highlightedFrameElement);
        return setTimeout((function() {
          return highlightedFrameElement.remove();
        }), 200);
      }
    };
  });

  window.focusThisFrame = function() {};

  extend(window, {
    scrollToBottom: function() {
      Marks.setPreviousPosition();
      return Scroller.scrollTo("y", "max");
    },
    scrollToTop: function() {
      Marks.setPreviousPosition();
      return Scroller.scrollTo("y", 0);
    },
    scrollToLeft: function() {
      return Scroller.scrollTo("x", 0);
    },
    scrollToRight: function() {
      return Scroller.scrollTo("x", "max");
    },
    scrollUp: function() {
      return Scroller.scrollBy("y", -1 * Settings.get("scrollStepSize"));
    },
    scrollDown: function() {
      return Scroller.scrollBy("y", Settings.get("scrollStepSize"));
    },
    scrollPageUp: function() {
      return Scroller.scrollBy("y", "viewSize", -1 / 2);
    },
    scrollPageDown: function() {
      return Scroller.scrollBy("y", "viewSize", 1 / 2);
    },
    scrollFullPageUp: function() {
      return Scroller.scrollBy("y", "viewSize", -1);
    },
    scrollFullPageDown: function() {
      return Scroller.scrollBy("y", "viewSize");
    },
    scrollLeft: function() {
      return Scroller.scrollBy("x", -1 * Settings.get("scrollStepSize"));
    },
    scrollRight: function() {
      return Scroller.scrollBy("x", Settings.get("scrollStepSize"));
    }
  });

  extend(window, {
    reload: function() {
      return window.location.reload();
    },
    goBack: function(count) {
      return history.go(-count);
    },
    goForward: function(count) {
      return history.go(count);
    },
    goUp: function(count) {
      var url, urlsplit;
      url = window.location.href;
      if (url[url.length - 1] === "/") {
        url = url.substring(0, url.length - 1);
      }
      urlsplit = url.split("/");
      if (urlsplit.length > 3) {
        urlsplit = urlsplit.slice(0, Math.max(3, urlsplit.length - count));
        return window.location.href = urlsplit.join('/');
      }
    },
    goToRoot: function() {
      return window.location.href = window.location.origin;
    },
    toggleViewSource: function() {
      return chrome.runtime.sendMessage({
        handler: "getCurrentTabUrl"
      }, function(url) {
        if (url.substr(0, 12) === "view-source:") {
          url = url.substr(12, url.length - 12);
        } else {
          url = "view-source:" + url;
        }
        return chrome.runtime.sendMessage({
          handler: "openUrlInNewTab",
          url: url,
          selected: true
        });
      });
    },
    copyCurrentUrl: function() {
      return chrome.runtime.sendMessage({
        handler: "getCurrentTabUrl"
      }, function(url) {
        chrome.runtime.sendMessage({
          handler: "copyToClipboard",
          data: url
        });
        if (28 < url.length) {
          url = url.slice(0, 26) + "....";
        }
        return HUD.showForDuration("Yanked " + url, 2000);
      });
    },
    enterInsertMode: function() {
      return new InsertMode({
        global: true,
        exitOnFocus: true
      });
    },
    enterVisualMode: function() {
      return new VisualMode();
    },
    enterVisualLineMode: function() {
      return new VisualLineMode;
    },
    enterEditMode: function() {
      return this.focusInput(1, EditMode);
    },
    focusInput: (function() {
      var recentlyFocusedElement;
      recentlyFocusedElement = null;
      window.addEventListener("focus", function(event) {
        if (DomUtils.isEditable(event.target)) {
          return recentlyFocusedElement = event.target;
        }
      }, true);
      return function(count, mode) {
        var FocusSelector, element, elements, hint, hints, i, rect, resultSet, selectedInputIndex, tuple, visibleInputs;
        if (mode == null) {
          mode = InsertMode;
        }
        resultSet = DomUtils.evaluateXPath(textInputXPath, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE);
        visibleInputs = (function() {
          var j, ref, results;
          results = [];
          for (i = j = 0, ref = resultSet.snapshotLength; j < ref; i = j += 1) {
            element = resultSet.snapshotItem(i);
            rect = DomUtils.getVisibleClientRect(element, true);
            if (rect === null) {
              continue;
            }
            results.push({
              element: element,
              rect: rect
            });
          }
          return results;
        })();
        if (visibleInputs.length === 0) {
          HUD.showForDuration("There are no inputs to focus.", 1000);
          return;
        }
        selectedInputIndex = count === 1 ? (elements = visibleInputs.map(function(visibleInput) {
          return visibleInput.element;
        }), Math.max(0, elements.indexOf(recentlyFocusedElement))) : Math.min(count, visibleInputs.length) - 1;
        hints = (function() {
          var j, len, results;
          results = [];
          for (j = 0, len = visibleInputs.length; j < len; j++) {
            tuple = visibleInputs[j];
            hint = DomUtils.createElement("div");
            hint.className = "vimiumReset internalVimiumInputHint vimiumInputHint";
            hint.style.left = (tuple.rect.left - 1) + window.scrollX + "px";
            hint.style.top = (tuple.rect.top - 1) + window.scrollY + "px";
            hint.style.width = tuple.rect.width + "px";
            hint.style.height = tuple.rect.height + "px";
            results.push(hint);
          }
          return results;
        })();
        return new (FocusSelector = (function(superClass) {
          extend1(FocusSelector, superClass);

          function FocusSelector() {
            FocusSelector.__super__.constructor.call(this, {
              name: "focus-selector",
              exitOnClick: true,
              keydown: (function(_this) {
                return function(event) {
                  if (event.keyCode === KeyboardUtils.keyCodes.tab) {
                    hints[selectedInputIndex].classList.remove('internalVimiumSelectedInputHint');
                    selectedInputIndex += hints.length + (event.shiftKey ? -1 : 1);
                    selectedInputIndex %= hints.length;
                    hints[selectedInputIndex].classList.add('internalVimiumSelectedInputHint');
                    _this.deactivateSingleton(visibleInputs[selectedInputIndex].element);
                    DomUtils.simulateSelect(visibleInputs[selectedInputIndex].element);
                    return _this.suppressEvent;
                  } else if (event.keyCode !== KeyboardUtils.keyCodes.shiftKey) {
                    _this.exit();
                    return _this.restartBubbling;
                  }
                };
              })(this)
            });
            this.hintContainingDiv = DomUtils.addElementList(hints, {
              id: "vimiumInputMarkerContainer",
              className: "vimiumReset"
            });
            this.deactivateSingleton(visibleInputs[selectedInputIndex].element);
            DomUtils.simulateSelect(visibleInputs[selectedInputIndex].element);
            if (visibleInputs.length === 1) {
              this.exit();
              return;
            } else {
              hints[selectedInputIndex].classList.add('internalVimiumSelectedInputHint');
            }
          }

          FocusSelector.prototype.exit = function() {
            FocusSelector.__super__.exit.call(this);
            DomUtils.removeElement(this.hintContainingDiv);
            if (mode && document.activeElement && DomUtils.isEditable(document.activeElement)) {
              return new mode({
                singleton: document.activeElement,
                targetElement: document.activeElement,
                indicator: false
              });
            }
          };

          return FocusSelector;

        })(Mode));
      };
    })()
  });

  KeydownEvents = {
    handledEvents: {},
    getEventCode: function(event) {
      return event.keyCode;
    },
    push: function(event) {
      return this.handledEvents[this.getEventCode(event)] = true;
    },
    pop: function(event) {
      var detailString, value;
      detailString = this.getEventCode(event);
      value = this.handledEvents[detailString];
      delete this.handledEvents[detailString];
      return value;
    },
    clear: function() {
      return this.handledEvents = {};
    }
  };

  handlerStack.push({
    _name: "KeydownEvents-cleanup",
    blur: function(event) {
      if (event.target === window) {
        KeydownEvents.clear();
      }
      return true;
    }
  });

  onKeypress = function(event) {
    var keyChar;
    keyChar = "";
    if (event.keyCode > 31) {
      keyChar = String.fromCharCode(event.charCode);
      if (keyChar) {
        if (currentCompletionKeys.indexOf(keyChar) !== -1 || isValidFirstKey(keyChar)) {
          DomUtils.suppressEvent(event);
          keyPort.postMessage({
            keyChar: keyChar,
            frameId: frameId
          });
          return this.stopBubblingAndTrue;
        }
        keyPort.postMessage({
          keyChar: keyChar,
          frameId: frameId
        });
      }
    }
    return this.continueBubbling;
  };

  onKeydown = function(event) {
    var i, keyChar, modifiers;
    keyChar = "";
    if (((event.metaKey || event.ctrlKey || event.altKey) && event.keyCode > 31) || (event.keyIdentifier && event.keyIdentifier.slice(0, 2) !== "U+")) {
      keyChar = KeyboardUtils.getKeyChar(event);
      if (keyChar !== "") {
        modifiers = [];
        if (event.shiftKey) {
          keyChar = keyChar.toUpperCase();
        }
        if (event.metaKey) {
          modifiers.push("m");
        }
        if (event.ctrlKey) {
          modifiers.push("c");
        }
        if (event.altKey) {
          modifiers.push("a");
        }
        for (i in modifiers) {
          keyChar = modifiers[i] + "-" + keyChar;
        }
        if (modifiers.length > 0 || keyChar.length > 1) {
          keyChar = "<" + keyChar + ">";
        }
      }
    }
    if (isShowingHelpDialog && KeyboardUtils.isEscape(event)) {
      hideHelpDialog();
      DomUtils.suppressEvent(event);
      KeydownEvents.push(event);
      return this.stopBubblingAndTrue;
    } else {
      if (keyChar) {
        if (currentCompletionKeys.indexOf(keyChar) !== -1 || isValidFirstKey(keyChar)) {
          DomUtils.suppressEvent(event);
          KeydownEvents.push(event);
          keyPort.postMessage({
            keyChar: keyChar,
            frameId: frameId
          });
          return this.stopBubblingAndTrue;
        }
        keyPort.postMessage({
          keyChar: keyChar,
          frameId: frameId
        });
      } else if (KeyboardUtils.isEscape(event)) {
        keyPort.postMessage({
          keyChar: "<ESC>",
          frameId: frameId
        });
      }
    }
    if (keyChar === "" && (currentCompletionKeys.indexOf(KeyboardUtils.getKeyChar(event)) !== -1 || isValidFirstKey(KeyboardUtils.getKeyChar(event)))) {
      DomUtils.suppressPropagation(event);
      KeydownEvents.push(event);
      return this.stopBubblingAndTrue;
    }
    return this.continueBubbling;
  };

  onKeyup = function(event) {
    if (!KeydownEvents.pop(event)) {
      return this.continueBubbling;
    }
    DomUtils.suppressPropagation(event);
    return this.stopBubblingAndTrue;
  };

  checkIfEnabledForUrl = function(frameIsFocused) {
    var url;
    if (frameIsFocused == null) {
      frameIsFocused = windowIsFocused();
    }
    url = window.location.toString();
    return chrome.runtime.sendMessage({
      handler: "isEnabledForUrl",
      url: url,
      frameIsFocused: frameIsFocused
    }, function(response) {
      isEnabledForUrl = response.isEnabledForUrl, passKeys = response.passKeys;
      installListeners();
      if (HUD.isReady() && !isEnabledForUrl) {
        HUD.hide();
      }
      handlerStack.bubbleEvent("registerStateChange", {
        enabled: isEnabledForUrl,
        passKeys: passKeys
      });
      if (windowIsFocused()) {
        chrome.runtime.sendMessage({
          handler: "setIcon",
          icon: isEnabledForUrl && !passKeys ? "enabled" : isEnabledForUrl ? "partial" : "disabled"
        });
      }
      return null;
    });
  };

  checkEnabledAfterURLChange = function() {
    if (windowIsFocused()) {
      return checkIfEnabledForUrl();
    }
  };

  window.refreshCompletionKeys = function(response) {
    if (response) {
      currentCompletionKeys = response.completionKeys;
      if (response.validFirstKeys) {
        return validFirstKeys = response.validFirstKeys;
      }
    } else {
      return chrome.runtime.sendMessage({
        handler: "getCompletionKeys"
      }, refreshCompletionKeys);
    }
  };

  isValidFirstKey = function(keyChar) {
    return validFirstKeys[keyChar] || /^[1-9]/.test(keyChar);
  };

  window.handleEscapeForFindMode = function() {
    var range, selection;
    document.body.classList.remove("vimiumFindMode");
    selection = window.getSelection();
    if (!selection.isCollapsed) {
      range = window.getSelection().getRangeAt(0);
      window.getSelection().removeAllRanges();
      window.getSelection().addRange(range);
    }
    return focusFoundLink() || selectFoundInputElement();
  };

  window.handleEnterForFindMode = function() {
    focusFoundLink();
    document.body.classList.add("vimiumFindMode");
    return FindMode.saveQuery();
  };

  focusFoundLink = function() {
    var link;
    if (FindMode.query.hasResults) {
      link = getLinkFromSelection();
      if (link) {
        return link.focus();
      }
    }
  };

  selectFoundInputElement = function() {
    var findModeAnchorNode;
    findModeAnchorNode = document.getSelection().anchorNode;
    if (FindMode.query.hasResults && document.activeElement && DomUtils.isSelectable(document.activeElement) && DomUtils.isDOMDescendant(findModeAnchorNode, document.activeElement)) {
      return DomUtils.simulateSelect(document.activeElement);
    }
  };

  findAndFocus = function(backwards) {
    Marks.setPreviousPosition();
    FindMode.query.hasResults = FindMode.execute(null, {
      backwards: backwards
    });
    if (FindMode.query.hasResults) {
      focusFoundLink();
      return new PostFindMode();
    } else {
      return HUD.showForDuration("No matches for '" + FindMode.query.rawQuery + "'", 1000);
    }
  };

  window.performFind = function() {
    return findAndFocus();
  };

  window.performBackwardsFind = function() {
    return findAndFocus(true);
  };

  getLinkFromSelection = function() {
    var node;
    node = window.getSelection().anchorNode;
    while (node && node !== document.body) {
      if (node.nodeName.toLowerCase() === "a") {
        return node;
      }
      node = node.parentNode;
    }
    return null;
  };

  followLink = function(linkElement) {
    if (linkElement.nodeName.toLowerCase() === "link") {
      return window.location.href = linkElement.href;
    } else {
      linkElement.scrollIntoView();
      linkElement.focus();
      return DomUtils.simulateClick(linkElement);
    }
  };

  findAndFollowLink = function(linkStrings) {
    var boundingClientRect, candidateLink, candidateLinks, computedStyle, exactWordRegex, i, j, k, l, len, len1, len2, len3, link, linkMatches, linkString, links, linksXPath, m, n, ref;
    linksXPath = DomUtils.makeXPath(["a", "*[@onclick or @role='link' or contains(@class, 'button')]"]);
    links = DomUtils.evaluateXPath(linksXPath, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE);
    candidateLinks = [];
    for (i = j = ref = links.snapshotLength - 1; j >= 0; i = j += -1) {
      link = links.snapshotItem(i);
      boundingClientRect = link.getBoundingClientRect();
      if (boundingClientRect.width === 0 || boundingClientRect.height === 0) {
        continue;
      }
      computedStyle = window.getComputedStyle(link, null);
      if (computedStyle.getPropertyValue("visibility") !== "visible" || computedStyle.getPropertyValue("display") === "none") {
        continue;
      }
      linkMatches = false;
      for (k = 0, len = linkStrings.length; k < len; k++) {
        linkString = linkStrings[k];
        if (link.innerText.toLowerCase().indexOf(linkString) !== -1) {
          linkMatches = true;
          break;
        }
      }
      if (!linkMatches) {
        continue;
      }
      candidateLinks.push(link);
    }
    if (candidateLinks.length === 0) {
      return;
    }
    for (l = 0, len1 = candidateLinks.length; l < len1; l++) {
      link = candidateLinks[l];
      link.wordCount = link.innerText.trim().split(/\s+/).length;
    }
    candidateLinks.forEach(function(a, i) {
      return a.originalIndex = i;
    });
    candidateLinks = candidateLinks.sort(function(a, b) {
      if (a.wordCount === b.wordCount) {
        return a.originalIndex - b.originalIndex;
      } else {
        return a.wordCount - b.wordCount;
      }
    }).filter(function(a) {
      return a.wordCount <= candidateLinks[0].wordCount + 1;
    });
    for (m = 0, len2 = linkStrings.length; m < len2; m++) {
      linkString = linkStrings[m];
      exactWordRegex = /\b/.test(linkString[0]) || /\b/.test(linkString[linkString.length - 1]) ? new RegExp("\\b" + linkString + "\\b", "i") : new RegExp(linkString, "i");
      for (n = 0, len3 = candidateLinks.length; n < len3; n++) {
        candidateLink = candidateLinks[n];
        if (exactWordRegex.test(candidateLink.innerText)) {
          followLink(candidateLink);
          return true;
        }
      }
    }
    return false;
  };

  findAndFollowRel = function(value) {
    var element, elements, j, k, len, len1, relTags, tag;
    relTags = ["link", "a", "area"];
    for (j = 0, len = relTags.length; j < len; j++) {
      tag = relTags[j];
      elements = document.getElementsByTagName(tag);
      for (k = 0, len1 = elements.length; k < len1; k++) {
        element = elements[k];
        if (element.hasAttribute("rel") && element.rel.toLowerCase() === value) {
          followLink(element);
          return true;
        }
      }
    }
  };

  window.goPrevious = function() {
    var previousPatterns, previousStrings;
    previousPatterns = Settings.get("previousPatterns") || "";
    previousStrings = previousPatterns.split(",").filter(function(s) {
      return s.trim().length;
    });
    return findAndFollowRel("prev") || findAndFollowLink(previousStrings);
  };

  window.goNext = function() {
    var nextPatterns, nextStrings;
    nextPatterns = Settings.get("nextPatterns") || "";
    nextStrings = nextPatterns.split(",").filter(function(s) {
      return s.trim().length;
    });
    return findAndFollowRel("next") || findAndFollowLink(nextStrings);
  };

  window.enterFindMode = function() {
    Marks.setPreviousPosition();
    return new FindMode();
  };

  window.showHelpDialog = function(html, fid) {
    var VimiumHelpDialog, container;
    if (isShowingHelpDialog || !document.body || fid !== frameId) {
      return;
    }
    isShowingHelpDialog = true;
    container = DomUtils.createElement("div");
    container.id = "vimiumHelpDialogContainer";
    container.className = "vimiumReset";
    document.body.appendChild(container);
    container.innerHTML = html;
    container.getElementsByClassName("closeButton")[0].addEventListener("click", hideHelpDialog, false);
    VimiumHelpDialog = {
      getShowAdvancedCommands: function() {
        return Settings.get("helpDialog_showAdvancedCommands");
      },
      init: function() {
        this.dialogElement = document.getElementById("vimiumHelpDialog");
        this.dialogElement.getElementsByClassName("toggleAdvancedCommands")[0].addEventListener("click", VimiumHelpDialog.toggleAdvancedCommands, false);
        this.dialogElement.style.maxHeight = window.innerHeight - 80;
        return this.showAdvancedCommands(this.getShowAdvancedCommands());
      },
      toggleAdvancedCommands: function(event) {
        var showAdvanced;
        event.preventDefault();
        showAdvanced = VimiumHelpDialog.getShowAdvancedCommands();
        VimiumHelpDialog.showAdvancedCommands(!showAdvanced);
        return Settings.set("helpDialog_showAdvancedCommands", !showAdvanced);
      },
      showAdvancedCommands: function(visible) {
        var advancedEls, el, j, len, results;
        VimiumHelpDialog.dialogElement.getElementsByClassName("toggleAdvancedCommands")[0].innerHTML = visible ? "Hide advanced commands" : "Show advanced commands";
        advancedEls = VimiumHelpDialog.dialogElement.getElementsByClassName("advanced");
        results = [];
        for (j = 0, len = advancedEls.length; j < len; j++) {
          el = advancedEls[j];
          results.push(el.style.display = visible ? "table-row" : "none");
        }
        return results;
      }
    };
    VimiumHelpDialog.init();
    container.getElementsByClassName("optionsPage")[0].addEventListener("click", function(clickEvent) {
      clickEvent.preventDefault();
      return chrome.runtime.sendMessage({
        handler: "openOptionsPageInNewTab"
      });
    }, false);
    return DomUtils.simulateClick(document.getElementById("vimiumHelpDialog"));
  };

  hideHelpDialog = function(clickEvent) {
    var helpDialog;
    isShowingHelpDialog = false;
    helpDialog = document.getElementById("vimiumHelpDialogContainer");
    if (helpDialog) {
      helpDialog.parentNode.removeChild(helpDialog);
    }
    if (clickEvent) {
      return clickEvent.preventDefault();
    }
  };

  toggleHelpDialog = function(html, fid) {
    if (isShowingHelpDialog) {
      return hideHelpDialog();
    } else {
      return showHelpDialog(html, fid);
    }
  };

  CursorHider = {
    cursorHideStyle: null,
    isScrolling: false,
    onScroll: function(event) {
      CursorHider.isScrolling = true;
      if (!CursorHider.cursorHideStyle.parentElement) {
        return document.head.appendChild(CursorHider.cursorHideStyle);
      }
    },
    onMouseMove: function(event) {
      if (CursorHider.cursorHideStyle.parentElement && !CursorHider.isScrolling) {
        CursorHider.cursorHideStyle.remove();
      }
      return CursorHider.isScrolling = false;
    },
    init: function() {
      return;
      if (!Utils.haveChromeVersion("39.0.2171.71")) {
        return;
      }
      this.cursorHideStyle = DomUtils.createElement("style");
      this.cursorHideStyle.innerHTML = "body * {pointer-events: none !important; cursor: none !important;}\nbody, html {cursor: none !important;}";
      window.addEventListener("mousemove", this.onMouseMove);
      return window.addEventListener("scroll", this.onScroll);
    }
  };

  initializePreDomReady();

  DomUtils.documentReady(initializeOnDomReady);

  DomUtils.documentReady(registerFrame);

  window.addEventListener("unload", unregisterFrame);

  window.onbeforeunload = function() {
    return chrome.runtime.sendMessage({
      handler: "updateScrollPosition",
      scrollX: window.scrollX,
      scrollY: window.scrollY
    });
  };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.handlerStack = handlerStack;

  root.frameId = frameId;

  root.windowIsFocused = windowIsFocused;

  root.bgLog = bgLog;

}).call(this);
