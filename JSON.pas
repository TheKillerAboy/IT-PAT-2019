unit JSON;

interface

uses COMMONS, SysUtils ,Dialogs;

type
  DictType = (dtBool,dtString,dtArray,dtObject,dtNumber);

type
DictObject = class
  private
    function GETkeyTOvalue(Index:string):DictObject;
    function GETkeyITOvalue(Index:integer):DictObject;
  public
  constructor CreateFromString(sname,obj : string; typ : DictType);
  function asString():string;
  class function QuotedName(name:string):string;
  class function KeyValueString(key,value:string):string;
  class function BoolAsString(bool:boolean):string;
  property keyTOvalue[Index:string] :DictObject read GETkeyTOvalue;default;
  property keyTOvalue[Index:integer] :DictObject read GETkeyITOvalue;default;
  var
    toBool : boolean;
    toString : string;
    toArray : MArray<DictObject>;
    toObject : MDict<string,DictObject>;
    toNumber : real;
    toType : DictType;
    name : string;
end;

type
JSONParser = class
  public
    class function parseObjects(obj : string):MDict<string,string>;
    class function parseArray(obj : string):MArray<string>;
    class function parseString(obj : string):string;
    class function parseBool(obj : string):boolean;
    class function parseType(obj:string):DictType;
    class function parseSplit(obj,spliter:string):MArray<string>;
    class function JSONParse(json:string):DictObject;
    class function FileParse(Tfile:string):DictObject;
    class procedure JSONSave(obj:DictObject;sfile:string);
end;

implementation

{ DictObject }

function DictObject.asString: string;
var
  tmpObj : DictObject;
  tmpPair : MPair<string,DictObject>;
begin
   case toType of
    dtBool:result:=BoolAsString(toBool);
    dtString:result:=QuotedName(toString);
    dtArray:begin
       result:='[';
       for tmpObj in toArray.container do
        result:=result+tmpObj.asString+',';
       Delete(result,Length(result),1);
       result:=result+']';
    end;
    dtObject:begin
       result:='{';
       for tmpPair in toObject.pairs.container do
        result:=result+KeyValueString(tmpPair.key,tmpPair.value.asString)+',';
       Delete(result,Length(result),1);
       result:=result+'}';
    end;
    dtNumber:FloatToStr(toNumber);
  end;
end;

class function DictObject.BoolAsString(bool: boolean): string;
begin
  if bool then
    result:= 'true'
  else
    result:='false';
end;

constructor DictObject.CreateFromString(sname,obj : string; typ : DictType);
var
  pair:MPair<string,string>;
  value : string;
begin
  name := sname;
  toType := typ;
  case typ of
  dtObject:
  begin
    toObject :=  MDict<string,DictObject>.Create();
    for pair in JSONParser.parseObjects(obj).pairs.container do
    begin
      toObject.append(JSONParser.parseString(pair.key),DictObject.CreateFromString(pair.key,pair.value,JSONParser.parseType(pair.value)));
    end;
  end;
  dtArray:
  begin
    toArray :=  MArray<DictObject>.Create();
    for value in JSONParser.parseArray(obj).container do
      toArray.append(DictObject.CreateFromString('',value,JSONParser.parseType(value)));
  end;
  dtBool:
    toBool := JSONParser.parseBool(obj);
  dtString:
    toString := JSONParser.parseString(obj);
  dtNumber:
    toNumber := StrToFloat(obj);
  end;
end;

function DictObject.GETkeyITOvalue(Index: integer): DictObject;
begin
  result:=toArray[Index];
end;

function DictObject.GETkeyTOvalue(Index: string): DictObject;
begin
  result:=toObject[Index];
end;

class function DictObject.KeyValueString(key, value: string): string;
begin
  result:=QuotedName(key)+':'+value;
end;

class function DictObject.QuotedName(name: string): string;
begin
  result:='"'+name+'"';
end;

{ JSONParser }

class function JSONParser.FileParse(Tfile: string): DictObject;
var
sline,ssingle:string;
TF:textfile;
i:integer;
begin
  AssignFile(TF,TFile);
  ssingle:='';
  Reset(TF);
  while not eof(TF) do
  begin
    Readln(TF,sline);
    ssingle:=ssingle+sline;
  end;
  CloseFile(TF);
  ssingle:=StringReplace(ssingle,#32,'',[rfReplaceAll]);
  ssingle:=StringReplace(ssingle,#9,'',[rfReplaceAll]);
  ssingle:=StringReplace(ssingle,#10,'',[rfReplaceAll]);
  result:=JSONParse(ssingle);
end;

class procedure JSONParser.JSONSave(obj: DictObject; sfile: string);
var
sline,ssingle:string;
TF:textfile;
i:integer;
begin
  AssignFile(TF,sfile);
  Rewrite(TF);
  Writeln(TF,obj.asString);
  CloseFile(TF);
end;

class function JSONParser.JSONParse(json: string): DictObject;
begin
  result:=DictObject.CreateFromString('',json,dtObject);
end;

class function JSONParser.parseArray(obj: string): MArray<string>;
begin
  obj := Copy(obj,2,LEngth(obj)-2);
  result:= parseSplit(obj,',');
end;

class function JSONParser.parseBool(obj: string): boolean;
begin
  result:= LowerCase(obj) = 'true';
end;

class function JSONParser.parseObjects(obj: string): MDict<string, string>;
var
objects : MArray<string>;
objt:string;
subobj : MArray<string>;
begin
  obj := Copy(obj,2,LEngth(obj)-2);
  objects := parseSplit(obj,',');
  result :=  MDict<string, string>.Create();
  for objt in objects.container do
  begin
    subobj := parseSplit(objt,':');
    result.append(subobj[0],subobj[1]);
  end;
end;

class function JSONParser.parseSplit(obj, spliter: string): MArray<string>;
var
i,ioff,off,len:integer;
begin
  result:=MArray<string>.Create();
  off := 0;
  ioff := 1;
  len := Length(spliter);
  for i := 1 to Length(obj) do
  begin
    if (obj[i] = '{') or (obj[i] = '[') then
      off := off + 1
    else if (obj[i] = '}') or (obj[i] = ']') then
      off := off - 1
    else if (Copy(obj,i,len) = spliter) and (off = 0) then
    begin
      result.append(Copy(obj,ioff,i-ioff));
      ioff := i + len;
    end;
  end;
  result.append(Copy(obj,ioff,i-ioff));
end;

class function JSONParser.parseString(obj: string): string;
begin
  result:=Copy(obj,2,LEngth(obj)-2);
end;

class function JSONParser.parseType(obj: string): DictType;
begin
  if obj[1] = '{' then
    result:= dtObject
  else if obj[1] = '[' then
    result:=dtArray
  else if (LowerCase(obj) = 'true') or (LowerCase(obj) = 'false') then
    result:=dtBool
  else if obj[1] = '"' then
    result:=dtString
  else
    result:=dtNumber;
end;

end.
