%Define ticker(s)
ticker = 'GOOG'

%Call stockData function
stockData = daily_stock_data(ticker);

%Save the structure
x = getfield(stockData,'Time',{1,1});
y = datestr(x)
filename = strcat(y, ' ', ticker);
save(fullfile('/home/alex/Projects/matlab/InvestmentSimulator/Intraday_data/', filename)...
    , '-struct', 'stockData', 'Ticker', 'Time', 'Price', 'Quantity');