function DATA_EPOCHING( subject_name )
% run under directory 'f:\STUDY\Project 1_Shanshan\'
mkdir(subject_name);        % make directory [subject_name] under 'f:\STUDY\Project 1_Shanshan\'

marker_addr = ['f:\STUDY\Project 1_Shanshan\',subject_name,'.xlsx'];
marker2index = xlsread(marker_addr);

data_addr = ['f:\STUDY\Project 1_Shanshan\',subject_name,'.edf'];
[~,record] = edfread(data_addr);

end_num = length(marker2index');

PL_DATA = [];
PL_INDEX = 1;
PH_DATA = [];
PH_INDEX = 1;
NL_DATA = [];
NL_INDEX = 1;
NH_DATA = [];
NH_INDEX = 1;

for index = 1 : end_num         % start checking the marker2index matrix
    if marker2index(index,2) == 10          % if the marker with 'index' is 10, then the PL data start here
        PL_Position = marker2index(index,1);        % FIND THE START POSITION FOR PL
        PL_DATA = record(3:16,PL_Position:PL_Position+1279);
        PL_DATA = zscore(PL_DATA,2);       % zscore normalization by row ('2 represent ROW')
        PL_INDEX_str = num2str(PL_INDEX);
        Filename = ['f:\STUDY\Project 1_Shanshan\',subject_name,'\',subject_name,'_','Positive Low No.',PL_INDEX_str,'.mat'];
        save(Filename,'PL_DATA');
        PL_DATA = [];
        PL_INDEX = PL_INDEX + 1;
        continue;
    end
    if marker2index(index,2) == 30
        PH_Position = marker2index(index,1);
        PH_DATA = record(3:16,PH_Position:PH_Position+1279);
        PH_DATA = zscore(PH_DATA,2);
        PH_INDEX_str = num2str(PH_INDEX);
        Filename = ['f:\STUDY\Project 1_Shanshan\',subject_name,'\',subject_name,'_','Positive High No.',PH_INDEX_str,'.mat'];
        save(Filename,'PH_DATA');
        PH_DATA = [];
        PH_INDEX = PH_INDEX + 1;
        continue;
    end
    if marker2index(index,2) == 40
        NL_Position = marker2index(index,1);
        NL_DATA = record(3:16,NL_Position:NL_Position+1279);
        NL_DATA = zscore(NL_DATA,2);
        NL_INDEX_str = num2str(NL_INDEX);
        Filename = ['f:\STUDY\Project 1_Shanshan\',subject_name,'\',subject_name,'_','Negative Low No.',NL_INDEX_str,'.mat'];
        save(Filename,'NL_DATA');
        NL_DATA = [];
        NL_INDEX = NL_INDEX + 1;
        continue;
    end
    if marker2index(index,2) == 50
        NH_Position = marker2index(index,1);
        NH_DATA = record(3:16,NH_Position:NH_Position+1279);
        NH_DATA = zscore(NH_DATA,2);
        NH_INDEX_str = num2str(NH_INDEX);
        Filename = ['f:\STUDY\Project 1_Shanshan\',subject_name,'\',subject_name,'_','Negative High No.',NH_INDEX_str,'.mat'];
        save(Filename,'NH_DATA');
        NH_DATA = [];
        NH_INDEX = NH_INDEX + 1;
        continue;
    end    
end
end