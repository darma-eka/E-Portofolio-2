# Read file as UTF-8
$content = [System.IO.File]::ReadAllText("d:\PPG\Courses\Backup eporto\E-Portofolio2\index.html", [System.Text.Encoding]::UTF8)

# === MARQUEE BULLET: â€¢ -> &bull; ===
$content = $content.Replace([char]0x00E2 + [string][char]0x20AC + [char]0x00A2, '&bull;')

# === EM DASH: â€" -> &mdash; ===
$content = $content.Replace([char]0x00E2 + [string][char]0x20AC + [char]0x201C, '&ndash;')

# === CLOSE BUTTON: âœ• -> &times; ===
$content = $content.Replace([char]0x00E2 + [string][char]0x0153 + [char]0x2022, '&times;')

# === ARROW UP-RIGHT: â†— -> &#8599; ===
$content = $content.Replace([char]0x00E2 + [string][char]0x2020 + [char]0x2014, '&#8599;')

# === CERT ARROW â† -> &#8592; (left arrow used as icon) ===
# Actually these should be arrow icons for cert buttons
# Let's just use simple HTML entities

# Now handle all the broken emoji sequences. These are UTF-8 emoji bytes
# misread as latin1. We'll replace them with proper HTML entities.

# ðŸ"„ -> 📄 (page facing up)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x201C + [char]0x201E, '&#128196;')

# ðŸš€ -> 🚀 (rocket)  
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x0161 + [char]0x20AC, '&#128640;')

# ðŸŽ¯ -> 🎯 (direct hit/target)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x0152 + [char]0x00AF, '&#127919;')

# ðŸ'» -> 💻 (laptop)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x2019 + [char]0x00BB, '&#128187;')

# ðŸ›¡ï¸ -> 🛡️ (shield)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x203A + [char]0x00A1 + [char]0x00EF + [char]0x00B8 + [char]0x008F, '&#128737;')

# ðŸ¤ -> 🤝 (handshake) — only partial match visible
# Actually let's search more carefully

# ðŸ"š -> 📚 (books)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x201C + [char]0x0161, '&#128218;')

# ðŸŽ" -> 🎓 (graduation cap)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x0152 + [char]0x201C, '&#127891;')

# ðŸ'¥ -> 👥 (busts in silhouette)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x2019 + [char]0x00A5, '&#128101;')

# ðŸŒŸ -> 🌟 (glowing star)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x0152 + [char]0x0178, '&#127775;')

# ðŸ" -> 🔍 (magnifying glass / search)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x201C + [char]0x0027, '&#128269;')

Write-Host "Phase 1 done. Now doing simpler text replacements..."

# Now do the remaining ones with simple string matching on the visible mojibake text
# These are the ones in the JS template strings for analisis

# ðŸ"˜ -> 📘 (blue book emoji)
$content = $content.Replace([char]0x00F0 + [string][char]0x0178 + [char]0x201C + [char]0x0098 + [char]0x0027, '&#128216;')

Write-Host "Phase 2 done."

# Write back as UTF-8 with BOM
[System.IO.File]::WriteAllText("d:\PPG\Courses\Backup eporto\E-Portofolio2\index.html", $content, [System.Text.Encoding]::UTF8)

Write-Host "File saved."
