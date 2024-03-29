unit COMMONS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Generics.Defaults,StrUtils;

type
  CompairFunc<K> = reference to function(value1,value2:K):boolean;
  ConvertFunc<F,T> = reference to function(value:F):T;

type
  MArray<T> = class
  private
    function FgetIndex(Index:integer):T;
    function getLength:integer;
    procedure WtoIndex(index:integer;value:T);
  public
    var
      container:TArray<T>;
      cIndex:integer;
    constructor Create();overload;
    constructor Create(pre:TArray<T>);overload;
    constructor Create(pre:array of T);overload;
    procedure append(value:T);
    procedure delete(index:integer);
    procedure cIndexRotate;
    property getIndex[Index : integer] : T read FgetIndex write WtoIndex;default;
    property len:integer read getLength;
    function getCIndex():T;
    function find(value:T):integer;
    function findIf(value:T;compair:CompairFunc<T>):integer;
    class function Equal(val1, val2: T): boolean;
    procedure clear;
  end;


type
  MPair<TKey,TValue> = class
  public
  constructor Create(okey:TKey;ovalue:TValue);
  var
    key:TKey;
    value:TValue;
  end;

type
  MDict<TKey,TValue> = class
    private
    function getLength:integer;
    function GETkeyTOvalue(index:TKey): TVAlue;
    public
      constructor Create();
      property len:integer read getLength;
      procedure append(key:TKey;value:TValue);overload;
      procedure append(pair:MPair<TKey,TValue>);overload;
      procedure delete(index:integer);
      property keyTOvalue[Index:TKey] :TValue read GETkeyTOvalue;default;
      function valueTOkey(index:TValue): TKey;
      procedure Clear;
      var
        keys : MArray<TKey>;
        values : MArray<TValue>;
        pairs : MArray<MPair<TKey,TValue>>
  end;

type
  Parser = class
    public
      class function parse(line,spliter:string):MArray<string>;
      class function getExtention(sFilename:string):string;
  end;

type
  Converter<F,T> = class
    public
      class function convert(input:MArray<F>;conv:ConvertFunc<F,T>):MArray<T>;
  end;

type
  Strings = class
  public
    class function Equivalent(val1,val2:string):boolean;
    class function EquivalentV(val1,val2:Variant):boolean;
  end;

implementation

constructor MArray<T>.Create();
begin
  container := TArray<T>.Create();
  cIndex := 0;
end;

procedure MArray<T>.append(value: T);
begin
  SetLength(container,len+1);
  container[len-1]:=value;
end;

procedure MArray<T>.cIndexRotate;
begin
  Inc(cIndex);
  if cIndex >= len then
    cIndex := 0;
end;

procedure MArray<T>.clear;
begin
  SetLength(container,0);
end;

constructor MArray<T>.Create(pre:TArray<T>);
begin
  inherited Create;
  container := pre;
end;

function MArray<T>.FgetIndex(Index: integer): T;
begin
  result:=container[Index];
end;

function MArray<T>.find(value: T): integer;
var
i:integer;
begin
  result:=findIf(value,Equal);
end;

function MArray<T>.findIf(value: T; compair: CompairFunc<T>): integer;
var
i:integer;
begin
  for i := 0 to len - 1 do
  begin
    if compair(container[i],value) then
    begin
      result:=i;
      exit;
    end;
  end;
  result:=-1;
end;

function MArray<T>.getCIndex: T;
begin
  result:= container[cIndex];
end;

function MArray<T>.getLength: integer;
begin
  result:= Length(container);
end;

procedure MArray<T>.WtoIndex(index: integer; value: T);
begin
  container[index] := value;
end;

{ MDict<Key, Value> }

procedure MDict<TKey, TValue>.append(key: TKey; value: TValue);
begin
  keys.append(key);
  values.append(value);
  pairs.append(MPair<TKey,TValue>.Create(key,value));
end;

procedure MDict<TKey, TValue>.append(pair: MPair<TKey, TValue>);
begin
  append(pair.key,pair.value);
end;

procedure MDict<TKey, TValue>.Clear;
begin
  keys.clear;
  values.clear;
end;

constructor MDict<TKey, TValue>.Create;
begin
  keys := MArray<TKey>.Create();
  values := MArray<TValue>.Create();
  pairs := MArray<MPair<TKey,TValue>>.Create();
end;

procedure MDict<TKey, TValue>.delete(index: integer);
begin
  keys.delete(index);
  values.delete(index);
  pairs.delete(index);
end;

class function MArray<T>.Equal(val1, val2: T): boolean;
var
  lComparer: IEqualityComparer<T>;
begin
  lComparer := TEqualityComparer<T>.Default;
  result:= lComparer.Equals(val1,val2);
end;

function MDict<TKey, TValue>.GETkeyTOvalue(index: TKey): TVAlue;
begin
  result:=values[keys.find(index)];
end;

function MDict<TKey, TValue>.getLength: integer;
begin
  result:=keys.len;
end;

function MDict<TKey, TValue>.valueTOkey(index: TValue): TKey;
begin
  result:=keys[values.find(index)];
end;

{ Converter<F, T> }

class function Converter<F, T>.convert(input: MArray<F>;
  conv: ConvertFunc<F, T>): MArray<T>;
var
value:F;
begin
  result := MArray<T>.create();
  for value in input.container do
    result.append(conv(value));
end;

{ Parser }

class function Parser.getExtention(sFilename: string): string;
begin
  result:= Copy(sFilename,Pos('.',sFilename)+1,Length(sFilename));
end;

class function Parser.parse(line, spliter: string): MArray<string>;
var
  iPos,iLen : integer;
begin
  iLen := Length(spliter);
  iPos := Pos(spliter,line);
  result:=MArray<string>.Create();
  while iPos <> 0 do
  begin
    result.append(Copy(line,1,iPos-1));
    Delete(line,1,iPos+iLen-1);
    iPos := Pos(spliter,line);
  end;
    result.append(line);
end;

constructor MArray<T>.Create(pre: array of T);
var
val:T;
begin
  inherited Create;
  for val in pre do
    append(val);
end;

procedure MArray<T>.delete(index: integer);
var
new_array:TArray<T>;
i : integer;
begin
  new_array:=TArray<T>.Create();
  SetLength(new_array,len-1);
  for I := 0 to index - 1 do
    new_array[i] := container[i];
  for I := index+1 to len - 1 do
    new_array[i-1] := container[i];
  container := new_array;
end;

{ MPair<TKey, TValue> }

constructor MPair<TKey, TValue>.Create(okey: TKey; ovalue: TValue);
begin
  key := okey;
  value := ovalue;
end;

{ Strings }

class function Strings.Equivalent(val1, val2: string): boolean;
begin
  result:=ContainsText(val1,val2);
end;

class function Strings.EquivalentV(val1, val2: Variant): boolean;
begin
  result:=ContainsText(val1,val2);
end;

end.
