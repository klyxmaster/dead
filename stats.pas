procedure stats();
begin
    DoorDisplayFile('scrnz\stats.ans');
    DoorTextColour(14);
    DoorGotoXY(17,9); DoorWrite(player.username);
    DoorGotoXY(17,10);DoorWrite(inttoStr(player.xp));

    DoorGotoXY(58,9); DoorWrite(inttoStr(player.hp) + '/' + intToStr(player.maxhp));
    DoorGotoXY(58,10);DoorWrite(intToStr(player.level));
    paused;
end;
