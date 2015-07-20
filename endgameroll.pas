procedure endGameRoll();
begin
    DoorClrScr;
    DoorGotoXY(1,1);
    DoorWriteC('`#D`5EAD `8- `7Is FREE!!!');
    DoorGotoXY(1,2);
    DoorWriteC('`7To Get your customized copy`7 for your BBS..');
    DoorGotoXY(1,3);
    DoorWriteC('`7email`8: `$klyxmaster@gmail.com');
    DoorGotoXY(1,4);
    DoorWriteC('`7Thank you for playing...');
    DoorGotoXY(1,8);
    DoorWriteC('`7Closing Game Door. One Moment...');                    
                    
    countDownDelay(5,57,8);
    GameOver := True;
    DoorGotoXY(1,15);
end;
