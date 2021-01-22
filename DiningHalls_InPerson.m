function [p] = DiningHalls_InPerson(R_positivity, N_Seats, F, r, V, t_f, N_Weeks)
    N_Students = N_Seats*4/36;
    N_InfectedStudents = N_Students * R_positivity;
    D_Mask = 1-F;
    N_meals = 3;
    
    t = 1:1:t_f*60;

    N_ViralParticles = N_InfectedStudents * 70;
    Delta_p = N_ViralParticles/V * D_Mask;

    D_HVAC = exp(-r.*t/60);

    for i=1:t_f*60
        dens=0;
        for j=1:t(i)
            dens = dens + Delta_p * D_HVAC(t(i)-j+1) * D_Mask;
        end
        n(i) = dens;
    end
    
    D_Meal = sum(n.*450/60*1);
    D_Semester = D_Meal*N_meals*7*N_Weeks;
    p = (1-exp(-D_Semester/100))*100;
end