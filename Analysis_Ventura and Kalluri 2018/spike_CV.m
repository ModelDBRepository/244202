function [Spikes] = spike_CV(V,Time,threshold)
   
    [pks,locs]=findpeaks(V(5e4:2e5),'minpeakheight',threshold);
    Spikes.spikeheight=pks;
    Spikes.s_time = Time(locs);
    Spikes.spikenum =numel(findpeaks(V,'minpeakheight',threshold));
    Spikes.ISI=diff(Time(locs));
    Spikes.mean_ISI= mean(Spikes.ISI);
    Spikes.CV= std(Spikes.ISI)/mean(Spikes.ISI);
end

     