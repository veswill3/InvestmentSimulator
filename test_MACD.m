stock = hist_stock_data('01012013','06282013','RHT')

[x1,x2] = macd(stock.Close);
indicator = {''};

for i = 1:length(x1)
    if x1(i) > x2(i)
        indicator{i} = 'Buy';
    else
        indicator{i} = 'Sell';
    end
end

subplot(2,1,1), plot(stock.Close)
subplot(2,1,2), plot(x1)
hold on
subplot(2,1,2), plot(x2)