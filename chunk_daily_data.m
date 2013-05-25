function [ time, price, quantity ] ...
    = chunk_daily_data( TimeData, PriceData, QuantityData, secPerChunk )
% CHUNK_DAILY_DATA peice out daily stock data for plotting and analysis
% Created by Vesper
%   Peice out daily stock data into usable chunks for plotting and analysis
%   TimeData, PriceData, and QuantityData are vectors returned from
%   daily_stock_data.
%   secPerChunk defines the number of seconds to use per chunk. The default
%   will be the min possible chunk size (1 second?)
%
%   time is returned as the unique values from Time in the specified chunks
%   price is returned as the average or mean of prices within each chunk
%   quantity is returned as the sum of quantities within each chunk

    if nargin < 3
        error('You must provide TimeData, PriceData, and QuantityData');
    end
    if exist('secPerChunk', 'var')
        oneSec = (1/86400);
        time = (min(TimeData):secPerChunk*oneSec:max(TimeData))';
    else
        % get the unique time values
        time = unique(TimeData);
    end

    [~, tb] = histc(TimeData, time);
    PriceSparse = sparse(1:numel(TimeData), tb, PriceData);
    % we want the mean of prices for each time
    price = full(mean(PriceSparse)./mean(PriceSparse>0))';
    QuantitySparse = sparse(1:numel(TimeData), tb, QuantityData);
    % we want to sum of quantities for each time
    quantity = full(sum(QuantitySparse)./sum(QuantitySparse>0))';

end