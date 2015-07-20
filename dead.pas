{
   DEAD.PAS
   
   Copyright 2015 Klyxmaster <klyxmaster@gmail.com>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}

{
* L.O.R.D. style game in a post apocolyptic zombie style
* }
program dead;
{$mode objfpc}{$H+}
{$CODEPAGE UTF8} 
uses 
    Door,
    Dos,    
    VideoUtils,
    MD5,
    StringUtils,   
    Classes,
    Crt,
    StrUtils,    
    INIFiles,           { working with ini files                        }    
    xCrypt,             { some encryption - not public                  }   
    SysUtils;

const
    AllowedStr  = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_';
    Crlf        = chr(10)+chr(13);
    
    { Do not mess with this. Doing so, and most the app will fail       }
    CryptKey    = 'CKb2#kKptS#xA4WzMJ!vHe4Fr7&67nc8';

// have not decided which way to store data yet...      
type
    tPlayer = record
        username        : String[50];
        sex             : byte;
        money           : longint;  { arbitrary - call it anything  }
        bank            : longint;
        classid         : byte;
        classlevel      : integer;
        classxp         : longint;
        weaponid        : integer;
        armorid         : integer;  { not "armour" = love           }
        attack          : integer;
        defense         : integer;
        hp              : integer;
        maxhp           : integer;
        totalzkills     : integer;  { total zombie kills            }
        xp              : longint;
        level           : integer;
        alive           : byte;
        online          : byte;
        seentrainer     : byte;
        seenboss        : byte;
        playerfights    : integer;  { playerfights left             }
        zkperday        : integer;  { zombie kills per day left     }
        foundsewer      : boolean;  { hidden outpost                }
        mingled         : boolean;  { interacted with patrons       }
        playedjukebox   : boolean;  { sometimes can be motivational }
    end;

    tGameSettings = record
        sysopname       : string[50];
        bbsname         : string[50];
        regcode         : string[52];
        playerfights    : integer;  { player fights allowed/day     }
        zkperday        : integer;  { zombie kills per day          }
        startingmoney   : integer;
    end;
    
        

var

    ch          : char;
    Alias       : String;           { remember user alias           }    
    GameOver    : Boolean;          { is player done playing        }
    
    GameSysop   : String;           { Name of sysop game owner      }        
    GameEncSysop: String;           { coded sysop string            }    
    Registered  : Boolean;          { Is game registered            }
    RegCode     : String;           { code found in gamesettings.ini}

    GameSettings: tGameSettings;
    player      : tPlayer;
    playerFile  : File Of tPlayer;



{
* BREAK PROGRAM DOWN TO FILE MODULES.
* MUCH EASIER TO WORK WITH :-)
* }

{$I about                       }   { Game About/Credits            }
{$I functions                   }   { various routines, old habbits }
{$I stats                       }   { player stats                  }
{$I titledisplay                }   { title related                 }
{$I newplayer                   }   { signing up new players        }
{$I endgameroll                 }   { end game screen/credits       }
{$I shownews                    }   { news page der!                }
{$I town                        }   { all the fun is here           }


procedure playGame();
begin
    

    // The following: showNews and Stats are always shown
    // before user logs on
    // TODO: Give sysop option to show news and stats at beginning
    showNews;
    //displayStats;
    // LOOP HERE ------
    Repeat
        Town;
        // Loop until player quits ----

    
    
    Until GameOver = True;

    
    endGameRoll;
    ch := 'Q'; // kinda stupid here, i'll fix later
end;

BEGIN   
    DoorStartUp;

    // see if game has been setup
    if not fileExists('gamesettings.dat') then begin
        DoorLWrite('`5Cannot start game. Please inform sysop to finish installing', True);
        paused;
        DoorShutDown;
        exit;
    end else getGameSettings;

    
    CursorHide;    
    // TURN ON LORD WRITE CODES "`"
    // **TODO: REMOVE ALL THE DOORLWRITE since sethwrite works as well
    DoorSession.SethWrite := true;

    GameOver := False;
    // Who is on
    Alias := DoorDropInfo.Alias;
    // Load up ini file location of user
    //ini     := TINIFile.Create('users\' + Alias + '.ini');
    // Load up game settings   
    //GameIni := TINIFile.Create('GAMESETTINGS.INI');
   

    // Check if registered
    Registered  := False;
    GameSysop   := GameSettings.sysopname;   
    RegCode     := GameSettings.regcode;        
    GameEncSysop := encode(GameSysop , CryptKey);    
    if RegCode = GameEncSysop then Registered := True;
    
    repeat
    
        displayTitle();       
        repeat
            ch := upCase(DoorReadKey);        
        until ch  in['E','A','L','Q'];
        
        Case ch of
            'E' : Begin
                    {
                    * First we'll need to check to see if they've
                    * been here before. If not we'll set them up
                    * and send them to playGame, other send them
                    * straight there.
                    * }
                    if playerExists(DoorDropInfo.Alias) then                        
                        playGame                        
                    else begin
                        newplayer;
                        playGame;
                    end;// if
                    
                    end;

            'A' : Begin        
                    About();
                    end;

            'L' : Begin
                end;

            'Q' : Begin
                    endGameRoll;
                end;
        end;{end case ch}
    until Ch = 'Q';
    
    DoorShutDown;
    
END.

