mmp_ls() {
  local argv=$*
  case "$argv" in
    "ls -a" ) ls -a ;;
    "ls -l" ) ls -l ;;
    "ls -al" | "ls -la" ) ls -al ;;
    "ls" ) ls ;;
    *) echo "Argument introuvable" ;;
  esac
}
