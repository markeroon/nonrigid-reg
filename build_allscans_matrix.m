function [all_scans] = build_allscans_matrix( index, scans )
    all_scans = [];
    for i=1:size(scans,1)
        if i ~= index
         all_scans = [all_scans; scans{i}];
        end
    end
end