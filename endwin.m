function [ Gewinn ] = endwin( Gewinnmatrix )
%Berechnet den Gesammtgewinn jedes Spieler

players=size(Gewinnmatrix);
Gewinn(players)=0;
for i=1:players
    for j=1:players
        Gewinn(i)=Gewinn(i)+ Gewinnmatrix(i,j);
    end
end
end

