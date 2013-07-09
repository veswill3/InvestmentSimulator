function signal = Stochosc_signal(StockData)

[FpctK, FpctD] = stochosc(StockData.High, StockData.Low, StockData.Close);

% Determine the signal:
%   Only buy if ... still need to research how to read this one:
%   http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:stochastic_oscillator

signal = zeros(size(StockData.Close));

%% plot for data validation

end

