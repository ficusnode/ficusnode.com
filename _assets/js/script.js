function konami(cheat) {
  var code  = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65];
  var index = 0;
  
  function addEvent(obj, eventName, func) {
    if (obj.addEventListener) {
      obj.addEventListener(eventName, func, false);
    } else if (obj.attachEvent) {
      obj.attachEvent("on" + eventName, func);
    }
  }
  
  addEvent(window, "keydown", function(e) {
    if (!e) {
      e = event;
    }
    switch (e.keyCode) {
      case code[index]:
        index ++;
      break;
      case code[0]:
        index = 1;
      break;
    }
    if (index >= code.length) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      e.returnValue = false;
      index = 0;
      cheat();
    }
  });
}

function regex_className(className) {
  return new RegExp("(\\s|^)" + className + "(\\s|$)");
}

function hasClass(el, className) {
  return el.className.match(regex_className(className));
}

function addClass(el, className) {
  if (!hasClass(el, className)) {
    el.className += " " + className;
  }
}

function removeClass(el, className) {
  if (hasClass(el, className)) {
    el.className = el.className.replace(regex_className(className), "");
  }
}

function toggleClass(el, className) {
  if (hasClass(el, className)) {
    removeClass(el, className);
  } else {
    addClass(el, className);
  }
}

function desobfuscateMail() {
  if (document.querySelectorAll) {
    els = document.querySelectorAll("span.mail");
    for (var i = 0; i < els.length; i++) {
      el = els[i];
      mail = new Array(el.getAttribute("data-user"), el.getAttribute("data-domain")).join("@");
      a = document.createElement("a");
      a.href = "mailto:" + mail;
      a.title = el.getAttribute("data-title");
      a.innerHTML = mail;
      el.parentNode.replaceChild(a, el);
    }
  }
}

(function (){
  desobfuscateMail();
  konami(function() {
    body = document.getElementsByTagName("body")[0];
    toggleClass(body, "konami");
  });
})();
