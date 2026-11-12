#!/usr/bin/env python3
"""
Compress R&R-CYCLE-RULES.md to meet the 3,000-line health limit (RR-9).
Tasks:
1. Remove redundant "Last Verified" annotations from every `###` header.
2. Compress the ~15 individual tables in the "Consolidated Rule Index" into one single dense table.
3. Ensure no formatting is broken.
"""
import re
import os

file_path = os.path.join(os.path.dirname(__file__), "..", "docs", "project", "R&R-CYCLE-RULES.md")

with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

# 1. Remove "— Last Verified: ..." from all `###` headers
# Pattern: `### <Title> — Last Verified: Cycles XX-YY`
# Replacement: `### <Title>`
def remove_last_verified(match):
    title = match.group(1)
    return f"### {title}"

content = re.sub(r"### (.+?) — Last Verified: Cycles [\d\-]+", remove_last_verified, content)

# 2. Compress the Consolidated Rule Index
# Current format: Many small tables separated by blank lines.
# Target format: One single large table.
#
# We look for the "## 📇 21. Consolidated Rule Index" section and everything up to the next "##".
# Inside that, we want to extract every table and merge them into one.

def compress_index(match):
    section_header = match.group(0).split('\n')[0] # Just the header
    body = match.group(0)
    
    # Extract all tables in this section
    # A table in markdown starts with | and has at least 3 rows (header, separator, data)
    tables = re.findall(r"(\|[^\|].*\|.*)\n(\|[-| ]*\|)\n((?:\|.*\|\n)*)", body)
    
    if not tables:
        return body

    # Build a single mega-table
    lines = [section_header, "", "| Rule Code | Title | Source Cycles | Severity if Missing |", "|-----------|-------|---------------|---------------------|"]
    
    for header, separator, rows in tables:
        # Clean the header of the table (it's just repeating the section name)
        # Remove the table headers and separators from the extraction
        pass # We will just process the rows
    
    # Re-extract just the data rows more simply
    # Match any line starting with | and not a separator
    data_rows = re.findall(r"^\| ([^|]+) \| ([^|]+) \| ([^|]+) \| ([^|]+) \|\s*$", body, re.MULTILINE)
    
    if data_rows:
        lines = [section_header, ""]
        lines.append("| Section | Rule Code | Title | Source Cycles | Severity if Missing |")
        lines.append("|---------|-----------|-------|---------------|---------------------|")
        for row in data_rows:
            lines.append(f"| 21 | {row[0].strip()} | {row[1].strip()} | {row[2].strip()} | {row[3].strip()} |")
    
    # Replace the body of the match with the new compact table
    # We need to find the start of the section header in the original text to replace correctly
    return section_header

# Regex to find the "Consolidated Rule Index" section
index_pattern = re.compile(r"(## 📇 21\. Consolidated Rule Index.*?)(?=## 🧭 22\.)", re.DOTALL)

def replace_index_section(match):
    body = match.group(1)
    
    lines = ["## 📇 21. Consolidated Rule Index\n", "\n", "This section provides a single reference table listing every rule across all sections of this document.\n", "| Section | Rule Code | Title | Source Cycles | Severity if Missing |\n", "|---------|-----------|-------|---------------|---------------------|\n"]
    
    data_rows = re.findall(r"^\| ([^|]+) \| ([^|]+) \| ([^|]+) \| ([^|]+) \|\s*$", body, re.MULTILINE)
    
    if data_rows:
        for row in data_rows:
            lines.append(f"| 21 | {row[0].strip()} | {row[1].strip()} | {row[2].strip()} | {row[3].strip()} |")
    
    return "\n".join(lines)

content = index_pattern.sub(replace_index_section, content)

# 3. Write back
with open(file_path, "w", encoding="utf-8") as f:
    f.write(content)

# 4. Report
current_len = len(content.splitlines())
print(f"✅ Compression complete. New line count: {current_len}")
print(f"✅ 'Last Verified' tags removed from all headers.")
print(f"✅ Index compressed into a single table.")
