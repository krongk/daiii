//encoding: utf-8
//Source from quotered.com
function slideIn() {
    var e = element("container");
    if (e) {
        var t = (new Date).getTime();
        t - start_time <= duration ? e.style.marginTop = Math.floor(swing(t - start_time, height / 2 - 320, 160 - height / 2, duration)) + "px" : (clearInterval(timer), e.style.marginTop = "-160px")
    }
}
function slideOut() {
    var e = element("container");
    if (e) {
        var t = (new Date).getTime();
        if (t - start_time <= duration) e.style.marginTop = Math.floor(swing(t - start_time, -160, -160 - height / 2, duration)) + "px";
        else {
            clearInterval(timer), e.style.marginTop = Math.floor(-height / 2 - 320) + "px", window.closing = !1, window.quoting = !1, window.requote_id = null, window.requote_tags = null;
            var e = element("overlay");
            e.parentNode.removeChild(e)
        }
    }
}
function swing(e, t, n, r) {
    return (e /= r / 2) < 1 ? n / 2 * e * e + t : -n / 2 * (--e * (e - 2) - 1) + t
}
function creator() {
    for (var e = 0; e < data.meta.length; e++) if (data.meta[e].name.toUpperCase() == "TWITTER:CREATOR") return data.meta[e].content.toLowerCase();
    return ""
}
function quote() {
    var e = "" + (window.getSelection ? window.getSelection() : document.getSelection ? document.getSelection() : document.selection.createRange().text);
    e = e.replace(/(^\s+|\s+$)/g, "").replace(/\s*(\r\n|\n|\r)+\s*/g, "\n");
    if (e == "") {
        data.highlighted = !1;
        var t = document.title.split("-");
        if (t.length > 1) {
            var n = t.shift().replace(/\s+$/, ""),
                r = t.join("-").replace(/^\s+/, "");
            e = n.length > r.length ? n : r
        } else e = document.title
    }
    return e
}
function no_quote() {
    for (var e = 0; e < data.meta.length; e++) if (data.meta[e].name.toUpperCase() == "QUOTERED" && data.meta[e].content.toUpperCase() == "NOQUOTE") return !0;
    return !1
}
function style_css() {
    var e = document.createElement("style");
    e.type = "text/css", height = window.innerHeight ? window.innerHeight : document.documentElement && document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight, data.css.push("#_container { margin-top: " + Math.floor(height / 2 - 320) + "px; }");
    var t = data.css.join("\n").replace(/#_/g, "#_" + window.random_number);
    e.styleSheet ? e.styleSheet.cssText = t : e.appendChild(document.createTextNode(t)), data.body.appendChild(e)
}
function render_html() {
    html = document.createElement("div"), html.id = "_" + window.random_number + "overlay", inner_html = data.html.replace(/id="_/g, 'id="_' + window.random_number), data.installingButton ? (inner_html = inner_html.replace(/TAGS_VALUE/g, ""), inner_html = inner_html.replace(/MESSAGE_PLACEHOLDER/g, "&nbsp;<br />&mdash;点击书签 &ldquo;+雨+&rdquo; 就可以在任何页面弹出该窗口."), inner_html = inner_html.replace(/TAGS_PLACEHOLDER/g, "给你要引用的文字和网站添加标签"), inner_html = inner_html.replace(/SUBMIT_PLACEHOLDER/g, "保存并继续"), inner_html = inner_html.replace(/TIP_PLACEHOLDER/g, "提示: 你可以直接按回车来保存.")) : data.requoting ? (inner_html = inner_html.replace(/TAGS_VALUE/g, window.requote_tags), inner_html = inner_html.replace(/MESSAGE_PLACEHOLDER/g, "&nbsp;<br />给你要引用的文字或网页添加标签，以空格隔开:"), inner_html = inner_html.replace(/TAGS_PLACEHOLDER/g, "例如：创业 编程 互联网 Ruby Rails Web Design"), inner_html = inner_html.replace(/SUBMIT_PLACEHOLDER/g, "REQUOTE"), inner_html = inner_html.replace(/TIP_PLACEHOLDER/g, "")) : (inner_html = inner_html.replace(/TAGS_VALUE/g, ""), inner_html = inner_html.replace(/MESSAGE_PLACEHOLDER/g, "&nbsp;<br />给你要引用的文字或网页添加标签，以空格隔开:"), inner_html = inner_html.replace(/TAGS_PLACEHOLDER/g, "例如： 电子商务 设计 网站 精彩 Design Funny"), inner_html = inner_html.replace(/SUBMIT_PLACEHOLDER/g, "保存本次引用"), data.highlighted == 1 ? inner_html = inner_html.replace(/TIP_PLACEHOLDER/g, "提示: 你可以直接按回车键来保存.") : inner_html = inner_html.replace(/TIP_PLACEHOLDER/g, "提示: 你可以选中精彩的文字片段并点+雨+保存下来.")), html.innerHTML = inner_html, data.body.appendChild(html)
}
function bind_handlers() {
    listen(element("tags"), "change", format), listen(element("tags"), "keyup", format), listen(element("form"), "submit", submit), listen(element("cancel"), "click", close), listen(window, "keyup", esc)
}
function format(e) {
   // e.preventDefault();
   // var t = element("tags").value;
   // t != "" && t[0] != "#" && (t = "#" + t), t = t.replace(/[^\w\u4e00-\u9eff#,; ]/g, ""), t = t.replace(/#?(\w+)/g, "#$1"), t != element("tags").value && (element("tags").value = t)
}
function submit(e) {
    e.preventDefault();
    var t = {};
    data.requoting ? (t.requote_id = window.requote_id, t.tag_names = encodeURIComponent(element("tags").value)) : (t.content = encodeURIComponent(data.quote), t.creator = encodeURIComponent(data.creator), t.title = encodeURIComponent(document.title), t.tag_names = encodeURIComponent(element("tags").value), t.url = encodeURIComponent(document.URL), t.url = t.url.charAt(253) == "%" ? t.url.substring(0, 253) : t.url.charAt(254) == "%" ? t.url.substring(0, 254) : t.url);
    var n = [];
    for (var r in t) n.push("quote[" + r + "]=" + t[r]);
    window.open("http://www.daiii.com/add_quote?" + n.join("&"), "雨服务", "target=_blank,width=550,height=500"), close(e)
}
function close(e) {
    e.preventDefault(), window.closing = !0, window.addEventListener ? window.removeEventListener("keyup", esc) : window.attachEvent && window.detachEvent("keyup", esc), height = window.innerHeight ? window.innerHeight : document.documentElement && document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight, start_time = (new Date).getTime(), clearInterval(timer), timer = setInterval(slideOut, 10)
}
function esc(e) {
    e.keyCode == 27 && window.closing !== !0 && close(e)
}
function element(e) {
    return document.getElementById("_" + window.random_number + e)
}
function listen(e, t, n) {
    typeof window.addEventListener != "undefined" ? e.addEventListener(t, n, !1) : document.attachEvent !== "undefined" && e.addEventListener("on" + t, n)
}
var data = {
    body: document.getElementsByTagName("BODY")[0],
    css: ["#_overlay, #_header, #_logo a, #_logo a:hover, #form, #_submit, #_container, #_container p, #_container pre, #_tags { background: none !important; border: none !important; border-radius: 0 !important; bottom: auto !important; box-shadow: none !important; clear: none !important; color: #222 !important; float: none !important; font-family: Georgia,serif !important; font-size: 16px !important; font-style: normal !important; font-weight: normal !important; height: auto !important; left: auto !important; letter-spacing: normal !important; line-height: 16px !important; margin-top: 0; margin-left: 0 !important; margin-bottom: 0 !important; margin-right: 0 !important; max-height: none !important; max-width: none !important; min-height: 0 !important; min-width: 0 !important; overflow: visible !important; padding: 0 !important; position: static !important; right: auto !important; text-align: left !important; text-decoration: none !important; text-indent: 0 !important; text-shadow: none !important; text-transform: none !important; top: auto !important; transition: none !important; visibility: visible !important; white-space: normal !important; width: auto !important; z-index: auto !important; }", "#_overlay { position: fixed !important; top: 0 !important; left: 0 !important; width: 100% !important; height: 100% !important; overflow: hidden !important; z-index: 2147483643 !important; }", '#_container { position: relative !important; top: 50% !important; left: 50% !important; margin-left: -320px !important; width: 640px !important; height: 320px !important; background: #f4f4f4 url("https://www.daiii.com/assets/paper.jpg") !important; box-shadow: 0 2px 2px rgba(0, 0, 0, 0.5) !important; }', "#_container #_header { margin-bottom: 32px !important; height: 40px !important; background-color: #0099ff !important; }", '#_container #_logo { float: left !important; display: block !important; margin: 0 178px 0 260px !important; width: 120px !important; height: 40px !important; background: url("http://www.daiii.com/assets/logo.png") !important; }', "#_container #_logo:hover { background-position: -120px 0 !important; }", "#_container #_cancel { float: left !important; display: block !important; width: 80px !important; color: #ffffff !important; font-family: Verdana,sans-serif !important; font-size: 14px !important; font-weight: normal !important; line-height: 40px !important; text-align: center !important; text-decoration: none !important; border-left: 2px solid #0099ff !important; }", "#_container #_cancel:hover { background-color: #0099ff !important; }", "#_container #_header { float: left !important; width: 40px; }", "#_container #_quote_form { display: inline !important; }", "#_container #_buttons { margin: 12px 0 22px 0 !important; text-align: center !important; }", "#_container #_submit { display: inline-block !important; height: 18px !important; color: #0099ff !important; font-family: Verdana,sans-serif !important; font-size: 14px !important; font-weight: normal !important; text-decoration: none !important; }", "#_container #_submit:hover { color: #0099ff !important; text-decoration: underline !important; cursor: pointer !important; }", "#_container #_submit:active { color: #0099ff !important; text-decoration: underline !important; cursor: pointer !important; }", "#_container #_tip { color: #999999 !important; font-family: Georgia,serif !important; font-size: 16px !important; font-style: italic !important; line-height: 27px !important; text-align: center !important; }", "#_container #_hr { clear: both !important; margin: 32px 0 !important; padding: 0 !important; border: 0 !important; border-top: thin solid #999999 !important; }", "#_container p { margin: 0 32px !important; font-family: Georgia,serif !important; font-size: 18px !important; line-height: 27px !important; }", "#_container pre { margin: 27px !important; font-family: Georgia,serif !important; font-size: 18px !important; line-height: 27px !important; white-space: pre-wrap !important; white-space: -moz-pre-wrap !important; white-space: -pre-wrap !important; white-space: -o-pre-wrap !important; word-wrap: break-word !important; }", '#_tags { display: block !important; margin: 24px 32px !important; padding: 0 8px !important; width: 560px !important; max-width: 624px !important; height: 34px !important; font-family: "proxima-nova",Verdana,sans-serif !important; font-weight: 400 !important; border: thin solid #999 !important; border-radius: 6px !important; background-color: #ffffff !important; box-shadow: inset 0 1px rgba(34, 34, 34, 0.15), 0 1px #fff !important; outline: none !important; }', "#_tags:focus { border-color: #0099ff !important; box-shadow: inset 0 1px rgba(34, 34, 34, 0.15), 0 1px rgba(255, 255, 255, 0.8), 0 0 14px rgba(167, 57, 39, 0.5) !important; }", "#_tags::-webkit-input-placeholder { color: #999999 !important; }", "#_tags::-moz-placeholder { color: #999999 !important; }", "#_tags::-ms-input-placeholder { color: #999999 !important; }", "@media", "only screen and (-webkit-min-device-pixel-ratio: 2)      and (min-width: 480px),", "only screen and (   min--moz-device-pixel-ratio: 2)      and (min-width: 490px),", "only screen and (     -o-min-device-pixel-ratio: 2/1)    and (min-width: 480px),", "only screen and (        min-device-pixel-ratio: 2)      and (min-width: 480px),", "only screen and (                min-resolution: 192dpi) and (min-width: 480px),", "only screen and (                min-resolution: 2dppx)  and (min-width: 480px) {", '#_container #_logo { background: url("http://www.daiii.com/assets/logo-retina.png") !important; background-size: 240px 40px !important; }', "#_container #_logo:hover { background-position: -240px 0 !important; }", "}"],
    head: document.getElementsByTagName("HEAD")[0],
    highlighted: !0,
    html: '<div id="_container">                <div id="_header">                    <a id="_logo" href="http://www.yufuwu.cn" target="_blank"></a>                    <a id="_cancel" href="#">取消</a>                </div>                <p>MESSAGE_PLACEHOLDER</p>                <form id="_form" name="form" method="post">                    <input id="_tags" type="text" name="quote[tag_names]" value="TAGS_VALUE" maxlength="100" placeholder="TAGS_PLACEHOLDER" autocomplete="off">                    <div id="_buttons"><input id="_submit" type="submit" value="SUBMIT_PLACEHOLDER"></div>                </form>                <div id="_tip">TIP_PLACEHOLDER</div>            </div>',
    installingButton: document.location.hostname == "www.daiii.com" && window.location.pathname == "/install-button",
    meta: document.getElementsByTagName("META"),
    requoting: document.location.hostname == "www.daiii.com" && window.requote_id != null && window.requote_tags != null
};
if (data.body) {
    if (window.quoting !== !0) {
        window.quoting = !0;
        var height = 0,
            duration = 400,
            timer = null,
            start_time = null;
        data.creator = creator(), data.quote = quote(), window.random_number = Math.floor(Math.random() * 99999999), data.installingButton && document.getElementById("link_to_step3").parentNode.className == "disabled" && !data.highlighted ? (alert('Highlight the quote before clicking the "Quote It" button you installed in Step 2.'), window.quoting = !1) : data.installingButton && document.getElementById("link_to_step3").parentNode.className != "disabled" ? (alert("Please continue to Step 3."), window.quoting = !1) : no_quote() ? (alert("Sorry, quoting is not allowed from this domain. Please contact the owner with any questions. Thanks for visiting!"), window.quoting = !1) : (style_css(), render_html(), bind_handlers(), start_time = (new Date).getTime(), clearInterval(timer), timer = setInterval(slideIn, 20), element("tags").focus())
    }
} else alert("对不起，网站不能保存非HTML格式的网页.");