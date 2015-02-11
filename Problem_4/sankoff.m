function result = sankofffix1(ScM,Value1,Value2,LName)
%SANKOFF Perform Sankoff algorithm
% USAGE Tree = sankoff(T,ScM)
% T - is a 2 element cell, which are subtree cell arrays. Each cell arrays 
%      contain 2 cells with letter according to the leaves (e.g. T={{'G','T'},{'T','A'}})
% ScM - is a scoring matrix 4x4.
% 
%     for j=1:2
%         Tree.leaf(j).Letter=TLetter{j};
%         Tree.leaf(j).Name='AUGC';
% %         Tree.leaf(j).Value=Values{j};
%     end
% % end
% Tree.leaf(j).Value=Value1;
% Tree.leaf(j).Value=Value2;
% Find vertexes values and letters
[Value,Letter]=vertexfun(ScM,Value1,Value2,LName);

% Find root value
% Tree.root.Name='AUGC';
% [Tree.root.Value,Tree.root.Letter]=vertexfun(ScM,Tree.subtree(1).vertex,Tree.subtree(2).vertex);

result={...%Tree.leaf(1).Value, Tree.leaf(1).Letter;...
    ...%Tree.leaf(2).Value, Tree.leaf(2).Letter;...
    Value,Letter};
end



function [vertval,vertletter] = vertexfun(ScM,Val1,Val2,Name)
% Ca;culates vertex values and find the smalest value letter
for i=1:4
    for j=1:4
        %  left branch
        suml(j)=Val1(j)+ScM(i,j);
        %  right branch
        sumr(j)=Val2(j)+ScM(i,j);
    end
    vertval(i)=min(suml)+min(sumr);
end
% find minimum
[v,index]=min(vertval);
% the smalest value letter
vertletter=Name(index);
end