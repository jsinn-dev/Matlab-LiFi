%% Modifiy Tx and Rx data for test purposes
RxData = [zeros(1,213) reshape(Tx.Data(1,1,:),[1 length(Tx.Data)])];
timepad = linspace(0,Tx.Time(213,1),213);
RxTime = [timepad reshape(Tx.Time+Tx.Time(213,1),[1 length(Tx.Time)])];
Rx = timeseries(RxData, RxTime);

TxDataDownsampled(:) = downsample(Tx.Data(1,1,:),2);
TxTimeDownsampled(:) = downsample(Tx.Time(:,1),2);
Tx = timeseries(TxDataDownsampled, TxTimeDownsampled);

%% Plot initial TX data
figure(1);
subplot(611);
plot(Tx.Time, reshape(Tx.Data(1,1,:),[1 length(Tx.Data)]));
title('Raw TX data');
xlabel('time (s)');

%% Read received file from oscilloscope
%Rx = timeseries(a,b);

subplot(612);
plot(Rx.Time, reshape(Rx.Data(1,1,:),[1 length(Rx.Data)]));
title('Raw RX data');
xlabel('time (s)');

%% Find and compensate for the delay between TX and RX
% Upsample the TX data to match RX sampling rate
TxUpsampled = resample(Tx,Rx.Time);

subplot(613);
plot(TxUpsampled.Time, reshape(TxUpsampled.Data(1,1,:),[1 length(TxUpsampled.Data)]));
title('Upsampled TX data');
xlabel('time (s)');

% Retrieve preamble from TX data
PreambleIndices = find(TxUpsampled.Time<SimDuration/NbOFDMSymbols);
Preamble = timeseries(TxUpsampled.Data(PreambleIndices),TxUpsampled.Time(PreambleIndices));

subplot(614);
plot(Preamble.Time, reshape(Preamble.Data(1,1,:),[1 length(Preamble.Data)]));
xlim([0 1.2e-5]);
title('Reference preamble data');
xlabel('time (s)');

% Find delay between TX and RX using correlation
u(:) = Preamble.Data(1,1,:);
v(:) = Rx.Data(1,1,:);
delay = abs(finddelay(u, v));

% Compensate for the delay by shifting RX signal
shiftedRxData(:) = Rx.Data(:,:,delay+1:length(Rx.Data));
shiftedRxTime(:) = Rx.Time(delay+1:length(Rx.Time),1)-Rx.Time(delay+1,1);
Rx = timeseries(shiftedRxData, shiftedRxTime);

subplot(615);
plot(Rx.Time, reshape(Rx.Data(1,1,:),[1 length(Rx.Data)]));
title('RX data after delay compensation');
xlabel('time (s)')

%% Resample the RX data to match the original TX sampling rate
Rx = resample(Rx,Tx.Time);

subplot(616);
plot(Rx.Time, reshape(Rx.Data(1,1,:),[1 length(Rx.Data)]));
title('RX data after delay compensation and downsampling');
xlabel('time (s)')
