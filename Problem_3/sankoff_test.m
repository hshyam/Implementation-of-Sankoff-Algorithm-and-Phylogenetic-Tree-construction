clear
clc

% Define tree
T={{'A','G'},{'A','C'}};

% Define the scoring matrix
ScM=[0 3 4 9;...
     3 0 2 4;...
     4 2 0 4;...
     9 4 4 0];

%  Use Sankoff's algorithm
tree=sankoff(T,ScM);

% Display results
draw_sankoff(tree)