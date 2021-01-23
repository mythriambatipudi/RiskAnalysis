%% teaching spaces

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

% teaching spaces - next class

ndiluted = 10^-5;

dhvac = exp(-r.*t/60);
localnnextclass = ndiluted.*dhvac;
    
inhaling = localnnextclass.*dmask*450/60*1;
doseclass = sum(inhaling)
dosesem = doseclass*numclasses*numclassdaysweek*numweekssem
p = (1-exp(-dosesem/100))*100

finaldens = localn(length(localn))
waittime = log(ndiluted/finaldens)/-r

%% dining - in person

positivity = 0.0074;
numseats = 100;
numstudents = numseats*4/36;
numinfected = numstudents * positivity;
maskefficiency = 0;
dmask = 1-maskefficiency;
r = 0.2;
volume = 849505;
meallength = 1;
nummeals = 3;

t = 1:1:meallength*60;

breathingout = numinfected*70*dmask;
n = breathingout/volume;

dhvac = exp(-r.*t/60);

for i=1:meallength*60
    localdens=0;
    for j=1:t(i)
        localdens = localdens + n*dhvac(t(i)-j+1);
    end
    localn1(i) = localdens;
end
    
inhaling = localn1.*dmask*450/60*1;
dosemeal = sum(inhaling)
dosesem = dosemeal*nummeals*7*numweekssem
p = (1-exp(-dosesem/100))*100

%% dining - meal pick up

positivity = 0.0074;
numseats = 100;
numstudents = numseats*4/36;
numinfected = numstudents * positivity;
maskefficiency = 0.75;
dmask = 1-maskefficiency;
r = 0.2;
volume = 849505;
meallength = 10/60;
nummeals = 3;

t = 1:1:meallength*60;

breathingout = numinfected*70*dmask;
n = breathingout/volume;

dhvac = exp(-r.*t/60);

for i=1:meallength*60
    localdens=0;
    for j=1:t(i)
        localdens = localdens + n*dhvac(t(i)-j+1);
    end
    localn2(i) = localdens;
end
    
inhaling = localn2.*dmask*450/60*1;
dosemeal = sum(inhaling)
dosesem = dosemeal*nummeals*7*numweekssem
p = (1-exp(-dosesem/100))*100

% dining - next pick up

ndiluted = 1.66*10^-5;

dhvac = exp(-r.*t/60);
localnnextpickup = ndiluted.*dhvac;
    
inhaling = localnnextpickup.*dmask*450/60*1;
dosemeal = sum(inhaling)
dosesem = dosemeal*nummeals*7*numweekssem
p = (1-exp(-dosesem/100))*100

finaldens = localn2(length(localn2))
waittime = log(ndiluted/finaldens)/-r
%% dorm room

numstudents = 2;
numinfected = 1;
maskefficiency = 0;
dmask = 1-maskefficiency;
r = 3;
volume = 73623;
timeperday = 18;

t = 1:1:timeperday*60;

breathingout = numinfected*70*dmask;
n = breathingout/volume;

dhvac = exp(-r.*t/60);

for i=1:timeperday*60
    localdens=0;
    for j=1:t(i)
        localdens = localdens + n*dhvac(t(i)-j+1);
    end
    localn3(i) = localdens;
end
    
inhaling = localn3.*dmask*450/60*1;
dosemeal = sum(inhaling)
dosesem = dosemeal*7*2
p = (1-exp(-dosesem/100))*100

%% bathroom

% bathroom
numstudents = 6;
numinfected = 2;
maskefficiency = 0.75;
dmask = 1-maskefficiency;
r = 3;
volume = 84950;
timepervisit = 5/60;
waittimebathroom = 30/60;
numbathroomperday = 4;

t = 1:1:timepervisit*60;

breathingout = numinfected*70*dmask;
n = breathingout/volume;

dhvac = exp(-r.*t/60);

for i=1:timepervisit*60
    localdens=0;
    for j=1:t(i)
        localdens = localdens + n*dhvac(t(i)-j+1);
    end
    localn4(i) = localdens;
end
    
finaldensbathroom = localn4(length(localn4))
densnextvisit = finaldensbathroom * exp(-r*waittimebathroom);

ndiluted = densnextvisit;
dhvac = exp(-r.*t/60);
localnnextvisit = ndiluted.*dhvac;
    
inhaling = localnnextvisit.*dmask*450/60*1;
dosebathroom = sum(inhaling);

% shower
maskefficiency = 0;
dmask = 1-maskefficiency;
timepervisit = 20/60;
waittimeshower = 80/60;
numshowerperday = 1;

t = 1:1:timepervisit*60;

breathingout = numinfected*70*dmask;
n = breathingout/volume;

dhvac = exp(-r.*t/60);

for i=1:timepervisit*60
    localdens=0;
    for j=1:t(i)
        localdens = localdens + n*dhvac(t(i)-j+1);
    end
    localn5(i) = localdens;
end
    
finaldensshower = localn5(length(localn5));
densnextvisit = finaldensshower * exp(-r*waittimeshower);

ndiluted = densnextvisit;
dhvac = exp(-r.*t/60);
localnnextvisit = ndiluted.*dhvac;
    
inhaling = localnnextvisit.*dmask*450/60*1;
doseshower = sum(inhaling);

dosesem = (dosebathroom * numbathroomperday + doseshower * numshowerperday) * 7 * 2;
p = (1-exp(-dosesem/100))*100