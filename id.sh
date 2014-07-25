# iDonethis Command-line Script
#
# Usage:
#    id <project> <message>
# Example:
#    id e working out today
#
function id() {
  local from_name
  local from_addr
  local to_addr
  local tag
  local personal_addr
  local body
  local strip

  ## Set your name & email address tied to your iDoneThis account here
  from_name="Your Name"
  from_addr="your@email.com"
  personal_addr="your-personal-calendar@team.idonethis.com"

  body=$@
  strip=1

  ## Setup differnt "projects", by doing `id X message`, where X is the project.
  if [[ "$1" == "project" ]]; then
    to_addr="project@team.idonethis.com"
    tag="#project"
  elif [[ "$1" == "project2" ]]; then
    to_addr="project2@team.idonethis.com"
    tag="#project2"
  elif [[ "$1" == "t" ]]; then
    tag="#time"
  else
    tag=""
    strip=0
  fi

  # Strip the project segment.
  if [[ $strip -eq 1 ]]; then
    body=$(echo $body | sed 's/^.\{2\}//')
  fi


  ## Email Specific List
  if [ -n "${to_addr}" ]; then
    printf "From: ${from_name} <${from_addr}>\nTo: ${to_addr}\nSubject: Sent via IDT for Terminal\n\n${body}\n" | /usr/sbin/sendmail -F "${from_name}" -f "${from_addr}" "${to_addr}"
  fi

  ## Email Personal List
  printf "From: ${from_name} <${from_addr}>\nTo: ${personal_addr}\nSubject: Sent via IDT for Terminal\n\n${body} ${tag}\n" | /usr/sbin/sendmail -F "${from_name}" -f "${from_addr}" "${personal_addr}"
}

alias id="noglob id"
