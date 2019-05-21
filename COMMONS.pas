unit COMMONS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  CompairFunc<K> = reference to function(value1,value2:K):boolean;

type
  MArray<T> = class
  private
    function FgetIndex(Index:integer):T;
    function getLength:integer;
  public       
    var
      container:TArray<T>;
      cIndex:integer;  
    constructor Create();overload;
    constructor Create(pre:TArray<T>);overload;
    procedure append(value:T);
    procedure cIndexRotate;
    property getIndex[Index : integer] : T read FgetIndex;default;
    property len:integer read getLength;
    function getCIndex():T;
    function find(value:T):integer;
    function findIf(value:T;compair:CompairFunc<T>):integer;
  end;

type
  MDict<TKey,TValue> = class
    private
    function getLength:integer;
    function GETkeyTOvalue(index:TKey): TVAlue;
      var
        keys : MArray<TKey>;
        values : MArray<TValue>;
    public
      constructor Create();
      property len:integer read getLength;
      procedure append(key:TKey;value:TValue);
      property keyTOvalue[Index:TKey] :TValue read GETkeyTOvalue;
      function valueTOkey(index:TValue): TKey;
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

constructor MArray<T>.Create(pre:TArray<T>);
begin
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
  for i := 0 to len - 1 do
  begin
    if container[i] = value then
    begin
      result:=i;
      exit;
    end;
  end;
  result:=-1;
end;

function MArray<T>.findIf(value: T; compair: CompairFunc<T>): integer;
var
i:integer;
begin
  for i := 0 to len - 1 do
  begin
    if compair(value,container[i]) then
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

{ MDict<Key, Value> }

procedure MDict<TKey, TValue>.append(key: TKey; value: TValue);
begin
  keys.append(key);
  values.append(value);
end;

constructor MDict<TKey, TValue>.Create;
begin
  keys := MArray<TKey>();
  values := MArray<TValue>();
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

end.
