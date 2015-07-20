procedure newPlayer();
var
    username        : string;       { the actual name player chooses    }
    sex             : String;       { 0 = male, 1 = female              }
    trait           : string;       { what class player chooses         }    
    alias           : string;       { store current alias               }
    fileCopied      : boolean;      { for checking for copying error    }
    
begin
    alias := DoorDropInfo.Alias;
    DoorClrScr;
    DoorLWrite('`4Welcome to `%Ashtown `@' + alias, True);
    DoorLWrite('`4I am sure you are eager to get into the frey, however,',True);
    DoorLWrite('`4you will need to first fill out our registration form`8.',True);
    DoorLWrite('`4So I will need to ask you a few questions`8:',True);
    DoorWriteLn;
    DoorLWrite('`4Before we start, what is your name? Never seen you before.`n ' +
        crlf + 'If you like the name shown just press `@"Esc"`4',True);
    DoorWrite('Enter your wasteland name: ');        
    username := DoorInput( Alias, AllowedStr, #0, 20, 20, 127 );
    DoorWriteLn;
    
    DoorLWrite('`@' + username + ' `4it is`8.  `4Now the embarrasing question `@*cough*`4' + crlf +
                'Are you a `7[`$0`7]`4Male or a `7[`$1`7]`4Female? ', False);    
    sex := DoorInput( '', '01', #0, 1, 1, 127 );
    DoorClrScr;
    DoorLWrite('`4What sort of skills do you posses`8?',True);
    DoorWriteLn;
    li('R', 'ough Neck');
    DoorLWrite('`@Most my days were doing odd body guard jobs, bouncer even a few stretches ' +
                'in the pen. I can hold my own, can even take a few hits I have no problems ' +
                'with the zombie riff-raff ',True);                
    DoorWriteLn; li('M', 'edical Field');    
    DoorLWrite('`@Grad student of University of Medical School. Helping the Rough Necks and ' +
                'Wanderers, I was able to learn to take care of myself after the apocolypse.' +
                'But tending to the wounded is mostly my thing. I can fix up anyone!',True);

    DoorWriteLn; li('W', 'anderer');
    DoorLWrite('`@Don''t have the smarts of the Med dude, and definately not built like ' +
                'Rough Necks but I know how to fight. I''m quick and silent. I''ve got ' +
                'a knack for hitting sofast, that all them peole see are zombies fallin ' +
                'down for no reason. Ya Im quick and deadly!',True);
    DoorWriteLn;
    DoorLWrite('`$1`8.`4 Rough Neck    [Tank]',True);
    DoorLWrite('`$2`8.`4 Medical       [Healer]',True);
    DoorLWrite('`$3`8.`4 Wanderer      [DPS]',True);
    
    DoorLWrite('`4Enter your trait: ', False);
    trait := DoorInput( '', '123', #0, 1, 1, 127 );

    {
    * Save it in user/[alias].ini
    * To prevent funny issues with file name, make sure that allowed
    * characters in the input, do not allow spaces but instead
    * underscores
    *
    * To prevent dupes, I use the Alias from the drop file. BBS catches
    * that at registration.
    *}
    fileCopied := FileCopy('users\template.ini', 'users\' + Alias + '.ini');
    
    { Hopefully nothing goes wrong, but just in case - trap it }
    if fileCopied = False then begin
        DoorLWrite('`4*** ERROR CREATING PLAYER FILE ***', True);
        paused;
        DoorShutDown;
        Halt;
    end;

    ini := TINIFile.Create('users\' + Alias + '.ini');
    ini.WriteString('userinfo','username',username);
    ini.WriteString('userinfo','sex',sex);
    ini.WriteString('userinfo','classId',trait);
    ini.Free;
    DoorClrScr;
    DoorLWrite('`7OK, your set. I''ve filed you application. YOu can ' +
                'come and go as you please. Good Luck', True);
    
    paused();
end;
