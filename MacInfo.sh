(
  echo "<!DOCTYPE html>"
  echo "<html lang='de'>"
  echo "<head>"
  echo "  <meta charset='UTF-8'>"
  echo "  <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
  echo "  <title>Mac System Info</title>"
  echo "  <style>"
  echo "    body { font-family: SF Pro, Arial, sans-serif; margin: 20px; padding: 20px; background-color: #f4f4f4; }"
  echo "    .container { max-width: 800px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }"
  echo "    h1, h2 { color: #333; }"
  echo "    table { width: 100%; border-collapse: collapse; margin-top: 10px; }"
  echo "    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }"
  echo "    th { background-color: #39AFAD ; color: white; }"
  echo "    ul { list-style-type: none; padding: 0; }"
  echo "    li { background: #eee; margin: 5px 0; padding: 8px; border-radius: 4px; }"
  echo "    .footer { text-align: right; margin-top: 20px; font-weight: bold; }"
  echo "  </style>"
  echo "</head>"
  echo "<body>"
  echo "  <div class='container'>"
  echo "    <h1>Mac Systeminformationen</h1>"
  echo "    <table>"

  # macOS Version
  echo "      <tr><th>macOS Version</th><td>$(sw_vers -productVersion)</td></tr>"

  # Mac Modell
  echo "      <tr><th>Mac Modell</th><td>$(sysctl -n hw.model)</td></tr>"

  # CPU Modell
  CPU_MODEL=$(sysctl -n machdep.cpu.brand_string)
  echo "      <tr><th>CPU Modell</th><td>$CPU_MODEL</td></tr>"

  # CPU-Kerne & Threads
  CPU_CORES=$(sysctl -n machdep.cpu.core_count)
  CPU_THREADS=$(sysctl -n machdep.cpu.thread_count)
  echo "      <tr><th>CPU-Kerne & Threads</th><td>$CPU_CORES Kerne / $CPU_THREADS Threads</td></tr>"

  # RAM Größe
  echo "      <tr><th>RAM Größe</th><td>$(system_profiler SPHardwareDataType | awk '/Memory:/ {print $2, $3}')</td></tr>"

  # Seriennummer
  SERIAL=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
  echo "      <tr><th>Seriennummer</th><td>$SERIAL</td></tr>"

  # Mac Name
  echo "      <tr><th>Mac Name</th><td>$(scutil --get ComputerName)</td></tr>"

  echo "    </table>"

  # Installierte Programme
  echo "    <h2>Installierte Programme</h2>"
  echo "    <ul>"
  ls /Applications | awk '{print "      <li>" $0 "</li>"}'
  echo "    </ul>"

  # Footer mit Jensipdia rechtsbündig
  echo "    <div class='footer'>powerd by Jensipdia</div>"

  echo "  </div>"
  echo "</body>"
  echo "</html>"
) > ~/Downloads/"$(sysctl -n hw.model)-$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')-$(scutil --get ComputerName)-Mac_info.html"


