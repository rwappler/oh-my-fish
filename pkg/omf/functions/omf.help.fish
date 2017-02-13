function omf.help
  set -l IFS ''
  set -l doc_root $OMF_PATH/docs/commands
  set -l doc $doc_root/omf.adoc

  if set -q argv[1]
    if not set command (omf.core.command $argv[1])
      echo (omf::err)"Unknown command: $argv[1]"(omf::off) >&2
      return $OMF_UNKNOWN_OPT
    end

    set doc $doc_root/$command.adoc
  end

  omf.core.asciidoc < $doc
end
