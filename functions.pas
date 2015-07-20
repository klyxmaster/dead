{
* This will be turned into a unit once i have all the routines I want,
* or at least most of them. this is old PHP habit here.
* }


{
* Used mostly for quitting game
* Shows just the counter from "Seconds"
* to 0.
* Counter will be placed as x,y
* }
procedure countDownDelay(Seconds, X, Y: Integer);
var
    i: integer;
begin
    for i := Seconds downto 1 do
    begin
        DoorGotoXY(x,y);
        DoorWrite( intToStr(i) );
        delay(1000);
    end;
end;

procedure paused();
begin
    DoorGotoY(25);
    DoorWriteC('`8..-`7-=] `%P`@r`4ess `%A`@n`4ykey `@t`4o `%c`@o`4ntinue`7 [=-`8-..');
    repeat ch := upCase(DoorReadKey); until ch > '';
end;

function FileCopy(Source, Target: string): boolean;
// Copies source to target; overwrites target.
// Caches entire file content in memory.
// Returns true if succeeded; false if failed.
var
  MemBuffer: TMemoryStream;
begin
  result := false;
  MemBuffer := TMemoryStream.Create;
  try
    MemBuffer.LoadFromFile(Source);
    MemBuffer.SaveToFile(Target); 
    result := true
  except
    //swallow exception; function result is false by default
  end;
  // Clean up
  MemBuffer.Free
end;

{ lazy, using html markup method LOL }
procedure li(HLetter, txtOption: String);
begin
    DoorLWrite('`7[`$' + HLetter + '`7]`4' + txtOption, True);
end;

procedure header(Text: String);
begin
    Text := '`8.  .. ..-`7---`8-`7---=`%] `4' +
            Text +
            ' `%[`7=---`8-`7---`8-.. ..  .';
    DoorWriteC(Text);
end;

// DRAWS ANSI SCREEN
procedure showAnsi(AnsiScreenFile: String);
var
    TAnsi           : TextFile;
    aline           : ansistring;
    s: widestring;
begin    
    if FileExists('scrnz\' + AnsiScreenFile + '.ans') then begin
        assignFile(TAnsi, 'scrnz\' + AnsiScreenFile + '.ans');
        reset(TAnsi);    
        while not eof(TAnsi) do begin
            readln(TAnsi, aline);
            s := AnsiString(aline);
            DoorWriteLn(s);
        end;       
    end;
end;

