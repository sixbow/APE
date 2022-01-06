function dthetadNqp = dphaseMazin(alpha_k, Q, V)
%dphaseMazin calculates the responsivity in phase via the relation
%mentioned on p.33 of his Dissertion titled: Microwave kinetic inductance
%detectors (2004)
% Eq 2.59
dthetadNqp = 1.63E-7.*((alpha_k.*Q)./V);
end

