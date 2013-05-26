function save_intraday_stock_data( varargin )
% SAVE_INTRADAY_STOCK_DATA  Save intraday stock data to file
%   Saves intraday stock data to file for later analysis. This will save to
%   an Intraday_data folder in the current working directory. The filename
%   will be date_ticker.mat where date is of the format yyyymmdd
%
%   save_intraday_stock_data(X,Y,'Ticker1','Ticker2',...) retrives current
%   intraday data for the ticker symbols Ticker1, Ticker2, etc...
%   
%   save_intraday_stock_data('tickers.txt') retrieves intraday stock data
%   using the ticker symbols found in the user-defined text file. Ticker
%   symbols must be seperated by line feeds.
%
%   save_intraday_stock_data(... 'silent' ...) will run in silent mode,
%   where warnings and progress is not shown, useful when running via
%   command line

tic

% determine if in silent mode
temp = find(strcmp(varargin,'silent') == 1); % search for silent
if isempty(temp)                            % if not given
    silent = 0;                             % default is no (0)
else                                        % if user supplies frequency
    silent = 1;                             % set to 1
    varargin(temp) = [];                    % remove from varargin
    tic                                     % start timer
end
clear temp

SAVE_FOLDER = 'Intraday_data';
% make sure folder exists
if exist(SAVE_FOLDER, 'file') ~= 7
    if ~silent
        warning([SAVE_FOLDER, ' did not exist. Creating it'])
    end
    mkdir(SAVE_FOLDER); % create the folder
end

% Determine if user supplied ticker symbols or a text file
if isempty(strfind(varargin{1},'.txt'))     % If individual tickers
    tickers = varargin;                     % obtain ticker symbols
else                                        % If text file supplied
    tickers = textread(varargin{1},'%s');   % obtain ticker symbols
end

if ~silent
    h = waitbar(0, 'Please Wait...');       % create waitbar
end

for i = 1:length(tickers)
    if ~silent
        % update waitbar to display current ticker
        waitbar((i-1)/length(tickers),h,sprintf('%s %s %s%0.2f%s', ...
            'Retrieving stock data for',tickers{i},'(', ...
            (i-1)*100/length(tickers),'%)'))
    end
    try
        % get most recent stock data
        stockData = intraday_stock_data(tickers{i});
        % generate filepath (date-ticker)
        dataStr = datestr(stockData(1).Time(1), 'yyyymmdd');
        filename = strcat(dataStr, '_', tickers{i});
        path = fullfile(pwd, SAVE_FOLDER, filename);
        save(path, 'stockData'); % save to a .mat file
        if ~silent
            waitbar(i/length(tickers),h) % update waitbar
        end
    catch
        if ~silent
            warning(['Unable to get data for ',tickers{i},' - skipping'])
        end
    end
end
if ~silent
    close(h)    % close waitbar
    toc         % stop timer/report elapsed time
end