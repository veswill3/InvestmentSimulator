% Gather stock data
stock = hist_stock_data('01012013','06282013','RHT')

% Calculate Williams %R for 14 periods (days)
wpctr = willpctr(stock.High,stock.Low,stock.Close,14)

% Determine the signal, buy or sell, based on Williams %R
wpctrSignal = ones(size(wpctr));
wpctrSignal(wpctr>-20) = -1

% Plot the closing price of the stock
subplot(2,1,1), plot(stock.Close)

% Plot Williams %R
subplot(2,1,2), plot(wpctr)