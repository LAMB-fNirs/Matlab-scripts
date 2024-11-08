function [b, T_2ras] = leftRightFlipped(obj)

b = false;

if isempty(obj)
    return;
end
if ischar(obj)
    orientation = obj;
else
    orientation = obj.orientation;
end

%%% Create a table of transform matrices to RAS.
%%% Group them into 6 types, where one of 2 rules apply for whether 
%%% the matrix will appear flipped.

% Odd number of -1's means left-right appear flipped when plotted in matlab 
M{1,1}  = [ 1, 0, 0;   0, 1, 0;   0, 0, 1];
M{1,2}  = [-1, 0, 0;   0, 1, 0;   0, 0, 1];
M{1,3}  = [ 1, 0, 0;   0,-1, 0;   0, 0, 1];
M{1,4}  = [ 1, 0, 0;   0, 1, 0;   0, 0,-1];
M{1,5}  = [-1, 0, 0;   0,-1, 0;   0, 0, 1];
M{1,6}  = [-1, 0, 0;   0, 1, 0;   0, 0,-1];
M{1,7}  = [ 1, 0, 0;   0,-1, 0;   0, 0,-1];
M{1,8}  = [-1, 0, 0;   0,-1, 0;   0, 0,-1];

% Even number of -1's means left-right appear flipped when plotted in matlab 
M{2,1}  = [ 1, 0, 0;   0, 0, 1;   0, 1, 0];
M{2,2}  = [-1, 0, 0;   0, 0, 1;   0, 1, 0];
M{2,3}  = [ 1, 0, 0;   0, 0, 1;   0,-1, 0];
M{2,4}  = [ 1, 0, 0;   0, 0,-1;   0, 1, 0];
M{2,5}  = [-1, 0, 0;   0, 0, 1;   0,-1, 0];
M{2,6}  = [-1, 0, 0;   0, 0,-1;   0, 1, 0];
M{2,7}  = [ 1, 0, 0;   0, 0,-1;   0,-1, 0];
M{2,8}  = [-1, 0, 0;   0, 0,-1;   0,-1, 0];

% Odd  number of -1's means left-right appear flipped when plotted in matlab 
M{3,1}  = [ 0, 1, 0;   0, 0, 1;   1, 0, 0];
M{3,2}  = [ 0,-1, 0;   0, 0, 1;   1, 0, 0];
M{3,3}  = [ 0, 1, 0;   0, 0, 1;  -1, 0, 0];
M{3,4}  = [ 0, 1, 0;   0, 0,-1;   1, 0, 0];
M{3,5}  = [ 0,-1, 0;   0, 0, 1;  -1, 0, 0];
M{3,6}  = [ 0,-1, 0;   0, 0,-1;   1, 0, 0];
M{3,7}  = [ 0, 1, 0;   0, 0,-1;  -1, 0, 0];
M{3,8}  = [ 0,-1, 0;   0, 0,-1;  -1, 0, 0];

% Even number of -1's means left-right appear flipped when plotted in matlab 
M{4,1}  = [ 0, 1, 0;   1, 0, 0;   0, 0, 1];
M{4,2}  = [ 0,-1, 0;   1, 0, 0;   0, 0, 1];
M{4,3}  = [ 0, 1, 0;  -1, 0, 0;   0, 0, 1];
M{4,4}  = [ 0, 1, 0;   1, 0, 0;   0, 0,-1];
M{4,5}  = [ 0,-1, 0;  -1, 0, 0;   0, 0, 1];
M{4,6}  = [ 0,-1, 0;   1, 0, 0;   0, 0,-1];
M{4,7}  = [ 0, 1, 0;  -1, 0, 0;   0, 0,-1];
M{4,8}  = [ 0,-1, 0;  -1, 0, 0;   0, 0,-1];

% Odd number of -1's means left-right appear flipped when plotted in matlab 
M{5,1}  = [ 0, 0, 1;   1, 0, 0;   0, 1, 0];
M{5,2}  = [ 0, 0,-1;   1, 0, 0;   0, 1, 0];
M{5,3}  = [ 0, 0, 1;   1, 0, 0;   0,-1, 0];
M{5,4}  = [ 0, 0, 1;  -1, 0, 0;   0, 1, 0];
M{5,5}  = [ 0, 0,-1;   1, 0, 0;   0,-1, 0];
M{5,6}  = [ 0, 0,-1;  -1, 0, 0;   0, 1, 0];
M{5,7}  = [ 0, 0, 1;  -1, 0, 0;   0,-1, 0];
M{5,8}  = [ 0, 0,-1;  -1, 0, 0;   0,-1, 0];

% Even number of -1's means left-right appear flipped when plotted in matlab 
M{6,1}  = [ 0, 0, 1;   0, 1, 0;   1, 0, 0];
M{6,2}  = [ 0, 0,-1;   0, 1, 0;   1, 0, 0];
M{6,3}  = [ 0, 0, 1;   0,-1, 0;   1, 0, 0];
M{6,4}  = [ 0, 0, 1;   0, 1, 0;  -1, 0, 0];
M{6,5}  = [ 0, 0,-1;   0,-1, 0;   1, 0, 0];
M{6,6}  = [ 0, 0,-1;   0, 1, 0;  -1, 0, 0];
M{6,7}  = [ 0, 0, 1;   0,-1, 0;  -1, 0, 0];
M{6,8}  = [ 0, 0,-1;   0,-1, 0;  -1, 0, 0];

T_2ras = findTransform2RAS(orientation);
T1 = T_2ras(1:3,1:3);


% Find which matrix matches our input T_2ras
T2 = [];
for ii=1:size(M,1)
    for jj=1:size(M,2)
        if equal(T1, M{ii,jj})
            T2 = M{ii,jj};
            break;
        end
        if ~isempty(T2)
            break;
        end
    end
    if ~isempty(T2)
        break;
    end
end

% Find which type of matrix T_2ras matches. Based on the above rules we can know 
% if the type it matches will appear flipped or not in matlab. 
if ~isempty(T2)
    k = find(M{ii,jj} == -1);
    if mod(ii,2)==0 & mod(length(k),2)==0
        b=true;
    end
    if mod(ii,2)==1 & mod(length(k),2)==1
        b=true;
    end
end




% -----------------------------------------------------------------------
function T_2ras = findTransform2RAS(o)

% Construct a matrix, T_2ras, relating the 3-letter orientation 
% input code to RAS 

T_2ras = eye(4);

if isempty(o)
    return;
end

o = upper(o);

if o(1)     == 'R'
    T_2ras(1,1:3) = [ 1, 0, 0];
elseif o(1) == 'L'
    T_2ras(1,1:3) = [-1, 0, 0];
elseif o(1) == 'A'
    T_2ras(1,1:3) = [ 0, 1, 0];
elseif o(1) == 'P'
    T_2ras(1,1:3) = [ 0,-1, 0];
elseif o(1) == 'S'
    T_2ras(1,1:3) = [ 0, 0, 1];
elseif o(1) == 'I'
    T_2ras(1,1:3) = [ 0, 0,-1];
end

if o(2)     == 'R'
    T_2ras(2,1:3) = [ 1, 0, 0];
elseif o(2) == 'L'
    T_2ras(2,1:3) = [-1, 0, 0];
elseif o(2) == 'A'
    T_2ras(2,1:3) = [ 0, 1, 0];
elseif o(2) == 'P'
    T_2ras(2,1:3) = [ 0,-1, 0];
elseif o(2) == 'S'
    T_2ras(2,1:3) = [ 0, 0, 1];
elseif o(2) == 'I'
    T_2ras(2,1:3) = [ 0, 0,-1];
end

if o(3)     == 'R'
    T_2ras(3,1:3) = [ 1, 0, 0];
elseif o(3) == 'L'
    T_2ras(3,1:3) = [-1, 0, 0];
elseif o(3) == 'A'
    T_2ras(3,1:3) = [ 0, 1, 0];
elseif o(3) == 'P'
    T_2ras(3,1:3) = [ 0,-1, 0];
elseif o(3) == 'S'
    T_2ras(3,1:3) = [ 0, 0, 1];
elseif o(3) == 'I'
    T_2ras(3,1:3) = [ 0, 0,-1];
end

T_2ras = inv(T_2ras);



