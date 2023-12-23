clear all 
load('0.65_IKL_1.0Kv1_100uMcAMP.mat')
Output1=Outputdata;
clear Outputdata
load('0.65_IKL_0.75Kv1_100uMcAMP.mat')
Output2=Outputdata;
clear Outputdata
load('0.65_IKL_splitKvs_100uMcAMP.mat')
Output3=Outputdata;
clear Outputdata
load('0.65_IKL_0.75Kv7_100uMcAMP.mat')
Output4=Outputdata;
clear Outputdata
load('0.65_IKL_1.0Kv7_100uMcAMP.mat')
Output5=Outputdata;
clear Outputdata

Time=Output1.time; %%Code for Time variable

set(0,'DefaultFigureWindowStyle','docked') %% code to dock the figures

%Plots for Current clamp mode%
figure(1)

subplot (2,3,1)
plot(Time,Output1.Vsave);
title('0.65_IKL_1.0Kv1_100uMcAMP.mat')

subplot(2,3,2)
plot(Time,Output2.Vsave);
title('0.65_IKL_0.75Kv1_100uMcAMP.mat')

subplot(2,3,3)
plot(Time,Output3.Vsave);
title('0.65_IKL_splitKvs_100uMcAMP.mat')

subplot(2,3,4)
plot(Time,Output4.Vsave);
title('0.65_IKL_0.75Kv7_100uMcAMP.mat')

subplot (2,3,5)
plot(Time,Output5.Vsave);
title('0.65_IKL_1.0Kv7_100uMcAMP.mat')