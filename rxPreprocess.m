%% Read received file from oscilloscope
RX = TX;
%% Find and compensate for the delay between TX and RX
delay = 10;
shiftedData = RX.Data(:,:,delay+1:length(TX.Data));
shiftedTime = RX.Time(delay+1:length(TX.Time),:);
RX = timeseries(shiftedData, shiftedTime);
%% Resample the signal to match the TX sampling rate
RX = resample(RX,TX.Time);