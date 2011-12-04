classdef player21
properties
    name='CDowning';
    n_c=0;           % number of cases with oponent: c
    n_cc=0;          % number of cases with oponent: c, downing: c
    n_cd=0;          % number of cases with oponent: c, downing: d
    playernumber = 21;
    
end
methods
    function decision=decide(obj,K2,op,turn)
        if (turn == 1)
            decision = 1;
        else
            [obj.n_c, obj.n_cc, obj.n_cd] = update_rounds(obj.n_c, obj.n_cc, obj.n_cd, K2, turn, obj, op);
            p_c=obj.n_c/(turn-1);
            p_cd=obj.n_cd/(turn-1);
            p_cc=obj.n_cc/(turn-1);
            
            if(p_c == 0)
                p1 = 0.5;
                p2 = 0.5;
            else

                p1=p_cc/p_c;   
                p2=p_cd/p_c;
                
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
    
    function [n_c_new, n_cc_new, n_cd_new] = update_rounds(n_c_old, n_cc_old, n_cd_old, K2, turn,obj, op)
        if (K2(obj.playernumber,op,turn-1)== 1)
            n_c_new=n_c_old + 1;
            if(K2(obj.playernumber,op,turn-1)== 1)
                n_cc_new = n_cc_old + 1;
            else
                n_cd_new = n_cd_old +1;
            end
        end
    end
end
end
        