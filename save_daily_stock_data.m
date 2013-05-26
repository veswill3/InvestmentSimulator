function save_daily_stock_data( ticker )
%SAVE_DAILY_STOCK_DATA save daily stock data to file
%   Saves daily stock data to file for later analysis. This will save to an
%   Intraday_data folder in the current working directory. The filename
%   will be date_ticker.mat where date is of the format yyyymmdd

    SAVE_FOLDER = 'Intraday_data';
    % make sure folder exists
    if exist(SAVE_FOLDER, 'file') ~= 7
        mkdir(SAVE_FOLDER); % create the folder
    end

    % get most recent stock data
    stockData = daily_stock_data(ticker);

    % generate filepath (date-ticker)
    dataStr = datestr(stockData(1).Time(1), 'yyyymmdd');
    filename = strcat(dataStr, '_', ticker);
    path = fullfile(pwd, SAVE_FOLDER, filename);

    % save to a .mat file
    save(path, 'stockData');
end