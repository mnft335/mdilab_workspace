function result = hoge(arg1, arg2)

    result = arg1 + arg2;

end

disp(func2str(@hoge));
disp(func2str(@(z) hoge(z, 1)));