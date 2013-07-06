function test = signal_compare(start_date, end_date, varargin, signals{:})

stock = hist_stock_data(start_date, end_date, varargin);
newSignal = zeros(length(stock.Close));

    