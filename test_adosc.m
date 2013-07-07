% % Gather stock data
stock = hist_stock_data('01012013','06282013','RHT')

% Calculate the Accumulation/Distribution Oscillator
ado = adosc(stock.High, stock.Low, stock.Open, stock.Close);

% Calculate the Accumulation/Distribution Line
adl = adline(stock.High, stock.Low, stock.Close, stock.Volume);

% Determine the signal, buy or sell, based on the Accumulation/Distribution
% Line
adoscSignal = {''};
tic
for i = 1:(size(adl) - 1)
    if adl(i) < adl(i + 1) && stock.Close(i) > stock.Close(i + 1)
        adoscSignal{i} = 1;
        
    elseif adl(i) > adl(i + 1) && stock.Close(i) < stock.Close( i + 1 )
        adoscSignal{i} = -1;
    else
        adoscSignal{i} = 0;
    end
end      
toc

subplot(3,1,1), plot(stock.Close)
subplot(3,1,2), plot(adl)
subplot(3,1,3), plot(ado)