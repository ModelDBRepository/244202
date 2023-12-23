%%Code for processing the output data from the runs and outputting plots
%%for comparision

%Code for loading in the output data files must change the names of the files for different ones to be opened% 
clear all 
load('E:\Grad School\MATLAB\Sustained-B_0.91_IH conditions\Spikes Data\Spike Trains\0.20-0.80_IKL_splitKvs_max-activation(revised equation)_spiketrain.mat')
Output1=Outputdata;
clear Outputdata
load('E:\Grad School\MATLAB\Sustained Titration\Spikes Data\Spike Trains\0_IKL_0-0.91_IH_max-activation_spiketrain.mat')
Output2=Outputdata;
clear Outputdata
load('E:\Grad School\MATLAB\Sustained Titration\Spikes Data\Spike Trains\0.65_IKL_0-0.91_IH_min-activation_spiketrain.mat')
Output3=Outputdata;
clear Outputdata
load('E:\Grad School\MATLAB\Sustained Titration\Spikes Data\Spike Trains\0.65_IKL_0-0.91_IH_max-activation_spiketrain.mat')
Output4=Outputdata;
clear Outputdata
%load('E:\Grad School\MATLAB\Sustained-B_0.91_IH conditions\Spikes Data\Spike Trains\0.20-0.80_IKL_splitKvs_min-activation_spiketrain.mat')
%Output5=Outputdata;
%clear Outputdata;
%load('E:\Grad School\MATLAB\Sustained-B_0.91_IH conditions\Spikes Data\Spikes Trains\0.20-0.80_IKL_splitKvs_max-activation_spiketrain.mat')
%Output6=Outputdata;
%clear Outputdata;

Time=Output1.time; %%Code for Time variable

set(0,'DefaultFigureWindowStyle','docked') %% code to dock the figures

%Plots for Current clamp mode%
figure(1)
   plot(Time,Output1.Vsave,'r-', 'Linewidth',1);hold on 
   %plot(Time,Output2.Vsave,'g-', 'Linewidth',1);
   %plot(Time,Output3.Vsave,'b-', 'Linewidth',1);
   %plot(Time,Output4.Vsave,'y-', 'Linewidth',1);
  %plot(Time,Output5.Vsave,'k-', 'Linewidth',1);
  %plot(Time,Output6.Vsave,'m-', 'Linewidth',1);

%% for loop to have the current components in 1 structure for each current

    for n =1:20
        Ih1(n,:)= Output1.Ioutput(n).Ih_rm';
        %Ih2(n,:)= Output2.Ioutput(n).Ih_rm';
        %Ih3(n,:)= Output3.Ioutput(n).Ih_rm';
        %Ih4(n,:)= Output4.Ioutput(n).Ih_rm';
        %Ih5(n,:)= Output5.Ioutput(n).Ih_rm';
        %Ih6(n,:)= Output6.Ioutput(n).Ih_rm';
        
        Ikl1(n,:)= Output1.Ioutput(n).Iltk_rm';
        %Ikl2(n,:)= Output2.Ioutput(n).Iltk_rm';
        %Ikl3(n,:)= Output3.Ioutput(n).Iltk_rm';
        %Ikl4(n,:)= Output4.Ioutput(n).Iltk_rm';
        %Ikl5(n,:)= Output5.Ioutput(n).Iltk_rm';
        %Ikl6(n,:)= Output6.Ioutput(n).Iltk_rm';
        
        Ina1(n,:)= Output1.Ioutput(n).Ina_rm';
        %Ina2(n,:)= Output2.Ioutput(n).Ina_rm';
        %Ina3(n,:)= Output3.Ioutput(n).Ina_rm';
        %Ina4(n,:)= Output4.Ioutput(n).Ina_rm';
        %Ina5(n,:)= Output5.Ioutput(n).Ina_rm';
        %Ina6(n,:)= Output6.Ioutput(n).Ina_rm';
        
    end
       
    %%Plotting the currents vs time
    
    figure(2)  %%IH currents 
    plot(Time,Ih1,'r-', 'Linewidth',1); hold on
    plot(Time,Ih2,'g-', 'Linewidth',1);
    plot(Time,Ih3,'b-', 'Linewidth',1);
    plot(Time,Ih4,'y-', 'Linewidth',1);
    %plot(Time,Ih5,'k-', 'Linewidth',1);
    %plot(Time,Ih6,'m-', 'Linewidth',1);
    
    figure(3)    %%IKL currents
    plot(Time,Ikl1,'r-', 'Linewidth',1); hold on
    plot(Time,Ikl2,'g-', 'Linewidth',1);
    plot(Time,Ikl3,'b-', 'Linewidth',1);
    plot(Time,Ikl4,'y-', 'Linewidth',1);
    %plot(Time,Ikl5,'k-', 'Linewidth',1);
    %plot(Time,Ikl6,'m-', 'Linewidth',1);
    
    figure(4)    %%Ina currents
    plot(Time,Ina1,'r-', 'Linewidth',1); hold on
    plot(Time,Ina2,'g-', 'Linewidth',1);
    plot(Time,Ina3,'b-', 'Linewidth',1);
    plot(Time,Ina4,'y-', 'Linewidth',1);
    %plot(Time,Ina5,'k-', 'Linewidth',1);
    %plot(Time,Ina6,'m-', 'Linewidth',1);
    