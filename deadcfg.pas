program DeadCFG;
{$mode objfpc}{$H+}

uses
    utils,
    crt,
    sysutils;

type
    tGameSettings = record
        sysopname       : string[50];
        bbsname         : string[50];
        regcode         : string[52];
        playerfights    : integer;  { player fights allowed/day     }
        zkperday        : integer;  { zombie kills per day          }
        startingmoney   : integer;
    end;

var
    GameSettings        : tGameSettings;
    ch                  : char;
    fGSFile             : file of tGameSettings;

procedure getGameSettings();
begin
    Assign(fGSFile,'gamesettings.dat');
    Reset(fGSFile);
    Seek(fGSFile, 0);
    Read(fGSFile, GameSettings);
    close(fGSFile);    
end;
    
procedure header(Text: String);
begin
    Text := '`8.  .. ..-`7---`8-`7---=`%] `4' +
            Text +
            ' `%[`7=---`8-`7---`8-.. ..  .';
    writec(Text);
end;

begin
    // Check to see if there is a gamesettings.dat alread,
    // if so load that
    if fileExists('gamesettings.dat') then getGameSettings;
    repeat
        clrscr;
        header('Dead Configuration');
        writeln; writeln;
        lwrite('`%1`8. `7Sysop Name`8: `0'); writeln(GameSettings.sysopname);
        lwrite('`%2`8. `7BBS Name`8: `0'); writeln(GameSettings.bbsname);
        lwrite('`%3`8. `7RegCode`8: `0'); writeln(GameSettings.regcode);
        lwrite('`%4`8. `7Player Fights/Day`8: `0'); writeln(GameSettings.playerFights);
        lwrite('`%5`8. `7Zombi Fights/Day`8: `0'); writeln(GameSettings.zkperday);
        lwrite('`%6`8. `7Starting Money`8: `0'); writeln(GameSettings.startingmoney);
        
        lwrite('`%Q`8. `7Save & Quit');
        writeln;writeln;

        lwrite('`%Select Option`8: `$');
        
        repeat
            ch := upCase(ReadKey);        
        until ch in['1'..'9','Q'];

        gotoxy(1,wherey + 1);
        case ch of
            '1' : begin lwrite('`5Sysop''s Name`8: `$');readln(GameSettings.sysopname); end;
            '2' : begin lwrite('`5BBS Name`8: `$');readln(GameSettings.bbsname); end;
            '3' : begin lwrite('`5RegCode`8: `$');readln(GameSettings.regcode); end;
            '4' : begin lwrite('`5Player Fights`8: `$');readln(GameSettings.playerFights); end;
            '5' : begin lwrite('`5Zombie Kills`8: `$');readln(GameSettings.zkperday); end;
            '6' : begin lwrite('`5Starting Money`8: `$');readln(GameSettings.startingmoney); end;
        end;       
        
    until ch = 'Q';

    try
        Assign(fGSFile, 'gamesettings.dat');
        Rewrite(fGSFile);
        Write(fGSFile,GameSettings);
        Close(fGSFile);
    except
        LWrite('`4*** ERROR: Could not save data! Please contact author ***');
        halt;
    end;

    lwrite('`0Game settings saved successfully. Press enter to cont...');
    readln;
    
    
end.
