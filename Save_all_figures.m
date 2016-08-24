function Save_all_figures(varargin)

if nargin
    [PathName, FileName, ext] = fileparts(varargin{1});
    FileName = [FileName, ext];
else
    [FileName,PathName] = uiputfile(...
        {'*.pdf;*.PDF', 'PDF files (*.pdf)';'*.*',  'All Files (*.*)'},...
        'Save all figures as a PDF file');
end


fhs = get(groot,'Children');
[~, fig_idx] = sort([fhs.Number]);
num_fig = length(fhs);

for m=1:num_fig
    save_file_names{m} = fullfile(PathName,sprintf('_Save_all_figures_%02d.pdf',m));
    figure(fhs(fig_idx(m)));
    saveas(fhs(fig_idx(m)),save_file_names{m},'pdf');
    fprintf('Saved %s\n',save_file_names{m});
end

my_Merge_PDF(fullfile(PathName,FileName),save_file_names{:});