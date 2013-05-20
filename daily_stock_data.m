function stockData = daily_stock_data( ticker )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Created by: Alex Heiden
% 2013-05-19

stockData = struct([]);

%for i = 1:length(tickers)
    
    %Download 'Close today' data from www.netfonds.se
    %http://www.netfonds.se/quotes/tradedump.php?paper=GOOG.O&csv_format=csv
    [temp, status] = urlread(strcat('http://www.netfonds.se/quotes/tradedump.php?paper='...
        ,ticker,'.O&csv_format=csv'));
    
    if status
        % organize data by using the comma delimiter
        [time, price, quantity] = ...
            strread(temp(50:end),'%s%s%s','delimiter',',');
    
     stockData(1).Ticker = ticker;        % obtain ticker symbol
     stockData(1).Time = flipud(time);                % save date/time data
     stockData(1).Price = flipud(str2double(price));      % save trade price data
     stockData(1).Quantity = flipud(str2double(quantity));    % save trade quantity data
     
end

