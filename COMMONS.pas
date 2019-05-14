unit COMMONS;

interface

type common<T> = class
  class procedure append(var arr: TArray<T>; value : T);
  class procedure remove(var arr: TArray<T>; index : integer);
end;
implementation

{ common<T> }

class procedure common<T>.append(var arr: array of T; value: T);
begin
  SetLength(arr,Length(arr)+1);
  arr[Length(arr)] := value;
end;

class procedure common<T>.remove(var arr: TArray<T>; index: integer);
var
i:integer;
begin
  for I := index to Length(arr) - 1 do
  begin
    arr[i] := arr[i+1];
  end;
  SetLength(arr,Length(arr)-1);
end;

end.
