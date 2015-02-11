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
showalignment(SeqsMultiAligned)

