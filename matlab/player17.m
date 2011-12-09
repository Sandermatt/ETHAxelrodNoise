classdef player17 < handle
properties
    name='LookBack_DDowning';
    n_c_cd=0;           % number of cases with oponent: c, downing: c
    n_c_dd=0;           % number of cases with oponent: c, downing: d
    n_cd=0;             % number of cases with downing: c
    n_dd=0;             % number of cases with downing: d
    playernumber = 17;
    
end
methods
    function P17 = player17(np)
        P17.n_c_cd=zeros(np,1);
        P17.n_c_dd=zeros(np,1);
        P17.n_cd=zeros(np,1);
        P17.n_dd=zeros(np,1);
    end
    
    function decision=decide(obj,K2,op,turn)
        if (turn == 1 || turn == 2)
            decision = 2;           
        else
            [obj.n_c_cd, obj.n_c_dd, obj.n_cd, obj.n_dd] = update_rounds(obj, obj.n_c_cd, obj.n_c_dd, obj.n_cd, obj.n_dd, K2, op, turn);
            p_c_cd=obj.n_c_cd(op)/(turn-1);
            p_c_dd=obj.n_c_dd(op)/(turn-1);
            p_cd=obj.n_cd(op)/(turn-1);
            p_dd=obj.n_dd(op)/(turn-1);
            
            if (p_cd == 0)
                p1=0.5;
            else
                p1=p_c_cd/p_cd;
            end
            if (p_dd == 0)
                p2 = 0.5;
            else
                p2=p_c_dd/p_dd;
            end  

            E1 = p1*3 + (1-p1) * 0;
            E2 = p2*5 + (1-p2) * 1;
            
            if(E2>E1)
                decision = 2;
            else 
                decision = 1;       
            end
            
        end
    end
    
    function [n_c_cd_new, n_c_dd_new, n_cd_new, n_dd_new] = update_rounds(obj, n_c_cd_old, n_c_dd_old, n_cd_old,n_dd_old, K, op, turn)
        n_c_cd_new = n_c_cd_old;
        n_c_dd_new = n_c_dd_old;
        n_cd_new = n_cd_old;
        n_dd_new = n_dd_old;
        if (K(op,obj.playernumber,turn-1) == 1)
            if(K(obj.playernumber,op,turn-2) == 1)
                n_c_cd_new(op) = n_c_cd_old(op) + 1;
            else
                n_c_dd_new(op) = n_c_dd_old(op) + 1;
            end
        end
        if (K(obj.playernumber,op,turn-2) == 1)
            n_cd_new(op) = n_cd_old(op) + 1;
        else
            n_dd_new(op) = n_dd_old(op) + 1;
        end
    end
end
end