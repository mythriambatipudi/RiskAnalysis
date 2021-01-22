function [p, waittime] = TeachingSpaces(R_positivity, N_Seats, F, r, V, t_f, N_Classes)
    N_Students = N_Seats*4/36;
    N_InfectedStudents = N_Students * R_positivity;
    D_Mask = 1-F;
    
    t = 1:1:t_f*60;
    
    N_ViralParticles = N_InfectedStudents*70;
    Delta_p = N_ViralParticles/V * D_Mask;

    D_HVAC = exp(-r.*t/60);

    % ex. if measuring at time 3, viral density from time 1 has been around 3 minutes now, time 2 has been around for 2 minutes now and time 3 has been around for only 1 minute 
    for i=1:t_f*60
        dens=0;
        for j=1:t(i)
            dens = dens + Delta_p * D_HVAC(t(i)-j+1) * D_Mask;
        end
        n(i) = dens;
    end
    
    d_Class = sum(n.*450/60*1);
    d_Semester = d_Class*N_Classes;
    p = (1-exp(-d_Semester/100))*100;
    
    
    p_NextClass = 10^-5;

    D_HVAC = exp(-r.*t/60);
    n_NextClass = p_NextClass.*D_HVAC.*D_Mask;
    
    d_NextClass = sum(n_NextClass.*450/60*1);
    d_NextClassSemester = d_NextClass*N_Classes;
    pnextclass = (1-exp(-d_NextClassSemester/100))*100;

    p_Final = n(length(n))/D_Mask;
    waittime = log(p_NextClass/p_Final)/-r;

end
    