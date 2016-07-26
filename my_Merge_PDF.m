function my_Merge_PDF(merged_file,varargin)
% merge multiple PDF files
% by Takayuki 080520
% first argument is merged output file name.
% second and third or after them are input file names.
% input file name is not cell
% Please convert cell to strings by following command.
%      aaa{:}


rm_option = 1;  % 1:erase  0:leave


%%
[pathstr, name, ext] = fileparts(merged_file);
name = strrep([name ext],' ','_');
merged_file = fullfile(pathstr,name);

%%

file_names = cat(2,merged_file,varargin);
num_files = length(file_names);

for m=1:num_files
    if ~strcmp(file_names{m}(end-3:end),'.pdf')
        file_names{m} = [file_names{m},'.pdf'];
    end
end


%%

% merge_command0 = sf_gs_command;
% merge_command1 = ' -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=';
merge_command1 = '/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py --output ';
merge_command2 = sprintf('%s ',file_names{:});
% merge_command = [merge_command0, merge_command1, merge_command2];
merge_command = [merge_command1, merge_command2];


disp(' ');
disp('source PDF files');
for m=2:num_files
    disp(sprintf('     %s',file_names{m}));
end

fprintf('%s\n',merge_command);


unix(merge_command);    % merge here ===========================

disp('Merged PDF file');
disp(sprintf('     %s',file_names{1}));



if rm_option
    rm_command1 = 'rm ';
    
    disp('Delete PDF files');
    for m=2:num_files
        rm_command = [rm_command1,file_names{m}];
        unix(rm_command);
        disp(sprintf('     %s',file_names{m}));
    end
end


function gs_command = sf_gs_command()

candidates = {'/usr/local/bin/gs';'gs'};
% candidates = {'/sdjfljsldfa/gs';'/jafkjsleklkjla/gs'};
s=1;
count = 0;
while s
    count = count+1;
    if count > length(candidates)
        error('gs command is not found.');
%         break;
    end
    [s w] = unix(sprintf('which %s',candidates{count}));
    gs_command = candidates{count};
end




