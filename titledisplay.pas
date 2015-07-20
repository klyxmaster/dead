procedure displayTitle();

begin
    
    showAnsi('title'); 
        
    DoorGotoXY(5, 15); DoorWrite('`8[`$E`8]`7nter Wasteland');
    DoorGotoXY(5, 16); DoorWrite('`8[`$A`8]`7bout');
    DoorGotoXY(5, 17); DoorWrite('`8[`$L`8]`7ist Hunters');
    DoorGotoXY(5, 18); DoorWrite('`8[`$Q`8]`7uit ');

    DoorGotoXY(5, 20); DoorWrite('`%O`@pti`4on? `8[`$E`7]`8: ');
    DoorGotoXY(5, 22);

    if Registered then begin
        DoorWriteC('`4DEAD `2is registered to `0' + GameSysop);DoorGotoXY(5, 23);
        DoorWriteC('`2of `0' + GameSettings.bbsname);DoorGotoXY(5, 24);       
    end
        
    else begin        
        DoorWriteC('`4DEAD is NOT registered');DoorGotoXY(5, 23);
        DoorWriteC('`4Game Features Limited');DoorGotoXY(5, 24);
    end;
   
doorwrite(chr(176));
    
    
end;
