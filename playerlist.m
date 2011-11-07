function [ Liste ] = playerlist(player, maxplayers)
%PLAYERLIST: imports the players
%Input: "player": A string, which is equal to the Name of the Players
%Input: "maxplayers" the maximum of allowed players

% Output:
% If a "playerxx" exists, the value xx of the Vector "Liste" becomes 1
% If a "playerxx" doesn't exist, the value xx becomes 0


Liste=1;

for i=1:maxplayers
    i2=int2str(i);
    Pruefbed = strcat(player, i2);
    if exist(Pruefbed)==2
        Liste(i)=1;
    else
        Liste(i)=0;
    end
end

