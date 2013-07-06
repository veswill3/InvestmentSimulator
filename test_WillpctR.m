stock = hist_stock_data('01012013','06282013','RHT')

wpctr = willpctr(stock.High,stock.Low,stock.Close,14)

wpctrSignal = zeros(size(wpctr));
wpctrSignal(wpctr<-80) = 1

subplot(2,1,1), plot(stock.Close)
subplot(2,1,2), plot(wpctr)