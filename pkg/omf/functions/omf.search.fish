function omf.search -d 'Searches all available packages'
  switch (count $argv);
    case 1;
      omf.index.update --if-missing

      echo (omf::under)"Plugins"(omf::off)
      __omf.search.output --type=plugin --text=$argv[1]
      echo
      echo (omf::under)"Themes"(omf::off)
      __omf.search.output --type=theme --text=$argv[1]

    case 2;
      omf.index.update --if-missing

      switch "$argv[1]"
        case "-p" "--plugin";
          __omf.search.output --type=plugin --text=$argv[2]
        case "-t" "--theme";
          __omf.search.output --type=theme --text=$argv[2]
        case '*';
          omf.help search
          return 1
      end

    case '*';
      omf.help search
      return 1
  end

  return 0
end

function __omf.search.output
  for package in (omf.index.query $argv)
    set -l desc (omf.index.stat $package description)
    echo "$package - $desc"
  end
end
