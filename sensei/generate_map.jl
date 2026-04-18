using JSON3, Dates

function extract_notes(filepath)
    content = read(filepath, String)
    notes = String[]
    for m in eachmatch(r"#=\s*NOTES\s*\n(.*?)=#"s, content)
        push!(notes, strip(m.captures[1]))
    end
    return notes
end

function collect_chapter_notes(exercises_dir, chapter_num)
    # Find chapter folder matching ch{N}_*
    !isdir(exercises_dir) && return Dict{String,Vector{String}}()
    results = Dict{String,Vector{String}}()
    for d in readdir(exercises_dir; join=true)
        isdir(d) || continue
        dirname = basename(d)
        m = match(r"^ch(\d+)_", dirname)
        m === nothing && continue
        parse(Int, m.captures[1]) == chapter_num || continue
        # Scan all .jl files in this chapter folder
        for f in readdir(d; join=true)
            endswith(f, ".jl") || continue
            fname = replace(basename(f), ".jl" => "")
            label = replace(fname, "_" => " ")
            notes = extract_notes(f)
            isempty(notes) || (results[label] = notes)
        end
    end
    return results
end

function html_escape(s)
    s = replace(s, "&" => "&amp;")
    s = replace(s, "<" => "&lt;")
    s = replace(s, ">" => "&gt;")
    s = replace(s, "\"" => "&quot;")
    return s
end

function generate()
state = JSON3.read(read(joinpath(@__DIR__, "state.json"), String))
exercises_dir = joinpath(@__DIR__, "exercises")

mastery_colors = Dict(0 => "#e0e0e0", 1 => "#ef5350", 2 => "#ffcc02", 3 => "#66bb6a")
mastery_labels = Dict(0 => "Not Started", 1 => "Started", 2 => "Practicing", 3 => "Mastered")
mastery_icons = Dict(0 => "&#9744;", 1 => "&#9733;", 2 => "&#9733;&#9733;", 3 => "&#9733;&#9733;&#9733;")

nodes = state.nodes
total = length(nodes)
mastered = count(n -> n.mastery == 3, nodes)
started = count(n -> n.mastery >= 1, nodes)

chapters = sort(unique(n.chapter for n in nodes))

# Build chapter HTML blocks
chapter_html = ""
for ch in chapters
    ch_nodes = filter(n -> n.chapter == ch, nodes)
    ch_notes = collect_chapter_notes(exercises_dir, ch)

    cards = ""
    for (i, n) in enumerate(ch_nodes)
        color = mastery_colors[n.mastery]
        label = mastery_labels[n.mastery]
        icon = mastery_icons[n.mastery]
        border = n.mastery == 3 ? "3px solid #388e3c" : n.mastery == 2 ? "3px solid #f9a825" : n.mastery == 1 ? "3px solid #ef5350" : "2px solid #ccc"
        card_id = "card-ch$(ch)-$(i)"

        # Build notes panel from all exercises in this chapter
        notes_html = ""
        if n.mastery >= 1 && !isempty(ch_notes)
            for (ex_name, note_blocks) in sort(collect(ch_notes))
                notes_html *= """<div class="notes-exercise"><div class="notes-exercise-title">$(html_escape(ex_name))</div>"""
                for block in note_blocks
                    for line in split(block, "\n")
                        line = strip(line)
                        isempty(line) && continue
                        # Strip leading "- " for list items
                        if startswith(line, "- ")
                            notes_html *= """<div class="notes-line">&#8226; $(html_escape(line[3:end]))</div>"""
                        else
                            notes_html *= """<div class="notes-line" style="font-weight:600;">$(html_escape(line))</div>"""
                        end
                    end
                end
                notes_html *= "</div>"
            end
        end

        has_notes = !isempty(notes_html)
        clickable = has_notes ? "cursor: pointer;" : ""
        onclick = has_notes ? "onclick=\"toggleNotes('$(card_id)')\"" : ""

        cards *= """
        <div class="card" style="border: $(border); background: $(color)20; $(clickable)" $(onclick)>
          <div class="card-icon">$(icon)</div>
          <div class="card-title">$(n.title)$(has_notes ? " <span class='click-hint'>&#9660;</span>" : "")</div>
          <div class="card-desc">$(n.description)</div>
          <div class="card-meta">
            <span class="badge" style="background: $(color);">$(label)</span>
            <span>Attempts: $(n.attempts)</span>
            <span>Hints: $(n.hints_used)</span>
          </div>
          $(has_notes ? "<div class=\"notes-panel\" id=\"$(card_id)\" style=\"display:none;\">$(notes_html)</div>" : "")
        </div>
        """
    end
    chapter_html *= """
    <div class="chapter">
      <h2>Chapter $(ch)</h2>
      <div class="cards">$(cards)</div>
    </div>
    """
end

# Sessions log
session_html = ""
for s in state.sessions
    session_html *= """
    <tr>
      <td>$(s.date)</td>
      <td>$(s.node_id)</td>
      <td>$(s.challenges_completed)</td>
      <td>$(s.hints_used)</td>
      <td>$(s.mastery_before) &rarr; $(s.mastery_after)</td>
    </tr>
    """
end

html = """
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sensei | $(state.course_title)</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
         background: #1a1a2e; color: #e0e0e0; padding: 2rem; }
  h1 { font-size: 1.8rem; color: #fff; margin-bottom: 0.5rem; }
  .subtitle { color: #aaa; margin-bottom: 2rem; font-size: 0.95rem; }
  .progress-bar { background: #333; border-radius: 12px; height: 24px; margin-bottom: 2rem; overflow: hidden; position: relative; }
  .progress-fill { height: 100%; border-radius: 12px; transition: width 0.5s; }
  .progress-started { background: linear-gradient(90deg, #ef5350, #ffcc02); }
  .progress-mastered { background: linear-gradient(90deg, #388e3c, #66bb6a); }
  .progress-label { position: absolute; top: 2px; left: 50%; transform: translateX(-50%); font-size: 0.8rem; font-weight: 600; color: #fff; }
  .stats { display: flex; gap: 2rem; margin-bottom: 2rem; }
  .stat { background: #16213e; padding: 1rem 1.5rem; border-radius: 10px; text-align: center; }
  .stat-value { font-size: 2rem; font-weight: 700; color: #ffcc02; }
  .stat-label { font-size: 0.8rem; color: #aaa; }
  .chapter { margin-bottom: 2rem; }
  .chapter h2 { font-size: 1.2rem; color: #ffcc02; margin-bottom: 0.8rem; padding-bottom: 0.3rem; border-bottom: 1px solid #333; }
  .cards { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1rem; }
  .card { background: #16213e; border-radius: 10px; padding: 1rem; transition: transform 0.2s; }
  .card:hover { transform: translateY(-2px); }
  .card-icon { font-size: 1.2rem; margin-bottom: 0.3rem; }
  .card-title { font-weight: 600; font-size: 1rem; color: #fff; margin-bottom: 0.4rem; }
  .card-desc { font-size: 0.8rem; color: #aaa; margin-bottom: 0.6rem; line-height: 1.4; }
  .card-meta { display: flex; gap: 0.8rem; font-size: 0.75rem; color: #888; align-items: center; }
  .badge { padding: 2px 8px; border-radius: 6px; font-size: 0.7rem; font-weight: 600; color: #1a1a2e; }
  .click-hint { font-size: 0.7rem; color: #666; transition: transform 0.3s; display: inline-block; }
  .click-hint.open { transform: rotate(180deg); }
  .notes-panel { margin-top: 0.8rem; padding-top: 0.8rem; border-top: 1px solid #333; }
  .notes-exercise { margin-bottom: 0.8rem; }
  .notes-exercise-title { font-size: 0.85rem; font-weight: 600; color: #ffcc02; margin-bottom: 0.3rem; text-transform: capitalize; }
  .notes-line { font-size: 0.8rem; color: #ccc; line-height: 1.6; padding-left: 0.5rem; }
  table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
  th { text-align: left; padding: 0.6rem; background: #16213e; color: #ffcc02; font-size: 0.85rem; }
  td { padding: 0.6rem; border-bottom: 1px solid #333; font-size: 0.85rem; }
  .sessions { margin-top: 2rem; }
  .sessions h2 { font-size: 1.2rem; color: #ffcc02; margin-bottom: 0.5rem; }
  .legend { display: flex; gap: 1.5rem; margin-bottom: 1.5rem; font-size: 0.8rem; }
  .legend-item { display: flex; align-items: center; gap: 0.4rem; }
  .legend-dot { width: 14px; height: 14px; border-radius: 4px; }
</style>
</head>
<body>
<h1>&#x1F94B; Sensei Progress</h1>
<div class="subtitle">$(state.course_title)</div>

<div class="stats">
  <div class="stat"><div class="stat-value">$(started)</div><div class="stat-label">Started</div></div>
  <div class="stat"><div class="stat-value">$(mastered)</div><div class="stat-label">Mastered</div></div>
  <div class="stat"><div class="stat-value">$(total)</div><div class="stat-label">Total Nodes</div></div>
</div>

<div class="progress-bar">
  <div class="progress-fill progress-mastered" style="width: $(round(mastered/total*100, digits=1))%;"></div>
  <div class="progress-fill progress-started" style="width: $(round(started/total*100, digits=1))%; position: absolute; top: 0; opacity: 0.5;"></div>
  <div class="progress-label">$(mastered)/$(total) mastered</div>
</div>

<div class="legend">
  <div class="legend-item"><div class="legend-dot" style="background: #e0e0e0;"></div> Not Started</div>
  <div class="legend-item"><div class="legend-dot" style="background: #ef5350;"></div> Started</div>
  <div class="legend-item"><div class="legend-dot" style="background: #ffcc02;"></div> Practicing</div>
  <div class="legend-item"><div class="legend-dot" style="background: #66bb6a;"></div> Mastered</div>
</div>

$(chapter_html)

<div class="sessions">
  <h2>Session Log</h2>
  <table>
    <tr><th>Date</th><th>Node</th><th>Challenges</th><th>Hints</th><th>Mastery</th></tr>
    $(session_html)
  </table>
</div>

<div style="margin-top: 2rem; font-size: 0.75rem; color: #555;">
  Generated $(Dates.format(Dates.now(), "yyyy-mm-dd HH:MM"))
</div>

<script>
function toggleNotes(id) {
  var panel = document.getElementById(id);
  var card = panel.parentElement;
  var hint = card.querySelector('.click-hint');
  if (panel.style.display === 'none') {
    panel.style.display = 'block';
    if (hint) hint.classList.add('open');
  } else {
    panel.style.display = 'none';
    if (hint) hint.classList.remove('open');
  }
}
</script>
</body>
</html>
"""

outpath = joinpath(@__DIR__, "progress.html")
write(outpath, html)
println("Progress map written to: ", outpath)
end # function

generate()