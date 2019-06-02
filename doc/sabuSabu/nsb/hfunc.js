//Copyright (c) 2015 NS BASIC Corporation. All rights reserved.
//Helper functions
var True=true; TRUE=true;
var False=false; FALSE=false;
var _jsString=String; //allow javascript string object to be in vbScript code
var _JSSTRING=_jsString; _jsSTRING=_jsString; _jsstring=_jsString;
var savethefunction_rvar=null;
var NSB = NSB || {};  // setup the NSB namespace, if needed

//vbScript GetRef function: GetRef(sub name)
function getRef(str) {
    if (typeof(str)=='string') {
		return window[str];
    } else {
        return str;
    }
} var GetRef=getRef; var getref=getRef; var GETREF=getRef;

//MsgBox function to handle proper return variables since JavaScript returns true or false from CONFIRM box
function _msgbox_confirm(prompt, buttons, title, helpfile, context) {
    if (prompt == false || prompt == 0) {
        //do nothing and use the 'false' or '0' value
    } else {
        if (!prompt || prompt==null || typeof(prompt)=='undefined') { prompt = ''; }
    }
    if (!buttons || buttons==null || typeof(buttons)=='undefined' || buttons=='') { buttons = 0; }
    if (buttons == parseInt(buttons) && buttons == parseFloat(buttons)) { buttons = buttons & 0x000F; }

    var res = 1;
    switch (buttons) {
        case 1: //vbOKCancel - OK (1) and Cancel (2)
            res = confirm(prompt);
            if (res == true) { return 1; } else { return 2; }
            break;
        case 2: //vbAbortRetryIgnore - Abort (3), Retry (4), and Ignore (5)
            res = confirm(prompt);
            if (res == true) { return 4; } else { return 5; }
            break;
        case 3: //vbYesNoCancel - Yes (6), No (7), and Cancel (2)
            res = confirm(prompt);
            if (res == true) { return 6; } else { return 7; }
            break;
        case 4: //vbYesNo - Yes (6) and No (7)
            res = confirm(prompt);
            if (res == true) { return 6; } else { return 7; }
            break;
        case 5: //vbRetryCancel - Retry (4) and Cancel (2)
            res = confirm(prompt);
            if (res == true) { return 4; } else { return 2; }
            break;
        default: //0 = vbOKOnly - OK (1)
            NSB.MsgBox(prompt);
            return 1;
            break;
    }
}

//vbScript mid syntax: mid(string1, start[,end])
// string1: string to cust from; start: start of cut; end: end of cut (if no end, then to end of string1)
function Mid(strMid, intBeg, intEnd) {
    //setup variables in case there is no intEnd (optional value in vbScript)
    if (strMid==null || strMid=="" || intBeg < 0) { return ''; }
    intBeg -= 1; //reset vbScript 1 base
    if (intEnd==null || intEnd=="") {
        return strMid.substr(intBeg);
    } else {
        return strMid.substr(intBeg,intEnd);
    }
} var mid=Mid; var MID=Mid; var midb=Mid; var MidB=mid; var Midb=Mid; var MIDB=Mid; var midB=Mid;

//Splice function: Splice(array, index, howmany [,item])
function Splice(arr, i, c, el) {
  if (el==undefined)
    return arr.splice(i, c)
  else
    return arr.splice(i, c, el)
}

//indexOf function: indexOf(var,item[,fromIndex])
function IndexOf(a, el, fromIndex) {
  return a.indexOf(el, fromIndex)
}

//Push function: Push(array,item)
function Push(arr, el) {
  return arr.push(el)
}

//Push function: Push(array,item)
function ForEach(obj, func) {
  obj.forEach(func)
}

String.prototype.format = function() {
    var args = arguments;
    this.unkeyed_index = 0;
    return this.replace(/\{(\w*)\}/g, function(match, key) { 
        if (key === '') {
            key = this.unkeyed_index;
            this.unkeyed_index++
        }
        if (key == +key) {
            return args[key] !== 'undefined'
                ? args[key]
                : match;
        } else {
            for (var i = 0; i < args.length; i++) {
                if (typeof args[i] === 'object' && typeof args[i][key] !== 'undefined') {
                    return args[i][key];
                }
            }
            return match;
        }
    }.bind(this));
};

//Format("The month is {0}", "January")
function Format() {
  var shift=[].shift;
  var str=shift.apply(arguments);
  return str.format.apply(str, arguments);
}

//vbScript Right function: Right(str,len)
function Right(str, n) {
    var s=str + '';
    var iLen = s.length;
    if (n <= 0) {
        return "";
    } else if (n >= iLen) {
        return s;
    } else {
        return s.substr(iLen-n, n);
    }
} var right=Right; var rightb=Right; var Rightb=Right; var RightB=Right; var rightB=Right; var RIGHT=Right; //so all cases work for the function name

//vbScript Left function: Left(str,len)
function Left(str, n) {
    var s=str + '';
    var iLen = s.length;
    if (n <= 0) {
        return "";
    } else if (n >= iLen) {
        return str;
    } else {
        return s.substr(0,n);
    }
} var left=Left; var leftb=Left; var Leftb=Left; var LeftB=Left; var leftB=Left; var LEFT=Left;

//vbScript RTrim function: RTrim(str)
function RTrim(str) {
    var whitespace = " \t\n\r";
    var s = str;
    if (whitespace.indexOf(s.charAt(s.length-1)) != -1) {
        var i = s.length - 1;       // Get length of string
        while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1) { i--; }
        s = s.substring(0, i+1);
    }
    return s;
} var rtrim=RTrim; var rTrim=RTrim; var Rtrim=RTrim; var RTRIM=RTrim; //so both cases work for the function name

//vbScript LTrim function: LTrim(str)
function LTrim(str) {
    var whitespace = " \t\n\r";
    var s = str;
    if (whitespace.indexOf(s.charAt(0)) != -1) {
        var j=0, i = s.length;
        while (j < i && whitespace.indexOf(s.charAt(j)) != -1) { j++; }
        s = s.substring(j, i);
    }
    return s;
} var ltrim=LTrim; var lTrim=LTrim; var Ltrim=LTrim; var LTRIM=LTrim;

//vbScript Trim
function Trim(str) {
    return LTrim(RTrim(str));
} var trim=Trim; var TRIM=Trim;

//vbScrtip Sgn
function Sgn(val) {
    /*  >0 - Sgn returns 1
        =0 - Sgn returns 0
        <0 - Sgn returns -1
    */
    if (typeof(val)=='string') { val=parseFloat(val); }
    if (val == 0) { return 0; }
    if (val < 0) { return -1; }
    return 1;
} var sgn=Sgn; var SGN=Sgn;

//vbScript Len function: Len(str)
function Len(str) {
    if (typeof(str)=='object') { return str.length; }
    str=str + '';
    return str.length;
} var len=Len; var LEN=Len; var lenb=Len; var Lenb=Len; var LenB=Len; var LENB=Len; var lenB=Len;

//vbScript Replace function: Replace(string,find,replacewith[,start[,count[,compare]]])
function Replace(str, fnd, rpl, st, cnt, cmp) {
    if (st==null || st=="" || st < 0) { st=1; }
    st -= 1;
    if (cnt==null || cnt=="" || cnt < 0) { cnt=0; }
    if (st >= 0) { str=str.substr(st,str.length); }
    fnd=fnd.replace(/([\$\^\[\(\)\|\*\+\?\.\\])/g,'\\$1');
	var opt='';
	cmp = cmp + "";
	if (cmp=='1') { opt='i'; }
    if (cnt > 0) {
        var regex=new RegExp(fnd,opt);
        for (var i=0; i<cnt; i++) {
            str =str.replace(regex,rpl);
        }
    } else {
		opt += 'g';
        var regex=new RegExp(fnd,opt);
        str = str.replace(regex,rpl);
    }
    return str;
} var replace=Replace; var REPLACE=Replace;

function Replace2(str, fnd, rpl, st, cnt, cmp) {
    var regex=new RegExp(fnd,'g');
    return str.replace(regex,rpl);
    //return str.replace(fnd, rpl);
} replace=Replace; REPLACE=Replace;

//vbScript StrReverse function: StrReverse(str)
function StrReverse(s) {
    var sArray = s.split("");
    var rArray=sArray.reverse();
    return rArray.join("");
} var strreverse=StrReverse; var strReverse=StrReverse; var STRREVERSE=StrReverse;

//vbScript Year function: Year(date)
function Year(dt) {
	if (isNull(dt)) { return null; }
    var regex=new RegExp('-','g');
	try {
		dt=dt.replace(regex,'/'); //try/catch skips full date text of javascript
	} catch(e) {}
    var dat=new Date(dt);
    return dat.getFullYear();
} var year=Year; var YEAR=Year;

function Sort(arrayToSort, sortType, sortFunc) {
    //arguments: array to sort, sort type (a=ascending, d=descending), sort function (for custom functions--parameter for sort function is arrayToSort)
    //syntax:   sort(arrayToSort)               <-- sortType defaulted to ascending
    //          sort(arrayToSort,'')            <-- sortType defaulted to ascending
    //          sort(arrayToSort,'d')           <-- descending sort
    //          sort(arrayToSort,'a')           <-- ascending sort
    //          sort(arrayToSort,'d',sortFunc)  <-- function sortFunc called with argument arrayToSort; function will return sorted array; sortType ignored
    //          sort(arrayToSort,sortFunc)      <-- function sortFunc called with argument arrayToSort; function will return sorted array
    if (!sortType || sortType==null || typeof(sortType)=='undefined') {sortType='';}
    if (!sortFunc || sortFunc==null || typeof(sortFunc)=='undefined' || typeof(sortFunc)!='function') {sortFunc='';}
    if (typeof(sortType)=='function' && sortFunc=='') {
        sortFunc = sortType;
        sortType = 'a';
    } else {
        if (sortType != 'd') {sortType='a';}
    }
    this._sortType=sortType;
    var arr = arrayToSort.slice();
    var ret = [];
    if (sortFunc=='' || typeof(sortFunc)!='function') {
        arr.sort();
        arr.sort(_sort1);
        ret=arr.slice();
    } else {
        //ret = sortFunc(arr).slice();
        ret=arr.sort(sortFunc);
    }
    return ret;

    function _sort1(a,b) {
        if ( _isNumber(a) && _isNumber(b) ) {
            if (this._sortType=='d') {
            var y=a*1; var x=b*1;
            } else {
            x=a*1; y=b*1;
            }
            return ((x < y) ? -1 : ((x > y) ? 1 : 0));
        } else if ( _isNumber(a) && !_isNumber(b) ) {
            x=a*1; y=b;
            return (this._sortType=='d' ? 1 : -1);
        } else if ( !_isNumber(a) && _isNumber(b) ) {
            x=a; y=b*1;
            return (this._sortType=='d' ? -1 : 1);
        } else {
            if (this._sortType=='d') {
                y=a.toLowerCase(); x=b.toLowerCase();
            } else {
                x=a.toLowerCase(); y=b.toLowerCase();
            }
            return ((x > y) ? 1 : (x===y?0:-1) );
        }
    }
    function _isNumber(n) { return !isNaN(parseFloat(n)) && isFinite(n); }
}

//vbScript IsNumeric function: IsNumeric(var)
function IsNumeric(sText) {
   return !isNaN(sText);
} var isnumeric=IsNumeric; var isNumeric=IsNumeric; var ISNUMERIC=IsNumeric;

//vbScript CByte/CLng/CInt function: CByte(n)
function CByte(n) {
    var i=n*1;
    i=Math.round(i);
    //odd numbers round up if .5, even numbers don't
    if (i%2 != 0) {
        var j=Math.abs(n-i);
        if (j==.5) {i-=1;}
    }
    return i;
} var cbyte=CByte; var CBYTE=CByte; var CInt=CByte; var CINT=CByte; var CLng=CByte; var CLNG=CByte; var clng=CByte; var cint=CByte; var CINT=CByte;

//vbScript ROUND
function ROUND(n,d) {
    if (!d || d==null || d=="") {d=0;}
    d=Math.floor(d);
    d=d<1?0:d;
    d=Math.pow(10,d);
    var result=Math.round(n*d) / d;
    return result;
} var Round=ROUND; var round=ROUND;

//vbScript CCur function: CCur(n) round to 4 decimal places
function CCur(num) {
    var dec=4;
    var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
    return result;
} var ccur=CCur; var CCUR=CCur; var cCur=CCur;

//vbScript CSng function: CSng(n) round to 7 decimal places
function CSng(num) {
    var dec=7;
    var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
    return result;
} var csng=CSng; var CSNG=CSng;

//vbScript imp functionality
function impFunc(a,b) {
    var val1=a?1:0;
    var val2=b?1:0;
    if (val1==1 && val2==1) return true;
    if (val1==1 && val2==0) return false;
    if (val1==0 && val2==1) return true;
    if (val1==0 && val2==0) return true;
    if (a==null && val2==1) return true;
    return null;
} var IMPFUNC=impFunc; var ImpFunc=impFunc;

//vbScript exp functionality
function eqvFunc(a,b) {
    if (a==true && b==true || a==false && b==false) {
        return true;
    } else {
        return false;
    }
} var EQVFUNC=eqvFunc; var EqvFunc=eqvFunc;

//convertDate helper function
function convertDate(dt,convertMonth) {
    if(typeof(dt)=='object') {return dt;}
    if (dt==null || dt=='') {return null;}
    //new Date format
    dt=dt.toString();
    if (dt.match(/\s*\w{3}\s+\w{3}\s+\d{2}\s+\d{4}\s+\d{2}:\d{2}:\d{2}\s+\w{3}[\+\-]\d{4}/) ) {
        if (convertMonth != 1) {
            return dt.replace(/\s*\w{3}\s+(\w{3})\s+(\d{2})\s+(\d{4})\s+(\d{2}:\d{2}:\d{2}).*/, '$1 $2, $3 $4');
        } else {
            dt=dt.replace(/\s*\w{3}\s+(\w{3})\s+(\d{2})\s+(\d{4})\s+(\d{2}:\d{2}:\d{2}).*/, '$2 $1 $3 $4');
        }
    }

    if (dt.match(/\s*(\d{1,2})(\s+|\s*\-\s*)([a-z]{3})(\s+|\s*\-\s*)(\d{2})($|\s+)/i)) {
        dt=dt.replace(/\s*(\d{1,2})(\s+|\s*\-\s*)([a-z]{3})(\s+|\s*\-\s*)(\d{2})($|\s+)/i,'$1 $3 20$5$6');
    }
    if (dt.match(/\s*\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2}/)) {
        dt=dt.replace(/\s*(\d{4})[\/\-](\d{1,2})[\/\-](\d{1,2})/,'$2-$3-$1');
    }
    if (!dt.match(/\s*\d{1,2}(\s+|\s*\-\s*)[a-z]{3}(\s+|\s*\-\s*)(\d{2}|\d{4})\s*/i)) {
        if(!dt.match(/\s*[a-z]+\s+\d{1,2},?\s+(\d{2}|\d{4})\s*/i)) {
            dt=dt.replace(/\-/g,'/').replace(/\;/g,'/').replace(/\s+/g,'/').replace(/\./g,'/').replace(/,/g,'/').replace(/\/+/g,'/');
            if (!dt.match(/\d{1,2}\/\d{1,2}\/(\d{2}|\d{4})/)) {
				//check if time only
				if (dt.match(/^\s*\d{1,2}:\d{1,2}:\d{1,2}/)) { //match time only
					__dt__today = new Date();
					__m=(__dt__today.getMonth()+1);
					__mon = (__m < 10) ? '0' + __m : __m;
					__d=__dt__today.getDate();
					__day = (__d < 10) ? '0' + __d : __d;
					s__dt__today=__mon+'/'+__day+'/'+__dt__today.getFullYear();
					dt=s__dt__today+'  '+dt; //add today's date to time entry
				} else {
					return null;
				}
            }
        }
    }
    if (convertMonth==1) {
        var smon=[NSB._['Jan'],NSB._['Feb'],NSB._['Mar'],NSB._['Apr'],NSB._['May'],NSB._['Jun'],NSB._['Jul'],NSB._['Aug'],NSB._['Sep'],NSB._['Oct'],NSB._['Nov'],NSB._['Dec']];
        var dmon=dt.replace(/(\w+)(\s+)(\w+)(\s+)(\w+)(\s+)(\S+)/,'$3')
        var nmon=0;
        for (i=0; i<smon.length; i++) {
            if (dmon==smon[i]) {
                nmon=i+1;
                break;
            }
        }
        dt=nmon+dt.replace(/(\w+)(\s+)(\w+)(\s+)(\w+)(\s+)(\S+)/,'/$1/$5 $7');
    } else {
        var sdt=dt;
        dt=dt.replace(/(\d+)(\s+|\/)([a-zA-Z]{3,})(\s+|\/)(\d+)(\s+|\/)(\w+)(\s+|\/|\:)(\w+)(\s+|\/|\:)(\w+)(\s+|\/|)([apAP][mM])/,'$1 $3 $5 $7:$9:$11 $13');
        if (sdt==dt) {
            dt=dt.replace(/(\d+)(\s+|\/)([a-zA-Z]{3,})(\s+|\/)(\d+)(\s+|\/)(\w+)(\s+|\/|\:)(\w+)(\s+|\/|)([apAP][mM])/,'$1 $3 $5 $7:$9 $11');
        }
        if (sdt==dt) {
            dt=dt.replace(/(\d+)(\s+|\/)([a-zA-Z]{3,})(\s+|\/)(\d+)(\s+|\/)(\w+)(\s+|\/|\:)(\w+)(\s+|\/|\:)(\w+)/,'$1 $3 $5 $7:$9:$11');
        }
        if (sdt==dt) {
            dt=dt.replace(/(\d+)(\s+|\/)([a-zA-Z]{3,})(\s+|\/)(\d+)(\s+|\/)(\w+)(\s+|\/|\:)(\w+)/,'$1 $3 $5 $7:$9');
        }
        if (sdt==dt) {
            dt=dt.replace(/(\w+)(\s+|\/)(\w+)(\s+|\/)(\w+)(\s+|\/)(\w+)(\s+|\/|\:)(\w+)(\s+|\/|\:)(\w+)(\s+|\/|)([apAP][mM])/,'$1/$3/$5 $7:$9:$11 $13');
        }
        if (sdt==dt) {
            dt=dt.replace(/(\w+)(\s+|\/)(\w+)(\s+|\/)(\w+)(\s+|\/)(\w+)(\s+|\/|\:)(\w+)(\s+|\/|)([apAP][mM])/,'$1/$3/$5 $7:$9 $11');
        }
        if (sdt==dt) {
            dt=dt.replace(/(\w+)(\s+|\/)(\w+)(\s+|\/)(\w+)(\s+|\/)(\w+)(\s+|\/|\:)(\w+)(\s+|\/|\:)(\w+)/,'$1/$3/$5 $7:$9:$11');
        }
        if (sdt==dt) {
            dt=dt.replace(/(\w+)(\s+|\/)(\w+)(\s+|\/)(\w+)(\s+|\/)(\w+)(\s+|\/|\:)(\w+)/,'$1/$3/$5 $7:$9');
        }
    }
    return dt;
} var CONVERTDATE=convertDate; var ConvertDate=convertDate;

//vbScript IsDate function: IsDate(date string)
function IsDate(dt) {
    if (typeof(dt) != 'object' && isNumeric(dt)) { return false; }
    var cdt=convertDate(dt,0);
	if (isNull(cdt) || isNaN(year(cdt))) { return false; }
    return !isNaN(new Date(cdt));
} var isdate=IsDate; var isDate=IsDate; var ISDATE=IsDate;

//vbScript CDate
function CDate(dt) {
    if (typeof(dt)=='undefined') {return 'undefined'};
    if (IsDate(dt)) {
        if (VARTYPE(dt.toString(),1) == 'date') {
            return FormatDateTime(dt,2); //date
        }
        if (dt.toString().indexOf(':') > -1) {
            return FormatDateTime(dt,3); //time
        } else {
            return FormatDateTime(dt,2); //date
        }
    } else {
        return null;
    }
} var cdate=CDate; var cDate=CDate; var Cdate=CDate; var CDATE=CDate;

function CvDate(dt) {
    if (IsDate(dt)) {
        return new Date(convertDate(dt,0));
    } else {
        return null;
    }
} var cvdate=CvDate; var cvDate=CvDate; var Cvdate=CvDate; var CVDATE=CvDate;

//vbScript dateadd function: DateAdd(interval,number,date)
function DateAdd(dint, numval, thedate) {
    if(!CvDate(thedate)){   return null;    }
    if(isNaN(numval)){  return null;    }

    numval = new Number(numval);
    var dt = CvDate(thedate);

    switch(dint.toLowerCase()){
        case "yyyy": {
            dt.setFullYear(dt.getFullYear() + numval);
            break;
        }
        case "q": {
            var omon=dt.getMonth();
            dt.setMonth(dt.getMonth() + (numval*3));
            //fix problem with end of month date not correct for new month
            var nmon=dt.getMonth();
            var rmon=omon+(numval*3)<0?12+(omon+(numval*3)):omon+(numval*3);
            if (rmon != nmon) {
                dat=dt.getDate();
                dt.setDate(dt.getDate() - dat);
            }
            break;
        }
        case "m": {
            var omon=dt.getMonth();
            dt.setMonth(dt.getMonth() + numval);
            //fix problem with end of month date not correct for new month
//          nmon=dt.getMonth();
//          rmon=omon+numval<0?12+(omon+numval):omon+numval;
//          if (rmon != nmon) {
//              dat=dt.getDate();
//              dt.setDate(dt.getDate() - dat);
//          }
            break;
        }
        case "y":
        case "d":
        case "w": {
            dt.setDate(dt.getDate() + numval);
            break;
        }
        case "ww": {
            dt.setDate(dt.getDate() + (numval*7));
            break;
        }
        case "h": {
            dt.setHours(dt.getHours() + numval);
            break;
        }
        case "n": {
            dt.setMinutes(dt.getMinutes() + numval);
            break;
        }
        case "s": {
            dt.setSeconds(dt.getSeconds() + numval);
            break;
        }
        case "ms": {
            dt.setMilliseconds(dt.getMilliseconds() + numval);
            break;
        }
        default: {
            return null;
            break;
        }
    }
    var fdt = FormatDateTime(dt,2) + " " + FormatDateTime(dt,3);
    return fdt;
} var dateadd=DateAdd; var dateAdd=DateAdd; var DATEADD=DateAdd;

//vbScript datepart function: DatePart(interval,date[,firstdayofweek[,firstweekofyear]])
function DatePart(dint, thedate, fdow) {
    var d;
    //if(fdow==null) fdow=1;
    d=CvDate(thedate);
    if( !d ){
		if ( _chkTime(thedate) != '' ) { return null; }
		d=CvDate('1/1/2013 '+thedate);
		if(!d){ return null; }
	}
    var dtPart = d;
    var leapYearAdj=0;
    if (_testLeapYear(dtPart.getFullYear())) {
        //test if leap year and past 2/28
        if ( dtPart.getMonth()>1 || (dtPart.getMonth()==1 && dtPart.getDate()>28) ) { leapYearAdj=1; } //adjust for leap year
    }

    if (!dint || dint==null) return null;
    switch(dint.toLowerCase()){
        case "yyyy": return dtPart.getFullYear();
        case "q": return Math.floor(dtPart.getMonth() / 3) + 1;
        case "m": return dtPart.getMonth() + 1;
        case "y": return DateDiff("y", "1/1/" + dtPart.getFullYear(), dtPart) + 1 + leapYearAdj;    // day of year
        case "d": return dtPart.getDate();
        case "w": return Weekday((dtPart.getMonth()+1)+'/'+(dtPart.getDate())+'/'+dtPart.getFullYear(), fdow);     // weekday
        case "ww": //week of year
			var dt1 = new Date('1/1/'+dtPart.getFullYear());
			nDays = (Math.floor((dtPart-dt1)/86400000)+(dt1.getDay()+1));
			nWeek = Math.ceil((nDays)/7);
			return nWeek;
        case "h": return dtPart.getHours();
        case "n": return dtPart.getMinutes();
        case "s": return dtPart.getSeconds();
        case "ms":return dtPart.getMilliseconds();  // <-- JS extension, NOT in vbScript
        default : return null;
    }
} var datepart=DatePart; var datePart=DatePart; var DATEPART=DatePart;

function _testLeapYear(yr) {
    //test if leap year
    if ((parseInt(yr)%4) == 0) {
        if (parseInt(yr)%100 == 0) {
            if (parseInt(yr)%400 != 0) {
                return false;
            }
            if (parseInt(yr)%400 == 0) {
                return true;
            }
        }
        if (parseInt(yr)%100 != 0) {
            return true;
        }
    }
    if ((parseInt(yr)%4) != 0) {
        return false;
    }
}

// adjusts weekday for week starting on fdow
function Weekday(wd, fdow) {
    var vbSunday=1;
    fdow = (isNaN(fdow) || fdow==0) ? vbSunday : Math.floor(fdow);  // set default & cast
    if (!isObject(wd)) {
        wd=new Date(wd.replace(/-/g,'/')); //javascript Date object does not work with yyyy-mm-dd format
    }
    var iDay=wd.getDay()+1;
    return ((iDay - fdow +7) % 7) + 1;
} var weekday=Weekday; var weekDay=Weekday; var WEEKDAY=Weekday; var WeekDay=Weekday;//vbScript DateDiff function: DateDiff(interval,date1,date2[,firstdayofweek[,firstweekofyear]])

function DateDiff(dint, thedate1, thedate2, fdow) {
    var vbUseSystemDayOfWeek=0; var vbSunday=1; var vbMonday=2; var vbTuesday=3; var vbWednesday=4; var vbThursday=5; var vbFriday=6; var vbSaturday=7;
    if(!CvDate(thedate1)){  return null;    }
    if(!CvDate(thedate2)){  return null;    }
    fdow = (isNaN(fdow) || fdow==0) ? vbSunday : Math.floor(fdow);  // set default & cast

    var dt1 = CvDate(thedate1);
    var dt2 = CvDate(thedate2);

    // correct DST-affected intervals ("d" & bigger)
    //if("h,n,s,ms".indexOf(dint.toLowerCase())==-1){
        //if(thedate1.toString().indexOf(":") ==-1){ dt1.setUTCHours(0,0,0,0) };    // no time, assume 12am
        //if(thedate2.toString().indexOf(":") ==-1){ dt2.setUTCHours(0,0,0,0) };    // no time, assume 12am
    //}

    // get ms between UTC dates and make into "difference" date
    var iDiffMS = dt2.valueOf() - dt1.valueOf();
    var dtDiff = new Date(iDiffMS);

    // calc various diffs
    var nYears  = dt2.getYear() - dt1.getYear();
    var nMonths = dt2.getMonth() - dt1.getMonth() + (nYears!=0 ? nYears*12 : 0);
    var nQuarters = Math.floor(nMonths / 3);    //<<-- different than vbScript, which watches rollover not completion

    var nMilliseconds = iDiffMS;
    var nSeconds = Math.floor(iDiffMS / 1000);
    var nMinutes = Math.floor(nSeconds / 60);
    var nHours = Math.floor(nMinutes / 60);
    var nDays  = Math.floor(nHours / 24);
    var nWeeks = Math.floor(nDays / 7);

    if(dint.toLowerCase()=='ww'){
            // set dates to 1st & last FirstDayOfWeek
            var offset = DatePart("w", dt1, fdow)-1;
            if(offset){ dt1.setDate(dt1.getDate() +7 -offset);  }
            var offset = DatePart("w", dt2, fdow)-1;
            if(offset){ dt2.setDate(dt2.getDate() -offset); }
            // recurse to "w" with adjusted dates
            var nCalWeeks1 = DateDiff("w", dt1, dt2) + 1;
            var nCalWeeks2 = (nDays / 7 == Math.floor(nDays / 7) ) ? nWeeks : nWeeks+1;
            var nCalWeeks = round(nDays / 7);
            //document.write("<br>days: "+nCalWeeks1+', '+nCalWeeks2+', ' + nDays / 7 + ', '+iDiffMS/(1000*60*60*24*7)+', '+nWeeks+'<br>');
    }

    // return difference
    switch(dint.toLowerCase()){
        case "yyyy": return nYears;
        case "q": return nQuarters;
        case "m":   return nMonths;
        case "y":           // day of year
        case "d": return nDays;
        case "w": return nWeeks;
        case "ww":return nCalWeeks; // week of year
        case "h": return nHours;
        case "n": return nMinutes;
        case "s": return nSeconds;
        case "ms":return nMilliseconds; // not in vbScript
        default : return null;
    }
} var datediff=DateDiff; var dateDiff=DateDiff; var DATEDIFF=DateDiff;

//vbScript Minute
function Minute(tm) {
    return DatePart("n",tm);
} var minute=Minute; var MINUTE=Minute;

//vbScript Second
function Second(tm) {
    return DatePart("s",tm);
} var second=Second; var SECOND=Second;

//vbScript CStr function: Cstr(value)
function CStr(val) {
   if (typeof(val)=='undefined') {return 'undefined'};
    if (isNumeric(val)) {
        return val.toString();
    }
    if (val==true) {
        return 'True';
    } else if (val==false) {
        return 'False';
    }
    return val=val.toString();
} var cstr=CStr; var cStr=CStr; var Cstr=CStr; var CSTR=CStr;

//vbScript FormatDateTime function: FormatDateTime(date,format)
// thanks to Rob Eberhardt of Slingshot Solutions for free use of partial versions of the vbScript native Date functions
// many of these Date functions have been modified from the original author's design
function FormatDateTime(thedate, df) {
    var vbGeneralDate=0; var vbLongDate=1; var vbShortDate=2; var vbLongTime=3; var vbShortTime=4;
    var vbYYYYMMDD=5; var vbDDdotMMdotYY=6; var vbDDdotMMdotYYYY=7;
    var vbYYslashMMslashDD=8; var vbDDslashMMslashYY=9; var vbYYYYhyphenMMhyphenDD=10;
    var datstr=thedate.toString();
    if(datstr.toUpperCase().substring(0,3) == "NOW") {
        thedate = new Date();
    };
    if( !CvDate(thedate) ){
		if ( _chkTime(thedate) != '' ) { return null; }
		thedate='1/1/2013 '+thedate;
		if(!CvDate(thedate)){ return null; }
	}
    var dt = CvDate(thedate);
    //add custom date formats
    if (!df || df==null || df=='undefined') {
        //skip custom date formats
    } else {
        var newdf = df.toString().replace(/\s*/g,'').toUpperCase();
        if (newdf=="DD.MM.YY") { return _Format(thedate, 'DD.MM.YY'); }
        if (newdf=="DD.MM.YYYY") { return _Format(thedate, 'DD.MM.YYYY'); }
        if (newdf=="DD/MM/YY") { return _Format(thedate, 'DD/MM/YY'); }
        if (newdf=="DD/MM/YYYY") { return _Format(thedate, 'DD/MM/YYYY'); }
        if (newdf=="DD-MM-YY") { return _Format(thedate, 'DD-MM-YY'); }
        if (newdf=="DD-MM-YYYY") { return _Format(thedate, 'DD-MM-YYYY'); }
        if (newdf=="DDMMYY") { return _Format(thedate, 'DDMMYY'); }
        if (newdf=="DDMMYYYY") { return _Format(thedate, 'DDMMYYYY'); }

        if (newdf=="YY.MM.DD") { return _Format(thedate, 'YY.MM.DD'); }
        if (newdf=="YYYY.MM.DD") { return _Format(thedate, 'YYYY.MM.DD'); }
        if (newdf=="YY/MM/DD") { return _Format(thedate, 'YY/MM/DD'); }
        if (newdf=="YYYY/MM/DD") { return _Format(thedate, 'YYYY/MM/DD'); }
        if (newdf=="YY-MM-DD") { return _Format(thedate, 'YY-MM-DD'); }
        if (newdf=="YYYY-MM-DD") { return _Format(thedate, 'YYYY-MM-DD'); }
        if (newdf=="YYMMDD") { return _Format(thedate, 'YYMMDD'); }
        if (newdf=="YYYYMMDD") { return _Format(thedate, 'YYYYMMDD'); }

        if (newdf=="MM.DD.YY") { return _Format(thedate, 'MM.DD.YY'); }
        if (newdf=="MM.DD.YYYY") { return _Format(thedate, 'MM.DD.YYYY'); }
        if (newdf=="MM/DD/YY") { return _Format(thedate, 'MM/DD/YY'); }
        if (newdf=="MM/DD/YYYY") { return _Format(thedate, 'MM/DD/YYYY'); }
        if (newdf=="MM-DD-YY") { return _Format(thedate, 'MM-DD-YY'); }
        if (newdf=="MM-DD-YYYY") { return _Format(thedate, 'MM-DD-YYYY'); }
        if (newdf=="MMDDYY") { return _Format(thedate, 'MMDDYY'); }
        if (newdf=="MMDDYYYY") { return _Format(thedate, 'MMDDYYYY'); }
    }

    if(isNaN(df)){ df = vbGeneralDate };

    switch(Math.floor(df)){
        case vbGeneralDate:     return dateadd("s",0,dt); //0
        case vbLongDate:        return _Format(thedate, 'DDDD, MMMM D, YYYY'); //1
        case vbShortDate:       return _Format(thedate, 'M/DD/YYYY'); //2
        case vbLongTime:        return _Format(thedate, 't t t t t'); //3
        case vbShortTime:       return _Format(thedate, 'HH:MM'); //4
        case vbYYYYMMDD:        return _Format(thedate, 'YYYYMMDD'); //5
        case vbDDdotMMdotYY:    return _Format(thedate, 'DD.MM.YY'); //6
        case vbDDdotMMdotYYYY:  return _Format(thedate, 'DD.MM.YYYY'); //7
        case vbYYslashMMslashDD:    return _Format(thedate, 'YY/MM/DD'); //8
        case vbDDslashMMslashYY:    return _Format(thedate, 'DD/MM/YY'); //9
        case vbYYYYhyphenMMhyphenDD:    return _Format(thedate, 'YYYY-MM-DD'); //10
        default:    return null;
    }
} var formatDateTime=FormatDateTime; var formatdateTime=FormatDateTime; var formatdatetime=FormatDateTime; var FORMATDATETIME=FormatDateTime;

function _Format(thedate, dfmt, fdow, fdoy) {
    var pmtest=0;
    thedate=thedate.toString();
    if (thedate.match(/\d{1,2}\s*:\s*\d{2}/)) {
        if(thedate.match(/^\s*\d{1,2}\s*:\s*\d{2}/)) { thedate='1/1/2001 '+thedate; }
        if (thedate.match(/\d{1,2}\s*pm/i)) { pmtest=1; }
    }
    if( !CvDate(thedate) ) {
		if ( _chkTime(thedate) != '' ) { return null; }
		thedate='1/1/2013 '+thedate;
		if(!CvDate(thedate)){ return null; }
	}
    if(!dfmt || dfmt==''){  return dt.toString()    };

    var dt = CvDate(thedate);
    // Zero-padding formatter
    this._NSB_pad = function(p_str){
        if(p_str.toString().length==1){p_str = '0' + p_str}
        return p_str;
    }

    var ampm = dt.getHours()>=12 ? 'PM' : 'AM'
    var hr = dt.getHours();
    if (pmtest==1 && hr < 12) { hr +=12; }
    if (hr == 0){hr = 12};
    if (hr > 12) {hr -= 12};
    if (hr<10) { hr = '0'+Math.floor(hr).toString(); }
    var strShortTime = hr +':'+ this._NSB_pad(dt.getMinutes()) +':'+ this._NSB_pad(dt.getSeconds()) +' '+ ampm;
    var strShortDate = (dt.getMonth()+1) +'/'+ dt.getDate() +'/'+ (new _jsString( dt.getFullYear() ) + '').substring(2,4);
    var strLongDate = MonthName(dt.getMonth()+1) +' '+ dt.getDate() +', '+ dt.getFullYear();

    var retVal = dfmt;

    // switch tokens whose alpha replacements could be accidentally captured
    retVal = retVal.replace( new RegExp('C', 'gi'), 'CCCC' );
    retVal = retVal.replace( new RegExp('mmmm', 'gi'), 'XXXX' );
    retVal = retVal.replace( new RegExp('mmm', 'gi'), 'XXX' );
    retVal = retVal.replace( new RegExp('dddddd', 'gi'), 'AAAAAA' );
    retVal = retVal.replace( new RegExp('ddddd', 'gi'), 'AAAAA' );
    retVal = retVal.replace( new RegExp('dddd', 'gi'), 'AAAA' );
    retVal = retVal.replace( new RegExp('ddd', 'gi'), 'AAA' );
    retVal = retVal.replace( new RegExp('timezone', 'gi'), 'ZZZZ' );
    retVal = retVal.replace( new RegExp('time24', 'gi'), 'TTTT' );
    retVal = retVal.replace( new RegExp('time', 'gi'), 'TTT' );
    // now do simple token replacements
    retVal = retVal.replace( new RegExp('am/pm', 'g'), dt.getHours()>=12 ? 'pm' : 'am');
    retVal = retVal.replace( new RegExp('AM/PM', 'g'), dt.getHours()>=12 ? 'PM' : 'AM');
    retVal = retVal.replace( new RegExp('a/p', 'g'), dt.getHours()>=12 ? 'p' : 'a');
    retVal = retVal.replace( new RegExp('A/P', 'g'), dt.getHours()>=12 ? 'P' : 'A');
    retVal = retVal.replace( new RegExp('AMPM', 'g'), dt.getHours()>=12 ? 'pm' : 'am');
    retVal = retVal.replace( new RegExp('yyyy', 'gi'), dt.getFullYear() );
    retVal = retVal.replace( new RegExp('yy', 'gi'), (new _jsString( dt.getFullYear() ) + '').substring(2,4) );
    retVal = retVal.replace( new RegExp('y', 'gi'), DatePart("y", dt) );
    retVal = retVal.replace( new RegExp('q', 'gi'), DatePart("q", dt) );
    retVal = retVal.replace( new RegExp('hh:mm', 'gi'), 'hh:'+this._NSB_pad(dt.getMinutes()) );

    retVal = retVal.replace( new RegExp('mm', 'gi'), this._NSB_pad(dt.getMonth() + 1) );
    retVal = retVal.replace( new RegExp('(a|p)m', 'g'), '$1x' );
    retVal = retVal.replace( new RegExp('(A|P)M', 'g'), '$1X' );
    retVal = retVal.replace( new RegExp('m', 'gi'), (dt.getMonth() + 1) );
    retVal = retVal.replace( new RegExp('(a|p)x', 'g'), '$1m' );
    retVal = retVal.replace( new RegExp('(A|P)X', 'g'), '$1M' );

    retVal = retVal.replace( new RegExp('dd', 'gi'), this._NSB_pad(dt.getDate()) );
    retVal = retVal.replace( new RegExp('d', 'gi'), dt.getDate() );
    retVal = retVal.replace( new RegExp('hh', 'gi'), this._NSB_pad(dt.getHours()) );
    retVal = retVal.replace( new RegExp('h', 'gi'), dt.getHours() );
    retVal = retVal.replace( new RegExp('nn', 'gi'), this._NSB_pad(dt.getMinutes()) );
    retVal = retVal.replace( new RegExp('n', 'gi'), dt.getMinutes() );
    retVal = retVal.replace( new RegExp('ss', 'gi'), this._NSB_pad(dt.getSeconds()) );
    retVal = retVal.replace( new RegExp('s', 'gi'), dt.getSeconds() );
    retVal = retVal.replace( new RegExp('t t t t t', 'gi'), strShortTime );
    // (always proceed largest same-lettered token to smallest)
    // now finish the previously set-aside tokens
    retVal = retVal.replace( new RegExp('XXXX', 'gi'), MonthName(dt.getMonth()+1, false) ); //
    retVal = retVal.replace( new RegExp('XXX',  'gi'), MonthName(dt.getMonth()+1, true ) ); //
    retVal = retVal.replace( new RegExp('AAAAAA', 'gi'), strLongDate );
    retVal = retVal.replace( new RegExp('AAAAA', 'gi'), strShortDate );
    retVal = retVal.replace( new RegExp('AAAA', 'gi'), WeekdayName(dt.getDay()+1, false, fdow) );   //
    retVal = retVal.replace( new RegExp('AAA',  'gi'), WeekdayName(dt.getDay()+1, true,  fdow) );   //
    retVal = retVal.replace( new RegExp('TTTT', 'gi'), dt.getHours() + ':' + this._NSB_pad(dt.getMinutes()) );
    retVal = retVal.replace( new RegExp('TTT',  'gi'), hr +':'+ this._NSB_pad(dt.getMinutes()) +' '+ ampm );
    retVal = retVal.replace( new RegExp('CCCC', 'gi'), strShortDate +' '+ strShortTime );

    // finally timezone
    var tz = dt.getTimezoneOffset();
    var timezone = (tz<0) ? ('GMT-' + tz/60) : (tz==0) ? ('GMT') : ('GMT+' + tz/60);
    retVal = retVal.replace( new RegExp('ZZZZ', 'gi'), timezone );

    return retVal;
}

function _chkTime(fld) {
	var err = "";
	// regular expression to match required time format
	re = /^\s*(\d{1,2})[:\s](\d{2})([:\s]\d{2})?\s*([aApP][mM])?\s*$/;
	if(fld != null && fld != '') {
		if(regs = fld.match(re)) {
			if(regs[4]) {
				// 12-hour time format with am/pm
				if(regs[1] < 1 || regs[1] > 12) {
					err = "Invalid value for hours: " + regs[1];
				}
			} else {
				// 24-hour time format
				if(regs[1] > 23) {
					err = "Invalid value for hours: " + regs[1];
				}
			}
			if(!err && regs[2] > 59) {
				err = "Invalid value for minutes: " + regs[2];
			}
		} else {
			err = "Invalid time format: " + fld;
		}
	} else {
		if (fld == null) { err = "Invalid time format: " + fld; }
	}
	return err;
}

function Month(sdt) {
    if (IsDate(sdt)) {
        if (!isObject(sdt)) {
            sdt=CvDate(sdt);
        }
        return sdt.getMonth()+1;
    } else {
        return null;
    }
}

function MonthName(themonth, dabbr) {
    var MonthNames = [null,NSB._['January'],NSB._['February'],NSB._['March'],NSB._['April'],NSB._['May'],NSB._['June'],NSB._['July'],NSB._['August'],NSB._['September'],NSB._['October'],NSB._['November'],NSB._['December']];
    if(isNaN(themonth)){    // v0.94- compat: extract real param from passed date
        if(!CvDate(themonth)){  return null;    }
//      themonth = DatePart("m", Date.CvDate(themonth));
        themonth = DatePart("m", CvDate(themonth));
    }

    var retVal = MonthNames[themonth];
    if(dabbr==true){    retVal = retVal.substring(0, 3) }   // abbr to 3 chars
    return retVal;
} var MONTHNAME=MonthName; var monthName=MonthName;

function WeekdayName(theweekday, dabbr, fdow) {
    var WeekdayNames = [null,NSB._['Sunday'],NSB._['Monday'],NSB._['Tuesday'],NSB._['Wednesday'],NSB._['Thursday'],NSB._['Friday'],NSB._['Saturday']];
    var vbUseSystemDayOfWeek=0; var vbSunday=1; var vbMonday=2; var vbTuesday=3; var vbWednesday=4; var vbThursday=5; var vbFriday=6; var vbSaturday=7;
    if(isNaN(theweekday)){  // v0.94- compat: extract real param from passed date
        if(!CvDate(theweekday)){    return null;    }
//      theweekday = DatePart("w", Date.CvDate(theweekday));
        theweekday = DatePart("w", CvDate(theweekday));
    }
    var fdow = (isNaN(fdow) || fdow==0) ? vbSunday : Math.floor(fdow);  // set default & cast

    var nWeekdayNameIdx = ((fdow-1 + Math.floor(theweekday)-1 +7) % 7) + 1; // compensate nWeekdayNameIdx for fdow
    var retVal = WeekdayNames[nWeekdayNameIdx];
    if(dabbr==true){    retVal = retVal.substring(0, 3) }   // abbr to 3 chars
    return retVal;
} var WEEKDAYNAME=WeekdayName; var weekDayName=WeekdayName; var weekdayName=WeekdayName; var weekdayname=WeekdayName; var WeekDayName=WeekdayName;

//vbScript Day function: Day(date)
function Day(thedate) {
    if (IsDate(thedate)) {
        if (!isObject(thedate)) {
            thedate=CvDate(thedate);
        }
        return thedate.getDate();
    } else {
        return null;
    }
} var day=Day; var DAY=Day;

//vbScript DateSerial(year, month, day)
function DateSerial(yy, mm, dd) {
    return FormatDateTime(cvdate(mm+'/'+dd+'/'+yy),2);
} var dateSerial=DateSerial; var dateSERIAL=DateSerial; var DateSERIAL=DateSerial; var dateserial=DateSerial; var DATESERIAL=DateSerial;

//vbScript DateValue(dateString)
function DateValue(dateString) {
    return FormatDateTime(cvdate(dateString),2);
} var dateValue=DateValue; var dateVALUE=DateValue; var DateVALUE=DateValue; var datevalue=DateValue; var DATEVALUE=DateValue;

//vbScript IsEmpty
function IsEmpty(theValue) {
  return (!theValue
          || (typeof(theValue) === "object" && $.isEmptyObject(theValue))
          || ($.isArray(theValue) && !theValue.length));
} var isempty=IsEmpty; var isEmpty=IsEmpty; var ISEMPTY=IsEmpty;

//vbScript IsArray
//function IsArray(obj) {
//    return obj.constructor == Array;
//} var isarray=IsArray; var isArray=IsArray; var ISARRAY=IsArray;
function IsArray(obj) {
	return toString.call(obj) === "[object Array]";
} var isarray=IsArray; var isArray=IsArray; var ISARRAY=IsArray;

//vbScript IsNull
function IsNull(obj) {
    return obj == null
} var isnull=IsNull; var isNull=IsNull; var ISNULL=IsNull;

//vbScript IsObject
function IsObject(obj) {
    return obj.constructor == Object;
    //return typeOf(obj) == "Object";
} var isobject=IsObject; var isObject=IsObject; var ISOBJECT=IsObject;

//vbScript CHR()
function Chr(nmbr) {
//  return String.fromCharCode(nmbr);
    return _jsString.fromCharCode(nmbr);
} var ChrB=Chr; var ChrW=Chr; var chr=Chr; var chrB=Chr; var chrW=Chr; var CHRB=Chr; var CHRW=Chr; var CHR=Chr; var Chrb=Chr; var Chrw=Chr

//vbScript ASC()
function Asc(str) {
    return str.charCodeAt(0);
} var AscB=Asc; var AscW=Asc; var ascB=Asc; var ascW=Asc; var asc=Asc; var ASCB=Asc; var ASCW=Asc; var ASC=Asc; var Ascb=Asc; var Ascw=Asc

//vbScript Join function: Join(s,c)
function Join(str,chr) {
    if (chr=="") { chr=""; } else {
        if (!chr || chr==null) { chr=" "; }
    }
    return str.join(chr);
} var join=Join; var JOIN=Join;

//vbScript Filter function : Filter(srchStr, fndStr, incl, filter)
function Filter(srchStr, fndStr, incl, fil_ter) {
    var origSrchStr = srchStr;
    if (!fndStr || fndStr==null) {fndStr="";}
    if(!fil_ter || fil_ter==null) {fil_ter=0; }
    if (incl==false) {
    } else {
        if(!incl || incl==null) {incl=true; }
    }
    fil_ter = (fil_ter==1) ? 1 : 0; //0=binary compare, 1=text compare
    incl = (incl == false) ? false : true; //true=include, false=exclude
    if (typeof(srchStr) != 'object') {return '';}
    if (fil_ter==1) {
        fndStr=fndStr.toLowerCase();
    }
    var na=new Array();
    var j=0, ss;
    for(var i=0; i<srchStr.length; i++) {
        if (fil_ter==1) {
            ss=srchStr[i].toLowerCase();
        } else {
            ss=srchStr[i];
        }
        var sso=origSrchStr[i];
        if (incl==true && ss.indexOf(fndStr) > -1) {
            na[j]=sso;
            j++;
        } else {
            if (incl==false && ss.indexOf(fndStr) == -1) {
                na[j]=sso;
                j++;
            }
        }
    }
    return na;
} var filter=Filter; var FILTER=Filter;

//vbScript InStrRev function : InStrRev(string1,string2[,start[,compare]])
function InStrRev(srchStr, fndStr, start, cmp) {
    if (!fndStr || fndStr==null) {fndStr="";}
    if (!cmp) {cmp=0;}
    srchStr.toString();
    if (cmp==1) {
        srchStr=srchStr.toLowerCase();
        fndStr=fndStr.toLowerCase();
    }
    if (!start || !isNumeric(start)) {start=-1;}
    if (start>-1) {
        srchStr=srchStr.substr(0,start);
    }
    var loc;
    if (fndStr == "" ) {
        loc=srchStr.length;
    } else {
        loc=srchStr.lastIndexOf(fndStr)+1;
    }
    return loc;
} var instrrev=InStrRev; var inStrRev=InStrRev; var INSTRREV=InStrRev; var InstrRev=InStrRev;

//vbScript InStr function : InStr([start,]string1,string2[,compare])
function InStr(start, srchStr, fndStr, cmp) {
    if (!fndStr || fndStr==null || fndStr=="") {
		fndStr += "";
        if (fndStr.length == 0) {
            if (!start || start==null || !isNumeric(start) || start=='' || start < 1 ) { start=1; }
            start=Math.floor(start);
            if (!srchStr || srchStr==null) { srchStr=''; }
            if (start > srchStr.toString().length) { return 0; }
            return start;
        }
		cmp=0;
        fndStr=srchStr;
        srchStr=start;
        start=1;
    }
	if (!isNumeric(Math.floor(start))) {
        cmp=fndStr;
		fndStr=srchStr;
        srchStr=start;
        start=1;
	}
    if (!start || start==null || !isNumeric(start) || start=='' || start < 1 ) { start=1; }
    if (!srchStr || srchStr==null) { srchStr=''; }
    if (!fndStr || fndStr==null) { fndStr=''; }
    start=Math.floor(start);

    if (srchStr == "") { return 0; }
    var osrchStr=srchStr.toString();
    if (start > osrchStr.length) { return 0; }
    if (fndStr == "") { return start; }

    srchStr=osrchStr;
    fndStr=fndStr.toString();
    if (start>1) { srchStr=srchStr.substr(start-1); }
	cmp = cmp + "";
	var loc=0;
	if (cmp=='1') { //insensitive
		var osrchStr=srchStr.toLowerCase();
		var ofndStr=fndStr.toLowerCase();
		if (osrchStr.indexOf(ofndStr) == -1) { return 0; }
		loc=osrchStr.indexOf(ofndStr)+1+(start-1);
	} else {
		if (srchStr.indexOf(fndStr) == -1) { return 0; }
		loc=srchStr.indexOf(fndStr)+1+(start-1);
	}
    return loc;
} var instr=InStr; var inStr=InStr; var INSTR=InStr;

//vbScript Space function: Space(n)
function Space(c) {
    return (new Array(c+1)).join(' ');
} var space=Space; var SPACE=Space;

//vbScript String function: String(n,c)
//javascript String object has name changed to _jsString to allow for vbScript STRING function
function _vbsSTRING(n,c) {
    if (!n || n==null) {
        return '';
    } else {
        if (!c || c==null) {
            return (n.toString());
        } else {
            c=c.toString().substr(0,1);
            return (new Array(n+1)).join(c);
        }
    }
} var _vbsstring=_vbsSTRING; var _vbsString=_vbsSTRING;

//vbScript StrCmp function: StrComp(string1,string2[,compare])
function StrComp(str1, str2, compare, typ) {
    typ = (typ==1) ? 1 : 0; //0=binary compare, 1=text compare
    if (typ==0) {
        str1=str1.toLowerCase();
        str2=str2.toLowerCase();
    }
    return ( ( str1 == str2 ) ? 0 : ( ( str1 > str2 ) ? 1 : -1 ) );
} var strcomp=StrComp; var strComp=StrComp; var strcmp=StrComp; var strCmp=StrComp; var StrCmp=StrComp; var STRCOMP=StrComp;

//vbScript Split function: Split(expression[,delimiter[,count[,compare]]])
function Split(str, del, cnt, cmp) {
    if (!del || del==null || del=="") { del=" "; }
    if (del != "") {
        return str.split(del);
    }
} var split=Split; var SPLIT=Split;

//vbScript Hex function: Hex(n)
function Hex(n) {
    n=Math.round(n);
    if (n < 0) {
        n = 0xFFFFFFFF + n + 1;
    }
    return n.toString(16).toUpperCase();
} var hex=Hex; var HEX=Hex;

//vbScript Oct function: Oct(n)
function Oct(n) {
    n=Math.round(n);
    if (n < 0) {
        n = 0177777 + n + 1;
    }
    return n.toString(8);
} var oct=Oct; var OCT=Oct;

//vbScript LBound function: LBound(arrayname[,dimension])
//dimension Optional. Which dimension's lower bound to return. 1 = first dimension, 2 = second dimension, and so on. Default is 1
function LBound(arr, dm) {
    return 0;
} var lbound=LBound; var lBound=LBound; var LBOUND=LBound;

//vbScript UBound function: UBound(arrayname[,dimension])
//dimension Optional. Which dimension's upper bound to return. 1 = first dimension, 2 = second dimension, and so on. Default is 1
//JavaScript will increase the size of the multidim arrays if more array values are added regardless of how array was created
function UBound(arr, dm) {
    if (!dm || dm==null || dm<1) dm=1;
    dm--;
    var rv=null;
    if (dm==0) {
        try { arr[0]==null; rv=Object.keys(arr).length-1; } catch(e) {}
    } else {
        try { arr[dm]==null; rv=arr[dm-1].length; } catch(e) {}
    }
    return rv;
} var ubound=UBound; var uBound=UBound; var UBOUND=UBound;

//dm: array dimensions: create array (d1,d2,d3,d4)
//handle any number of dimensions and indexes
//Thomas Gruber
function createMultiDimArray(dm,b,c,d) {
    var arr=null;
    if (!dm || dm==null) { dm=""; } dm+='';
    if (!b || b==null) { b=""; } b+='';
    if (!c || c==null) { c=""; } c+='';
    if (!d || d==null) { d=""; } d+='';
    if (b != "") dm+=","+b;
    if (c != "") dm+=","+c;
    if (d != "") dm+=","+d;

    var dms=split(dm.replace(/\s/g,'').replace(/,,/g,',').replace(/,+$/,''),","); //no whitespace, no double comma's, no ending comma
    var dmsctr=(dms==""?0:dms.length)-1;
    if (dmsctr<0) {
        //single dimension array without parameters
        arr=[]; //array[]
        return arr;
    }
    currdim = 0;
    arr = _NSBsubCreateArray(arr,dmsctr,dms,currdim);
    return arr;
}

//Thomas Gruber
function _NSBsubCreateArray(arr,dmsctr,dms,currdim) {
    var ub=null
    ub = dms[currdim]*1+1;
    arr = new Array(ub);
    if (currdim<dmsctr)  {
        for(var i=0;i<ub;i++)  {
            currdim = currdim+1;
            arr[i] = _NSBsubCreateArray(arr,dmsctr,dms,currdim);
            currdim = currdim-1;
        }
    }
    return arr;
}

//vbScript Time()
function Time() {
   var now    = new Date();
   var hour   = now.getHours();
   var minute = now.getMinutes();
   var second = now.getSeconds();
   var ap = "AM";
   if (hour   > 11) { ap = "PM";             }
   if (hour   > 12) { hour = hour - 12;      }
   if (hour   == 0) { hour = 12;             }
   if (hour   < 10) { hour   = "0" + hour;   }
   if (minute < 10) { minute = "0" + minute; }
   if (second < 10) { second = "0" + second; }
   var timeString = hour + ':' + minute + ':' + second + " " + ap;
   return timeString;
} var time=Time; var TIME=Time;

//vbScript Hour()
function Hour(tm) {
    return DatePart("h",tm);
} var hour=Hour; var HOUR=Hour;

//vbScript ERASE
function _erase(varr) {
	//clears up to 8 dimensioned arrays
	//would be helpful to have array dimensions as inputs  "arr(3,2)"
	//since javascript doesn't support multi-dimensional arrays so
	//you can't get the size of the array
	var arylist = split(varr,','); //allow multiple arrays
	var maxArySize=0;
	for(zz=0;zz<arylist.length;++zz) {
		var ary=window[arylist[zz]];
		if (ary.length > maxArySize) { maxArySize=ary.length; }
		if (Object.prototype.toString.call(ary)=='[object Array]') {
			for (aa=0;aa<maxArySize;++aa) {
			try {
				if (ary[aa] && !(ary[0] instanceof Array)) {
					val=ary[aa];
					if (val===null || isNaN(val) || val=='') {
						ary[aa]='';
					} else {
						ary[aa]=0;
					}
				}
				for (bb=0;bb<maxArySize;++bb) {
				try {
					if (ary[aa][bb] && !(ary[0][0] instanceof Array)) {
						val=ary[aa][bb];
						if (val===null || isNaN(val) || val=='') {
							ary[aa][bb]='';
						} else {
							ary[aa][bb]=0;
						}
					}
					for (cc=0;cc<maxArySize;++cc) {
					try {
						if (ary[aa][bb][cc] && !(ary[0][0][0] instanceof Array)) {
							val=ary[aa][bb][cc];
							if (val===null || isNaN(val) || val=='') {
								ary[aa][bb][cc]='';
							} else {
								ary[aa][bb][cc]=0;
							}
						}
						for (dd=0;dd<maxArySize;++dd) {
						try {
							if (ary[aa][bb][cc][dd] && !(ary[0][0][0][0] instanceof Array)) {
								val=ary[aa][bb][cc][dd];
								if (val===null || isNaN(val) || val=='') {
									ary[aa][bb][cc][dd]='';
								} else {
									ary[aa][bb][cc][dd]=0;
								}
							}
							for (ee=0;ee<maxArySize;++ee) {
							try {
								if (ary[aa][bb][cc][dd][ee] && !(ary[0][0][0][0][0] instanceof Array)) {
									val=ary[aa][bb][cc][dd][ee];
									if (val===null || isNaN(val) || val=='') {
										ary[aa][bb][cc][dd][ee]='';
									} else {
										ary[aa][bb][cc][dd][ee]=0;
									}
								}
								for (ff=0;ff<maxArySize;++ff) {
								try {
									if (ary[aa][bb][cc][dd][ee][ff] && !(ary[0][0][0][0][0][0] instanceof Array)) {
										val=ary[aa][bb][cc][dd][ee][ff];
										if (val===null || isNaN(val) || val=='') {
											ary[aa][bb][cc][dd][ee][ff]='';
										} else {
											ary[aa][bb][cc][dd][ee][ff]=0;
										}
									}
									for (gg=0;gg<maxArySize;++gg) {
									try {
										if (ary[aa][bb][cc][dd][ee][ff][gg] && !(ary[0][0][0][0][0][0][0] instanceof Array)) {
											val=ary[aa][bb][cc][dd][ee][ff][gg];
											if (val===null || isNaN(val) || val=='') {
												ary[aa][bb][cc][dd][ee][ff][gg]='';
											} else {
												ary[aa][bb][cc][dd][ee][ff][gg]=0;
											}
										}
										for (hh=0;hh<maxArySize;++hh) {
										try {
											if (ary[aa][bb][cc][dd][ee][ff][gg][hh] && !(ary[0][0][0][0][0][0][0][0] instanceof Array)) {
												val=ary[aa][bb][cc][dd][ee][ff][gg][hh];
												if (val===null || isNaN(val) || val=='') {
													ary[aa][bb][cc][dd][ee][ff][gg][hh]='';
												} else {
													ary[aa][bb][cc][dd][ee][ff][gg][hh]=0;
												}
											}
											for (ii=0;ii<maxArySize;++ii) {
											try {
												if (ary[aa][bb][cc][dd][ee][ff][gg][hh][ii] && !(ary[0][0][0][0][0][0][0][0][0] instanceof Array)) {
													val=ary[aa][bb][cc][dd][ee][ff][gg][hh][ii];
													if (val===null || isNaN(val) || val=='') {
														ary[aa][bb][cc][dd][ee][ff][gg][hh][ii]='';
													} else {
														ary[aa][bb][cc][dd][ee][ff][gg][hh][ii]=0;
													}
												}
												for (jj=0;jj<maxArySize;++jj) {
												try {
													if (ary[aa][bb][cc][dd][ee][ff][gg][hh][ii] && !(ary[0][0][0][0][0][0][0][0][0][0] instanceof Array)) {
														val=ary[aa][bb][cc][dd][ee][ff][gg][hh][ii][jj];
														if (val===null || isNaN(val) || val=='') {
															ary[aa][bb][cc][dd][ee][ff][gg][hh][ii][jj]='';
														} else {
															ary[aa][bb][cc][dd][ee][ff][gg][hh][ii][jj]=0;
														}
													}
												} catch (e) {} //jj
												}
											} catch (e) {} //ii
											}
										} catch (e) {} //hh
										}
									} catch (e) {} //gg
									}
								} catch (e) {} //ff
								}
							} catch (e) {} //ee
							}
						} catch (e) {} //dd
						}
					} catch (e) {} //cc
					}
				} catch (e) {} //bb
				}
			} catch (e) {} //aa
			}
		}
	}
	return '';
} var _Erase=_erase; var _ERASE=_erase;

//vbScript VARTYPE
function VARTYPE(arg,txt) {
    /*
    vbEmpty 0   Uninitialized (default)
    vbNull  1   No valid data
    vbInteger   2   Integer
    vbLong  3   Long integer
    vbSingle    4   Single-precision floating-point
    vbDouble    5   Double-precision floating-point
    vbCurrency  6   Currency
    vbDate  7   Date
    vbString    8   String
    vbObject    9   Object
    vbError 10  Error
    vbBoolean   11  Boolean
    vbVariant   12  Variant (only with arrays of Variants)
    vbDataObject    13  Data-access object
    vbByte  17  Byte
    vbArray 8192    Array
    */
    if (!txt || txt==null) { txt=0; } //vartype() vs. typename(); txt==0 if vartype
    var res=-1;
    if (!arg && arg != null && arg != 0) {
        res=0;
        if (txt==1 && isNaN(parseInt(arg))) { return arg; } //typename - returns NaN
        if (txt==1) { return 'empty'; } //typename
    } else if (arg==null) {
        res=1;
        if (txt==1) { return 'null'; } //typename
    } else {
        var type='';
        var typ=typeof arg;
        arg=arg.toString();
        if (type == '' && (arg==1 || arg==0) ) { type='integer'; }
        if (type == '' && (arg==true || arg==false || arg=='true' || arg=='false') ) { type='boolean'; res=11;}
        if (type == '' && arg.match(/\s*\d{1,2}(\/|-)\d{1,2}(\/|-)\d{2,4}/) && arg != "NaN") { type='date'; }
        if (type == '' && arg.match(/\s*\w{3}\s+\w{3}\s+\d{2}\s+\d{4}\s+\d{2}:\d{2}:\d{2}\s+\w{3}[\+\-]\d{4}/) && arg != "NaN") { type='date'; }
        if (type == '' && arg.match(/\s*(\d{1,2})(\s+|\s*\-\s*)([a-z]{3})(\s+|\s*\-\s*)(\d{2})($|\s+)/) && arg != "NaN") { type='date'; }
        if (type == '' && arg.match(/\s*\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2}/) && arg != "NaN") { type='date'; }
        if (type == '' && arg.match(/\s*\d{1,2}(\s+|\s*\-\s*)[a-z]{3}(\s+|\s*\-\s*)(\d{2}|\d{4})\s*/) && arg != "NaN") { type='date'; }
        if (type == '' && arg.match(/\s*[a-z]+\s+\d{1,2},?\s+(\d{2}|\d{4})\s*/) && arg != "NaN") { type='date'; }
        if (type == '' && arg.match(/\d{1,2}\/\d{1,2}\/(\d{2}|\d{4})/) && arg != "NaN") { type='date'; }
        if (type == '' && arg[1] && typ=='object') { type='array'; }
        if (type == '' && arg.match(/[a-zA-z][\s\!\@\#\$\%\^\&\*\(\)\-\_\+\+\{\[\}\]\:\;\"\'\<\>\,\.\?\/]*\d/)) { type='string'; }
        if (type == '' && arg.match(/\d[\s\!\@\#\$\%\^\&\*\(\)\-\_\+\+\{\[\}\]\:\;\"\'\<\>\,\.\?\/]*[a-zA-z]/)) { type='string'; }
        if (type == '' && arg.match(/\s*\$\d+,*\d*\.*\d*/)) { type='currency'; }
        if (type == '' && arg.match(/\d\.\d/)) { type='double'; }
        if (type == '' && arg.match(/\d/)) { type='integer'; }
        if (type == '') { type = typeof arg; }

        if (txt==1) { //typename()
            if (res==0 || res==1) { type='null'; }
            if (type=='array') { type='object'; }
            return type;
        }

        switch (type) {
            case 'date': res=7; break;
            case 'integer': res=2; break;
            case 'double': res=5; break;
            case 'currency': res=6; break;
            case 'string': res=8; break;
            case 'object': res=9; break;
            case 'boolean': reg=11; break;
            case 'array': res=8192; break;
            default: res=type; break;
        }
    }
    return res;
} var vartype=VARTYPE; var varType=VARTYPE; var VarType=VARTYPE; var Vartype=VARTYPE;

//vbScript typeName
function TypeName(ele) {
    return vartype(ele, 1);
    /*
    var tmpNumStr = new _jsString(ele);
    if (ele==null) { return null; }
    if (typeof(ele)=='number') {
        if (tmpNumStr.indexOf(".") > -1) { return 'double'; }
        return 'integer';
    }
    return typeof(ele);
    */
} var typename=TypeName; var typeName=TypeName; var TYPENAME=TypeName; var Typename=TypeName;

function FormatNumber(num,decimalNum,bolLeadingZero,bolParens,bolCommas) {
    if (isNaN(Math.floor(num))) { return "NaN" };

    var tmpNum = num;
    var iSign = num < 0 ? -1 : 1;       // Get sign of number
    if (!decimalNum || decimalNum==null || decimalNum < 0) { decimalNum=0; }
    if (!bolLeadingZero && bolLeadingZero != false || bolLeadingZero==null) { bolLeadingZero=true; }
    if (!bolParens && bolParens != false || bolParens==null) { bolParens=false; }
    if (!bolCommas && bolCommas != false || bolCommas==null) { bolCommas=true; }

    tmpNum = Math.round(Math.abs(tmpNum*Math.pow(10,decimalNum)))/Math.pow(10,decimalNum)*iSign;

    // Create a string object to do our formatting on
    var tmpNumStr = new _jsString(tmpNum);

    // See if we need to strip out the leading zero or not.
    if (!bolLeadingZero && num < 1 && num > -1 && num != 0) {
        if (num > 0) {
            tmpNumStr = tmpNumStr.substring(1,tmpNumStr.length);
        } else {
            tmpNumStr = "-" + tmpNumStr.substring(2,tmpNumStr.length);
        }
    }

    // See if we need to put in the commas
    var iStart;
    if (bolCommas && (num >= 1000 || num <= -1000)) {
        iStart = tmpNumStr.indexOf(".");
        if (iStart < 0) {
            iStart = tmpNumStr.length;
        }

        iStart -= 3;
        while (iStart >= 1) {
			if (tmpNumStr.substring(0,iStart).match(/\d+/)) {
				tmpNumStr = tmpNumStr.substring(0,iStart) + "," + tmpNumStr.substring(iStart,tmpNumStr.length);
			}
            iStart -= 3;
        }
    }

    // add additional zeroes after decimal point
    iStart = tmpNumStr.indexOf(".");
    var decStr, intStr, totLen;
    if (iStart > -1) {
        decStr=tmpNumStr.substr(iStart+1,tmpNumStr.length);
        intStr=tmpNumStr.substr(0,iStart);
    } else {
        decStr="";
        intStr=tmpNumStr;
        iStart=tmpNumStr.length;
    }
    if (decStr.length < decimalNum) {
        totLen=(decimalNum-decStr.length);
        for(var di=0;di<totLen;di++) {
            decStr=decStr.toString() + '0'.toString();
        }
        intStr=tmpNumStr.substr(0,iStart);
        tmpNumStr=intStr+'.'+decStr
    }

    // See if we need to use parenthesis
    if (bolParens && num < 0) {
        tmpNumStr = "(" + tmpNumStr.substring(1,tmpNumStr.length) + ")";
    }

    return tmpNumStr;
} var FORMATNUMBER=FormatNumber; var formatNumber=FormatNumber; var formatnumber=FormatNumber;

function FormatPercent(num,decimalNum,bolLeadingZero,bolParens,bolCommas) {
    var tmpNumStr = new _jsString(FormatNumber(num*100,decimalNum,bolLeadingZero,false,bolCommas));

    // See if we need to use parenthesis
    if (bolParens && num < 0) {
        tmpNumStr = "(" + tmpNumStr.substring(1,tmpNumStr.length) + "%)";
    } else {
        tmpNumStr += '%';
    }
    return tmpNumStr;
} var FORMATPERCENT=FormatPercent; var formatPercent=FormatPercent; var formatpercent=FormatPercent;

function FormatCurrency(num,decimalNum,bolLeadingZero,bolParens,bolCommas) {
    decimalNum=decimalNum<0?2:decimalNum;
    var tmpStr = new _jsString(FormatNumber(num,decimalNum,bolLeadingZero,bolParens,bolCommas));

    if (tmpStr.indexOf("(") != -1 || tmpStr.indexOf("-") != -1) {
        // We know we have a negative number, so place '$' inside of '(' / after '-'
        if (tmpStr.charAt(0) == "(")
            tmpStr = "($"  + tmpStr.substring(1,tmpStr.length);
        else if (tmpStr.charAt(0) == "-")
            tmpStr = "-$" + tmpStr.substring(1,tmpStr.length);

        return tmpStr;
    }
    else
        return "$" + tmpStr;        // Return formatted string!
} var FORMATCURRENCY=FormatCurrency; var formatCurrency=FormatCurrency; var formatcurrency=FormatCurrency;

//vbScript TimeValue
function TimeValue(tm) {
    return FormatDateTime(tm,3);
} var timevalue=TimeValue; var timeValue=TimeValue; var TIMEVALUE=TimeValue;

//vbScript TimeSerial
function TimeSerial(hh,mm,ss) {
    if (!ss || ss==null || ss=="") { ss='00'; }
    if (!mm || mm==null || mm=="") { mm='00'; }
    var ssval=parseInt(ss.toString());
    var mmval=parseInt(mm.toString());
    var hhval=parseInt(hh.toString());
    if (ssval>59) {
        ssval=ssval-60;
        mmval++;
    }
    if (mmval>59) {
        mmval=mmval-60;
        hhval++;
    }
    if (hhval > 23) { hhval=hhval-24; }
    hh=hhval.toString(); if (hh.length==1) { hh='0'+hh; }
    mm=mmval.toString(); if (mm.length==1) { mm='0'+mm; }
    ss=ssval.toString(); if (ss.length==1) { ss='0'+ss; }
    return TimeValue(hh+':'+mm+':'+ss);
} var timeserial=TimeSerial; var timeSerial=TimeSerial; var TIMESERIAL=TimeSerial;

//vbScript Rnd (sort of)
function rnd() {
    return Math.random()%1;
} var RND=rnd; var Rnd=rnd;

//vbScript sleep n
function _pause(millis) {
    var date = new Date();
    var curDate = null;
    do { curDate = new Date(); }
    while(curDate-date < millis);
}

//vbscript sysinfo()
function sysinfo(arg) {
    switch(arg) {
        case 0: return screen.width;
        case 1: return screen.height;
        case 2: {if(SysInfo(4)==false) return window.innerWidth;
               if(Math.abs(window.orientation==90))
                 {return Math.max(screen.width,screen.height)}
                else
                 {return Math.min(screen.width,screen.height)}
                };
        case 3: {if(SysInfo(4)==false) return window.innerHeight;
                if(Math.abs(window.orientation==90))
                 {return Math.min(screen.width,screen.height)}
                else
                 {return Math.max(screen.width,screen.height)}
                };
        case 4:  return 'ontouchstart' in window || 'onmsgesturechange' in window;
        case 5:  return window.devicePixelRatio
        case 10: return new Date().getTime();
        case 108: return screen.availWidth;
        case 109: return screen.availHeight;
        case 188: return screen.width;
        case 190: return screen.height;
        default: return 0;
    }
} var sysInfo=sysinfo; var SYSINFO=sysinfo; var SysInfo=sysinfo; var Sysinfo=sysinfo;

function RGB(r,g,b)  {
    //return '#'+(r + 256 * g + 65536 * b).toString(16).toUpperCase();
    return '#'+(right('00'+hex(r),2) + right('00'+hex(g),2) + right('00'+hex(b),2));
} var rgb=RGB;

//vbScript "\" opterator: integer division
function intDiv(v1, v2) {
    if (!v1) { v1=0; }
    if (!v2) { v2=0; }
    if (v1==null || v2==null) { return null; }
    if (v1==0 || v2==0) { return 0; }
    return (v1 % v2);
} var intdiv=intDiv; var IntDiv=intDiv; var Intdiv=intDiv; var INTDIV=intDiv;

function ucase(arg) {
    if (!arg || arg==null || typeof(arg)=='undefined') { return arg; }
    return arg.toUpperCase();
} var UCASE=ucase; var uCase=ucase; var Ucase=ucase; var UCase=ucase;

function lcase(arg) {
    if (!arg || arg==null || typeof(arg)=='undefined') { return arg; }
    return arg.toLowerCase();
} var LCASE=lcase; var lCase=lcase; var Lcase=lcase; var LCase=lcase;

//vbScript doevents simulation
function doevents() {
    setTimeout("doevents()",100);
} var doEvents=doevents; var DOEVENTS=doevents; var DoEvents=doevents; var Doevents=doevents;

// SQL Functions

function Sql(db, sqlList){
    // Built in function
    db.transaction(function(transaction) {
        for(var i = 0; i < sqlList.length; i++) {
            // create a new scope that holds sql for the error message, if needed
            (function(tx, sql) {
                if (typeof(sql) === 'string') sql = [sql];
                if (typeof(sql[1]) === 'string') sql[1] = [sql[1]];
                var args = (typeof(sql[1]) === 'object') ? sql.splice(1,1)[0] : [];
                var sql_return = sql[1] || function() {};
                var sql_error = sql[2] || NSB._sqlError(sql[0]);

                tx.executeSql(sql[0], args, sql_return, sql_error);
            }(transaction, sqlList[i]));
        }
    });
}

function SqlOpenDatabase(shortName, version, displayName, maxSize) {
  //Built in function
    try {
            if (!window.openDatabase) {
                    NSB.MsgBox(NSB._['SQLite not supported.']);
            } else {
                    if (typeof(shortName) == 'undefined') {
                        NSB.MsgBox(NSB._["Database name required."]);
                        return 0;
                        }
                    if (typeof(version) == 'undefined') version="";
                    if (typeof(displayName) == 'undefined') displayName = shortName;
                    if (typeof(maxSize) == 'undefined') maxSize =1000000;
                    var myDB = openDatabase(shortName, version, displayName, maxSize);
            }
    } catch(e) {
            if (e.code == 11) {// INVALID_STATE_ERR: Version number mismatch.
            NSB.MsgBox(NSB._["Invalid database version: {version}"].supplant({"version": version}));
            } else {
            NSB.MsgBox(NSB._["Unknown error: {error}"].supplant({"error": e}));
            }
            return 0;
    }
    return myDB;
}

function SQLExport(db, dbname, callback) {
    // convert a SQLite database schema to JSON
    //
    // db is the db to export
    // callback is a function of one argument that recieves the JSON
    //
    // Limitations:
    // - BLOB data will probably not export properly, or not import properly
    // - Foreign keys are not taken into account when exporting/importing
    var item,
        totalRows = 0,
        processedRows = 0,
        masterSql = 'SELECT name, sql, type FROM sqlite_master WHERE sql IS NOT NULL',
        schema = {
            'dbname': db.name || dbname || 'default',
            'dbver': db.version,
            'ddl': {
                'drops': [],
                'tables': [],
                'creates': []
            },
            'dml': [],
	    'version': 2
        };

    db.transaction(function(tx) {
        tx.executeSql(masterSql, [], function(tx, result) {
            for (var i = 0; i < result.rows.length; i++) {
                item = result.rows.item(i);

                if (item['name'] != '__WebKitDatabaseInfoTable__' && item['name'] != 'sqlite_sequence') {
                    schema.ddl.drops.push('DROP ' + item['type'] + ' IF EXISTS ' + item['name']);
                    if (item['type'] === 'table') {
                        schema.ddl.tables.push(item['sql']);
                        totalRows++;
                        tx.executeSql('SELECT * FROM ' + item['name'], [], (function(item) {
                            return function(tx, result) {
                                var row,
                                    sql,
                                    sql1,
                                    sql2,
                                    params,
				    param_list = [];

                                for (var i = 0; i < result.rows.length; i++) {
                                    row = result.rows.item(i);
                                    params = []

                                    for (field in row) {
                                        params.push(row[field]);
                                    }

				    param_list.push(params);
                                }

				if (result.rows.length > 0) {
				    row = result.rows.item(0);
                                    sql1 = 'INSERT INTO ' + item['name'] + ' (';
                                    sql2 = ') VALUES (';

                                    for (field in row) {
                                        sql1 += field + ', ';
                                        sql2 += '?, ';
                                    }
                                    sql = sql1.slice(0, -2) + sql2.slice(0, -2) + ')';

				    schema.dml.push({'sql': sql, 'params': param_list});
				}

                                // only callback when we're done
                                if (callback && (++processedRows === totalRows)) callback(schema);
                            };
                        }(item)), NSB._sqlError('SELECT * FROM ' + item['name']));
                    } else {
                        schema.ddl.creates.push(item['sql']);
                    }
                }
            }
        }, NSB._sqlError(masterSql));
    });

    return schema;
}

function SQLImport(json, db, callback, overwrite) {
    // imports a database exported by SQLExport -
    // - json: the json object from SQLExport
    // - db (optional): the database to use, normally you should let SQLImport open the DB
    // - callback (optional): call this function on completion, expects function(msg) {}
    // - overwrite (optional): numeric - pass one of the following values
    //   - NSB.overwriteNever - never overwrite the database - used to be false
    //   - NSB.overwriteAlways - always overwrite the database (default) - used to be true
    //   - NSB.overwriteIfVersionDifferent - only overwrite if the database version is different
    //   - NSB.overwriteIfVersionSame - only overwrite if the database version is the same
    var i,
        j;

    // try to parse the json as a string if someone gave us the wrong sort of object
    if (typeof json.dbname === 'undefined') {
        json = JSON.parse(json);
    }

    // this routine can only parse v1 and v2, error our if it's higher
    if (json.version > 2) {
	callback('Export format is too new. Cannot parse.');
	return;
    }

    // default values
    db = db || SqlOpenDatabase(json.dbname, '');
    callback = callback || function(msg) {};
    if (typeof overwrite === 'undefined') {
        overwrite = NSB.overwriteAlways;
    } else {
        // overwrite used to be boolean - this converts a boolean to a number
        // and has no effect if it's already a number
        overwrite = +overwrite;
    }

    // the database version will be blank if it was newly created, so we
    // ignore the overwrite section unless the version is set to something
    if (db.version !== '') {
        switch (overwrite) {
            case NSB.overwriteAlways:
                break;
            case NSB.overwriteIfVersionDifferent:
                if (db.version === json.dbver) {
                    callback('No overwrite - new database is same version as old.');
                    return;
                }
                break;
            case NSB.overwriteIfVersionSame:
                if (db.version !== json.dbver) {
                    callback('No overwrite - new database is different version from old.');
                    return;
                }
                break;
            case NSB.overwriteNever:
                callback('No overwrite - database already exists.');
                return;
            default:
                callback('Invalid overwrite argument: ' + overwrite);
                return;
        }
    }

    // make sure we don't clobber the database version if it wasn't spec'd
    // this is really about being extra careful - unlikely scenario
    if (typeof json.dbver !== 'undefined') {
        try {
            db.changeVersion(db.version, json.dbver);
        } catch (e) {
            // changeVersion doesn't work in iOS<5, so ignore it
        }
    }

    db.transaction(function(tx) {
        for (i = 0; i < json.ddl.drops.length; i++) {
            tx.executeSql(json.ddl.drops[i], [], function(t, r) {},
                          NSB._sqlError(json.ddl.drops[i]));
        }

        for (i = 0; i < json.ddl.tables.length; i++) {
            tx.executeSql(json.ddl.tables[i], [], function(t, r) {},
                          NSB._sqlError(json.ddl.tables[i]));
        }

        for (i = 0; i < json.dml.length; i++) {
	    if (json.version >= 2) {
		for (j = 0; j < json.dml[i].params.length; j++) {
		    tx.executeSql(json.dml[i].sql, json.dml[i].params[j], function(t, r) {},
				  NSB._sqlError(json.dml[i].sql));
		}
	    } else {
		tx.executeSql(json.dml[i].sql, json.dml[i].params, function(t, r) {},
                              NSB._sqlError(json.dml[i].sql));
	    }
        }

        for (i = 0; i < json.ddl.creates.length; i++) {
            tx.executeSql(json.ddl.creates[i], [], function(t, r) {},
                          NSB._sqlError(json.ddl.creates[i]));
        }

        callback(json.dbname + ' sucessfully written.');
    });
}

function Main(){}

function _navGetLocaleFunc() {
    var lang='';
    if ( navigator ) {
        if ( navigator.language ) {
            lang=navigator.language;
        }
        else if ( navigator.browserLanguage ) {
            lang=navigator.browserLanguage;
        }
        else if ( navigator.systemLanguage ) {
            lang=navigator.systemLanguage;
        }
        else if ( navigator.userLanguage ) {
            lang=navigator.userLanguage;
        }
    }
    return lang;
}

function Log10(x) {
    return Math.log(x)/Math.log(10);
} var log10=Asc; var LOG10=Asc;

function _jsCint(n) {
    //simulate vbScript CINT()
    var i=Math.floor(n);
    var d=n*1-i-0.5; //get fractional part
    if (d==0) { //d=.5
        if (i%2 == 0) { //even leave as is otherwise inc
            n=i;
        } else {
            n=i*1+1;
        } // end of if d%2
    } else if (d>0) { //greater than .5
        n=i*1+1;
    } else { //less than .5
        n=i;
    }
    return n*1;
} var _jsCINT=_jsCint; var _JSCINT=_jsCint; var _jsCInt=_jsCint; var _JSCInt=_jsCint;

function jsFix(n) {
    //simulate vbScript FIX()
    var i=Math.floor(n);
    if (i<0) { i++; };
    return i*1;
} var jsFIX=jsFix; var JSFIX=jsFix; var JSFix=jsFix;

function readFile(filename,method){
    if (!method || method==null || typeof(method)=='undefined') { method = ''; }
    if(method=="") method="GET";
    req=new XMLHttpRequest();
    req.open(method.toUpperCase(),filename,false);
    try {
        req.send(null)}
    catch(err) {
        req.err=err};
    return req
} var ReadFile=readFile; var readfile=readFile; var READFILE=readFile;

function Ajax(URL, method, data, callback) {
  if (typeof(method) !== 'object') {
	  var settings = new Object;
	  if(!method || method === null || typeof(method) === 'undefined') method = "GET";
	  settings.type = method.toUpperCase()
	  if(!data || data === null || typeof(data) === 'undefined') data = "";
	  settings.data = data;
	  if (!callback) {
		settings.async = false;
	  } else {
		settings.success = callback;
		settings.fail = callback}
  }
  return $.ajax(URL, settings);
}

window.GetJSON = $.getJSON;

function nsbDOMAttr(obj, strobj) {
    var parts = strobj.split('.');
    var target = parts[parts.length - 1]
    var setter = arguments.length > 2;
    var value = arguments[2];  // optional, value to be set
    var noscroll = arguments[3];  // optional, don't do scroller exceptions

    // special cases for canvas elements
    if ((obj.tagName === 'CANVAS') && setter) {
        if (strobj === 'style.width') obj.width = parseInt(value);
        if (strobj === 'style.height') obj.height = parseInt(value);
    }

    // one more exception and this needs to be a list
    if (obj.parentNode && !noscroll && (obj.parentNode.id === (obj.id + '_scroller')) &&
        ((strobj === 'style.left') || (strobj === 'style.top') ||
         (strobj === 'style.width') || (strobj === 'style.height') ||
         (strobj === 'style.display'))) {
        // if setting, set the actual value as well
        if (setter && strobj !== 'style.left' && strobj !== 'style.top') nsbDOMAttr(obj, strobj, value, true);
        // get/set from the parent object
        obj = obj.parentNode;
    }

    for (var i = 0; i < parts.length - 1; i++) {
        obj = obj[parts[i]];
    }

    if (setter) {
        // set the value
        return obj[target] = value;
    } else {
        // return the value
        return obj[target];
    }
}

NSB.addDisableProperty = function(ctrl) {
    NSB.defineProperty(ctrl, 'disabled', {
	set: function(n) {
            if (n) {
                $(this).addClass('ui-disabled');
	    } else {
                $(this).removeClass('ui-disabled');
		$(this).find('*').removeClass('ui-disabled');
		$(this).find('[disabled="disabled"]').removeAttr('disabled');
	    }
        },
	get: function() {
            return $(this).hasClass('ui-disabled');
        }
    });
}

function GetURLParameter( name ) {
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results == null )
    return "";
  else
    return results[1];
} getURLParameter=GetURLParameter;

function enquote(s){
  var i, arrTerms, arrTerm;
  arrTerms=s.split(" ");
  for (i=0; i<arrTerms.length; i++){
    arrTerm=arrTerms[i].split("=");
    if (arrTerm.length>1) {
      if (arrTerm[1].length==0){
        arrTerms[i]="";
        }
      else {
        if (arrTerm[1].substring(0,1)!="'") {
          arrTerms[i]=arrTerm[0] + "='" + arrTerm[1] + "'"}
          }
        }
    else
      if (arrTerms[i].indexOf("=")>0) {
        //arrTerms[i]=arrTerm[0] + "=''"}
        arrTerms[i]=""}
    }
  return arrTerms.join(" ");
  }

function ChangeForm(newForm, transition, reverse) {
  if (typeof(NSBCurrentForm.onhide)=='function') {NSBCurrentForm.onhide()};
  NSBCurrentForm.style.display="none";
  newForm.style.display="block"
  NSBCurrentForm=newForm;
  if (typeof(NSBCurrentForm.onshow)=='function')
    {setTimeout(NSBCurrentForm.onshow, 100)};
}

NSB.alertDialog = null
NSB.eCount = 0
NSB.NSB_Progress = null

// Constants used by SQLImport
NSB.overwriteNever = 0
NSB.overwriteAlways = 1
NSB.overwriteIfVersionDifferent = 2
NSB.overwriteIfVersionSame = 3

NSB.msgboxDefaultRtn = function(buttonClicked, inputTxt) {}

NSB.addProperties = function(ctrl, actualCtrl, noHeight) {
    actualCtrl = actualCtrl || ctrl;
	if(actualCtrl.id==undefined){console.log("NSB.addProperties: ctrl is undefined");console.log(ctrl)};
	if(typeof ctrl.getAttribute == "undefined") return; //for partly formed select_jqm
    var textBoxCtrl = actualCtrl;
    if (ctrl.getAttribute('data-nsb-type') === 'TextBox_jqm' ||
        ctrl.getAttribute('data-nsb-type') === 'Date' ||
        ctrl.getAttribute('data-nsb-type') === 'DateTime' ||
        ctrl.getAttribute('data-nsb-type') === 'Month' ||
        ctrl.getAttribute('data-nsb-type') === 'Time')
          { textBoxCtrl = ctrl; }
    NSB.defineProperty(ctrl, 'Left', {
        set: function(n) { actualCtrl.style.left = n + (typeof n === 'number' ? 'px' : ''); },
        get: function() { return actualCtrl.offsetLeft; }
    });
    NSB.defineProperty(ctrl, 'Top', {
        set: function(n) { actualCtrl.style.top = n + (typeof n === 'number' ? 'px' : ''); },
        get: function() { return actualCtrl.offsetTop; }
    });
    NSB.defineProperty(ctrl, 'Width', {
        set: function(n) {if(ctrl.nodeName=='CANVAS')ctrl.width=parseInt(n);actualCtrl.style.width = n + (typeof n === 'number' ? 'px' : ''); },
        get: function() { return actualCtrl.offsetWidth; }
    });
    if(noHeight!=true){
    NSB.defineProperty(ctrl, 'Height', {
        set: function(n){
          if(ctrl.nodeName=='CANVAS') ctrl.height=parseInt(n);
          textBoxCtrl.style.height = n + (typeof n === 'number' ? 'px' : '');
          if(ctrl.nodeName=='TEXTAREA') ctrl.style.maxHeight=textBoxCtrl.style.height;
          },
        get: function() { return textBoxCtrl.offsetHeight; }
    })}
    if(ctrl.getAttribute('data-nsb-type') === 'Label') {
        NSB.defineProperty(ctrl, 'Caption', {
            set: function(n) { ctrl.innerHTML = n; },
            get: function() { return ctrl.innerHTML; }
        });
        NSB.defineProperty(ctrl, 'text', {
            set: function(n) { ctrl.innerHTML = n; },
            get: function() { return ctrl.innerHTML; }
        });
    }
    if (ctrl.nodeName === 'INPUT' || ctrl.nodeName === 'TEXTAREA') {
        NSB.defineProperty(ctrl, 'text', {
            set: function(n) { textBoxCtrl.value = n; },
            get: function() { return textBoxCtrl.value; }
        });
    };
    if (ctrl.getAttribute('data-nsb-type') === 'Button_jqm') {
        NSB.defineProperty(ctrl, 'value', {
            set: function(n) { $(ctrl).text(n) },
            get: function() { return $(ctrl).text() }
        });
        NSB.defineProperty(ctrl, 'text', {
            set: function(n) { $(ctrl).text(n) },
            get: function() { return $(ctrl).text() }
        });
    }
    if (ctrl.getAttribute('data-nsb-type') === 'image') {
        NSB.defineProperty(ctrl, 'src', {
            set: function(n) { ctrl.firstChild.src = n },
            get: function() { return ctrl.firstChild.src }
        });
    }
    NSB.defineProperty(ctrl, 'Visible', {
        set: function(n) { if (n) { actualCtrl.style.display = 'block'; } else { actualCtrl.style.display = 'none'; } },
        get: function() { return actualCtrl.style.display !== 'none'; }
    });

    NSB.defineProperty(ctrl, 'hidden', {
        set: function(n) { if (n) { actualCtrl.style.display = 'none'; } else { actualCtrl.style.display = 'block'; } },
        get: function() { return actualCtrl.style.display === 'none'; }
    });
    ctrl.hide = function() {if (actualCtrl.parentNode.id === actualCtrl.id + "_scroller") {
        actualCtrl.parentNode.style.display = 'none'}
      else {actualCtrl.style.display = 'none'}};
    ctrl.show = function() {if (actualCtrl.parentNode.id === actualCtrl.id + "_scroller") {
        actualCtrl.parentNode.style.display = 'block'}
        else {actualCtrl.style.display = 'block'}};

    ctrl.resize = function(l, t, w, h) {ctrl.Left = l; ctrl.Top = t; ctrl.Width = w; ctrl.Height = h; };
    if(!ctrl.refresh)ctrl.refresh=function(){}
};

NSB.defineProperty = function(obj, prop, descriptor) {
    try {
        Object.defineProperty(obj, prop, descriptor);
    } catch(err) {
        if (descriptor.get) {
            obj.__defineGetter__(prop, descriptor.get);
        }
        if (descriptor.set) {
            obj.__defineSetter__(prop, descriptor.set);
        }
    }
};

NSB.oncache = function(e){
      if (typeof oncache!='undefined'){oncache(e);return;}
      NSB.eCount=NSB.eCount+1;
      if (e.type=="progress"){NSB.ShowProgress(NSB._["Updating - Please wait"] + (Array(NSB.eCount%15).join(".")))}
        else {NSB.ShowProgress(e.type);}
      if ((e.type=="noupdate") || (e.type=="cached")){
        NSB.ShowProgress(false);
      }
      if (e.type=="updateready"){
        NSB.ShowProgress(NSB._["Update Complete - Restarting."]);
        if (typeof(window.applicationCache)=='undefined') return; //ie8
        window.applicationCache.swapCache();
        window.location.reload();
      }
    }

NSB.EULA=function(s){
  if (s==false || !s){
    if (typeof(NSB.EULAobj)==='object' && NSB.EULAobj != null) {
      if (NSB.EULAobj.parentNode!=undefined){
        NSB.EULAobj.parentNode.removeChild(NSB.EULAobj);
        NSB.EULAobj=null;}
      }
    if (typeof(NSB.EULAref)==='object' && NSB.EULAref != null) {
      NSB.EULAref.destroy()
      NSB.EULAref=null
      }
    return
  }
 var height=window.innerHeight
  var accept=NSB._["Accept"];
  NSB.EULAobj=document.createElement('div')
  NSB.EULAobj.style.position='fixed'
  NSB.EULAobj.style.width='100%'
  NSB.EULAobj.style.height=height+'px';
  NSB.EULAobj.style.background='black'
  NSB.EULAobj.style.zIndex=1
  NSB.EULAobj.id='NSB_EULA'
  NSB.EULAobj.innerHTML=
    "<div id='NSB_scroller' style='height:" + (height-5) + "px;'>" +
        "<div id='NSB_text' style='padding:10px; background-color:black; color:white; text-shadow:0 0 0; font-family:helvetica; font-size:12px;'>" + s +
        "</div>" +
    "</div>" +
    "<div id='NSB_ProgressClose' style='position:absolute; bottom:0px; left:5%; width:90%; text-align:center;" +
      "text-shadow:0 0 0; margin-bottom:0px; background-color:black; color:white; font-family:helvetica; font-size:18px;" +
      "border:2px solid white;'>"+accept+"</div>";
  document.body.appendChild(NSB.EULAobj);
  NSB_ProgressClose.onclick = function(){
    localStorage.EULA=true;
    NSB.EULA();
    if (typeof(NSBCurrentForm.onshow)=='function') NSBCurrentForm.onshow(); Main()};
  NSB.EULAref=new IScroll(NSB_scroller,{mouseWheel:true, scrollbars:true, bounce:true, zoom:false})
  setTimeout(function(){NSB.EULAref.refresh()}, 200)
}

NSB.PlaySound = function(filename) {
  NSB.initSound();
  if(NSB.audio_ctx == undefined) return;
  var src = NSB.audio_ctx.createBufferSource();
  src.buffer = NSB.sounds[filename];
  gain_node = NSB.audio_ctx.createGain();
  src.connect(gain_node);
  gain_node.connect(NSB.audio_ctx.destination);
  // polyfill the standard name on older browsers
  src.start = src.start || src.noteOn;
  src.start(0);
  return src;
}

NSB.decodeSound = function(name, data){
  NSB.initSound();
  if (NSB.audio_ctx == undefined) return;
  var arrayBuffer = Base64Binary.decodeArrayBuffer(data);
  NSB.audio_ctx.decodeAudioData(arrayBuffer,
    function(audioBuffer){
      NSB.sounds[name] = audioBuffer})
  }

NSB.initSound = function() {
  if (NSB.audio_ctx == undefined) {
	window.AudioContext = window.AudioContext || window.webkitAudioContext;
	if (window.AudioContext === undefined) {
	  console.log("Warning: Browser does not support sound files");
	  return}
	if (window.AudioContext) {
  		NSB.audio_ctx = new AudioContext();
  		// polyfill the standard name on older browsers
  		NSB.audio_ctx.createGain = NSB.audio_ctx.createGain || NSB.audio_ctx.createGainNode;
		}
    }
	if (NSB.sounds == undefined) NSB.sounds = {};
}

/*
Copyright (c) 2011, Daniel Guerrero
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL DANIEL GUERRERO BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

var Base64Binary = {
	_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

	/* will return a  Uint8Array type */
	decodeArrayBuffer: function(input) {
		var bytes = (input.length/4) * 3;
		var ab = new ArrayBuffer(bytes);
		this.decode(input, ab);

		return ab;
	},

	decode: function(input, arrayBuffer) {
		//get last chars to see if are valid
		var lkey1 = this._keyStr.indexOf(input.charAt(input.length-1));
		var lkey2 = this._keyStr.indexOf(input.charAt(input.length-2));

		var bytes = (input.length/4) * 3;
		if (lkey1 == 64) bytes--; //padding chars, so skip
		if (lkey2 == 64) bytes--; //padding chars, so skip

		var uarray;
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;
		var j = 0;

		if (arrayBuffer)
			uarray = new Uint8Array(arrayBuffer);
		else
			uarray = new Uint8Array(bytes);

		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

		for (i=0; i<bytes; i+=3) {
			//get the 3 octects in 4 ascii chars
			enc1 = this._keyStr.indexOf(input.charAt(j++));
			enc2 = this._keyStr.indexOf(input.charAt(j++));
			enc3 = this._keyStr.indexOf(input.charAt(j++));
			enc4 = this._keyStr.indexOf(input.charAt(j++));

			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;

			uarray[i] = chr1;
			if (enc3 != 64) uarray[i+1] = chr2;
			if (enc4 != 64) uarray[i+2] = chr3;
		}

		return uarray;
	}
}
// end Daniel Guerrero code
// end Sound support

NSB_WaitCursor=null;
NSB.WaitCursor=function(s){
  if (typeof(s) == "boolean") {
  	 if(s){
  	   if(SysInfo(4)) {
  	     NSB.WaitCursorShow('nsb/images/ajax-loader.gif')}
  	   else {
  	     document.body.style.cursor = "progress"}}
  	 else {
       document.body.style.cursor = "auto";
       NSB.WaitCursorHide()}
     }
  else if(typeof(s)=="string" && s.indexOf('.')==-1) {
     if(s=="wait" && SysInfo(4))
       NSB.WaitCursorShow('nsb/images/ajax-loader.gif')
     else
       document.body.style.cursor = s
     }
  else NSB.WaitCursorShow(s);
}
NSB.WaitCursorHide=function(){
    if (typeof(NSB.WaitCursorobj)==='object' && NSB.WaitCursorobj != null) {
      if (NSB.WaitCursorobj.parentNode!=undefined){
        NSB.WaitCursorobj.parentNode.removeChild(NSB.WaitCursorobj);
        NSB.WaitCursorobj=null;
        NSB_WaitCursor=null;}
      }
    return
  }
NSB.WaitCursorShow=function(image){
  if (!NSB_WaitCursor){
	  var height=window.innerHeight;
	  NSB.WaitCursorobj=document.createElement('div');
	  NSB.WaitCursorobj.style.position='fixed';
	  NSB.WaitCursorobj.style.width='100%';
	  NSB.WaitCursorobj.style.height=height+'px';;
	  NSB.WaitCursorobj.style.backgroundImage='url("'+image+'")';
	  NSB.WaitCursorobj.style.backgroundPosition='center';
	  NSB.WaitCursorobj.style.backgroundRepeat='no-repeat';
	  NSB.WaitCursorobj.style.pointerEvents = "none";;
	  NSB.WaitCursorobj.style.zIndex=1;
	  NSB.WaitCursorobj.id='NSB_WaitCursor';
	  document.body.appendChild(NSB.WaitCursorobj);
	  NSB_WaitCursor = NSB.WaitCursorobj;
	}
	NSB_WaitCursor.style.backgroundImage='url("'+image+'")';
}

NSB.Print=function(s){
  if (s==false){
    if (typeof(NSB.Printobj)==='object' && NSB.Printobj != null) {
      if (NSB.Printobj.parentNode!=undefined){
        NSB.Printobj.parentNode.removeChild(NSB.Printobj);
        NSB.Printobj=null;}
      }
    if (typeof(NSB.Printref)==='object' && NSB.Printref != null) {
      NSB.Printref.destroy()
      NSB.Printref=null
      }
    return
  }
  if(typeof(NSB.Printobj)!='undefined' && NSB.Printobj != null){
     if(!s) return;
     if(NSB_text.innerHTML.slice(-4)!="<br>") s="<br>" + s;
     NSB_text.innerHTML=NSB_text.innerHTML + s;
     NSB.Printobj.style.display="block";
     if(typeof(IScroll)!="undefined") {setTimeout(function(){NSB.Printref.refresh()}, 100)}
  }
  else {
    var height=window.innerHeight-50
    NSB.Printobj=document.createElement('div')
    NSB.Printobj.style.position='fixed'
    NSB.Printobj.style.top='25px'
    NSB.Printobj.style.left='10%'
    NSB.Printobj.style.width='80%'
    NSB.Printobj.style.height=height+'px';
    NSB.Printobj.style.zIndex=1
    NSB.Printobj.id='NSB_Progress'
    NSB.Printobj.innerHTML=
      "<div id='NSB_scroller' style='height:" + (height-5) + "px;'>" +
          "<div id='NSB_text' style='padding:10px; font-family:helvetica; font-size:12px;'>" + s +
      "</div>" +
      "<div id='NSB_ProgressClose' class='NSB_ProgressClose'>&times;</div>";
    document.body.appendChild(NSB.Printobj);
    NSB_ProgressClose.onclick = function(){NSB_Progress.style.display='none'};
    if(typeof(IScroll)!="undefined") {
       NSB.Printref=new IScroll(NSB_scroller,{bounce:true, zoom:false, mouseWheel:true, scrollbars:true})
       setTimeout(function(){NSB.Printref.refresh()}, 200)
    }
  }
}

NSB.ShowProgress = function(s){
    if (s==false || !s){
        if (typeof(NSB.ShowProgressobj)==='object' && NSB.ShowProgressobj != null) {
          if (NSB.ShowProgressobj.parentNode!=undefined){
            NSB.ShowProgressobj.parentNode.removeChild(NSB.ShowProgressobj);
            NSB.ShowProgressobj=null;}
            }
          return
        }
    if (typeof(NSB.ShowProgressobj)=='undefined' || NSB.ShowProgressobj==null){
        NSB.ShowProgressobj = document.createElement("div");
        NSB.ShowProgressobj.style.width='100%';
        NSB.ShowProgressobj.style.height='100%';
        NSB.ShowProgressobj.innerHTML=
          "<div id='NSB_Progress' style='left:50%; width:240px; top:50%; margin-left:-120px; margin-top:-40px;'>" + s +
          "<span class='NSB_ProgressClose'>&times;</span></div>";
        NSB.ShowProgressobj.onclick=function(){NSB.ShowProgress(false)};
        document.body.appendChild(NSB.ShowProgressobj);
        }
    NSB_Progress.innerHTML=s+"<span class='NSB_ProgressClose'>&times;</span></div>";
    }

NSB.MsgBox = function(rtnFunc, prompt, buttons, title) {
        if (typeof(rtnFunc)!='function' && !title){ //looking for less than 4 parameters
            title=buttons; buttons=prompt; prompt=rtnFunc; rtnFunc=NSB.msgboxDefaultRtn;}
        var imgicon = NSB._parseIcon(buttons);
        if (prompt==null || typeof(prompt)=='undefined') { prompt = ''; }
        if (title==null || typeof(title)=='undefined') { title = document.title; }
        if (title=='') title=' ';
        if (!buttons || buttons==null || typeof(buttons)=='undefined') { buttons = '0'; }
        if (!rtnFunc || rtnFunc==null || typeof(rtnFunc)=='undefined' || typeof(rtnFunc) != 'function' || rtnFunc=='') { rtnFunc=NSB.msgboxDefaultRtn; }
        buttonObj = NSB._parseButtons(buttons, rtnFunc);

        if (!this.alertDialog) {
            this.alertDialog = new Dialog({ //default options
                //top: 140,
                width: 281,
                title: title,
                icon: imgicon,
                content: prompt.toString(),
                icontent: '',
                buttons: buttonObj,
                openOnCreate: false,
                destroyOnClose: true //jw destroy on any button click
            });
        }
        this.alertDialog.open();
    }

NSB.closeMsgBox = function() { if (this.alertDialog) {this.alertDialog.close();} }

NSB.InputBox = function(rtnFunc, prompt, title, def, xpos, ypos) {
        if (!prompt || prompt==null || typeof(prompt)=='undefined') { prompt = ''; }
        if (title==null || typeof(title)=='undefined') { title = document.title; }
        if (!rtnFunc || rtnFunc==null || typeof(rtnFunc)=='undefined' || rtnFunc=='') { rtnFunc=NSB.msgboxDefaultRtn; }
        if (!def || def==null || typeof(def)=='undefined' || def=='') { def = null; }

        var config = {
            title: title,
            icon: '',
            content: prompt.toString(),
            icontent: def,
            buttons: {},
            close: function() {this.close();}
        }
        config.buttons[NSB._['Cancel']] = function() {
            this.close();
            rtnFunc(2,'');
        }
        config.buttons[NSB._['OK']] = function() {
            var iboxValue = document.getElementById('_nsbDialogBoxInput');
            var inputText = iboxValue.value;
            this.close();
            rtnFunc(1,inputText);
        }
        var dialog = new Dialog(config);
        this.alertDialog = dialog;
        _nsbDialogBoxInput.focus();
    }

    //parses button types
NSB._parseButtons = function(buttons, rtnFunc) {
        if (buttons == "") buttons = "0";
        var buttonObj = {};
        //test if buttons parameter numeric
        if (buttons == parseInt(buttons) && buttons == parseFloat(buttons)) {
            //determine button from vbscript value: modal 0xF000, default 0x0F00, icon 0x00F0, button 0x000F

            // 0 = vbOKOnly - OK button only
            // 1 = vbOKCancel - OK and Cancel buttons
            // 2 = vbAbortRetryIgnore - Abort, Retry, and Ignore buttons
            // 3 = vbYesNoCancel - Yes, No, and Cancel buttons
            // 4 = vbYesNo - Yes and No buttons
            // 5 = vbRetryCancel - Retry and Cancel buttons
            var buttonCombination = buttons & 0x000F;

            // 0 = vbDefaultButton1 - First button is default
            // 256 = vbDefaultButton2 - Second button is default
            // 512 = vbDefaultButton3 - Third button is default
            // 768 = vbDefaultButton4 - Fourth button is default
            var buttonDefault = buttons & 0x0F00;

            // 0 = vbApplicationModal - Application modal (the current application will not work until the user responds to the message box)
            // 4096 = vbSystemModal - System modal (all applications wont work until the user responds to the message box)
            var buttonMode = buttons & 0xF000;

            switch (buttonCombination) {
                case 1: //vbOKCancel - OK (1) and Cancel (2) buttons
                    buttonObj[NSB._['OK']] = function() {this.close(); rtnFunc(1,'');}
                    buttonObj[NSB._['Cancel']] = function() {this.close(); rtnFunc(2,'');}
                    break;
                case 2: //vbAbortRetryIgnore - Abort (3), Retry (4), and Ignore (5) buttons
                    buttonObj[NSB._['Abort']] = function() {this.close(); rtnFunc(3,'');}
                    buttonObj[NSB._['Retry']] = function() {this.close(); rtnFunc(4,'');}
                    buttonObj[NSB._['Ignore']] = function() {this.close(); rtnFunc(5,'');}
                    break;
                case 3: //vbYesNoCancel - Yes (6), No (7), and Cancel (2) buttons
                    buttonObj[NSB._['Yes']] = function() {this.close(); rtnFunc(6,'');}
                    buttonObj[NSB._['No']] = function() {this.close(); rtnFunc(7,'');}
                    buttonObj[NSB._['Cancel']] = function() {this.close(); rtnFunc(2,'');}
                    break;
                case 4: //vbYesNo - Yes (6) and No (7) buttons
                    buttonObj[NSB._['Yes']] = function() {this.close(); rtnFunc(6,'');}
                    buttonObj[NSB._['No']] = function() {this.close(); rtnFunc(7,'');}
                    break;
                case 5: //vbRetryCancel - Retry (4) and Cancel (2) buttons
                    buttonObj[NSB._['Retry']] = function() {this.close(); rtnFunc(4,'');}
                    buttonObj[NSB._['Cancel']] = function() {this.close(); rtnFunc(2,'');}
                    break;
                default: //0 = vbOKOnly - OK (1) button only
                    buttonObj[NSB._['OK']] = function() {this.close(); rtnFunc(1,'');}
                    break;
            }
        } else {
            //not numeric so custom buttons
            var customButtonParams = buttons.split(";"); //separate button values from icon value
            var customButton = customButtonParams[0].split(","); //get button values

            var cbutton=[];
            for(var i=0; i<customButton.length; i++) {
                var appendType = (i==0?true:false); //insert first one then append others
                cbutton[i] = customButton[i]+": function() {this.close(); rtnFunc('"+customButton[i]+"','');}"
                if (i != customButton.length-1) { cbutton[i] += ','; }
            }
            var cbuttonObj='';
            for(i=0; i<customButton.length; i++) { cbuttonObj += cbutton[i]; }
            //window["buttonObj={"+cbuttonObj+"};"];
            eval("buttonObj={"+cbuttonObj+"};");
        }
        return buttonObj;
    }

    //parses icon types
NSB._parseIcon = function(buttons) {
        if (typeof(buttons)=="undefined") buttons=0;
        if (buttons == "") buttons = 0;
        //test if buttons parameter numeric
        var imgIcon = '';
        if (buttons == parseInt(buttons) && buttons == parseFloat(buttons)) {
            //determine button from vbscript value: modal 0xF000, default 0x0F00, icon 0x00F0, button 0x000F

            // 16 = vbCritical - Critical Message icon
            // 32 = vbQuestion - Warning Query icon
            // 48 = vbExclamation - Warning Message icon
            // 64 = vbInformation - Information Message icon
            imgIcon = buttons & 0x00F0;
        } else {
            //not numeric so custom buttons
            var customButtonParams = buttons.split(";"); //separate button values from icon value
            if (customButtonParams.length > 1) { imgIcon=customButtonParams[1]; } //icon can be vbScript type or custom path
        }

        imgIcon = imgIcon + ""; //force string conversion
        if (!imgIcon || imgIcon==null || imgIcon.replace(/\s+/g,'')=='') { imgIcon=''; }
        if (imgIcon.length > 2) {
            imgIcon=imgIcon.replace(/\'/g,"''").replace(/\"/g,'""');
            imgIcon="<img src='"+imgIcon+"' width='33' height='33' border='0'>";
            //source string of custom image
        } else {
            switch (imgIcon) { //must begin with "*" to denote system icon to calling function
                case '16': imgIcon="*criticalicon" + NSB.MsgBoxStyle; break;
                case '32': imgIcon="*questionicon" + NSB.MsgBoxStyle; break;
                case '48': imgIcon="*exclamationicon" + NSB.MsgBoxStyle; break;
                case '64': imgIcon="*informationicon" + NSB.MsgBoxStyle; break;
                default: imgIcon=""; break;
            }
        }
        return imgIcon;
    }

NSB._sqlError = function(lastSQL) {
        // returns an appropriate sqlError function give lastSQL
        return function(tx, err) {
            NSB.MsgBox(NSB._['SQLite error: {errmsg} (Code {errcode}) {sql}'].supplant({"errmsg": err.message, "errcode": err.code, "sql": lastSQL}));
            return false;
        };
    }

// Utility functions
function bindEventHandler(element, eventName, handler) {
	var evtSupport = ('on'+eventName) in element;
	if (!evtSupport) {
		var newElement = element;
		newElement.setAttribute(('on'+eventName),'return;');
		evtSupport = typeof newElement[eventName] == 'function';
		newElement = null;
	}
	if (evtSupport) {
		if (element.addEventListener) {
			element.addEventListener(eventName, handler, false);
		} else if (element.attachEvent) {
			element.attachEvent("on" + eventName, handler); //IE is onclick //jw
		} else {
			element["on" + eventName] = handler;
		}
	}
}

/**
 * The modal dialog class
 * @constructor
 */
function Dialog(options) {
    this.options = {
        width: 281,
        //top: 140,
        openOnCreate: true,
        destroyOnClose: true,
        escHandler: this.close
    };
    // Overwrite the default options
    for (var option in options) {
        this.options[option] = options[option];
    }
    // Create dialog dom
    this._makeNodes();
    if (this.options.openOnCreate) {
        this.open();
    }
}

Dialog.prototype = {
    /* handles to the dom nodes */
    header: null,
    body: null,
    icon: null,
    content: null,
    icontent: null,
    buttonbar: null,
    wrapper: null,
    _overlay: null,
    _wrapper: null,
    _zIndex: 0,
    _escHandler: null,

    // Shows the dialog
    open: function() {
        this._makeTop();
        var ws = this._wrapper.style;
        ws.left = (document.body.clientWidth - this.options.width) / 2 + 'px';
        ws.position="fixed";
        ws.top="60px";
        this._overlay.style.display = 'block';
        ws.display = 'block';
        this._wrapper.focus();

        if (this.options.focus) {
            var input = document.getElementById(this.options.focus);
            if (input) {
                input.focus();
            }
        }
    },

    close: function() {
        if (this.options.destroyOnClose) {
            this._destroy();
            NSB.alertDialog=null; //remove the alertDialog since object destroyed //jw
        } else {
            this._overlay.style.display = 'none';
            this._wrapper.style.display = 'none';
        }
    },

    addButtons: function(buttons, prepend) {
        var buttonbar = this.buttonbar;
        var buttonArray = this._makeButtons(buttons);
        var first = null;
        if (prepend && (first = buttonbar.firstChild) != null) {
            for (var i in buttonArray) {
                buttonbar.insertBefore(buttonArray[i], first);
            }
        } else {
            for (var i in buttonArray) {
                buttonbar.appendChild(buttonArray[i]);
            }
        }
    },

     //Makes the dom tree for the dialog
    _makeNodes: function() {
        if (this._wrapper || this.overlay) {
            return; // Avoid duplicate invocation
        }
        // Make overlay
        this._overlay = document.createElement('div');
        this._overlay.className = 'dialog-overlay' + NSB.MsgBoxStyle;
        document.body.appendChild(this._overlay);

        // build header display
        if (typeof this.options.title == 'string' && this.options.title != '') {
            var header = document.createElement('div');
            header.className = 'dialog-header' + NSB.MsgBoxStyle;
            if (this.options.title == ' ' && NSB.MsgBoxStyle=="-android") {
              header.className = 'none';}
            header.innerHTML = this.options.title;
            this.header = header;
        }

        //build icon display
        var icon = document.createElement('div');
        if (this.options.icon.substring(0,1)=='*') {
            icon.className = 'dialog-icon' + NSB.MsgBoxStyle;
            icon.id = this.options.icon.substring(1); //system icon
        } else {
            icon.className = 'dialog-icon-c';
            icon.innerHTML = this.options.icon; //custom icon
        }
        this.icon = icon;

        //build text display
        var content = document.createElement('div');
        if (this.options.icon != '') {
            content.className = 'dialog-itext' + NSB.MsgBoxStyle;
        } else {
            content.className = 'dialog-text' + NSB.MsgBoxStyle;
        }
        this.options.content=this.options.content.replace(/(\r\n)+/g,'<br>');
        this.options.content=this.options.content.replace(/(\n)+/g,'<br>');
        this.options.content=this.options.content.replace(/(\r)+/g,'<br>');
        content.innerHTML = this.options.content;
        this.content = content;

        // build button bar
        var buttonbar = document.createElement('div');
        var buttons = this._makeButtons(this.options.buttons);
        buttonbar.className = 'dialog-buttonbar' + NSB.MsgBoxStyle;
        for (var i=0; i<buttons.length; i++)
            buttonbar.appendChild(buttons[i]);
        this.buttonbar = buttonbar;

        var dialogContent = document.createElement('div')
        dialogContent.className = 'dialog-content' + NSB.MsgBoxStyle;
        if (this.options.icon != '') {
            dialogContent.appendChild(icon);
        }

        dialogContent.appendChild(content);
        if (this.options.icontent != '') {
            var icont = document.createElement('input');
            icont.id = '_nsbDialogBoxInput';
            icont.type = 'text';
            icont.value = this.options.icontent;
            icont.text = icont.value;
            if (navigator.appVersion.indexOf('Chrome')==-1) icont.style.width = '90%';
            dialogContent.appendChild(icont);
        }

        var wrapper = document.createElement('div');
        wrapper.className = 'dialog-wrapper' + NSB.MsgBoxStyle;
        wrapper.id = 'NSB_MsgBox';
        var ws = wrapper.style;
        ws.position = 'absolute';
        ws.display = 'none';
        ws.outline = 'none';

        if (this.header) {
            wrapper.appendChild(header);
        }
        wrapper.appendChild(dialogContent);
        wrapper.appendChild(buttonbar);

        if (this.options.escHandler) {
            wrapper.tabIndex = -1;
            this._onKeydown = this._makeHandler(function(e) {
                //if (!e) { //removed for Firefox
                //    e = window.event;
                //}
                if (e.keyCode && e.keyCode == 27) {
                    this.options.escHandler.apply(this);
                }
            }, this);
            bindEventHandler(wrapper, 'keydown', this._onKeydown);
        }
        this._wrapper = document.body.appendChild(wrapper);
    },

    _makeButtons: function(buttons) {
        var buttonArray = new Array();
        var buttonCount=0; //button counter
        var buttonTotal=0; //button total
        var buttonWidth=0; //button width
        for (var buttonText in buttons) { buttonTotal++; }

        for (var buttonText in buttons) {
            var button = document.createElement('button');
            button.className = 'dialog-buttonNoBorder' + NSB.MsgBoxStyle;
            if (NSB.MsgBoxStyle=='') {switch (buttonTotal) {
                case 1: buttonWidth='263px'; break;
                case 2: buttonWidth='128px'; break;
                case 3: buttonWidth='83px'; break;
                default: buttonWidth=parseInt(260/buttonTotal-1)+'px'; break; //compute button width
            	}
            } else {switch (buttonTotal) {
                case 1: buttonWidth='282px'; break;
                case 2: buttonWidth='141px'; break;
                case 3: buttonWidth='94px'; break;
                default: buttonWidth=parseInt(282/buttonTotal-1)+'px'; break; //compute button width
              }
            }
            button.style.width = buttonWidth;

			if (NSB.MsgBoxStyle=='') {
				if (buttonCount%2 == 0) { //even: 0, 2, 4, ...
					if (buttonTotal <=2) {
						button.style.margin = "0px 1px 0px 0px";
					} else {
						if (buttonCount == 0) {
							button.style.margin = "0px 2px 0px 1px";
						} else if (buttonCount == buttonTotal-1) {
							button.style.margin = "0px 0px 0px 2px";
						} else {
							button.style.margin = "0px 2px 0px 2px";
						}
					}
				} else {
					if (buttonTotal <=2) {
						button.style.margin = "0px 0px 0px 2px";
					} else {
						if (buttonCount == buttonTotal-1) {
							button.style.margin = "0px 0px 0px 1px";
						} else {
							button.style.margin = "0px 2px 0px 2px";
						}
					}
				}
			} else {button.style.margin="0px";}

            button.innerHTML = buttonText;
            bindEventHandler(button, 'click', this._makeHandler(buttons[buttonText], this));
            buttonArray.push(button);
            buttonCount++;
        }
        return buttonArray;
    },

    _makeHandler: function(method, obj) {
        return function(e) {
			//if (!e) { e = window.event; } //removed for FireFox
			if (e.stopPropagation) { //IE9 & Other Browsers
				if (e.keyCode==0) {e.preventDefault()};
				e.stopPropagation();
			} else { //IE8 and Lower
			  e.cancelBubble = true;
			}
            method.call(obj, e);
        }
    },

    _makeTop: function() {
        if (this._zIndex < Dialog.Manager.currentZIndex) {
            this._overlay.style.zIndex = Dialog.Manager.newZIndex();
            this._zIndex = this._wrapper.style.zIndex = Dialog.Manager.newZIndex();
        }
    },

    _destroy: function() {
        document.body.removeChild(this._wrapper);
        document.body.removeChild(this._overlay);
        this.header = null;
        this.body = null;
        this.icon = null;
        this.content = null;
        this.buttonbar = null;
        this.wrapper = null;
        this._overlay = null;
        this._wrapper = null;
    }
};

Dialog.Manager = {
    currentZIndex: 3000,
    newZIndex: function() {
        return ++this.currentZIndex;
    }
};

function browserWarningMessage(msg){
  if ((navigator.userAgent.indexOf('AppleWebKit') === -1) &&
      (navigator.userAgent.indexOf('Chrome') === -1) &&
      (navigator.userAgent.indexOf('MSIE 1') === -1) &&
      (navigator.userAgent.indexOf('rv:11.0') === -1) &&
      (navigator.userAgent.indexOf('BlackBerry') === -1) &&
      (navigator.userAgent.indexOf('Firefox') === -1) &&
      (navigator.userAgent.indexOf('RIM') === -1) &&
      (navigator.userAgent.indexOf('Tablet PC') === -1)) {
         alert(msg + ' (' + navigator.userAgent + ')');
         if(typeof(browserWarningMessageAfterScript)=='function') browserWarningMessageAfterScript();
  }
}

//Global code

if (typeof navigator !== 'undefined' && navigator.onLine && typeof window.applicationCache !== 'undefined'){
    //window.applicationCache.addEventListener("checking", NSB.oncache, false);
    window.applicationCache.addEventListener("downloading", NSB.oncache, false);
    window.applicationCache.addEventListener("noupdate", NSB.oncache, false);
    window.applicationCache.addEventListener("progress", NSB.oncache, false);
    window.applicationCache.addEventListener("updateready", NSB.oncache, false);
    window.applicationCache.addEventListener("cached", NSB.oncache, false);
    window.applicationCache.addEventListener("error", NSB.oncache, false);
    window.applicationCache.addEventListener("obsolete", NSB.oncache, false);
}

// globals and init
if (typeof document !== 'undefined') {
    var AppBuildStamp=document.getElementsByName("date")[0].content;
    var AppVersion=document.getElementsByName("version")[0].content;
    var AppLegalCopyright=document.getElementsByName("copyright")[0].content;
    var AppTitle=document.title;
    var NSBVersion=document.getElementsByName("generator")[0].content.split("$")[0];
    document.ontouchmove = function(e) { e.preventDefault(); };
    /mobile/i.test(navigator.userAgent) && !location.hash && setTimeout(function(){if (!pageYOffset) window.scrollTo(0,0)},500);
    NSB.MsgBoxStyle = '-android';

!function(){var L=$("<div style=\"position:fixed;top:0;left:0;height:100%;width:100%;background-color:#191919;background-position:center;z-index:2147483647;background-repeat:no-repeat;background-image:url('data:image/png;base64,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')\"></div>"),s=-2e9,F=function(){!$("#nsb"+s).length&&$.now()-s>12e4&&(s=$.now(),L[0].id="nsb"+s,$("body").append(L),$("#nsb"+s).click(function(){s=$.now(),$(this).remove()}))}
if(!/[bdghjkmnpqrvwxyz]{4}/.test($('meta[name="generator"]').attr("content").slice(-4))){var W=setInterval(F,500),n=window.clearInterval
window.clearInterval=function(L){L!=W&&n(L)},$(function(){F()})}}()

document.addEventListener(
  (document.hidden==undefined) ? "webkitvisibilitychange" : "visibilitychange",
  function(){if(typeof onvisibilitychange!=="undefined")
    onvisibilitychange(!(document.hidden || document.webkitHidden) )}, False);
}


// messages.js
// this file can be parsed as JSON if the first 16 lines are truncated

// make string interpolation possible for i18n
if (!String.prototype.supplant) {
    String.prototype.supplant = function (o) {
        return this.replace(/{([^{}]*)}/g,
            function (a, b) {
                var r = o[b];
                return typeof r === 'string' || typeof r === 'number' ? r : a;
            }
        );
    };
}

NSB._ =
{
  "Sunday": "Sunday",
  "Monday": "Monday",
  "Tuesday": "Tuesday",
  "Wednesday": "Wednesday",
  "Thursday": "Thursday",
  "Friday": "Friday",
  "Saturday": "Saturday",
  "Jan": "Jan",
  "Feb": "Feb",
  "Mar": "Mar",
  "Apr": "Apr",
  "May": "May",
  "Jun": "Jun",
  "Jul": "Jul",
  "Aug": "Aug",
  "Sep": "Sep",
  "Oct": "Oct",
  "Nov": "Nov",
  "Dec": "Dec",
  "January": "January",
  "February": "February",
  "March": "March",
  "April": "April",
  "May": "May",
  "June": "June",
  "July": "July",
  "August": "August",
  "September": "September",
  "October": "October",
  "November": "November",
  "December": "December",
  "SQLite not supported.": "SQLite not supported.",
  "Database name required.": "Database name required.",
  "Invalid database version: {version}": "Invalid database version: {version}",
  "Unknown error: {error}": "Unknown error: {error}",
  "SQLite error: {errmsg} (Code {errcode}) {sql}": "SQLite error: {errmsg} (Code {errcode}) {sql}",
  "Updating - Please wait": "Updating - Please wait",
  "Update Complete - Restarting.": "Update Complete - Restarting.",
  "Error: Index out of range: {array}[{index}]": "Error: Index out of range: {array}[{index}]",
  "Error: Must be true or false: {array}[{index}] {value}": "Error: Must be true or false: {array}[{index}] {value}",
  "Overlay() requires Sencha initialization.": "Overlay() requires Sencha initialization.",
  "Var keyword commented out--cannot be used as a variable!": "Var keyword commented out--cannot be used as a variable!",
  "Cannot use Var keyword as a variable!": "Cannot use Var keyword as a variable!",
  "{keyword} statement commented out!": "{keyword} statement commented out!",
  "No overwrite - new database is same version as old.": "No overwrite - new database is same version as old.",
  "No database write - database already exists.": "No database write - database already exists.",
  "OK": "OK",
  "Cancel": "Cancel",
  "Retry": "Retry",
  "Yes": "Yes",
  "No": "No",
  "Abort": "Abort",
  "Ignore": "Ignore",
  "Accept": "Accept",
  "Decline": "Decline",
  "Landscape not supported. Please rotate back.": "Landscape not supported. Please rotate back.",
  "Portrait not supported. Please rotate back.": "Portrait not supported. Please rotate back."
};

CanvasRenderingContext2D.prototype.addImage = function(filename, x, y, w, h, dx, dy, dw, dh) {
  var that = this,
      image = new Image();
  x = typeof x !== 'undefined' ? x : 0;
  y = typeof y !== 'undefined' ? y : 0;
  this.imgQueue = this.imgQueue || [];
  this.imgQueue.push({'image': image, 'x': x, 'y': y, 'w': w, 'h': h,
		      'dx': dx, 'dy': dy, 'dw': dw, 'dh': dh, 'loaded': false});
  image.src = filename;
  image.addEventListener('load', function() {
    var i, q0;
    for (i = 0; i < that.imgQueue.length; i++) {
      if (that.imgQueue[i]['image'] === image) {
        that.imgQueue[i]['loaded'] = true;
        while (i === 0 && that.imgQueue.length > 0 && that.imgQueue[0]['loaded']) {
          q0 = that.imgQueue[0];
          if (typeof q0['w'] === 'undefined') {
            that.drawImage(q0['image'], q0['x'], q0['y']);
          } else if (typeof q0['dx'] === 'undefined') {
            that.drawImage(q0['image'],
			   q0['x'], q0['y'], q0['w'], q0['h']);
          } else {
            NSB.drawImageIOSFix(that, q0['image'],
			   q0['x'], q0['y'], q0['w'], q0['h'],
			   q0['dx'], q0['dy'], q0['dw'], q0['dh']);
          }
          that.imgQueue.shift();
        }
        break;
      }
    }
  });
};

NSB.detectVerticalSquash = function(img) {
    var iw = img.naturalWidth, ih = img.naturalHeight;
    var canvas = document.createElement('canvas');
    canvas.width = 1;
    canvas.height = ih;
    var ctx = canvas.getContext('2d');
    ctx.drawImage(img, 0, 0);
    var data = ctx.getImageData(0, 0, 1, ih).data;
    var sy = 0;
    var ey = ih;
    var py = ih;
    while (py > sy) {
        var alpha = data[(py - 1) * 4 + 3];
        if (alpha === 0) {
            ey = py;
        } else {
            sy = py;
        }
        py = (ey + sy) >> 1;
    }
    var ratio = (py / ih);
    return (ratio===0)?1:ratio;
}

NSB.drawImageIOSFix = function (ctx, img, sx, sy, sw, sh, dx, dy, dw, dh) {
	if (sw === 0) sw = img.width;
	if (sh === 0) sh = img.height;
    var vertSquashRatio = NSB.detectVerticalSquash(img);
    ctx.drawImage(img, sx, sy, sw, sh, dx, dy, dw, dh / vertSquashRatio);
}

function iScrollClick(){
  // workaround click bug iscroll #674
  if (/iPhone|iPad|iPod|Macintosh/i.test(navigator.userAgent)) return false;
  if (/Chrome/i.test(navigator.userAgent)) return (/Android/i.test(navigator.userAgent));
  if (/Silk/i.test(navigator.userAgent)) return false;
  if (/Android/i.test(navigator.userAgent)) {
    var s=navigator.userAgent.substr(navigator.userAgent.indexOf('Android')+8,3);
    return parseFloat(s[0]+s[3]) < 44 ? false : true}
}
