procedure showNews();
var
    newsFile    : TextFile;
    aline       : String;
    
begin
     
    DoorClrScr;
    DoorGotoXY(1,2);
    DoorWriteC('`8...-`7--=] `% AshTown Local News `7[=--`8-...');
    DoorWriteLn;
    if FileExists('news.txt') then begin
        try
            assignFile(newsFile, 'news.txt');
            while not eof(newsFile) do begin
                readln(newsFile, aline);
                DoorWriteC(aline);
                DoorWriteLn;
            end;
            paused;
            
        except
            DoorLWrite('`4*** UNABLE TO GET NEWS FILE ***',True);
            paused;            
        end;
        
    end else begin
        DoorLWrite('`7No news today. ', True);
    end;
    paused;
end;
