function [List,NotHere,Selected]=Random_Select_Person(varargin)
% [List,NotHere,Selected]=Random_Select_Person(ListPath)

    % Get path
    if ~isempty(varargin)
        path=varargin{1};
    else
        path='NameList.txt';
    end
    % Read List
    if ~exist(path,'file')
        error(['Cannot find ' path]);
    elseif exist(path,'file')~=2
        error(['Your path ' path ' is not a file']);
    end
    List={};
    fid=fopen(path,'r');
    while 1
        Line=fgetl(fid);
        if ~ischar(Line)
            break
        elseif isempty(Line)
            continue
        elseif strcmpi(Line(1:2),'//')
            continue
        else
            List{end+1}=Line;
        end
    end
    fclose(fid);
    % Random Select
    NotHere={};
    Selected={};
    Continue=1;
    while Continue
        LenList=length(List);
        Num=randi([1,LenList],1,1);
        Name=List{Num};
        disp(Name);
        if LenList-1==0
            disp('All members in list has been selected')
            break
        elseif Num==1
            List=List(2:end);
        elseif Num==LenList
            List=List(1:end-1);
        else
            List=List([1:Num-1 Num+1:end]);
        end
        while 1
            HereorNot=input('Here (Y or N)?: ','s');
            if strcmpi(HereorNot,'N')
                NotHere{end+1}=Name;
                break;
            elseif strcmpi(HereorNot,'Y')
                Selected{end+1}=Name;
                break;
            else
                disp('Unknown input')
            end
        end
        while 1
            ContinueorNot=input('Continue (c) or Not (N): ','s');
            if strcmpi(ContinueorNot,'c')
                Continue=1;
                break;
            elseif strcmpi(ContinueorNot,'N')
                Continue=0;
                break;
            else
                disp('Unknow input')
            end
        end
    end
end