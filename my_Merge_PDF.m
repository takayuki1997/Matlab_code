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


rm_option = 0;  % 1:erase originals, 0:leave originals


%% OS, file, directory check

fprintf('\n----------------\n%s\n', mfilename);
if ~ismac
    fprintf(' <<This function is only for Mac.>>\n <<PDF files were not merged.>>\n\n');
    return
end

fprintf('\nsource PDF files\n');
fprintf(' %s\n', varargin{:});


%% Merge PDF files

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
