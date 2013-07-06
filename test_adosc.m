stock = hist_stock_data('01012013','06282013','RHT')

ado = adosc(stock.High, stock.Low, stock.Open, stock.Close);
adl = adline(stock.High, stock.Low, stock.Close, stock.Volume);

adoscSignal = zeros(size(ado));

subplot(3,1,1), plot(stock.Close)
subplot(3,1,2), plot(adl)
subplot(3,1,3), plot(ado)