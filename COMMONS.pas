unit COMMONS;

interface

type
  MArray<T> = class
  private
    function FgetIndex(Index:integer):T;   
    function getLength:integer; 
    function getCIndex():T;
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

function MArray<T>.getCIndex: T;
begin
  result:= container[cIndex];
end;

function MArray<T>.getLength: integer;
begin
  result:= Length(container);
end;

end.
