projs = ReadFinishedProj(0); Np = length(projs);
mbrs = ReadMemberInfo(0);    Nm = length(mbrs);
cities = China('4cities',0);

Dpm = sqrt( ([projs.x]' - [mbrs.x]).^2 + ([projs.y]' - [mbrs.y]).^2 );
%Dpm = abs([projs.x]' - [ mbrs.x]) + abs([projs.y]' - [ mbrs.y]);


Dpp = sqrt( ([projs.x]' - [projs.x]).^2 + ([projs.y]' - [projs.y]).^2 );
%Dpp = abs([projs.x]' - [projs.x]) + abs([projs.y]' - [projs.y]);



