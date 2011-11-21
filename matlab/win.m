function [ Reward ] = win( K )
%GEWINN Gewinnberechnung

    if K(1)==1 && K(2)==1
            Reward(1)=3;
            Reward(2)=3;
   
    elseif K(1)==2 && K(2)==1
                    
             Reward(1)=5;
             Reward(2)=0;

    elseif K(1)==1 && K(2)==2
        
             Reward(1)=0;
             Reward(2)=5;
                
    elseif K(1)==2 && K(2)==2

             Reward(1)=1;
             Reward(2)=1;

    else
        disp('Unknown decisions were made!!!')

    end
    


