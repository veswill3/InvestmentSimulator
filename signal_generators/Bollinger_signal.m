% Gather stock data
stock = hist_stock_data('01012013','06282013','RHT')

% Calculate the middle, upper, and lower Bollinger Bands
[mid, uppr, lowr] = bollinger(stock.Close);

% STILL NEED TO DEVELOP SIGNAL

%Plot the Close price and Bollinger BAnds on the same figure
plot(stock.Close)
hold on
plot(mid)
hold on
plot(uppr)
hold on
plot(lowr)