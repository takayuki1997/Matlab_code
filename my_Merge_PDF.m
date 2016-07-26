function my_Merge_PDF(merged_file,varargin)
% merge multiple PDF files
% by Takayuki 160726
% first argument is merged output file name.
% second and third or after them are input file names.
% my_Marge_PDF('out.pdf', 'in1.pdf', 'in2.pdf');
%
% input file name is not cell
% Please convert cell to strings by following command.
% ins = {'in1.pdf', 'in2.pdf'};
% my_Marge_PDF('out.pdf', ins{:});


rm_option = 1;  % 1:erase originals, 0:leave originals


%% 

fprintf('\n----------------\n%s\n',mfilename);
if ~ismac
    fprintf('<<This function is only for Mac.>>\n\n');
    return
end

file_names = cat(2,merged_file,varargin);
fprintf('\nsource PDF files\n');
fprintf(' %s\n',file_names{2:end});


%% Marge PDF files

merge_command = '/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py --output';
merge_command = [merge_command, sprintf(' ''%s''',file_names{:})];

fprintf('\nmarge command\n %s\n...',merge_command);
unix(merge_command);    % merge here ================

fprintf('\b\b\b\nmarged PDF file\n %s\n\n',file_names{1});


%% Delete source PDF files

if rm_option
    rm_command = 'rm';
    fprintf('delete source PDF files\n');
    rm_command = [rm_command, sprintf(' ''%s''',file_names{2:end})];
    unix(rm_command);   % delete here ================
    fprintf(' %s\n',file_names{2:end});
    fprintf('\n');
end
