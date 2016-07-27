function my_Merge_PDF(merged_file, varargin)
% merge multiple PDF files
% by Takayuki 160726
% first argument is merged output file name.
% second and third or after them are input file names.
% my_Merge_PDF('out.pdf', 'in1.pdf', 'in2.pdf');
%
% input file name is not cell
% Please convert cell to strings by following command.
% ins = {'in1.pdf', 'in2.pdf'};
% my_Merge_PDF('out.pdf', ins{:});


rm_option = 1;  % 1:erase originals, 0:leave originals


%% OS, file, directory check

fprintf('\n----------------\n%s\n\n', mfilename);
if ~ismac
    fprintf(' <<This function is only for Mac.>>\n <<PDF files were not merged.>>\n\n');
    return
end

flag = 0;
for m=1:length(varargin)
    if ~exist(varargin{m}, 'file');
        fprintf(' Not exist in file ''%s''\n',varargin{m});
        flag = 1;
    end
end
[pathstr, name, ext] = fileparts(merged_file);
if isempty(pathstr)
    pathstr = './';
end
if ~isdir(pathstr)
    fprintf(' Not exist out dir ''%s''\n', pathstr);
end
if flag
    fprintf('\n');
    return
end


%% Merge PDF files

fprintf('source PDF files\n');
fprintf(' %s\n', varargin{:});

merge_command = '/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py --output';
merge_command = [merge_command, sprintf(' ''%s''', merged_file), sprintf(' ''%s''', varargin{:})];

fprintf('\nmerge command\n %s\n...', merge_command);
unix(merge_command);    % merge here ================

fprintf('\b\b\b\nmerged PDF file\n %s\n\n', merged_file);


%% Delete source PDF files

if rm_option
    rm_command = 'rm';
    fprintf('delete source PDF files\n');
    rm_command = [rm_command, sprintf(' ''%s''', varargin{:})];
    unix(rm_command);   % delete here ================
    fprintf(' %s\n', varargin{:});
    fprintf('\n');
end
