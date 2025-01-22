function CheckExistMkDir(dirname)

if ~exist(dirname)
    mkdir(dirname)
end