function final_pf = pfAssign(pfa, pfb, pfc, id)
    %This function equates the power factor to the power factor of 
    %the previous ID 3 event
    
    %Final pf stores the 3 newly assigned power factors as its 3 vectors
    final_pf = [];
    %We create 3 new vectors
    
    tmpa = -1; tmpb = -1; tmpc = -1;
    
    %We only take into account the event 5's after the first event 3
    % as the even 5 needs an event 3 before it
    id_5=id==5; 
    length_id5=sum(id_5);
    %If there are no event 3's before the first event 5, we can add
    % an extrapolated value of an event 3 power factor before it
    for i=1:length(id)
        if(id(i)==3)
            tmpa = pfa(i);
            tmpb = pfb(i);
            tmpc = pfc(i);
        end;
      
        %If the event ID is 5 and an event 3 has already occured, we
        %update the values
        %Event 3 has occured if tmpa, tmpb, tmc ~= -1
        if(id(i)== 5 && tmpa ~= -1)
            final_pf = [final_pf; [tmpa tmpb tmpc]];
        end 
    end
     % Since in some data sets, an evnet 5 occurs before an event 3, we
     % have taken the average of the first 3 event 5 power factor values
     % and stored it as the first set of values.
     if(length(final_pf)~=length_id5)        
        temp_pf = (final_pf(1,:)+final_pf(2,:)+final_pf(3,:))./3;
        final_pf=[temp_pf;final_pf];
     end
final_pf=interpolate(final_pf);
end
        
            
            
            
            
        
        
    
    