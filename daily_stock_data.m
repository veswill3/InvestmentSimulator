function stockData = daily_stock_data( ticker )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Created by: Alex Heiden
% 2013-05-19

f = 'yyyymmddTHHMMSS'; % date format
stockData = struct([]);

%for i = 1:length(tickers)
    
    %Download 'Close today' data from www.netfonds.se
    %http://www.netfonds.se/quotes/tradedump.php?paper=GOOG.O&csv_format=csv
    [temp, status] = urlread(strcat('http://www.netfonds.se/quotes/tradedump.php?paper='...
        ,ticker,'.O&csv_format=csv'));
    
    if status
        % organize data by using the comma delimiter
        % headders: time,price,quantity,board,source,buyer,seller,initiator
        [time, price, quantity, ~, ~, ~, ~, ~] = ...
            strread(temp(56:end),'%s%s%s%s%s%s%s%s','delimiter',',');

        stockData(1).Ticker = ticker;
        stockData(1).Time = datenum(time, f) - .25; % -.25 to adjust for timezone
        stockData(1).Price = str2double(price);
        stockData(1).Quantity = str2double(quantity);
    end
end

