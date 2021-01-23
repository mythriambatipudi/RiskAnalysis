function [p] = Bathrooms(N_Students, N_InfectedStudents, F, r, V, t_Bathroom, t_Shower, t_WaitBathroom, t_WaitShower, N_Bathroom, N_Shower)
    D_Mask = 1-F;
    
    t = 1:1:t_Bathroom*60;

    N_ViralParticles = N_InfectedStudents * 70;
    Delta_p = N_ViralParticles/V * D_Mask;

    D_HVAC = exp(-r.*t/60);
    
    for i=1:t_Bathroom*60
        dens=0;
        for j=1:t(i)
            dens = dens + Delta_p * D_HVAC(t(i)-j+1);
        end
        n(i) = dens;
    end
    
    p_f = n(length(n));
    p_Diluted = p_f * exp(-r*t_WaitBathroom);

    D_HVAC = exp(-r.*t/60);
    n_NextVisit = p_Diluted.*D_HVAC.*D_Mask;
    
    d_Bathroom = sum(n_NextVisit.*450/60*1);

    % shower
    F = 0;
    D_Mask = 1-F;
    t = 1:1:t_Shower*60;

    N_ViralParticles = N_InfectedStudents * 70;
    Delta_p = N_ViralParticles/V * D_Mask;

    D_HVAC = exp(-r.*t/60);

    for i=1:t_Shower*60
        dens=0;
        for j=1:t(i)
            dens = dens + Delta_p * D_HVAC(t(i)-j+1);
        end
        n2(i) = dens;
    end
    
    p_f = n2(length(n2));
    p_Diluted = p_f * exp(-r*t_WaitShower);

    D_HVAC = exp(-r.*t/60);
    n_NextVisit = p_Diluted .* D_HVAC .* D_Mask;
    
    d_Shower = sum(n_NextVisit.*450/60*1);

    d_Semester = (d_Bathroom * N_Bathroom + d_Shower * N_Shower) * 7 * 2;
    p = (1-exp(-d_Semester/100))*100;
end