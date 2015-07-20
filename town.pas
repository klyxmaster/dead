procedure town();
begin
    repeat
        DoorDisplayFile('scrnz\ASHTOWN.ANS');  
        repeat
            ch := upCase(DoorReadKey);        
        until ch  in['N','T','S','I','W','A','B','C','P','D','#','L','Q'];
        
        Case ch of
            'S' : Begin stats; end;

            'Q' : Begin endGameRoll; end;
        end;{end case ch}
    until Ch = 'Q';
    DoorShutDown;
    halt;
end;
