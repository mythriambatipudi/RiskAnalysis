function [p] = DormRooms(N_Students, N_InfectedStudents, F, r, V, t_f, N_Weeks)
    D_Mask = 1-F;
    
    t = 1:1:t_f*60;

    N_ViralParticles = N_InfectedStudents*70;
    Delta_p = N_ViralParticles/V * D_Mask;

    D_HVAC = exp(-r.*t/60);

    for i=1:t_f*60
        dens=0;
        for j=1:t(i)
            dens = dens + Delta_p * D_HVAC(t(i)-j+1) * D_Mask;
        end
        n(i) = dens;
    end
    
    d_Day = sum(n.*450/60*1);
    d_Semester = d_Day*7*N_Weeks;
    p = (1-exp(-d_Semester/100))*100
end