%% teaching spaces

% input parameters in the following order: positivity rate, # of students, 
% face mask filtration efficiency, air exchange rate (/hr), room 
% volume (L), time spent in space per visit (hr), total # of visits to the 
% space over the semester

% output parameters: probability of infection, required wait time

[p, waittime] = TeachingSpaces(0.0074, 492, 0.85, 1.12, 3879054, 1.5, 180)

%% dining halls - in-person dining

% input parameters in the following order: positivity rate, # of students, 
% face mask filtration efficiency (0 for in-person dining, air exchange 
% rate (/hr), room volume (L), time spent in space per visit (hr), total # 
% of visits to the space over the semester

% output parameter: probability of infection

p = DiningHalls_InPerson(0.0074, 100, 0, 0.2, 849505, 1, 12)

%% dining halls - meal pick-ups

% input parameters in the following order: positivity rate, # of students, 
% face mask filtration efficiency, air exchange rate (/hr), room volume(L), 
% time spent in space per visit (hr), total # of visits to the space over 
% the semester

% output parameters: probability of infection, required wait time

[p, waittime] = DiningHalls_MealPickUps(0.0074, 100, 0.75, 0.2, 849505, 10/60, 12)

%% dorm rooms

% input parameters in the following order: # of students in room, # of 
% infected students, face mask filtration efficiency (0 for dorm room), air 
% exchange rate (/hr), room volume (L), time spent in space per day (hr)

% output parameter: probability of infection

p = DormRooms(2, 1, 0, 3, 73623, 18)

%% bathrooms

% input parameters in the following order: # of students sharing bathroom, 
% # of infected students among those sharing the bathroom, face mask 
% filtration efficiency, air exchange rate (/hr), room volume(L), 
% time spent in space per bathroom visit (hr), time in space per shower
% visit (hr), wait time between bathroom visits (hr), wait time between
% shower visits (hr), # of bathroom visits per day, # of shower visits per
% day

% output parameter: probability of infection

p = Bathrooms(6, 2, 0.75, 3, 84950, 5/60, 20/60, 40/60, 80/60, 4, 1)