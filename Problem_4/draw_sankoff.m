% DRAW_SANKOFF.m Display Sankoff algorithm result
% Tree: is a tree structure array from sankoff.
function draw_sankoff(Tree)

% Draw a tree
B = [1 2 ;3 4;5 6];
tree = phytree(B);
plot(tree,'Orientation','top')

% Create names
names=create_string(Tree.root.Name);

% Set positions for text fields
PositionVertex={[1.5,0.95],[3.5,0.95]};
PositionLeaf={[1,1.95],[2,1.95],[3,1.95],[3.5,1.95]};
PositionRoot={[2.5,0.15]};

% Create values array
ValueVertex={create_string(Tree.subtree(1).vertex.Value),create_string(Tree.subtree(2).vertex.Value)};
ValueRoot={create_string(Tree.root.Value)};
ValueLeaf={create_string(Tree.subtree(1).leaf(1).Value),create_string(Tree.subtree(1).leaf(2).Value),...
    create_string(Tree.subtree(2).leaf(1).Value),create_string(Tree.subtree(2).leaf(2).Value)};

% Create letter array
LetterVertex={Tree.subtree(1).vertex.Letter,Tree.subtree(2).vertex.Letter,'NAN','NAN'};
LetterLeaf={Tree.subtree(1).leaf(1).Letter,Tree.subtree(1).leaf(2).Letter,...
    Tree.subtree(2).leaf(1).Letter,Tree.subtree(2).leaf(2).Letter};
LetterRoot={Tree.root.Letter,'NAN','NAN','NAN'};

% Plot results on a tree figure
draw_filed_text(PositionVertex,names,ValueVertex,LetterVertex)
draw_filed_text(PositionRoot,names,ValueRoot,LetterRoot)
draw_filed_text(PositionLeaf,names,ValueLeaf,LetterLeaf)
end

function draw_filed_text(Position,string,values,letter)

% Place text on a tree figure
% Position: is a cell array with position coordinates in each cell
% string: is a cell array with letters
% values: is a cell array with values of letters
% letter: is a letter at current vertex

for i=1:length(Position)
    for j=1:4
        if string{j}==letter{i}
            text(Position{i}(1)+j*0.1,Position{i}(2),string{j},'BackgroundColor','g')
            text(Position{i}(1)+j*0.1,Position{i}(2)-0.1, values{i}{j},'BackgroundColor','g')
        else
            text(Position{i}(1)+j*0.1,Position{i}(2),string{j})
            text(Position{i}(1)+j*0.1,Position{i}(2)-0.1, values{i}{j})
        end
    end
end
end

function str=create_string(val)

% Convert data in val to cell array including converting Inf to \infty for
% correct visualization

for i=1:4
    if val(i)==Inf
        str{i}='\infty';
    else
        str{i}=num2str(val(i),'%.2f');
    end
end
end