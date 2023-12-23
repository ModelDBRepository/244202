function II_array=EPSC_excitation_response(v,c,excitation,mag_mult)

tic
% global n_k_hh m_na_hh h_na_hh  
global a_k_rm b_k_rm c_k_rm m_na_rm h_na_rm n_htk_rm p_htk_rm w_ltk_rm z_ltk_rm w_ltk_kv7 z_ltk_kv7 w_ltk_kvA z_ltk_kvA r_h_rm
global dt dur gb_syn VV plot_syn time EPSC_shape Isyn %(added Isyn on 3/9/2016

tau=excitation; % the average II time

% For calculating the size of the array containing the synaptic excitation
if EPSC_shape==1
    EPSC_length=ceil(tau*9.5/dt);
elseif EPSC_shape==2
    EPSC_length=25/dt;
elseif EPSC_shape==3
    EPSC_length=52/dt;
end
    
% Preallocating large arrays
VV=zeros(1,dur/dt);
II=zeros(1,dur/5);

% Initial values to initiate backwards difference equations
V(1:2)=v;

[mi_rm variable]=inf_tau_m_rm(V(1));
[hi_rm variable]=inf_tau_h_rm(V(1));
[ai_rm variable]=inf_tau_a_rm(V(1));
[bi_rm variable]=inf_tau_b_rm(V(1));
[ci_rm variable]=inf_tau_c_rm(V(1));
[ni_htk_rm variable]=inf_tau_n_htk_rm(V(1));
[pi_htk_rm variable]=inf_tau_p_htk_rm(V(1));
[wi_ltk_rm variable]=inf_tau_w_ltk_rm(V(1));
[zi_ltk_rm variable]=inf_tau_z_ltk_rm(V(1));
[ri_h_rm variable]=inf_tau_r_rm(V(1));

[wi_ltk_kv7 variable]=inf_tau_w_ltkcnq_rm(V(1));  % initialize these values if you want to have a complex representation of IKL
[zi_ltk_kv7 variable]=inf_tau_z_ltkcnq_rm(V(1));
[wi_ltk_kvA variable]=inf_tau_w_ltk_rm(V(1));
[zi_ltk_kvA variable]=inf_tau_z_ltkA_rm(V(1));



m_na_rm(1:2)=mi_rm;
h_na_rm(1:2)=hi_rm;
a_k_rm(1:2)=ai_rm;
b_k_rm(1:2)=bi_rm;
c_k_rm(1:2)=ci_rm;
n_htk_rm(1:2)=ni_htk_rm;
p_htk_rm(1:2)=pi_htk_rm;
w_ltk_rm(1:2)=wi_ltk_rm;
z_ltk_rm(1:2)=zi_ltk_rm;
r_h_rm(1:2)=ri_h_rm;

w_ltk_kv7(1:2)=wi_ltk_kv7; 
z_ltk_kv7(1:2)=zi_ltk_kv7;
w_ltk_kvA(1:2)=wi_ltk_kvA;
z_ltk_kvA(1:2)=zi_ltk_kvA;

gb_syn=0;

Il(3)=I_l(V(2));
Isyn(3)=I_syn(V(2));

Ina_rm=I_na_rm(V(2));
Ik_rm=I_k_rm(V(2));
Ihtk_rm=I_htk_rm(V(2));
Iltk_rm=I_ltk_rm(V(2));
Ih_rm=I_h_rm(V(2));

Il=I_l(V(2));
Isyn=I_syn(V(2));

V(3)=(-2*dt/c*(Isyn+Ina_rm+Ik_rm+Ihtk_rm+Iltk_rm+Ih_rm+Il)+4*V(2)-V(1))*1/3;

V(1)=V(2);
V(2)=V(3);

% EPSC_II=100;        % Need to calculate how long it takes for single 
%                     % compartment to reach steady steat resting potential
%                     % This is the "time" at wich EPSC spike waveforms
%                     % Will start to be calculated/created
% II_waveform=zeros(1,EPSC_II);
%                     % for first few steps, the synaptic conductance is zero
% EPSC_II_count=1;    % Start countdown to next EPSC spike
% filter_count=1;
% overflow=0;
% H=[1 0.31135116787317596 1; 1 -1.9669151776947449 0.96745369748177656];
%                     % Coefficents of filter
% 
% spike_count=1;      % Needed to start the arry of II times for spikes from 
%                     % the single compartment model
% ii_count=1;         % Needed to start the counter for interspike intervals

VV=(V);

% Generating the stimulus array
EPSC_train=generate_EPSC_train(EPSC_length,excitation);
plot_syn=EPSC_train/10*mag_mult/97;   %EPSC converted to pA (/10), converted to scale factor (*mag_mult), and converted to conductance (/97 mV holding potential of recording)


for zz=4:dur/dt
            
% % % % % %     % Generates the EPSC spikes (adds a new one once the intervent
% % % % % %     % interval "runs out", and then calculates a new intervent interval)
% % % % % %     if EPSC_II_count>=EPSC_II
% % % % % %         if EPSC_II_count < EPSC_length      % Still possibility of residual conductance from previous EPSC... This value needs to be changed if alpha is also changed
% % % % % %             [EPSC_II EPSC_A]=rnd_spike(excitation);
% % % % % %             buff_length=length(II_waveform)-EPSC_II_count;                 % Calculates how the long the buffer is that keeps information about residual conductances from previous EPSC spikes
% % % % % %             buffer=II_waveform(EPSC_II_count:length(II_waveform));         % Buffer that keeps track of any residual conductances from previous EPSC spikes
% % % % % %             new_waveform=zeros(1,round(EPSC_length));                                     % 500? pick appropriate #
% % % % % %             new_waveform(1)=EPSC_A;                                        % Amplitude of new EPSC spike
% % % % % %             if EPSC_shape==1
% % % % % %                 new_waveform=alpha_func(new_waveform)/10;                  % Calculate the waveform for the calculated current (pA) clamped @ -94 mV for new EPSC spike
% % % % % %             elseif EPSC_shape==2
% % % % % %                 new_waveform=alpha_func_elongated(new_waveform)/10;
% % % % % %             elseif EPSC_shape==3
% % % % % %                 new_waveform=alpha_func_blunted(new_waveform)/10;
% % % % % %             end
% % % % % %             II_waveform=new_waveform;
% % % % % %             II_waveform(1:buff_length)=II_waveform(1:buff_length)+buffer(1:buff_length);   % Superimpose new EPSC spike over any residual conductances from previous spikes
% % % % % %             EPSC_II_count=1;
% % % % % %         else                        % No residual conductance from previous EPSC
% % % % % %             [EPSC_II EPSC_A]=rnd_spike(excitation);
% % % % % %             new_waveform=zeros(1,EPSC_length);                                     % 500? pick appropriate #
% % % % % %             new_waveform(1)=EPSC_A;                                        % Amplitude of new EPSC spike
% % % % % %             new_waveform=alpha_func(new_waveform)/10;                  % Calculate the waveform for the calculated current (pA) clamped @ -94 mV for new EPSC spike
% % % % % %             II_waveform=new_waveform;
% % % % % %             EPSC_II_count=1;
% % % % % %         end
% % % % % %     end
    
    % Updating g_syn
%     if EPSC_II_count < EPSC_length
%         gb_syn=EPSC_train(zz)/97*mag_mult;
%         plot_syn(zz)=gb_syn;
%     else
%         gb_syn=0;
%         plot_syn(zz)=gb_syn;
%     end
%     EPSC_II_count=EPSC_II_count+1;
    gb_syn=EPSC_train(zz)/10*mag_mult/97;
    
    % Updating currents from each type of channel
    Ina_rm=I_na_rm(V(2));
    Ik_rm=I_k_rm(V(2));
    Ihtk_rm=I_htk_rm(V(2));
    Iltk_rm=I_ltk_rm(V(2));
    Ih_rm=I_h_rm(V(2));
    
    % Updating currents from leak channel and synaptic conductances
    Il=I_l(V(2));
    Isyn=I_syn(V(2));
    
    % Calculating the new voltage value given the calculated currents
    V(3)=(-2*dt/c*(Isyn+Ina_rm+Ik_rm+Ihtk_rm+Iltk_rm+Ih_rm+Il)+4*V(2)-V(1))*1/3;
    
%     % Spike detection and calculation of Interspike Interval
%     ii_count=ii_count+1;
%     if V(3) > -30 
%         if V(3) < V(2) && V(2) > V(1)
%             II(spike_count)=ii_count;
%             ii_count=1;
%             spike_count=spike_count+1;
%         end
%     end
    
    % Updating new values for voltage buffer
    V(1)=V(2);
    V(2)=V(3);
    
    VV(zz)=V(3);   % for recording voltages
end

%% Spike Detection 

II_array=spike_detection(VV);


figure(69)
subplot(3,1,1)
plot(dt:dt:dur,VV); hold on % Plotting Voltages
title('Model Response to Synaptic Excitation')
xlabel('time (ms)')
ylabel('mV')
ylim([-100 100])
subplot(2,1,2)
plot(dt:dt:dur,plot_syn(1:dur/dt)); hold on
title('Synaptic Excitation')
xlabel('time (ms)')
ylabel('mV')
ylim([0 1.5])

% II_array=II(2:length(II));

time=toc;