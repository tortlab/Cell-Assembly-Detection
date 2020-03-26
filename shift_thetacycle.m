function control_max_eig = shift_thetacycle(SpikeCount,number_of_surrogates,binspercycle)

control_max_eig=zeros(1,number_of_surrogates);
for surr_idx = 1:number_of_surrogates
    ControlSpikeCount=zeros(size(SpikeCount));
    for neuron_idx = 1:size(SpikeCount,1)
        drawnbin = randi(length(SpikeCount)/binspercycle,1);
        drawnbin = drawnbin*4-3;
        auxbin = [drawnbin:length(SpikeCount) 1:drawnbin-1];
        ControlSpikeCount(neuron_idx,:) = SpikeCount(neuron_idx,auxbin);
    end
    CorrelationMatrix = corr(ControlSpikeCount');
    [garbage,eigenvalues]=eig(CorrelationMatrix);
    control_max_eig(surr_idx)=max(reshape(eigenvalues,1,[]));
end