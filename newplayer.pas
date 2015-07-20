procedure newPlayer();
var
    alias           : string;       { store current alias               }    
    FileErr         : integer;      { file error trap                   }
    fileSZ          : integer;      { size of file                      }
    playerFile      : file of tPlayer;
    player          : tPlayer;
    
    
begin
    alias := DoorDropInfo.Alias;
    DoorClrScr;
    DoorWrite('`4Welcome to `%Ashtown `@' + alias);
    DoorWrite('`4I am sure you are eager to get into the frey, however,');
    DoorWrite('`4you will need to first fill out our registration form`8.');
    DoorWrite('`4So I will need to ask you a few questions`8:');
    DoorWriteLn;
    DoorWrite('`4Before we start, what is your name? Never seen you before.`n ' +
        crlf + 'If you like the name shown just press `@"Esc"`4');
    DoorWrite('Enter your wasteland name: ');        
    player.username := DoorInput( Alias, AllowedStr, #0, 20, 20, 127 );
    DoorWriteLn;
    
    DoorWrite('`@' + player.username + ' `4it is`8.  `4Now the embarrasing question `@*cough*`4' + crlf +
                'Are you a `7[`$0`7]`4Male or a `7[`$1`7]`4Female? ');    
    player.sex := StrToInt(DoorInput( '', '01', #0, 1, 1, 127 ));
    DoorClrScr;
    DoorWrite('`4What sort of skills do you posses`8?');
    DoorWriteLn;
    DoorWriteLn('`$RoughNeck');DoorWriteLn;
    DoorWrite('`@Most my days were doing odd body guard jobs, bouncer even a few stretches ' +
                'in the pen. I can hold my own, can even take a few hits I have no problems ' +
                'with the zombie riff-raff ');                
    DoorWriteLn('`$Medical');  DoorWriteLn;  
    DoorWrite('`@Grad student of University of Medical School. Helping the Rough Necks and ' +
                'Wanderers, I was able to learn to take care of myself after the apocolypse.' +
                'But tending to the wounded is mostly my thing. I can fix up anyone!');

    DoorWriteLn('`4Wanderer');DoorWriteLn;
    DoorWrite('`@Don''t have the smarts of the Med dude, and definately not built like ' +
                'Rough Necks but I know how to fight. I''m quick and silent. I''ve got ' +
                'a knack for hitting sofast, that all them peole see are zombies fallin ' +
                'down for no reason. Ya Im quick and deadly!');
    DoorWriteLn;
    DoorWrite('`$1`8.`4 Rough Neck    [Tank]');DoorWriteLn;
    DoorWrite('`$2`8.`4 Medical       [Healer]');DoorWriteLn;
    DoorWrite('`$3`8.`4 Wanderer      [DPS]');DoorWriteLn;
    
    DoorWrite('`4Enter your trait: ');
    player.classId := StrToInt(DoorInput( '', '123', #0, 1, 1, 127 ));

    // See if a player file exists, if not start one.
    Assign(playerFile, 'users.dat');
    if FileExists('users.dat') then
        Reset(playerFile)
    else
        Rewrite(playerFile);

    try  

    fileSz   := round(FileSize(playerFile) / sizeOf(tPlayer));       // how big is this?
    Seek(playerFile, fileSz);             // move ptr to end

    // Default the rest of player info
    with player do
    begin
        money               := GameSettings.startingmoney;
        bank                := 0;
        classxp             := 0;
        classlevel          := 1;
        attack              := 0;
        defense             := 0;
        xp                  := 0;
        hp                  := 20;
        maxhp               := 20;
        totalzkills         := 0;
        level               := 1;
        alive               := 1;
        online              := 1;
        seentrainer         := 0;
        seenboss            := 0;
        zkperday            := GameSettings.zkperday;
        foundsewer          := False;
        playedjukebox       := False;
        mingled             := False;
    end;
    write(playerFile, player);
    close(playerFile);
    except
        on E:Exception do
        begin
        DoorWriteLn('could not complete because ' + E.message);
        DoorShutDown;
        end;
    end;
    
    {
    ini := TINIFile.Create('users\' + Alias + '.ini');
    ini.WriteString('userinfo','username',username);
    ini.WriteString('userinfo','sex',sex);
    ini.WriteString('userinfo','classId',trait);
    ini.Free;
    * }
    DoorClrScr;
    DoorWrite('`7OK, your set. I''ve filed you application. YOu can ' +
                'come and go as you please. Good Luck');
    paused();
end;
