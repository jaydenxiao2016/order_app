// copyright 2014 NS BASIC Corporation. All rights reserved.

NSB.$=function(id) {return document.getElementById(id)}

NSB.refresh=function(id){
  try{id.refresh()} 
  catch(err){console.log("Error: " +err.message);debugger}
  }

NSB.Checkbox = function(id, width, options, html) {
  var i,s,arrOptions;
  arrOptions=split(options, ",");
  s="<ul class='pageitem' id='" + id + "' " + enquote(html) + ">\n"
  for (i=0; i<arrOptions.length; i++){
    s=s+"  <li class='checkbox' data-role='none'>\n"
    + "    <span class='name'>"+arrOptions[i]+"</span>\n"
    + "    <input type='checkbox' data-role='none'>\n";
    }
  s=s+"</ul>";
  return s;
}
  
NSB.Checkbox_init = function(id, width){
  id.style.height="auto";
  if(width<=10) id.style.width=document.width-18+"px";
  id.getValue=function(n){
    if (n<1 || n>=id.childNodes.length) {
      alert(NSB._["Error: Index out of range: {array}[{index}]"].supplant({"array": id.id, "index": n}));
    }
    return id.childNodes[n].children[1].checked;
  }
  id.setValue=function(n,val){
      if (n<1 || n>=id.childNodes.length) {
      alert(NSB._["Error: Index out of range: {array}[{index}]"].supplant({"array": id.id, "index": n}));
    }
    if (typeof(val)!="boolean"){
      alert(NSB._["Error: Must be true or false: {array}[{index}] {value}"].supplant({"array": id.id, "index": n, "value": val}));
    }
    id.childNodes[n].children[1].checked=val;
  }  
}

NSB.ButtonBar = function(id, TopBar, ButtonNames, DefaultButton, html) {
  var i,s,arrNames;
  var arrNames=split(ButtonNames,",");
  s="<div id='"+id+"'>\n";
  if (TopBar==true){
    s+="<div id='topbar'" + enquote(html) + ">";
    if (arrNames.length==2) s+="<div id='duoselectionbuttons'>"
	                   else s+="<div id='triselectionbuttons'>";
  } else {
    if (arrNames.length==2) s+="<div id='duobutton'>"
	                   else s+="<div id='tributton'>";  
    s+="<div class='links'" + enquote(html) + ">";
  }
  s+="\n";
  for (i=0; i<arrNames.length; i++){
    s+="<a id='"+ id+"_"+i + "' nsbclick='"+id+"' nsbvalue='"+arrNames[i]+"' style='line-height:27px;'";
	if (i+1==DefaultButton) s+=" id=' pressed'";
	s+=">"+arrNames[i]+"</a>";
  }
  s+="</div></div></div>\n";
  //console.log(s);
  return s;
}
  
NSB.ButtonBar_init = function(id, names){
  var arrNames=split(names,",");
  for (var i=0; i<arrNames.length; i++) {
    NSB.$(id.id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onbuttonclick(this.getAttribute("nsbvalue"))}};
}

NSB.TitleBar = function(id, title, leftButtonStyle, rightButtonStyle, leftButtonNames, rightButtonNames, html) {
  var imageButtons,s,arrNames,i
  var lbCnt=0;
  imageButtons=['home','back','forward','info','minus','plus','setup'];
  s="<div id='" + id + "'></div>\n";
  s+="<div id='topbar' "+ enquote(html) + ">\n";
  if (leftButtonStyle != ""){
    s+="  <div id='" + leftButtonStyle + "'>\n";
    arrNames=split(leftButtonNames,",");
    lbCnt=arrNames.length;
    for (i=0; i<lbCnt; i++) {
      if (imageButtons.indexOf(arrNames[i])>=0) {
        s+="    <a id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+arrNames[i]+"'>\n";
        s+="    <div id=img1 style='background-image:url(\"./nsb/images/titlebarIcons.png\");" +
           " background-position:" + imageButtons.indexOf(arrNames[i])*-20 + "px; height:22px; width:20px; background-repeat:no-repeat;'" + 
           " ></div></a>\n"}
      else {
        s+="    <a id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+arrNames[i]+"' >\n";
        s+="    <div id='" + arrNames[i] + "'>" + arrNames[i] + "</div></a>\n"}
	  if (leftButtonStyle != "leftnav") break;
    }
    s+="    </div>\n";
  }
  if (title != "") s+="  <div id='title'>" + title + "</div>\n";
   
  if (rightButtonStyle != ""){
    s+="  <div id='" + rightButtonStyle + "'>\n";
    arrNames=split(rightButtonNames,",");
    for (i=0; i<arrNames.length; i++) {
      if (imageButtons.indexOf(arrNames[i])>=0) {
        s+="    <a id='" + (id+"_"+(i+lbCnt))  + "' nsbclick='"+id+"' nsbvalue='"+arrNames[i]+"'>\n";
        s+="    <div id=img1 style='background-image:url(\"./nsb/images/titlebarIcons.png\");" +
           " background-position:" + imageButtons.indexOf(arrNames[i])*-20 + "px; height:22px; width:20px; background-repeat:no-repeat;'" + 
           " ></div></a>\n"}
      else {
        s+="    <a id='" + (id+"_"+(i+lbCnt))  + "' nsbclick='"+id+"' nsbvalue='"+arrNames[i]+"' >\n";
		s+="    <div id='" + arrNames[i] + "'>" + arrNames[i] + "</div></a>\n"}
 	  if (rightButtonStyle != "rightnav") break;
    }
    s+="    </div>\n";
  }
 
  s+="</div>\n";
  //console.log(s);
  return s; 
}

NSB.TitleBar_init=function(id, leftButtonNames, rightButtonNames){
  var lbCnt=0;
  if (leftButtonNames!="") {
    var arrNames=split(leftButtonNames,",");
    lbCnt=arrNames.length;
    for (i=0; i<lbCnt; i++) {
      if(NSB.$(id+"_"+i)!=undefined)
        NSB.$(id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(this.getAttribute("nsbvalue"))}};
    }
  if (rightButtonNames!="") {
    arrNames=split(rightButtonNames,",");
    for (i=0; i<arrNames.length; i++) {
      if(NSB.$(id+"_"+(i+lbCnt))!=undefined)
        NSB.$(id+"_"+(i+lbCnt)).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(this.getAttribute("nsbvalue"))}}; 
    }
}

NSB.Menu = function(id, title, itemList, imageList, html){
  var i,s,arrItems,arrImages;
  s="<div id='" + id + "_scroller' >\n";
  s+="<div id='" + id + "'>\n";
  if (title!="") s+="<span class='graytitle'>" + title + "</span>\n";
  s+="<ul id='" + id + "_list' class='pageitem' " + enquote(html) + ">\n";
  arrItems=split(itemList,",");
  arrImages=split(imageList,",");
  for (i=0; i<arrItems.length; i++) {
    s+="  <li class='menu'>\n";
    s+="    <a id='" + (id+"_"+i) + "' nsbclick='" + id + "' nsbvalue='"+i+"'>\n";
    if ((i<arrImages.length) & (arrImages[i]!="")) s+="      <img src='" + arrImages[i] + "'>\n";
    s+="      <span class='name'>" + arrItems[i] + "</span>\n";
    s+="      <span class='arrow'></span>\n";
    s+="  </a>\n";
    }
  s+="</ul></div></div>\n";
  //console.log(s);
  return s
}

NSB.Menu_init = function(id,items){
  var arrItems=split(items,",");
  for (var i=0; i<arrItems.length; i++) {
    NSB.$(id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(Number(this.getAttribute("nsbvalue")))}};
  NSB.$(id).getItemCount=function(){
    var elem = NSB.$(id + "_list");
    return elem.getElementsByTagName("li").length;
    }
  NSB.$(id).getItem=function(i){
    var ii=(NSB.$(id).children[0].tagName!="SPAN")?0:1;
    return NSB.$(id).children[ii].children[i].innerText};
  NSB.$(id).deleteItem=function(which){
    var elem = NSB.$(id + "_list");
    if (isNull(which)) {
      which = NSB.$(id).getItemCount() - 1;
      elem.removeChild(elem.getElementsByTagName("li")[which]);
      }
    else if (which.toUpperCase() == "ALL") {
      i = NSB.$(id).getItemCount()-1
      for (i; i>=0; i--) {
        elem.removeChild(elem.getElementsByTagName("li")[i]);
        }
      }
 	NSB.$(id).refresh()
    }
  NSB.$(id).addItem=function(itemName,imgSrc,itemNo){
    var newLi,newSpan,newHref,newImgSrc, newASpan;
    if (isNull(itemNo)) {
      i = NSB.$(id).getItemCount();
      }
    else {
      i = itemNo;
      }
    newLi = document.createElement("li");
    newLi.setAttribute("class", "menu")
    newLi.setAttribute("onclick", (id + ".onclick(" + i + ")"))
    newHref = document.createElement("a");
    newHref.setAttribute("id", (id+"_"+i));
    if (!isNull(imgSrc)) {
      newImgSrc = document.createElement("img");
      newImgSrc.setAttribute("src", imgSrc);
      newHref.appendChild(newImgSrc);
     }    
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "name")
    newSpan.appendChild(document.createTextNode(itemName));
    newHref.appendChild(newSpan);
    
    newASpan = document.createElement("span");
    newASpan.setAttribute("class", "arrow")  
    newHref.appendChild(newASpan)    
    newLi.appendChild(newHref)   
    if (isNull(itemNo)) {
      NSB.$(id + "_list").appendChild(newLi); 
      }
    else {
      NSB.$(id + "_list").insertBefore(newLi,NSB.$(id +"_list").getElementsByTagName("li")[itemNo]); 
      }
 	NSB.$(id).refresh()
    }
  NSB.$(id).replaceItem=function(itmNo,newItemName,newImgSrc){
    if ((isNaN(itmNo)) || (itmNo < 0 || itmNo > NSB.$(id).getItemCount() -1)) {
      return -1;
      }
    elem = NSB.$(id + "_list")
    elem.removeChild(elem.getElementsByTagName("li")[itmNo]);
    NSB.$(id).addItem(newItemName,newImgSrc,itmNo);
    return itmNo;
  }
}

NSB.MenuNumberTitleTime = function(id, numberList, titleList, timeList, html){
  var i,s,arrNumbers,arrTitles,arrTimes;
  arrNumbers=split(numberList,",");
  arrTitles=split(titleList,",");
  arrTimes=split(timeList,",");
  s ="<div id='" + id + "_scroller' >\n"
  s+="<div id='" + id + "' class='ipodlist'>\n";
  s+="<div style='height:10px'></div>\n"
  s+="<div id='content'>\n";
  s+="<ul id='" + id + "_list'" + enquote(html) + ">\n";
  for (i=0; i<arrNumbers.length; i++) {
    s+="  <li>\n";
    s+="    <a id='" + (id+"_"+i) + "' nsbclick='" + id + "' nsbvalue='"+i+"'>\n";
    s+="      <span class='number'>" + arrNumbers[i] + "</span>\n";
    s+="      <span class='auto'></span>\n";
    s+="      <span class='name'>" + arrTitles[i] + "</span>\n";
    if ((i<arrTimes.length) & (arrTimes[i]!="")) s+="      <span class='time'>" + arrTimes[i] + "</span>\n";
    s+="  </a>\n";
    }
  s+="</ul></div></div></div>\n";
  //console.log(s)
  return s;
}
  
NSB.MenuNumberTitleTime_init = function(id,items){
  var i, arrItems
  arrItems=split(items,",");
  for (i=0; i<arrItems.length; i++) {
    NSB.$(id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(Number(this.getAttribute("nsbvalue")))}};
  NSB.$(id).getItemCount=function(){
    var elem = NSB.$(id + "_list");
    return elem.getElementsByTagName("li").length;
    }
  NSB.$(id).getItem=function(i){
    return NSB.$(id).children[1].children[0].children[i].innerText};
  NSB.$(id).deleteItem=function(which){
    var elem = NSB.$(id + "_list");
    if (isNull(which)) {
      which = NSB.$(id).getItemCount() - 1;
      elem.removeChild(elem.getElementsByTagName("li")[which]);
      }
    else if (which.toUpperCase() == "ALL") {
      i = NSB.$(id).getItemCount()-1
      for (i; i>=0; i--) {
        elem.removeChild(elem.getElementsByTagName("li")[i]);
        }
      }
	NSB.$(id).refresh()
    }
  NSB.$(id).addItem=function(number,title,time,itemNo){
    var newLi,newSpan,newHref;
    if (isNull(itemNo)) {
      i = NSB.$(id).getItemCount();
      }
    else {
      i = itemNo;
      }
    newLi = document.createElement("li");
    newLi.setAttribute("onclick", (id + ".onclick(" + i + ")"))
    newHref = document.createElement("a");
    newHref.setAttribute("id", (id+"_"+i));
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "number")
    newSpan.appendChild(document.createTextNode(number));
    newHref.appendChild(newSpan)
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "auto")
    newHref.appendChild(newSpan)
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "name")
    newSpan.appendChild(document.createTextNode(title));
    newHref.appendChild(newSpan)
 	  if (time!="") {
      newSpan = document.createElement("span");
      newSpan.setAttribute("class", "time")
      newSpan.appendChild(document.createTextNode(time));
      newHref.appendChild(newSpan)};
    newLi.appendChild(newHref)
    if (isNull(itemNo)) {
      NSB.$(id + "_list").appendChild(newLi); 
      }
    else {
      NSB.$(id + "_list").insertBefore(newLi,NSB.$(id + "_list").getElementsByTagName("li")[itemNo]); 
      }
	NSB.$(id).refresh()
    } 
  NSB.$(id).replaceItem=function(itmNo,number,title,time){
    if ((isNaN(itmNo)) || (itmNo < 0 || itmNo > NSB.$(id).getItemCount() -1)) {
      return -1;
      }
    elem = NSB.$(id + "_list")
    elem.removeChild(elem.getElementsByTagName("li")[itmNo]);
    NSB.$(id).addItem(number,title,time,itmNo);
    return itmNo;
  }
}

NSB.MenuNumberTitleDescArrow = function(id, numberList, titleList, descList, html){
  var i,s,arrNumbers,arrTitles,arrDescs;
  arrNumbers=split(numberList,",");
  arrTitles=split(titleList,",");
  arrDescs=split(descList,",");
  s ="<div id='" + id + "_scroller' >\n"
  s+="<div id='" + id + "' class='musiclist'>\n";
  s+="<div style='height:10px'></div>\n"
  s+="<div id='content'>\n";
  s+="<ul id='" + id + "_list'" + enquote(html) + ">\n";
  for (i=0; i<arrNumbers.length; i++) {
    s+="  <li>\n";
    s+="    <a id='" + (id+"_"+i) + "' nsbclick='" + id + "' nsbvalue='"+i+"'>\n";
    s+="      <span class='number'>" + arrNumbers[i] + "</span>\n";
    s+="      <span class='name'>" + arrTitles[i] + "</span>\n";
    if ((i<arrDescs.length) & (arrDescs[i]!="")) s+="      <span class='time'>" + arrDescs[i] + "</span>\n";
    s+="      <span class='arrow'></span>\n";
   s+="  </a>\n";
    }
  s+="</ul></div></div></div>\n";
  //console.log(s);
  return s;
}
  
NSB.MenuNumberTitleDescArrow_init = function(id,items){
  var i, arrItems
  arrItems=split(items,",");
  for (i=0; i<arrItems.length; i++) {
    NSB.$(id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(Number(this.getAttribute("nsbvalue")))}};
  NSB.$(id).getItemCount=function(){
    var elem = NSB.$(id + "_list");
    return elem.getElementsByTagName("li").length;
    }
  NSB.$(id).getItem=function(i){
    return NSB.$(id).children[1].children[0].children[i].innerText};
  NSB.$(id).deleteItem=function(which){
    var elem = NSB.$(id + "_list");
    if (isNull(which)) {
      which = NSB.$(id).getItemCount() - 1;
      elem.removeChild(elem.getElementsByTagName("li")[which]);
      }
    else if (which.toUpperCase() == "ALL") {
      i = NSB.$(id).getItemCount()-1
      for (i; i>=0; i--) {
        elem.removeChild(elem.getElementsByTagName("li")[i]);
        }
      }
 	NSB.$(id).refresh()
    }
  NSB.$(id).addItem=function(number,title,desc,itemNo){
    var newLi,newSpan,newHref;
    if (isNull(itemNo)) {
      i = NSB.$(id).getItemCount();
      }
    else {
      i = itemNo;
      }
    newLi = document.createElement("li");
    newLi.setAttribute("onclick", (id + ".onclick(" + i + ")"))
    newHref = document.createElement("a");
    newHref.setAttribute("id", (id+"_"+i));
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "number")
    newSpan.appendChild(document.createTextNode(number));
    newHref.appendChild(newSpan)
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "name")
    newSpan.appendChild(document.createTextNode(title));
    newHref.appendChild(newSpan) 
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "time")
    newSpan.appendChild(document.createTextNode(desc));
    newHref.appendChild(newSpan)
	newSpan = document.createElement("span");
    newSpan.setAttribute("class", "arrow")
    newHref.appendChild(newSpan);
    newLi.appendChild(newHref)
    if (isNull(itemNo)) {
      NSB.$(id + "_list").appendChild(newLi); 
      }
    else {
      NSB.$(id + "_list").insertBefore(newLi,NSB.$(id + "_list").getElementsByTagName("li")[itemNo]); 
      }
 	NSB.$(id).refresh()
    } 
  NSB.$(id).replaceItem=function(itmNo,number,title,time){
    if ((isNaN(itmNo)) || (itmNo < 0 || itmNo > NSB.$(id).getItemCount() -1)) {
      return -1;
      }
    elem = NSB.$(id + "_list")
    elem.removeChild(elem.getElementsByTagName("li")[itmNo]);
    NSB.$(id).addItem(number,title,time,itmNo);
    return itmNo;
  }
}

NSB.MenuTextBlock = function(id, title, textList, html){
  var i,s,arrTexts,elem;
  
  s="<style>\n"
  s+="  .menuTextBlock .name {max-width:86%;}\n";
  s+="  .menuTextBlock {position:relative; list-style-type:none; display:block; height:85px; overflow:hidden; border-top:1px solid #878787; width:auto;}\n";
  s+="  .menuTextBlock:hover{background:-webkit-gradient(linear,0% 0%,0% 100%,from(#cfcfcf),to(#ffffff));}\n";
  s+="  .menuTextBlock a:hover .name {color:#fff;}\n";
  s+="  .menuTextBlock a:hover .comment { color:#CCF;}\n";
  s+="  .menuTextBlock a {display:block; height:43px; width:auto; text-decoration:none;}\n";
  s+="  .menuTextBlock a img {width:auto; height:32px; margin:5px 0 0 5px; float:left;}\n";
  s+="  .menuTextBlock .name {margin:11px 0 0 7px; width:auto; color:#000; font-weight:normal; font-size:11px; text-overflow:ellipsis; overflow:hidden; white-space:wrap; float:left;}\n";
  s+="  .menuTextBlock .comment {margin:11px 30px 0 0; width:auto; font-size:17px; text-overflow:ellipsis; overflow:hidden; max-width:75%; white-space:nowrap; float:right;color:#324f85; }\n";
  s+="  .menuTextBlock .arrow {position:absolute; width:8px!important; height:13px!important; right:10px; top:15px; margin:0!important; background:url('nsb/images/arrow.png') 0 0 no-repeat;}\n";
  s+="  </style>\n";  
  
  s+="<div id='" + id + "_scroller' >\n";
  s+="<div id='" + id + "'>\n";
  if (title!="") s+="<span class='graytitle'>" + title + "</span>\n";
  s+="<ul id='" + id + "_list' class='pageitem' " + enquote(html) + ">\n";
  arrTexts=split(textList,"|");
  for (i=0; i<arrTexts.length; i++) {
    s+="  <li class='menuTextBlock'>\n";
    s+="    <a id='" + (id+"_"+i) + "' nsbclick='" + id + "' nsbvalue='"+i+"'>\n";
    s+="     <span class='name'>" + arrTexts[i] + "</span>\n";
    s+="     <span class='arrow'></span>\n";
    s+="  </a>\n";
    }
  s+="</ul></div></div>\n";
  //console.log(s);
  return s;
}  

NSB.MenuTextBlock_init = function(id,items){
  var i, arrItems
  arrItems=split(items,"|");
  for (i=0; i<arrItems.length; i++) {
    NSB.$(id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(Number(this.getAttribute("nsbvalue")))}};
  NSB.$(id).getItemCount=function(){
    elem = NSB.$(id + "_list");
    return elem.getElementsByTagName("li").length;
    }
  NSB.$(id).getItem=function(i){
    var ii=(NSB.$(id).children[0].tagName!="SPAN")?0:1;
    return NSB.$(id).children[ii].children[i].innerText};
  NSB.$(id).deleteItem=function(which){
    elem = NSB.$(id + "_list");
    if (isNull(which)) {
      which = NSB.$(id).getItemCount() - 1;
      elem.removeChild(elem.getElementsByTagName("li")[which]);
      }
    else if (which.toUpperCase() == "ALL") {
      i = NSB.$(id).getItemCount()-1
      for (i; i>=0; i--) {
        elem.removeChild(elem.getElementsByTagName("li")[i]);
        }
      }
 	NSB.$(id).refresh()
    }
  NSB.$(id).addItem=function(text, itemNo){
    var newLi,newSpan,newHref;
    if (isNull(itemNo)) {
      i = NSB.$(id).getItemCount();
      }
    else {
      i = itemNo;
      }
    newLi = document.createElement("li");
    newLi.setAttribute("class", "menuTextBlock")
    newLi.setAttribute("onclick", (id + ".onclick(" + i + ")"))
    newHref = document.createElement("a");
    newHref.setAttribute("id", (id+"_"+i));
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "name")
    newSpan.appendChild(document.createTextNode(text));
    newHref.appendChild(newSpan)
    newSpan = document.createElement("span");
    newSpan.setAttribute("class", "arrow")
    newHref.appendChild(newSpan)
    newLi.appendChild(newHref)
    if (isNull(itemNo)) {
      NSB.$(id + "_list").appendChild(newLi); 
      }
    else {
      NSB.$(id + "_list").insertBefore(newLi,NSB.$(id + "_list").getElementsByTagName("li")[itemNo]); 
      }
	NSB.$(id).refresh()
    } 
  NSB.$(id).replaceItem=function(itmNo,text){
    if ((isNaN(itmNo)) || (itmNo < 0 || itmNo > NSB.$(id).getItemCount() -1)) {
      return -1;
      }
    elem = NSB.$(id + "_list")
    elem.removeChild(elem.getElementsByTagName("li")[itmNo]);
    NSB.$(id).addItem(text,itmNo);
    return itmNo;
   }
}

NSB.Grid = function(id, rows, cols, rowHeights, colWidths, titles, alignments, style, cellstyle, klass){
    var styleName, arrHeights, arrWidths, arrTitles, arrAlignments, r, s, c;
    styleName=id + "Style"
	s="<style>"
	s+="  ." + styleName + "{border-top:1px solid #9bb3cd;border-left:1px solid #9bb3cd;margin-bottom:4em;border-collapse:collapse;}\n";
	s+="  ." + styleName + " th{padding:.2em .2em .2em .2em;background:#93A5BB;text-shadow:none;color:#fff;border:2px ridge #9bb3cd;}\n";
	s+="  ." + styleName + " th p{font-weight:bold;margin-bottom:.33em;}\n";
	s+="  ." + styleName + " td{vertical-align:middle;text-shadow:none;border:2px ridge #9bb3cd;" + cellstyle + "}\n";
	s+="  ." + styleName + " td p{margin-bottom:0;}\n";
	s+="  ." + styleName + " td p+p{margin-top:.417em;}\n";
	s+="  ." + styleName + " td p+p+p{margin-top:.417em;}\n";
	s+="</style>\n\n";

	s+="<div id='" + id + "_scroller' class='"+klass+"'>\n"
	s+="<table id='"+id+"' class='" + styleName + "' cellspacing=0 cellpadding=0 border=1  "+ enquote(style) + ">\n"
	arrHeights=split(rowHeights,",");
	arrWidths=split(colWidths,",");
	arrTitles=split(titles,",");
	arrAlignments=split(alignments,",");
	for (r=0; r<rows; r++){
	  s+="  <tr";
	  s+=">\n";
	  for (c=0; c<cols; c++){
	    if (r==0 & titles!="") td="th" 
		else td="td";
		s+="    <"+td+" id="+id+"_"+r+"_"+c;
	    if (r<arrHeights.length & arrHeights[r]!="") s+=" height=" + arrHeights[r];
		if (c<arrWidths.length & arrWidths[c]!="") s+=" width=" + arrWidths[c];
		if (c<arrAlignments.length & arrAlignments[r]!="") s+=" align=" + arrAlignments[c];
		if (cellstyle!="") s+=" style='" + cellstyle + "'";
	    s+=">";
  	    if (r==0 & c<arrTitles.length & arrTitles[c]!="") s+=arrTitles[c];
		  else s+="&nbsp;"
	    s+="</"+td+">\n";
	  }
	  s+="  </tr>\n";
	}
	s+="</table>\n</div>\n";
	//console.log(s);
	return s;
}

NSB.Grid_init = function(id){
	NSB.$(id).getRowCount=function(){
      return NSB.$(id).rows.length;
    }
    NSB.$(id).getColCount=function(cellType){
      switch (cellType){
        case "td":
          return NSB.$(id).getElementsByTagName("tr")[0].getElementsByTagName("td").length;
        case "th":
          return NSB.$(id).getElementsByTagName("tr")[0].getElementsByTagName("th").length;
        default:
          var a,b
          a=NSB.$(id).getElementsByTagName("tr")[0].getElementsByTagName("td").length;
          b=NSB.$(id).getElementsByTagName("tr")[0].getElementsByTagName("th").length;
          if (b==0){
            return a;
            }
          else{
            return b;
            }
      }
    }

	NSB.$(id).setGridWidth=function(){
    // if width of any cell in top row is given as %
    // or as "" (blank) then returns -1 else returns
    // sum of all cell widths
      var i,tmpStr,ttlCellWidth = 0;
      for (i=0; i<NSB.$(id).getColCount(); i++){
        tmpStr = NSB.$(id).rows[0].cells[i].width;
        if ((tmpStr.substr(-1) == "%") || (tmpStr == "")) {
          return -1;
          }
        else {
          ttlCellWidth = ttlCellWidth + parseInt(tmpStr);
          }
      }
      if (ttlCellWidth == -1) {
          NSB.$(id).style.width="100%";
          }
        else {
          if(ttlCellWidth>0) NSB.$(id).style.width=ttlCellWidth+"px";
          }
    }
	NSB.$(id).setGridWidth();

    NSB.$(id).getValue=function(x,y,val){
      return NSB.$(id).rows[x].cells[y].innerHTML;
      }
    NSB.$(id).setValue=function(x,y,val){
      NSB.$(id).rows[x].cells[y].innerHTML=val;
      }
	NSB.$(id).cell=function(x,y){
	  return NSB.$(id).rows[x].cells[y]
	  }
    NSB.$(id).addRows=function(no){
      var newCell,newRow,i = 1,ii,cnt,previousRow,tblBodyObj,newRowNo;
      if (no < 0){
	cnt = 0;
        }
      else if (no == null || no == ""){
        cnt = 1;
        }
      else{
        cnt = no;
        }
      tblBodyObj = NSB.$(id).tBodies[0];
      previousRow = tblBodyObj.rows[NSB.$(id).getRowCount() -1];
      while (i <= cnt){
        newRow = NSB.$(id).insertRow(tblBodyObj.rows.length);
        newRowNo = tblBodyObj.rows.length - 1;
        for (ii=0; ii<NSB.$(id).getColCount(); ii++){
          newCell = newRow.insertCell(-1);
          newCell.id = id + "_" + newRowNo + "_" + ii;
          newCell.height = previousRow.cells[ii].height;
          newCell.width = previousRow.cells[ii].width;
          newCell.innerHTML = "&nbsp"
          }
        i++;
        }
      return cnt
    }
    NSB.$(id).deleteRows=function(no){
      var cnt,noRows,i;
      if (no < 0){
	cnt = 0;
        }
      else if (no == null || no == ""){
        cnt = 1;
        }
      else{
        cnt = no;
        }
      noRows = NSB.$(id).getRowCount();
      if (cnt > (noRows-1)){
        cnt = (noRows-1);
        }
      for (i=noRows-1; i>=noRows-cnt; i--){
        NSB.$(id).deleteRow(i);
        }
      return cnt;
    }
    NSB.$(id).addCols=function(no){
      var cnt,i=1,ii,newTH,tblBodyObj,newCell,noCols;
      if (no < 0){
	      cnt = 0;
        }
      else if (no == null || no == ""){
        cnt = 1;
        }
      else{
        cnt = no;
        }
      tblBodyObj = NSB.$(id).tBodies[0];
      noCols = NSB.$(id).getColCount("th");
      if (noCols !== 0){
        while (i <= cnt){
          newTH = document.createElement("th");
          NSB.$(id).rows[0].appendChild(newTH);
          newTH.id = id + "_" + 0 + "_" + noCols;
          newTH.innerHTML = "&nbsp"
          newTH.width = "10px";
          newTH.height = NSB.$(id).rows[0].cells[noCols].height;
          for (ii=1; ii<tblBodyObj.rows.length; ii++){
            newCell = tblBodyObj.rows[ii].insertCell(-1);
            newCell.id = id + "_" + ii + "_" + noCols;
            newCell.innerHTML = "&nbsp"
            newCell.width = "10px";
            newCell.height = NSB.$(id).rows[ii].cells[noCols].height;
            }
          i++;
          }
        }
      else{
        while (i <= cnt){
          noCols = NSB.$(id).getColCount("td");
          for (ii=0; ii<tblBodyObj.rows.length; ii++){
            newCell = tblBodyObj.rows[ii].insertCell(-1);
            newCell.id = id + "_" + ii + "_" + noCols;
            newCell.innerHTML = "&nbsp"
            newCell.height = NSB.$(id).rows[ii].cells[noCols].height;
          }
          i++;
          }
        }
      NSB.$(id).setGridWidth();
      return cnt;
    }
    NSB.$(id).deleteCols=function(no){
      var cnt,noCols,i=1,ii,allRows;
      if (no < 0){
	      cnt = 0;
        }
      else if (no == null || no == ""){
        cnt = 1;
        }
      else{
        cnt = no;
        }
      noCols = NSB.$(id).getColCount();
      if (cnt > (noCols-1)){
        cnt = (noCols-1);
        }
      while (i <= cnt){
        allRows = NSB.$(id).rows;
        for (ii=0; ii<allRows.length; ii++){
          if (allRows[ii].cells.length > 1){
            allRows[ii].deleteCell(-1);
            }
          }
        i++;
        }
      NSB.$(id).setGridWidth();
      return cnt;
    }
    NSB.$(id).setColumnWidth=function(col,wdth){
      var noCols,i;
      noCols = NSB.$(id).getColCount();
      if (col < 0 || col > (noCols - 1)){
        return -1;
        }
      for (i=0; i<NSB.$(id).getRowCount(); i++){
        NSB.$(id).rows[i].cells[col].width=wdth;
        }
      NSB.$(id).setGridWidth();
      return col;
    }
    NSB.$(id).setRowHeight=function(row,ht){
      noRows = NSB.$(id).getRowCount();
      if (row < 0 || row > (noRows - 1)){
        return -1;
        }
      var noRows, i;
      if (row > (noRows - 1)){
        return -1;
        }
      for (i=0; i<NSB.$(id).getColCount(); i++){
        NSB.$(id).rows[row].cells[i].style.height=ht;
        }
      return row;
    }
 }	
 
NSB.GridRefreshWidth=function(id){
  try{id.Width=""+id.offsetWidth+"px"}
  catch(err){console.log("Error: " +err.message);debugger}
  }
  
NSB.MultiInput = function(id, rows, fieldtype, placeholders, prompts, inputTypes, values, html, scrolling) {
  var i,s,arrPlaceholders,arrPrompts,arrInputTypes,arrValues;
  arrPlaceholders=split(placeholders, ",");
  arrPrompts=split(prompts, ",");
  arrInputTypes=split(inputTypes, ",");
  arrValues=split(values, ",");
  s='';if(scrolling)s+="<div id='" + id + "_scroller' >\n";
  s+="<ul class='pageitem' id='" + id + "' " + enquote(html) + ">\n";
  for (i=0; i<rows; i++){
    s=s+"  <li class='"+ fieldtype + "' data-role='none'>\n"
    if (fieldtype=="smallfield" & i<arrPrompts.length & arrPrompts[i]!="") s+= "    <span class='name'>"+arrPrompts[i]+"</span>\n";
	if (i>arrInputTypes.length)
		s+= "    <input type='text' data-role='none'";
		else s+= "    <input type='" + arrInputTypes[i] + "' data-role='none'";
	if (i<arrPlaceholders.length & arrPlaceholders[i]!="") s+= " placeholder='" + arrPlaceholders[i] + "'";
	if (i<arrValues.length & arrValues[i]!="") s+= " value='" + arrValues[i] + "'";
	s+=" " + enquote(html) + ">\n";
    }
  s=s+"</ul>"
  if(scrolling)s=s+"\n</div>";
  //console.log(s)
  return s;
}

NSB.MultiInput_init = function(id){
  NSB.$(id).getValue=function(n){
    if (n<1 || n>=NSB.$(id).childNodes.length) {
      alert(NSB._["Error: Index out of range: {array}[{index}]"].supplant({"array": id, "index": n}));
    }
	  if (NSB.$(id).childNodes[n].className=="bigfield") p=0;
	  else p=1;
    return NSB.$(id).childNodes[n].children[p].value;
  }
  NSB.$(id).setValue=function(n,val){
    if (n<1 || n>=NSB.$(id).childNodes.length) {
      alert(NSB._["Error: Index out of range: {array}[{index}]"].supplant({"array": id, "index": n}));
    }
 	  if (NSB.$(id).childNodes[n].className=="bigfield") p=0;
	  else p=1;
    NSB.$(id).childNodes[n].children[p].value=val;
  }  
}

NSB.ComboBox = function(id, items, values, name, html) {
  var i,s,arrItems,arrValues;
  arrItems=split(items, ",");
  if(items==''){arrItems=[]};
  arrValues=split(values, ",");
  if(values==''){arrValues=[]};
  s="<div id='" + id + "' class='select' style='" + html + "'>"
  s+="<select style='" + html + "' name='" + name + "' data-role='none'>\n"
  for (i=0; i<arrItems.length; i++) {    
    if ((i<arrValues.length) & (arrValues[i]!="")) 
	  v=arrValues[i]
	else
	  v=i+1;
    s=s+"  <option value='" + (v) + "' data-role='none'>" + arrItems[i] + "</option>\n"
    }
  s=s+"</select>\n";
  s=s+"<span class='arrow'></span>\n";
  s=s+"</div>";
  //console.log(s);
  return s;
}

NSB.ComboBox_init= function(id){
  NSB.$(id).getItemCount=function(){
    return NSB.$(id).children[0].options.length}
  NSB.$(id).selectedIndex=function(){
    return NSB.$(id).childNodes[0].selectedIndex}
  NSB.$(id).selectedItem=function(){
    return NSB.$(id).childNodes[0].options[NSB.$(id).selectedIndex()].text}
  NSB.$(id).selectedValue=function(){
    return NSB.$(id).childNodes[0].value}
  NSB.$(id).setText=function(n){
    NSB.$(id).childNodes[0].options[NSB.$(id).selectedIndex()].text=n}
  NSB.$(id).setValue=function(n){
    NSB.$(id).childNodes[0].options[NSB.$(id).selectedIndex()].value=n}
  NSB.$(id).setIndex=function(n){
    NSB.$(id).childNodes[0].selectedIndex=n}
  NSB.$(id).clear=function(){
    NSB.$(id).children[0].options.length=0}
  NSB.$(id).addItem=function(optionName,optionValue){
    NSB.$(id).children[0].options[NSB.$(id).getItemCount()]=new Option(optionName, optionValue)}
  NSB.$(id).removeItem=function(items){
	if (items === undefined){return}
	if (Object.prototype.toString.apply(items) !== '[object Array]') {
       items = Array.prototype.slice.call(arguments)}
	if (items.length > 0) {items = Sort(items,"d")}
	for (i in items) {
       NSB.$(id).children[0].options[items[i]-1]=null}
  }
  NSB.$(id).List=function(n){
    return NSB.$(id).childNodes[0].options[n].text}
    var el = document.getElementById(id)
    NSB.defineProperty(el,'text',{get:function(){return NSB.$(id).selectedItem()}})
    NSB.defineProperty(el,'ListCount',{get:function(){return NSB.$(id).getItemCount()}})
    NSB.defineProperty(el,'ListIndex',{get:function(){return NSB.$(id).selectedIndex()},set:function(n){
	NSB.$(id).setIndex(n);
	if (typeof(NSB.$(id).onclick)=='function') {NSB.$(id).onclick()};
	if (typeof(NSB.$(id).onchange)=='function') {NSB.$(id).onchange()};
    }});
}

NSB.RadioButton = function(id, width, items, value, name, html) {
  var i,s,arrItems,arrValues;
  arrItems=split(items, ",");
  s="<ul id='" + id + "' class='pageitem' data-role='none'>\n";
  for (i=0; i<arrItems.length; i++) {    
    s=s+"<li class='radiobutton' data-role='none'>\n";
    s=s+"  <span class='name' data-role='none'>" + arrItems[i] + "</span>\n";
    s=s+"  <input type='radio' data-role='none' name='_" + id + "' id='" + id + "_" + (i+1) + "'";
    if (i+1==value) s=s+" checked='checked'";
    s=s+"/>\n";
    }
  s=s+"</ul>\n";
  //console.log(s);
  return s;
}

NSB.RadioButton_init= function(id){
  NSB.$(id).getItemCount=function(n){return NSB.$(id).childNodes.length-1};
  NSB.$(id).getValue=function(n){
    if (n<1 || n>this.getItemCount()) {
      alert(NSB._["Error: Index out of range: {array}[{index}]"].supplant({"array": id, "index": n}));
    }
    return NSB.$(id + "_" + n).checked;
  }
  NSB.$(id).setValue=function(n,val){
    if (n<1 || n>this.getItemCount()) {
      alert(NSB._["Error: Index out of range: {array}[{index}]"].supplant({"array": id, "index": n}));
    }
    if (typeof(val)!="boolean"){
      alert(NSB._["Error: Must be true or false: {array}[{index}] {value}"].supplant({"array": id, "index": n, "value": val}));
    }
    NSB.$(id + "_" + n).checked=val;
  }
  NSB.$(id).value=function(){
    for (var i=1;i<=NSB.$(id).getItemCount(); i++) { 
	    if (NSB.$(id).getValue(i)) return i};
	return -1}
}

Overlay = function(caption, text){
  if(typeof Ext=="undefined"){return alert(NSB._["Overlay() requires Sencha initialization."]);}
  var Factor,x,y,sText,myOverlay
  Factor = window.innerHeight / 460;

  if ((Factor < 1.0) || ((320 * Factor) > window.innerWidth)) {Factor = 1.0};

  x = 320 * Factor;
  y = 460 * Factor;
  
  sText = "<font size=" + 3 * Factor + "px>" + text + "</font>";

  myOverlay = new Ext.Panel(
    {floating: true, 
     modal: true, 
     centered: true,
     width: x,
     height: y, 
     styleHtmlContent: true, 
     scroll: "vertical",
     "html": sText,
     dockedItems: [{dock: "top", xtype: "toolbar", title: caption},
                   {dock: "bottom", xtype: "toolbar", ui: "light",
                    items: [{ ui: "confirm", text: "Close", handler: function(){myOverlay.hide()} }] }]} );
  myOverlay.show();
  return myOverlay;
}

/**************************************************************************************/
// jqWidgets functions

NSB.PhotoGallery_jqw = function(id, fotos, photoclassname, photostyle){
	var i,s, arrItems;
	arrItems=split(fotos, ",");		
	if(fotos==''){arrItems=[]};
	//Man kann vieleicht eingene Class definieren, sonst default Class ".phone" benutzen....
	if(photoclassname=='') {photoclassname='.photo'};	
	s = '<style type="text/css">\n' ;
	s += '.'+id+'_photostyle{ '+photostyle+'}</style>\n' ;
	s += '<div id="'+id+ '">\n' ;
	if(photoclassname=='') {
		for (i=0; i<arrItems.length; i++) {
			s += '<div><div class="phone" style="background-image: url('+arrItems[i]+');"></div></div>\n';}
		} else {
			for (i=0; i<arrItems.length; i++) {
				s += '<div><div class="'+id+'_photostyle" style="background-image: url('+arrItems[i]+');"></div></div>\n';}
		}			
	s += '</div>\n';
	//console.log(s);
	return s
}

/**************************************************************************************/
// jQuery Mobile 1.3 functions
// copyright 2014 NS BASIC Corporation. All rights reserved.

NSB.Checkbox_jqm = function(id, width, options, html, properties, Theme, klass, corners, iconPos) {
  var i,s;
  var arrOptions=split(options, ",");
  if(corners) corners=" data-corners=" + corners;
  if(iconPos=='right') iconPos="data-icon-pos=right";
  s="<fieldset data-role='controlgroup' id='" + id + "' " + enquote(html) + properties + corners;
  s+=" " + iconPos + " style='margin-top:0px;' class='needsclick " + klass + "'>\n";
  for (i=0; i<arrOptions.length; i++){
    s=s+"  <input type='checkbox' data-theme=" + Theme + " name='" + id + "_" + (i+1) + "' id='" + id + "_" + (i+1) + "'>\n";
    s=s+"  <label for='" + id + "_" + (i+1) + "'>" + arrOptions[i] + "</label>";
	}
  s=s+"</fieldset>";
  //console.log(s)
  return s;
}

NSB.Checkbox_jqm_init= function(id, options){
  var arrOptions=split(options, ",");
  NSB.$(id).style.zIndex=0;
  for (var i=0; i<arrOptions.length; i++){
      window[id+'_'+(i+1)]=document.getElementById(id+'_'+(i+1))
  }
  NSB.addDisableProperty(NSB.$(id));
  //if(width<=10) NSB.$(id).style.width=document.width-18+"px";
  NSB.$(id).getValue=function(n){
    try
      {return NSB.$(id + "_" + n).checked}
	 catch(err)
      {alert(err.message)}
  }
  NSB.$(id).setValue=function(n,val){
	  if (typeof(val)!="boolean"){
      alert(NSB._["Error: Must be true or false: {array}[{index}] {value}"].supplant({"array": id, "index": n, "value": val}));
    }
    try
	   {NSB.$(id + "_" + n).checked = val;
	   $('#'+id+'_'+n).checkboxradio('refresh'); }
	 catch(err)
      {alert(err.message)};
    }  
}

NSB.RadioButton_jqm = function(id, width, items, value, html, properties, Theme, klass, corners, iconPos) {
  var i,s;
  var arrOptions=split(items, ",");
  if(Theme!="") Theme="data-theme="+Theme;
  if(corners) corners=" data-corners=" + corners + " ";
  if(iconPos=='right') iconPos=" data-icon-pos=right";
  s="<fieldset data-role='controlgroup' id='" + id + "' " + enquote(html) + properties + corners;
  s+=iconPos + " style='margin-top:0px;' class='" + klass + "'>\n";
  for (i=0; i<arrOptions.length; i++){
    s=s+"  <input type='radio' " + Theme + " name='" + id + "' id='" + id + "_" + (i+1) + "'";
    if (i==value-1) s=s+" checked=checked";
    s=s+" value='" + i + "'>\n";
    s=s+"  <label for='" + id + "_" + (i+1) + "'>" + arrOptions[i] + "</label>\n";
	}
  s=s+"</fieldset>";
  //console.log(s);
  return s;
}

NSB.RadioButton_jqm_init= function(id, width){
  NSB.addDisableProperty(NSB.$(id));
  NSB.$(id).style.height="auto";
  NSB.$(id).style.zIndex=0;
  if(width<=10) NSB.$(id).style.width=document.body.clientWidth-18+"px";
  NSB.$(id).getItemCount=function(){return NSB.$(id).children[0].childElementCount};
  NSB.$(id).getValue=function(n){
    try
      {return NSB.$(id + "_" + n).checked}
	 catch(err)
      {alert(err.message)}
  }
  NSB.$(id).setValue=function(n,val){
	  if (typeof(val)!="boolean"){
      alert(NSB._["Error: Must be true or false: {array}[{index}] {value}"].supplant({"array": id, "index": n, "value": val}));
    }
    try
	   {NSB.$(id + "_" + n).checked = val;
	   $('#'+id+'_'+n).checkboxradio('refresh'); }
	catch(err)
      {alert(err.message)};
    }
  NSB.$(id).value=function(){
    for (i=1;i<=NSB.$(id).getItemCount(); i++) {
      if (NSB.$(id).getValue(i)) return i}
	return -1}
  NSB.$(id).hide=function(){this.style.display='none'};
  NSB.$(id).show=function(){this.style.display='block'};
}

NSB.HeaderBar_jqm = function(id, title, leftButtonName, leftButtonIcon, rightButtonName, rightButtonIcon, html) {
  var name;
  var s="<div id='" + id + "' data-role='header'" + html + ">\n";
  if (leftButtonName != "" || leftButtonIcon != "false"){
    s+="  <div id='"+id+"_left' data-role='button' class='ui-btn-left' data-icon='" + leftButtonIcon + "'";
	if (leftButtonName == "") {
	   name=leftButtonIcon;
	   s+=" data-iconpos='notext'"}
	else name=leftButtonName;
    s+="' nsbclick='"+id+"' nsbvalue='"+name+"'";	
	s+=">" + leftButtonName + "</div>\n";
  }
  if (title != "") s+="  <h1>" + title + "</h1>\n";
   
  if (rightButtonName != "" || rightButtonIcon != "false"){
    s+="  <div id='"+id+"_right' data-role='button' class='ui-btn-right' data-icon='" + rightButtonIcon + "'";
	if (rightButtonName == "") {
	   name=rightButtonIcon;
	   s+=" data-iconpos='notext'"}
	else name=rightButtonName;
    s+="' nsbclick='"+id+"' nsbvalue='"+name+"'";
	s+=">" + rightButtonName + "</div>\n";
  }
  s+="</div>\n";
  //console.log(s);
  return s;
}

NSB.List_jqm = function(id, showNumbers, imageStyle, theme, dividerTheme, itemList, imageList, dividerList, html, properties, width, scrolling, readonly, corners, icon){
  var i,s='';
  if(scrolling)s="<div id='" + id + "_scroller'>\n"
  s+="<" + showNumbers + " id='" + id + "' data-role='listview' class='ui-listview' data-corners='"+corners+"' data-icon='"+icon+"' ";
  s+="data-inset=true data-theme='"+theme+"' data-dividertheme='"+dividerTheme+"' imagestyle='"+imageStyle+"'" + enquote(html) + ">\n";
  var arrItems=split(itemList,",");
  var arrImages=split(imageList,",");
  var arrDividers=split(dividerList,",");
  for (i=0; i<arrItems.length; i++) {
    s+="  <li ";
	if ((i<arrDividers.length) & (arrDividers[i]=="Y")) 
	  {s+="data-role='list-divider' role='heading'>\n"}
	else {
	  if (!readonly){
      	s+=">";
      	s+="<a id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+i+"' href='#'>"}
      else s+=">"};
    if ((i<arrImages.length) & (arrImages[i]!="")) 
	  {s+="<img src='" + arrImages[i] + "' class='"+imageStyle+"'>"};
    s+=Trim(arrItems[i]);
    if (!((i<arrDividers.length) & (arrDividers[i]=="Y")))
      {s+=readonly ? "\n" : "</a>\n"};
    }
  s+="</" + showNumbers + ">"
  if(scrolling)s+="</div>\n";
  //console.log(s);
  return s;
}

NSB.List_jqm_init= function(id, items, scrolling, width, readonly){ 
  var arrItems=split(items,",");
  for (var i=0; i<arrItems.length; i++) {
    if(NSB.$(id+"_"+i)!=undefined)
      NSB.$(id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(this.getAttribute("nsbvalue"))}};
  NSB.addDisableProperty(NSB.$(id)); 
  if (scrolling) {
    NSB.$(id+"_scroller").style.width=IsNumeric(width) ? width + "px" : width;
    NSB.$(id).style.width="100%"
  } else NSB.$(id).style.width=IsNumeric(width) ? width + "px" : width;	
  NSB.$(id).readonly=readonly;
  NSB.$(id).getItemCount=function(){
    var elem = NSB.$(id);
    return elem.getElementsByTagName("li").length;
  }
  NSB.$(id).getItem=function(i){
    var s=NSB.$(id).children[i].innerText;
    if (s.substr(-3)==String.fromCharCode(10) + String.fromCharCode(160) + String.fromCharCode(10)) {
      s=s.substr(0,s.length-3)};
    return s};
  NSB.$(id).deleteItem=function(which){
    var elem = NSB.$(id);
    if (isNull(which)) {
      which = NSB.$(id).getItemCount() - 1;
      elem.removeChild(elem.getElementsByTagName("li")[which]);
      }
    else if (which.toUpperCase() == "ALL") {
      var i = NSB.$(id).getItemCount()-1
      for (i; i>=0; i--) {
        elem.removeChild(elem.getElementsByTagName("li")[i]);
      }
    }
    $(NSB.$(id)).listview("refresh");
    NSB.$(id).refresh();
  }
  NSB.$(id).addItem=function(itemName,imgSrc,itemNo,divider){
    var s,i,newLi,newSpan,newHref,newImgSrc;
    if (isNull(itemNo)) {
      i = NSB.$(id).getItemCount();
      }
    else {
      i = itemNo;
      }
    newLi = document.createElement("li");
    if(divider!=true){
      if(!this.readonly){
        newLi.setAttribute("onclick", (id + ".onclick(" + i + ")"));
        s="<a id='" + (id+"_"+i) + "' href='#'>" + itemName;	
        if (imgSrc) s+=" <img src='" + imgSrc + "' class='" + NSB.$(id).getAttribute("imagestyle") + "'>";
        newLi.innerHTML+=s + "</a>\n"
      } else {
        newLi.innerHTML+=itemName}
    }
    else {
      newLi.setAttribute("data-role","list-divider");
      newLi.innerHTML = itemName}
    if (isNull(itemNo)) {
      NSB.$(id).appendChild(newLi); 
		}
    else {
      NSB.$(id).insertBefore(newLi,NSB.$(id).getElementsByTagName("li")[itemNo]); 
      }
	$(NSB.$(id)).listview("refresh");
	NSB.$(id).refresh();
    } 
  NSB.$(id).replaceItem=function(itmNo,newItemName,newImgSrc){
    if ((isNaN(itmNo)) || (itmNo < 0 || itmNo > NSB.$(id).getItemCount() -1)) {
      return -1;
    }
    elem = NSB.$(id)
    elem.removeChild(elem.getElementsByTagName("li")[itmNo]);
    NSB.$(id).addItem(newItemName,newImgSrc,itmNo);
    return itmNo;
  }
}

NSB.NavBar_jqm = function(id, items, fontSize, fontFamily, fontStyle, fontWeight, Theme, icons, iconPos, active, klass){
  var i,s;
  var arrItems=split(items,",");
  var arrIcons=split(icons,",");
  s="<div id="+id + " data-role=navbar data-iconPos="+iconPos+ " class='" + klass + "'>\n";
  s+="<ul>\n";
  for (i=0; i<arrItems.length; i++) {
    arrItems[i]=Trim(arrItems[i]);
    s+="  <li>\n";
    s+="    <a id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+replace(arrItems[i]," ","_")+"' href='#' data-role='button' data-theme="+Theme+"";
    if ((i<arrIcons.length) & (arrIcons[i]!="")) s+=" data-icon=" + Trim(arrIcons[i]);
    if (i+1==active) s+=" class='ui-btn-active'";
    s+=">\n";
    s+="    " + arrItems[i] + "\n";
    s+="    </a>\n";
    }
  s+="</ul></div>\n";
  //console.log(s);
  return s;
}

NSB.NavBar_jqm_init= function(id,items){
  var arrItems=split(items,",");
  for (var i=0; i<arrItems.length; i++) {
    NSB.$(id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(this.getAttribute("nsbvalue"))}};
  NSB.addDisableProperty(NSB.$(id));
  NSB.$(id).style.width="100%";
  NSB.$(id).style.left="0px";
  NSB.$(id).style.height="auto";
}

NSB.FooterBar_jqm = function(id, items, fontSize, fontFamily, fontStyle, fontWeight, Theme, icons, iconPos, active, klass){
  var i,s;
  var arrItems=split(items,",");
  var arrIcons=split(icons,",");
  s="<div id="+id + " data-role='footer' class='" + klass + "'>\n";
  s+="<div data-role=navbar data-iconPos="+iconPos+ ">\n";
  s+="<ul>\n";
  for (i=0; i<arrItems.length; i++) {
    arrItems[i]=Trim(arrItems[i]);
    s+="  <li>\n";
    s+="    <a id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+replace(arrItems[i]," ","_")+"' href='#' data-role='button' data-theme="+Theme+"";
    if ((i<arrIcons.length) & (arrIcons[i]!="")) s+=" data-icon=" + Trim(arrIcons[i]);
    if (i+1==active) s+=" class='ui-btn-active'";
    s+=">\n";
    s+="    " + arrItems[i] + "\n";
    s+="    </a>\n";
    }
  s+="</ul></div></div>\n";
  //console.log(s);
  return s;
}

NSB.FooterBar_jqm_init= function(id,items){  
  var arrItems=split(items,",");
  for (var i=0; i<arrItems.length; i++) {
    NSB.$(id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(this.getAttribute("nsbvalue"))}};
  NSB.addDisableProperty(NSB.$(id));
  NSB.$(id).style.width="100%";
  NSB.$(id).style.left="0px";
  NSB.$(id).style.height="auto";
  NSB.$(id).style.top="auto";
  NSB.$(id).style.bottom="0px";
  NSB.$(id).refresh();
}

NSB.FooterBarRefresh=function(id){
  //try{id.style.top=(window.innerHeight-id.offsetHeight) + 'px'}
  //catch(err){console.log("Error: " +err.message);debugger}
  //console.log("refreshed: " + window.innerHeight + "," +id.offsetHeight)
  }

NSB.Select_jqm = function(id, items, values, placeholder, selectedIndex, name, style, disabled, icon, iconPos, inline, nativeMenu, overlayTheme, Theme, mini, group, multiSelect, align, klass, corners) {
  var i,s,arrItems,arrValues;
  arrItems=split(items, ",");
  if(items==''){arrItems=[]};
  arrValues=split(values, ",");
  if(values==''){arrValues=[]};
  s ="<style>.ui-select {margin:0px}</style>\n";
  if(align!=''){s=s+"<style> #"+id+" .ui-btn {text-align:"+align+"}</style>\n"};
  s+="<select id="+id+"_inner";
  s+=" data-icon="+icon;
  s+=" data-iconpos="+iconPos;
  s+=" data-inline="+inline;
  s+=" data-native-menu="+nativeMenu;
  s+=" data-corners="+corners;
  s+=" " + mini;
  if(multiSelect=="true") {s+=" multiple=multiple"};
  if(overlayTheme!='') s+=" data-overlay-theme="+overlayTheme;
  if(Theme!='') s+=" data-theme="+Theme;
  if(style!='') s+=" style='"+style+"' class='";
  if(disabled!='') s+=disabled;
  if(icon="custom") s+=" ui-nodisc-icon";
  s+="' name='" + id + "'>\n";
  for (i=0; i<arrItems.length; i++) {    
    if ((i<arrValues.length) & (arrValues[i]!="")) 
      v=arrValues[i]
	else
      v=i+1;
    s+="  <option value='" + (v) + "'";
	if(i+1==placeholder) s+=" data-placeholder=true";
	if(i+1==selectedIndex) s+=" selected=selected";
    s+= ">" + arrItems[i] + "</option>\n"
    }
  s+="</select>";
  switch(group){
      case "": {
        if (NSB.selectGroup=="" || typeof(NSB.selectGroup)=='undefined'){
          s="<div id="+id+" class='"+klass+"'>\n" + s + "\n</div>";
          //console.log("ungrouped:\n" + s)
          return s;
        }
        else
          NSB.selectGroup+='\n<div id='+id+" class='"+klass+"'></div>\n" + s;
          //console.log("middle:\n" + NSB.selectGroup);
          break;
      }
      case "vertical": {
        NSB.selectGroup='<div data-role=fieldcontain id='+id+" style='margin:0px;' class='"+klass+"'>\n<fieldset data-role=controlgroup>\n"+s;
        //console.log("vertical:\n" + NSB.selectGroup);
        break;
      }
      case "horizontal": {
        NSB.selectGroup='<div data-role="fieldcontain" id='+id+" style='margin:0px;' class='"+klass+"'>\n<fieldset data-role='controlgroup' data-type='horizontal'>\n"+s;
        //console.log("horizontal:\n" + NSB.selectGroup);
		break;
      }
      case "end": {
        NSB.selectGroup+="\n<div id="+id+" class='"+klass+"'></div>\n" + s+"\n</fieldset></div>";
        //console.log(NSB.selectGroup);
        s=NSB.selectGroup;
        NSB.selectGroup="";
        return s;
      }
    }
}

NSB.Select_jqm_init= function(el, html, group){
    if (group=="end") NSB.selectGroup="";
    if (html.indexOf('ui-disabled')>0) 
      {setTimeout("$(NSB.$('" +id+"_inner')).selectmenu('disable')",10)};
    NSB.addDisableProperty(el);
    NSB.addProperties(el);
    el.getItemCount=function(){
      return NSB.$(el.id+'_inner').length};
    el.selectedIndex=function(){
     var s=[];
     for(var i=0;i<el.getItemCount();i++) {
       if (NSB.$(el.id+'_inner')[i].selected==true) {s.push(i)}};
     if (NSB.$(el.id+'_inner').multiple==false) {
      return s[0]}
     else {
      return s};
   }
  el.selectedValue=function(){
     var s=el.selectedIndex();
     if (s==null) return s;
     if (typeof(s)=="number") {s=[s]};
     for(var i=0;i<s.length;i++) {s[i]=NSB.$(el.id+"_inner")[s[i]].value};
     if (NSB.$(el.id+"_inner").multiple==false) {
       return s[0]}
     else {
       return s};
   }
  el.selectedItem=function(){
     var s=el.selectedIndex();
     if (s==null) return s;
     if (typeof(s)=="number") {s=[s]};
     for(var i=0;i<s.length;i++) {s[i]=NSB.$(el.id+"_inner")[s[i]].text};
     if (NSB.$(el.id+"_inner").multiple==false) {
       return s[0]}
     else {
       return s};
   }
  el.setIndex=function(n){
    var mySelect=NSB.$(el.id+"_inner");
    mySelect.selectedIndex=n;
    $(mySelect).selectmenu("refresh")}
  el.clear=function(){
    NSB.$(el.id+"_inner").options.length=0;
    //$("#"+el.id+"_inner").selectmenu("refresh")
    }
  el.addItem=function(optionName,optionValue){
    var mySelect=NSB.$(el.id+"_inner");
    if (typeof(optionValue)=="undefined") optionValue=mySelect.length;
	 mySelect.options[mySelect.length]=new Option(optionName, optionValue);
    $(mySelect).selectmenu("refresh")  
  }
  el.getValue=function(n){
	return NSB.$(el.id+"_inner").options[n].selected}
  el.getItem=function(n){
    return NSB.$(el.id+"_inner")[n].text};
  el.List=function(n){
    return el.getItem(n)}
  NSB.defineProperty(el,'text',{get:function(){return el.selectedItem()}})
  NSB.defineProperty(el,'ListCount',{get:function(){return el.getItemCount()}})
  NSB.defineProperty(el,'ListIndex',
    {get:function(){return el.selectedIndex()},
     set:function(n){
       el.setIndex(n);
       if (typeof(el.onclick)=='function') {el.onclick()};
       if (typeof(el.onchange)=='function') {el.onchange()};
     }});
}  //end select_jqm_init

NSB.PopUp_jqm = function(id, items, text, datatransition, theme, corners, arrows, icon){
	var i,s, arrItems, menu;
	arrItems=split(items, ",");
	if(items==''){arrItems=[]};

	menu=id + "Menu";
	s= "<a id="+id+" href='#"+menu+"' data-rel='popup' data-role='button' data-inline='true' data-transition='"+datatransition;
	s+="' data-icon='"+icon+"' data-theme='" + theme + " data-corners='"+corners+"' data-arrow='"+arrows+"'>" + text +"</a>\n";
	s+="<div data-role='popup' id='"+menu+"' data-theme='" + theme + "'>\n" ;
    s+="<ul data-role='listview' data-inset='true' style='min-width:210px;' data-theme='" + theme + "' >\n";
    s+="  <li data-role='divider' data-theme='e'>Choose an action</li>\n"  ;
    for (i=0; i<arrItems.length; i++) {
        s+="  <li id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+arrItems[i]+"'>"+arrItems[i]+"</li>\n"}  
	s+=    "</ul></div>" ;
	//console.log(s);
	return s;
}

NSB.PopUp_jqm_init= function(el,items){
  if(items=='') return;  
  var arrItems=split(items,",");
  for (var i=0; i<arrItems.length; i++) {
    NSB.$(el.id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(this.getAttribute("nsbvalue"))}};
  el.close=function(){$("#"+el.id+"Menu").popup("close")};
}

NSB.ToolTip_jqm = function(id, popupmsg, datatransition, theme, message, style, icon){
  if(theme != '') theme=" data-theme="+theme;
  var s = "<a id="+id+" href='#"+id+"_popupInfo' style='margin:0px;' data-rel='popup' data-role='button' ";
  s +="class='ui-icon-alt";
  if (icon == "custom") s+=" ui-nodisc-icon"; 
  s +="' data-inline='true' data-transition='" +datatransition;
  s +="' data-icon="+icon+theme+" data-iconpos='notext' title='"+message+"'>"+message+"</a>\n" ;
  s +="<div data-role='popup' id='"+id+"_popupInfo' class='ui-content'"+theme+" style='"+style+"'>\n";
  s += popupmsg+ "</div>" ;
  //console.log(s);
  return s
}

/**************************************************************************************/
// jQuery Mobile 1.4 functions

NSB.HeaderBar_jqm14 = function(id, title, leftButtonName, leftButtonIcon, leftButtonIconPos, rightButtonName, rightButtonIcon, rightButtonIconPos, html, corners, buttonTheme) {
  var name;
  var s="<div id='" + id + "' data-role='header'" + html + ">\n";
  if (leftButtonIcon == "false" || leftButtonIcon == "none") leftButtonIconPos="none";
  if (leftButtonName != "" || leftButtonIconPos != "none"){
    name = (leftButtonName == "") ? leftButtonIcon : leftButtonName;
    if (leftButtonIconPos == "notext") leftButtonName="";
    s+="  <div id='"+id+"_left' class='ui-btn ui-btn-left" + corners;
    if (leftButtonIconPos != "none") s+=" ui-btn-icon-left ui-icon-" + leftButtonIcon;
	if (leftButtonIcon == "custom") s+=" ui-nodisc-icon";
	if (buttonTheme != "") s+=" ui-btn-"+buttonTheme;
	s+="' data-iconpos=" + leftButtonIconPos;
    s+=" nsbclick='"+id+"' nsbvalue='"+name+"'";	
	s+=" style='height:14px;'>" + leftButtonName + "\n  </div>\n";
  }
  if (title != "") s+="  <h1>" + title + "</h1>\n";
   
  if (rightButtonIcon == "false" || rightButtonIcon=="none") rightButtonIconPos="none";
  if (rightButtonName != "" || rightButtonIconPos != "none"){
    name = (rightButtonName == "") ? rightButtonIcon : rightButtonName;
    if (rightButtonIconPos == "notext") rightButtonName="";
    s+="  <div id='"+id+"_right' class='ui-btn ui-btn-right" + corners;
    if (rightButtonIconPos != "none") s+=" ui-btn-icon-right ui-icon-" + rightButtonIcon;
	if (rightButtonIcon == "custom") s+=" ui-nodisc-icon";
	if (buttonTheme != "") s+=" ui-btn-"+buttonTheme;
    s+="' data-iconpos=" + rightButtonIconPos
    s+=" nsbclick='"+id+"' nsbvalue='"+name+"'";
	s+=" style='height:14px;'>" + rightButtonName + "\n  </div>\n";
  }
  s+="</div>\n";
  //console.log(s);
  return s;
}

NSB.FooterBar_jqm14 = function(id, items, theme, icons, iconPos, active, klass){
  var i,s;
  var arrItems=split(items,",");
  var arrIcons=split(icons,",");
  s="<div id="+id + " data-role='footer' class='" + klass + "'  data-theme="+theme+" data-position='fixed'>\n";
  s+="<div data-role=navbar data-iconpos="+iconPos+ ">\n";
  s+="<ul>\n";
  for (i=0; i<arrItems.length; i++) {
    arrItems[i]=Trim(arrItems[i]);
    if (arrIcons[i]) arrIcons[i]=Trim(arrIcons[i]);
    s+="  <li>\n";
    s+="    <a id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+replace(arrItems[i]," ","_")+"' href='#'";
    if(theme!="") s+=" data-theme="+theme+"";
    if ((i<arrIcons.length) & (arrIcons[i]!="")) s+=" data-icon=" + arrIcons[i];
    if (arrIcons[i] == "custom") s+=" class='ui-nodisc-icon'";
    if (i+1==active) s+=" class='ui-btn-active'";
    s+=">\n";
    s+="    " + arrItems[i] + "\n";
    s+="    </a>\n";
    }
  s+="</ul></div></div>\n";
  //console.log(s);
  return s;
}

NSB.NavBar_jqm14 = function(id, items, theme, icons, iconPos, active, klass){
  var i,s;
  var arrItems=split(items,",");
  var arrIcons=split(icons,",");
  if(theme!="") theme=" data-theme=theme";
  s="<div id="+id + " data-role=navbar data-iconpos="+iconPos+ " class='" + klass + "'>\n";
  s+="<ul>\n";
  for (i=0; i<arrItems.length; i++) {
    arrItems[i]=Trim(arrItems[i]);
    s+="  <li>\n";
    s+="    <a id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+replace(arrItems[i]," ","_")+"' href='#'"+theme+" ";
    if ((i<arrIcons.length) & (arrIcons[i]!="")) s+=" data-icon=" + Trim(arrIcons[i]);
    if (arrIcons[i] == "custom") s+=" class='ui-nodisc-icon'";
    if (i+1==active) s+=" class='ui-btn-active'";
    s+=">\n";
    s+="    " + arrItems[i] + "\n";
    s+="    </a>\n";
    }
  s+="</ul></div>\n";
  //console.log(s);
  return s;
}

NSB.PopUp_jqm14 = function(id, items, text, datatransition, theme, dataTheme, mini, corners, icon, iconPos, popup, style){
	var i,s, arrItems, menu;
	arrItems=split(items, ",");
	if(items==''){arrItems=[]};
	menu=id + "Menu";
	s= "<a id="+id+" href='#"+menu+"' data-rel='popup' data-transition='"+datatransition+"' style='"+style+" margin-top:0px' ";
	s+="class='ui-btn ui-btn-inline " + mini + " " + corners;
    if(theme!="") s+=" ui-btn-"+theme+"";
    if(icon!='') s+= " ui-icon-" + icon + " ui-btn-icon-" + iconPos;
    if(icon="customer") s+= " ui-nodisc-icon";
	s+="'>" + text +"</a>\n";
	s+="<div data-role='popup' id='"+menu+"' data-theme='" + dataTheme + "'>\n";
	if(items!="") {
        s+="<ul data-role='listview' data-inset='true' style='min-width:210px;'>\n";
        s+="  <li data-role='divider'>" + popup + "</li>\n"  ;
        for (i=0; i<arrItems.length; i++) {
            s+="  <li id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+arrItems[i]+"'>"+arrItems[i]+"</li>\n"}  
	    s+=    "</ul></div>"}
	else {
	    s+="<p>" + popup + "</div>"}
	//console.log(s);
	return s;
}

NSB.List_jqm14 = function(id, showNumbers, imageStyle, dataTheme, dividerTheme, itemList, imageList, dividerList, style, properties, width, scrolling, readonly, corners, icon, filter, filterPlaceholder, filterReveal,autoDividers){
  var i,s='';
  if(dataTheme!='') dataTheme = " data-theme=" + dataTheme;
  if(style!=='') style="style='" + style + "'";
  if(dividerTheme!='') dividerTheme = " data-divider-theme=" + dividerTheme;
  filterPlaceholder = ((filterPlaceholder!='') && (filter=='true')) ? filterPlaceholder = " data-filter-placeholder='" + filterPlaceholder + "'": "";
  filter = (filter=='true') ? " data-filter=true" : '';
  filterReveal = (filterReveal=='true') ? " data-filter-reveal=true" : '';
  autoDividers = (autoDividers=='true') ? " data-autodividers=true" : '';
  if(scrolling)s="<div id='" + id + "_scroller'>\n";
  s+="<div id='" + id + "'>\n";
  s+="<" + showNumbers + " id="+id+"_list data-role='listview' class='ui-listview";
  if (icon == "custom") s+=" ui-nodisc-icon";
  s+="' data-corners='"+corners+"' data-icon="+icon;
  s+=filter+filterReveal+filterPlaceholder+autoDividers;
  s+=" data-inset=true"+dataTheme+dividerTheme+" nsb-imageStyle='"+imageStyle+"'" + style + ">\n";
  var arrItems=split(itemList,",");
  var arrImages=split(imageList,",");
  var arrDividers=split(dividerList,",");
  for (i=0; i<arrItems.length; i++) {
    s+="  <li";
	if ((i<arrDividers.length) & (arrDividers[i]=="Y")) 
	  {s+=" data-role='list-divider' role='heading' style='white-space:normal;'>\n"}
	else {
	  if (!readonly){
      	s+=">";
      	s+="<a id='" + (id+"_"+i) + "' nsbclick='"+id+"' nsbvalue='"+i+"' href='#' style='white-space:normal;'>"}
      else s+=">"};
    if ((i<arrImages.length) & (arrImages[i]!="") & (imageStyle!='') )
	  {s+="<img src='" + arrImages[i] + "' class='"+imageStyle+"'>"};
    s+=Trim(arrItems[i]);
    if (!((i<arrDividers.length) & (arrDividers[i]=="Y")))
      {s+=readonly ? "\n" : "</a>\n"};
    }
  s+="</" + showNumbers + ">";
  s+="\n</div>\n";
  if(scrolling)s+="</div>\n";
  //console.log(s);
  return s;
}

NSB.List_jqm_init14= function(id, items, scrolling, width, readonly, filterReveal){ 
  var arrItems=split(items,",");
  for (var i=0; i<arrItems.length; i++) {
    if(NSB.$(id+"_"+i)!=undefined)
      NSB.$(id+"_"+i).onclick=function(){NSB.$(this.getAttribute("nsbclick")).onclick(this.getAttribute("nsbvalue"))}};
  NSB.addDisableProperty(NSB.$(id)); 
  if (scrolling) {
    NSB.$(id+"_scroller").style.width=IsNumeric(width) ? width + "px" : width;
    NSB.$(id).style.width="100%"
  } else NSB.$(id).style.width=IsNumeric(width) ? width + "px" : width;	
  NSB.$(id).readonly=readonly;
  NSB.$(id).getItemCount=function(){
    var elem = NSB.$(id);
    return elem.getElementsByTagName("li").length;
  }
  NSB.$(id).getItem=function(i){
    return $('#'+this.id+"_"+i).text()}
  NSB.$(id).deleteItem=function(which){
    var elem = NSB.$(id+'_list');
    if (isNull(which)) {
      which = NSB.$(id).getItemCount() - 1;
      elem.removeChild(elem.getElementsByTagName("li")[which]);
      }
    else if (which.toUpperCase() == "ALL") {
      $('#'+id+'_list').empty(); 
    }
    NSB.$(id).refresh();
  }
  NSB.$(id).addItem=function(itemName,imgSrc,itemNo,divider,theme){
    var s,i,newLi,newSpan,newHref,newImgSrc;
    if (isNull(itemNo)) {
      i = NSB.$(id).getItemCount()}
    else {
      i = itemNo}
    if (typeof(itemName)!="string") itemName=itemName.toString();
    newLi = document.createElement("li");
    if(divider!=true){
      if(!this.readonly){
        if(theme) newLi.setAttribute("data-theme",theme);
        newLi.setAttribute("onclick", (id + ".onclick(" + i + ")"));
        if(filterReveal) newLi.setAttribute("class","ui-screen-hidden");
        s="<a id='" + (id+"_"+i) + "' href='#' nsbclick='" + id + "' nsbvalue="+ i +">";	
        if (imgSrc) s+=" <img src='" + imgSrc + "' class='" + NSB.$(id+'_list').getAttribute("nsb-imageStyle") + "'>";
        s+=Trim(itemName) + "</a>\n";
        newLi.innerHTML+=s;
        //console.log(s);
      } else {
        newLi.innerHTML+=itemName}
    }
    else {
      newLi.setAttribute("data-role","list-divider");
      newLi.innerHTML = itemName}
    if (isNull(itemNo)) {
      NSB.$(id+'_list').appendChild(newLi); 
		}
    else {
      NSB.$(id+'_list').insertBefore(newLi,NSB.$(id+'_list').getElementsByTagName("li")[itemNo]); 
      }
	NSB.$(id).refresh();
	var padding=Page_jqm.style.paddingBottom;
	$(NSB.$(id+'_list')).listview("refresh");
	Page_jqm.style.paddingBottom=padding;
    } 
  NSB.$(id).replaceItem=function(itmNo,newItemName,newImgSrc){
    if ((isNaN(itmNo)) || (itmNo < 0 || itmNo > NSB.$(id).getItemCount() -1)) {
      return -1;
    }
    elem = NSB.$(id+'_list')
    elem.removeChild(elem.getElementsByTagName("li")[itmNo]);
    NSB.$(id).addItem(newItemName,newImgSrc,itmNo);
    return itmNo;
  }
  NSB.$(id).setFilter=function(str){
    $('input[data-type="search"]').val(str);
    $('input[data-type="search"]').trigger("keyup");
  }
}

NSB.Panel_jqm14 = function(id,display,dataTheme,theme,animate,dismissible,position,positionFixed,text ){
// <div data-role="panel" id="leftpanel2" data-position="left" data-display="push" data-theme="a">
	var s = "<div data-role='panel' ";
	s += " id='" +id+ "' href='" +id+ "' ";
	s += " theme='" +theme+ "'";
	s += " data-animate='" +animate+ "'";
	s += " data-dismissible='" +dismissible+ "'";
	s += " data-position='" +position+ "'";
	s += " data-position-fixed='" +positionFixed+ "'";
	s += " data-theme='" +dataTheme+ "'";
    s += " data-display='" +display+ "'> " ;
	s += "<div class='panel-content'>" ;
	s += text;
	s +=" </div></div>";
  return s ; 
//	console.log(s);
}

NSB.Panel_jqm_init14= function(id){ 
  NSB.$(id).open= function(form) {
    $(this).panel('open');
    if(typeof form === 'object') {
      this.appendChild(form);
      form.show();
      form.resize(0,0,this.Width, this.Height);  
      form.previousForm=NSBCurrentForm;
      NSBCurrentForm=form;
      if(typeof form.onshow === 'function') form.onshow();
      }
    if(typeof form === 'string') this.innerHTML=form;   
  } 
  NSB.$(id).onpanelbeforeclose = function(){
    if(typeof NSBCurrentForm.onhide === 'function') NSBCurrentForm.onhide();
    if(NSBCurrentForm.previousForm != undefined) NSBCurrentForm=NSBCurrentForm.previousForm;
  }	
  NSB.$(id).close= function() {$(this).panel('close');}
}
  
NSB.YouTubeRefresh = function(){
    var yt = this.settings;
    var s = "<iframe id='" + this.id + "_player' type='text/html' ";
    s += "width=" + yt.width + " height=" + yt.width * yt.ratio;
    s +=" src='https://www.youtube.com/embed";
    if (yt.videoID) s += '/' + yt.videoID + "?";
    if (yt.playlist) s += '?listtype=playlist&list={playlist}&';
    s += 'enablejsapi=1';
    if (yt.autoplay) s += '&autoplay=' + yt.autoplay;
    if (yt.autohide) s += '&autohide=' + yt.autohide;
    if (yt.controls) s += '&controls=' + yt.controls;
    if (yt.modestbranding) s += '&modestbranding=' + yt.modestbranding;
    s += yt.playsinline;
    if (yt.rel) s += '&rel=' + yt.rel;
    if (yt.showinfo) s += '&showinfo=' + yt.showinfo;
    if (yt.start>0) s += '&start=' + yt.start;
    if (yt.theme) s += '&theme=' + yt.theme;   
    s += "' frameborder=0 allowfullscreen></iframe>";
    this.innerHTML = s;
    }

NSB.GoogleMapRefresh = function(){
    this.mapOptions.center = new google.maps.LatLng(this.mapOptions.latitude, this.mapOptions.longitude);
    return this.map = new google.maps.Map(this, this.mapOptions)
    }
   
NSB.GoogleMapSetMarker = function(options){
	if (!options) options = {};
    options.map = this.map;
    if (!options.position) options.position=this.mapOptions.center;
    return new google.maps.Marker(options)
    }

NSB.SignatureCapture = function (canvasID) {
	// thanks to http://www.zetakey.com/codesample-signature.php
	var canvas = document.getElementById(canvasID);
	var context = canvas.getContext("2d");
	context.fillStyle = "#fff";
	context.lineCap = "round";
	context.fillRect(0, 0, canvas.width, canvas.height);
	var disableSave = true;
	var pixels = [];
	var cpixels = [];
	var xyLast = {};
	var xyAddLast = {};
	var calculate = false;
	{ 	//functions
		function remove_event_listeners() {
			canvas.removeEventListener('mousemove', on_mousemove, false);
			canvas.removeEventListener('mouseup', on_mouseup, false);
			canvas.removeEventListener('touchmove', on_mousemove, false);
			canvas.removeEventListener('touchend', on_mouseup, false);

			document.body.removeEventListener('mouseup', on_mouseup, false);
			document.body.removeEventListener('touchend', on_mouseup, false);
		}

		function get_coords(e) {
			var x, y;

			if (e.changedTouches && e.changedTouches[0]) {
				var offsety = canvas.offsetTop || 0;
				var offsetx = canvas.offsetLeft || 0;

				x = e.changedTouches[0].pageX - offsetx;
				y = e.changedTouches[0].pageY - offsety;
			} else if (e.layerX || 0 == e.layerX) {
				x = e.layerX;
				y = e.layerY;
			} else if (e.offsetX || 0 == e.offsetX) {
				x = e.offsetX;
				y = e.offsetY;
			}

			return {
				x : x,
				y : y
			};
		};

		function on_mousedown(e) {
			e.preventDefault();
			e.stopPropagation();

			canvas.addEventListener('mouseup', on_mouseup, false);
			canvas.addEventListener('mousemove', on_mousemove, false);
			canvas.addEventListener('touchend', on_mouseup, false);
			canvas.addEventListener('touchmove', on_mousemove, false);
			document.body.addEventListener('mouseup', on_mouseup, false);
			document.body.addEventListener('touchend', on_mouseup, false);

			empty = false;
			var xy = get_coords(e);
			context.beginPath();
			pixels.push('moveStart');
			context.moveTo(xy.x, xy.y);
			pixels.push(xy.x, xy.y);
			xyLast = xy;
		};

		function on_mousemove(e, finish) {
			e.preventDefault();
			e.stopPropagation();

			var xy = get_coords(e);
			var xyAdd = {
				x : (xyLast.x + xy.x) / 2,
				y : (xyLast.y + xy.y) / 2
			};

			if (calculate) {
				var xLast = (xyAddLast.x + xyLast.x + xyAdd.x) / 3;
				var yLast = (xyAddLast.y + xyLast.y + xyAdd.y) / 3;
				pixels.push(xLast, yLast);
			} else {
				calculate = true;
			}

			context.quadraticCurveTo(xyLast.x, xyLast.y, xyAdd.x, xyAdd.y);
			pixels.push(xyAdd.x, xyAdd.y);
			context.stroke();
			context.beginPath();
			context.moveTo(xyAdd.x, xyAdd.y);
			xyAddLast = xyAdd;
			xyLast = xy;

		};

		function on_mouseup(e) {
			remove_event_listeners();
			disableSave = false;
			context.stroke();
			pixels.push('e');
			calculate = false;
		};
	}
	canvas.addEventListener('touchstart', on_mousedown, false);
	canvas.addEventListener('mousedown', on_mousedown, false);
}