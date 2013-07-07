% Gather stock data
stock = hist_stock_data('01012013','06282013','RHT')

% Calculate MACD from the closing price
[x1,x2] = macd(stock.Close);

% Determine the signal, buy or sell, based on the MACD value
tic
macdSignal = ones(size(x1));
macdSignal(x2>x1) = -1;
toc

% Plot the stock closing price
subplot(2,1,1), plot(stock.Close)

% Plot the MACD line and the nine-period ema (exponential moving average)
subplot(2,1,2), plot(x1)
hold on
subplot(2,1,2), plot(x2)