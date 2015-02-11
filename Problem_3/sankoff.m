% SANKOFF.m Performs Sankoff algorithm
% T: is a 2 element cell, which are the subtree cell arrays. Each cell array 
%     contains 2 cells with letter according to the leaves (e.g. T={{'G','T'},{'T','A'}})
% ScM: is the scoring matrix
function Tree = sankoff(T,ScM)

% Create leaves
for i=1:2
    for j=1:2
        Tree.subtree(i).leaf(j).Letter=T{i}{j};
        Tree.subtree(i).leaf(j).Name='AUGC';
        Tree.subtree(i).leaf(j).Value=Inf*ones(1,4);
    end
end

% Fill the leaves values
for k=1:2
    for i=1:2
        for j=1:4
            if Tree.subtree(k).leaf(i).Letter== Tree.subtree(k).leaf(i).Name(j)
               Tree.subtree(k).leaf(i).Value(j)=0;
            end
        end
    end
end

% Find vertexes values and letters
for k=1:2
    Tree.subtree(k).vertex.Name='AUGC';
    [Tree.subtree(k).vertex.Value,Tree.subtree(k).vertex.Letter]=vertexfun(ScM,Tree.subtree(k).leaf(1),Tree.subtree(k).leaf(2));
end

% Find root value
Tree.root.Name='AUGC';
[Tree.root.Value,Tree.root.Letter]=vertexfun(ScM,Tree.subtree(1).vertex,Tree.subtree(2).vertex);
end

function [vertval,vertletter] = vertexfun(ScM,leaf1,leaf2)

% Calculates vertex values and find the smallest letter value
for i=1:4
    for j=1:4
       
        %  left branch
        sl(j)=leaf1.Value(j)+ScM(i,j);
        
        %  right branch
        sr(j)=leaf2.Value(j)+ScM(i,j);
    end
    
    vertval(i)=min(sl)+min(sr);
end

% find minimum
[v,index]=min(vertval);

% the smallest letter value
vertletter=leaf1.Name(index);
end