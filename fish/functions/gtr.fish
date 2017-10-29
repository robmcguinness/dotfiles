
# show remote git tags
#
#     ❯ gtr
#     From https://robmcguinness@github.com/Availity/availity-ekko
#     v1.0.0
#     v1.0.1
#     v1.1.0
#     v1.2.0
#
function gtr --description 'Git list remote tags'
  bass git ls-remote --tags | awk '{ print $2}' | sed -e 's;^refs/tags/;;' -e 's;\^{};;' | sort | uniq
end