positivity = 0:0.00001:0.01;
numseats = 492;
numstudents = numseats*4/36;
numinfected = numstudents .* positivity;
maskefficiency = 0.85;
dmask = 1-maskefficiency;
r = 1.12;
volume = 3879054;
classlength = 1.5;
numclasses = 3;
numclassdaysweek = 5;
numweekssem = 12;

t = 1:1:classlength*60;

for a=1:length(positivity)

    breathingout = numinfected(a)*70*dmask;
    n = breathingout/volume;

    dhvac = exp(-r.*t/60);

% ex. if measuring at time 3, viral density from time 1 has been around 3 minutes now, time 2 has been around for 2 minutes now and time 3 has been around for only 1 minute 
    for i=1:classlength*60
        localdens=0;
        for j=1:t(i)
            localdens = localdens + n*dhvac(t(i)-j+1);
        end
        localn(i) = localdens;
    end
    
    inhaling = localn.*dmask*450/60*1;
    doseclass = sum(inhaling);
    dosesem = doseclass*numclasses*numclassdaysweek*numweekssem;
    p = (1-exp(-dosesem/100))*100;
    
    probmask(a) = p;
end

%probmask = probmask(1:101)
plot(positivity, probmask)

%%
positivity = 0.0074;
numseats = 492;
numstudents = numseats*4/36;
numinfected = numstudents * positivity;
maskefficiency = 0.85;
dmask = 1-maskefficiency;
r = 1.12;
volume = 3879054;
classlength = 1.5;
numclasses = 3;
numclassdaysweek = 5;
numweekssem = 12;

t = 1:1:classlength*60;

breathingout = numinfected*70*dmask;
n = breathingout/volume;

dhvac = exp(-r.*t/60);

% ex. if measuring at time 3, viral density from time 1 has been around 3 minutes now, time 2 has been around for 2 minutes now and time 3 has been around for only 1 minute 
for i=1:classlength*60
    localdens=0;
    for j=1:t(i)
        localdens = localdens + n*dhvac(t(i)-j+1);
    end
    localn(i) = localdens;
end
    
inhaling = localn.*dmask*450/60*1;
doseclass = sum(inhaling)
dosesem = doseclass*numclasses*numclassdaysweek*numweekssem
p = (1-exp(-dosesem/100))*100


waittime = 0:1:120;
finaldens = localn(length(localn));
ndiluted = finaldens.*exp(-r.*waittime./60);

for i=1:length(waittime)
    dhvac = exp(-r.*t/60);
    localnnextclass = ndiluted(i)*dhvac;
    
    inhaling = localnnextclass.*dmask*450/60*1;
    doseclass = sum(inhaling);
    dosesem = doseclass*numclasses*numclassdaysweek*numweekssem;
    p = (1-exp(-dosesem/100))*100;
    
    prob(i) = p;

end

plot(waittime, prob)