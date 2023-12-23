clear all 
load('E:\Grad School\MATLAB\Sustained-B_0.91_IH conditions\Spikes Data\Spike Trains\0.20-0.80_IKL_splitKvs_max-activation_spiketrain.mat');

for n=1:20
spikes(n) = spike_CV(Outputdata.Vsave(n,:),Outputdata.time,-30);

end 

cd('E:\Grad School\MATLAB\Sustained-B_0.91_IH conditions\Spikes Data\Spike Features') % Change directory for where you wish to save
filename=input('EnterFileName:','s');
save(filename,'spikes'); %Output data structure is defined in lines near.