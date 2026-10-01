mmp_cd() {
  if [ "$#" -gt 1 ]; then
    builtin cd -- "$2"
  elif [ -n "${OLDPWD:-}" ]; then
    builtin cd -- -
  else
    builtin cd -- "$HOME"
  fi
}
