function omf.core.asciidoc -d 'Render AsciiDoc for display in a terminal'
  set -l IFS ''

  set -l r (set_color normal ^ /dev/null)
  set -l c (set_color cyan ^ /dev/null)
  set -l b (set_color --bold ^ /dev/null)
  set -l u (set_color --underline ^ /dev/null)

  fold -s | sed -e "
    # Strip cross references.
    s/<<[^,]*,\([^>]*\)>>/\1/g

    # Definition lists.
    s/^\(\S.*\)::\(..*\)/\1\2/g
    s/^\(\S.*\)::/\1/g

    # Nice bullets for unordered lists.
    s/^[*-] /· /g

    # Indent everything left except for headers and the first line.
    2,\$ s/^[^=]/  &/

    # Headers.
    s/^==* \(.*\)/$b\1$r/

    # Bold.
    s/\*\*\([^\*]*\)\*\*/$c\1$r/g
    s/\*\([^\*]*\)\*/$c\1$r/g

    # Style italics as underline.
    s/__\([^_]*\)__/$u\1$r/g
    s/_\([^_]*\)_/$u\1$r/g

    # Underline links.
    s/\w\w*:\S\S*/$u&$r/g

    # Since we're in the terminal anyway, just strip monospace backticks.
    s/`\([^`]*\)`/\1/g

    # Underline variable names in angle brackets.
    s/<[^>]*>/$u&$r/g
  "
end
