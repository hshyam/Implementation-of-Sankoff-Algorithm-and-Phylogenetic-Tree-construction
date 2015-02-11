clear
clc

% Set files directory
file_list=dir(fullfile('sequences\*.fasta'));

% Read files
for i=1:length(file_list)
    Seqs(i) = fastaread(['sequences\' file_list(i).name ]);
end

% Sequence alignment
SeqsMultiAligned = multialign(Seqs);

% Compute pairwise distances
D = seqpdist(Seqs,'Alphabet', 'NT');

% Generate and display phylogenetic tree
PhyloTree = seqneighjoin(D);
view(PhyloTree)

% Save distance to file
fileID = fopen('distance.txt','w');
fprintf(fileID,'%.2f \n',D);
fclose(fileID);
