function stockData = load_intraday_stock_data( ticker, startDate, endDate )
%LOAD_INTRADAY_STOCK_DATA   Load intradat stock data from file
%   Loads intraday stock data from file, provided a ticker, a start date,
%   and an end date. This is to be used in conjuntion with the
%   save_intraday_stock_data function as it assume the same data storage
%   convention.

startDate = datenum(startDate);
endDate = datenum(endDate);
if startDate >= endDate
    error('startDate must be before endDate')
end

SAVE_FOLDER = 'Intraday_data';
DATE_FORMAT = 'yyyymmdd';

% structure of stockData to return (as saved):
%     stockData(1).Ticker
%     stockData(1).Time
%     stockData(1).Price
%     stockData(1).Quantity

% initialize data
stockData = struct([]);
partialData = struct([]);
partialData(1).Ticker = ticker;
partialData(1).Time = [];
partialData(1).Price = [];
partialData(1).Quantity = [];

% loop over each day in the range
for date = startDate:endDate
    clear stockData;
    dataStr = datestr(date, DATE_FORMAT);
    filename = strcat(dataStr, '_', ticker);
    path = fullfile(pwd, SAVE_FOLDER, filename);
    try
        load(path);
        % append data
        partialData(1).Time = [partialData(1).Time; stockData.Time];
        partialData(1).Price = [partialData(1).Price; stockData.Price];
        partialData(1).Quantity = [partialData(1).Quantity; stockData.Quantity];
    catch
        % just skip it
    end
end
stockData = partialData;
end

