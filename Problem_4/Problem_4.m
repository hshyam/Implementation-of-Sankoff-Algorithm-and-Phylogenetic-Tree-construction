clear
clc

% Set files directory
file_list=dir(fullfile('sequences\*.fasta'));

% Files to open
% f2open=[22,31,33,21];
% Read files
for i=1:length(file_list)
    Seqs(i) = fastaread(['sequences\' file_list(i).name ]);
end

% Sequence alignment
SeqsMultiAligned = multialign(Seqs);

% Compute pairwise distances
D = seqpdist(Seqs,'Alphabet', 'NT','SquareForm',true);

% Generate and display phylogenetic tree
PhyloTree = seqneighjoin(D);

N=176;

% Define tree
% T={{'A','U'}};

% Define score matrix
ScM=[0 3 4 9;...
     3 0 2 4;...
     4 2 0 4;...
     9 4 4 0];
 
[MATRIX, ID, DIST] = getmatrix(PhyloTree);
[row,col] = find(MATRIX);

%% Set letters for leaves
LeafLetters= repmat(char(0),length(ID),1);
% Twoleaves=cell(length(ID),1);
LeafValues=cell(length(ID),1);
Names='AUGC';
for i=1:length(Seqs)
    lnum=ID(i);
    lnum{1}(1:5)=[];
    LeafLetters(i)=SeqsMultiAligned(str2double(lnum{:})).Sequence(N);
    LeafValues{i,1}=Inf*ones(1,4);
    for j=1:4
        if LeafLetters(i)==Names(j)
           LeafValues{i,1}(j)=0;
        end
    end
end
%% 

tree=cell(length(ID),1);
for i=1:length(ID)-1
    % Find 
    r=find(row==row(i));
    if ~isequal(LeafLetters(r(1)),char(0)) && ~isequal(LeafLetters(r(2)),char(0))
        % Check if there is assigned letter 
        Twoleaves={LeafLetters(r(1)),LeafLetters(r(2))};
        result=sankofffix1(ScM,LeafValues{r(1),1},LeafValues{r(2),1},Names);
        LeafValues{row(r(1)),1}=result{1};
        LeafLetters(row(r(1)))=result{2};
    end
        
 
end

 %% Display results

H=plot(PhyloTree,'BranchLabels', true,'LeafLabels',true);
for i=1:length(Seqs)
    set(H.leafNodeLabels(i),'String',[LeafLetters(i) ' '  num2str(LeafValues{i,1})])
    if i+length(Seqs)<length(ID)
        set(H.branchNodeLabels(i),'String',[LeafLetters(i+length(Seqs)) ' '  num2str(LeafValues{i+length(Seqs),1})])
    end
end
