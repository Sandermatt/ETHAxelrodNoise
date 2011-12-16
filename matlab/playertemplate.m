classdef playertemplate
    
properties                                      % There are only shown the basic 
                                                % properties each player has, 
                                                % there are some more advanced 
                                                % player with more porperties
    name = 'Template';                          % The players name
    short = 'TEMP';                             % The players short name
end

methods                                         % There is only shown the basic 
                                                % decisionfunction of each player, 
                                                % there are some more advanced 
                                                % player with more functions
    function P = playertemplate(np)             % Constructor for the player
    end
    
    function decision=decide(obj,K,op,turn)     % Decisionfunction of every player
                                                % 1 = cooperation
                                                % 2 = defection
    end
end
end
        