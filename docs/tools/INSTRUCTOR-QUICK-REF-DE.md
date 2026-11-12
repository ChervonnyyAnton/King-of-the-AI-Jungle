# 👨‍🏫 Instructor Quick-Ref-Karte: King of the Jungle

## 🧭 Schnelle Navigation

| Abschnitt | Thema | Zeilen |
|-----------|-------|-------|
| 0 | **Schnelles Troubleshooting** | 63–107 |
| 1 | **Rollendefinitionen** | 32–62 |
| 2 | **3-Stunden-Lieferstrom** | 108–121 |
| 3 | **Day-0 Mapping-Matrix** | 122–136 |
| 4 | **Judging-Checkliste** | 137–179 |
| 5 | **Ressourcen-Zuteilungsliste** | 180–193 |
| 6 | **Token-Verteilung** | 194–208 |
| 7 | **Automatisches Day-0-Setup** | 209–228 |
| 8 | **Judging-Rubric-Validierung** | 229–256 |
| 9 | **Erste 5 Minuten Skript** | 257–263 |
| 10 | **Pacing & Energiemanagement** | 264–277 |
| 11 | **Komplementäre Pairing-Strategie** | 278–308 |
| 12 | **Flow-State-Schutz** | 309–331 |
| 13 | **Instructor-Presence-Levels** | 332–346 |
| 14 | **Lerner-Autonomie & Hinweis-Karten** | 347–378 |
| 15 | **Schritt 4: Showdown-Format** | 379–405 |
| 16 | **Feier & Anerkennung** | 406–431 |
| 17 | **Workshop-Nachbereitung** | 432–463 |
| 18 | **Kontinuierliche Lernwege** | 464–484 |
| 19 | **Gamification & Leaderboard** | 485–560 |
| 20 | **Analytics Dashboard** | 561–611 |

---

> **Drucken Sie diese Karte. Halten Sie sie während der Lieferung sichtbar. Hard Stops durchsetzen.**

## 1. Rollendefinitionen

### Instructor-Verantwortlichkeiten
- **Moderieren, nicht teilnehmen.** Participants zu ihrem Jungle-Titel-Weg führen; keinen Code oder keine Artefakte dafür schreiben.
- **Hard Stops durchsetzen.** Den 3-Stunden-Lieferstrom-Timer verwenden. Keine Verlängerung über geplante Segmente hinaus.
- **Effizient troubleshooting.** Die Troubleshooting-Tabelle (Section 0) verwenden — max. 3 Minuten pro Problem, bevor Eskalation erfolgt.
- **Fair bewerten.** Das Judging-Rubric (Section 5) mit kalibrierten Bewertungen verwenden.
- **Budget-Disziplin einhalten.** Gesamte KI-Nutzung des Workshops tracken; Participants bei $45 warnen.

### Participant-Verantwortlichkeiten
- **Ihren Jungle-Titel-Weg folgen.** Das Prompt-Tooling-Set für ihren spezifischen Weg verwenden.
- **Eigenes KI-Budget verwalten.** Nutzung in `BUDGET-LOG.md` tracken. Keine instructor-verwaltete Token-Zuteilung.
- **Eigene Artefakte produzieren.** Risikoanalyse, Testplan, Code — alles Participant-Eigentum.
- **Selbst troubleshooting zuerst.** `INSTRUCTOR-QUICK-REF.md` Troubleshooting-Sektion konsultieren, bevor die Hand gehoben wird.

### Autoritätsgrenzen
| Scenario | Instructor-Aktion |
|----------|-------------------|
| Participant >10 Min. feststeckend | Hinweis anbieten, dann weitergehen; am Ende aufgreifen |
| Budget überschreitet $45 | Cloud-Modell deaktivieren; alle auf Sovereign umstellen |
| Technisches Problem nach 3 Min. nicht gelöst | Vorbereitete Lösung anwenden; nicht live debuggen |
| Participant fragt nach direkter Antwort | Nur sokratische Führung — "Was sagt die Fehlermeldung?" |
| Thementverwandte Frage | Parking-Lot-Technik — in den letzten 10 Min. beantworten |

### ⚠️ Anti-Patterns (Was Instructors NICHT tun dürfen)
- ❌ Participant-Code oder Prompts schreiben
- ❌ Participant-Artefakte eigenmächtig vervollständigen
- ❌ Zeit über Hard Stops hinaus verlängern
- ❌ Direkte Antworten geben — immer mit Fragen führen
- ❌ Subjektive Eindrücke bewerten — das Rubric verwenden

## 🚨 Schnelles Troubleshooting

### 🔍 Quick-Triage-Entscheidungsbäumen
1. **Ist es ein KI/Chat-Problem?** → Siehe Section A (KI & Modell-Probleme) unten.
2. **Ist es ein Tooling-Problem?** → Siehe Section B (Setup & Tooling) unten.
3. **Ist es ein App-Problem?** → Siehe Section C (Mock App & Daten) unten.
4. **Ist es ein Budget-Problem?** → Siehe Section D (Token & Kosten) unten.

### A. KI & Modell-Probleme
| Symptom | Aktion |
|---------|--------|
| **Fehlender API-Schlüssel** | `opencode.json.template` öffnen. In `opencode.json` kopieren. `{YOUR_SOVEREIGN_KEY}`, `{SOVEREIGN_URL}`, `{YOUR_CLOUD_KEY}`, `{CLOUD_URL}` mit Werten vom KI-Hub-Admin ersetzen. Keine Leerzeichen nach dem Schlüssel. |
| **opencode.json Syntaxfehler** | `cat opencode.json | python3 -m json.tool` zur Validierung ausführen. Kommas am Ende korrigieren. Prüfen, ob alle `{YOUR_*}`-Platzhalter ersetzt wurden. |
| **KI-Chat startet nicht** | API-Schlüssel ausgefüllt (nicht `{YOUR_KEY}`). `opencode.json`-Syntax prüfen. VS Code KI-Erweiterung neustarten. |
| KI-Modell-Umschlag schlägt fehl | Modell-ID in `opencode.json` prüfen. API-Schlüssel-Validität prüfen. |
| API-Ratenbegrenzung getroffen (429) | 30 Sekunden warten. Context pruning. Zum Sovereign-Modell wechseln. |
| Context-Window-Überlauf | Agent bitten: "Previous content to ≤512 tokens summarize." |
| Prompt-Injection-Ablehnung | Normales Verhalten. Bestätigen, dass Injection erkannt → korrekt. Bei False Positive, injiziertes Pattern in Benutzer-Eingabe prüfen. |
| Cloud-Modell nicht verfügbar | Budget-Warnung deaktiviert Cloud automatisch. Alle Anfragen gehen an Sovereign. |

### B. Setup & Tooling-Probleme
| Symptom | Aktion |
|---------|--------|
| Playwright schlägt fehl | `npx playwright install` ausführen. `playwright.config.js` prüfen. |
| `opencode.json` Syntaxfehler | `cat opencode.json | python3 -m json.tool` zur Validierung ausführen. Kommas am Ende korrigieren. |
| VS Code-Erweiterung lädt nicht | Fenster neu laden (Cmd+Shift+P → "Developer: Reload Window"). |
| Terminal-Befehl nicht gefunden | PATH prüfen. `which node` ausführen, um Node.js-Install zu verifizieren. |
| Port 3000 in Verwendung | `lsof -i :3000` zum Finden des Prozesses ausführen. Beenden oder anderen Port verwenden: `npx serve mock/ -p 3001`. |

### C. Mock App & Daten-Probleme
| Symptom | Aktion |
|---------|--------|
| App lädt nicht | `npx serve mock/` ausführen. Port 3000 muss frei sein. |
| JSON-Import stürzt ab | App verwendet jetzt strikte Validierung. `importConfig()` in Konsole prüfen. |
| Datentabelle wird nicht gerendert | `?debug=true` in URL sicherstellen, um Grid `data-testid` zu sehen. JSON-Format in Seitenleiste prüfen. |
| Browser-Cache-Problem | Hart aktualisieren (Cmd+Shift+R). Site-Daten in DevTools löschen. |
| JSON-Validierungsfehler | JSON-Struktur entspricht den Anforderungen der Mock App. `?debug=true` verwenden, um geparste Daten zu sehen. |

### D. Token & Kosten-Probleme
| Symptom | Aktion |
|---------|--------|
| Budget-Warnung ($45-Alarm) | Alle Agenten auf `qwen-sovereign` umstellen. Cloud-Modell in `opencode.json` deaktiviert verifizieren. |
| Token-Tracking ungenau | Participants sollten große Aufgaben manuell in `BUDGET-LOG.md` protokollieren (Fallback). |
| Cloud-Modell automatisch deaktiviert | Normales Verhalten. Alle Arbeiten fahren mit Sovereign-Modell fort. |

## ⏱ 3-Stunden-Lieferstrom (Hard Stops)
| Zeit | Segment | Puffer |
|------|---------|--------|
| 00:00-00:15 | Setup & Weg-Auswahl | +2 Min. |
| 00:15-00:25 | Theorie & Jungle-Legende | +2 Min. |
| 00:25-00:45 | Geführte Demo | +3 Min. |
| 00:45-01:15 | Unabhängiger Sprint (nach Weg) | +5 Min. |
| 01:15-01:30 | Pause | - |
| 01:30-02:15 | Automatisierung & Review | +5 Min. |
| 02:15-02:30 | Peer-Review-Sitzung | +3 Min. |
| 02:30-02:45 | Showdown & Judges | +2 Min. |
| 02:45-03:00 | Abschluss & Feedback | - |
*Verwenden Sie die "Parking-Lot"-Technik für themenverwandte Fragen. Nur in den letzten 10 Min. beantworten.*

## 🗺️ Day-0 Participant-Mapping-Matrix
Verwenden Sie dies, um Participants zu ihrem Weg zu führen, wenn sie unsicher sind:

| Wenn sie... | Und ihre KI-Erfahrung ist... | Sagen Sie, sie sollen wählen... |
|-------------|-------------------------------|--------------------------------|
| Manual Tester | Neu bei KI | **Trail Explorer** (A1) |
| Manual Tester | Vertraut mit ChatGPT | **River Ranger** (A2) |
| Manual Tester | Experte bei Prompt Engineering | **Scout Leader** (A3) |
| QA Engineer | Neu bei KI | **Camp Builder** (B1) |
| QA Engineer | Fortgeschritten mit Tools | **Jungle Guide** (B2) |
| Automation Engineer | Neu bei KI | **Gear Caster** (D1) |
| Automation Engineer | Experte bei KI | **Automation Wizard** (D4) |
| Architect | Neu bei KI | **Explorer** (F1) |
| Architect | Experte bei KI | **King of the Jungle** (F4) |

## 🏆 Judging-Checkliste (Weg-relativ)
Das Judging ist **relativ zum Jungle-Titel**. Verwenden Sie die 5-Punkte-Rubric-Tabellen (Scouts, Engineers, Architects) mit expliziten Kategoriengewichtungen. Führen Sie eine **Vor-Judging-Kalibrierung** (10 Min.) durch, bevor Sie Participants bewerten.

### Scouts (A/B/C Wege)
*Hauptziel: Strategie, Risiko und Berichterstattung — KI effektiv zum Brainstorming und Planen verwenden.*

**Kategoriegewichtungen:** KI-Nutzung 15%, Risikoanalyse 25%, Testplan 25%, Budget-Tracking 10%, Peer-Review 15%, Pfadübergreifender Beitrag 10%.

| Kriterium | Nicht ausreichend (1) | Unter Erwartungen (2) | Erfüllt Erwartungen (3) | Über Erwartungen (4) | Herausragend (5) |
|-----------|--------------------|------------------------|------------------------|------------------------|---------------|
| **KI-Nutzung** | Keine KI-Interaktion; komplett ohne KI-Tool gearbeitet | ≥1 KI-Tool mit grundlegenden Prompts verwendet; grundlegendes Output produziert | KI zum Brainstorming und Formatieren verwendet; strukturiertes Output produziert | KI iterativ verwendet — promptend, kritisierend, und basierend auf KI-Output verfeinert | KI iterativ verwendet — promptend, kritisierend, verfeinert, und **KI-Output gegen Anforderungen validiert**; Prompt-Evolution dokumentiert |
| **Risikoanalyse** | <3 Risikokategorien; keine Mitigationen für Kritische/Hohe Risiken | ≥3 Risikokategorien identifiziert; ≥1 Mitigation pro Kritischer/Hoher Risiko | Alle identifizierten Risiken haben Mitigationen; Kategorien decken technisch + sicherheitstechnisch + UX ab | Risikomodell umfasst quantifizierte Wahrscheinlichkeits-/Auswirkungswerte; verweist auf ≥3 Tickets | Umfangreiches Risikomodell mit quantifizierten Werten, Abhängigkeits-Mapping und ROI-verknüpften Mitigationen |
| **Testplan** | <5 Testfälle; keine ISTQB-Technik verwendet | ≥5 Testfälle; ≥1 ISTQB-Technik verwendet | ≥8 Testfälle; ≥3 ISTQB-Techniken; klare erwartete Ergebnisse | Testfälle decken positiv, negativ, Barrierefreiheit und Randfälle ab; auf Tickets zurückführbar | Testfälle umfassen explorative Szenarien; automatisiert wo möglich; Rückführbarkeitsmatrix produziert |
| **Budget-Tracking** | BUDGET-LOG.md nicht erstellt oder leer | BUDGET-LOG.md mit ≥3 Einträgen erstellt | BUDGET-LOG.md während des gesamten Prozesses getrackt; gesamt <$50 | BUDGET-LOG.md umfasst Aufgabenaufschlüsselung; identifiziert Hauptkosten Treiber | BUDGET-LOG.md umfasst Kosten-Nutzen-Analyse von KI-Tool-Wahlen mit Empfehlungen |
| **Peer-Review** | Peer-Arbeit nicht Reviewed oder kein Feedback gegeben | Peer-Arbeit gegen Checkliste geprüft; Probleme notiert | ≥2 umsetzbare Probleme in Peer-Arbeit gefunden | ≥2 umsetzbare Probleme gefunden; nach Schweregrad priorisiert | Spezifische Verbesserungsvorschläge gemacht, nicht nur Fehlerberichte; Peer hat Vorschläge umgesetzt |
| **Pfadübergreifender Beitrag** | Keine pfadübergreifende Interaktion | Notizen mit 1 Peer von einem anderen Weg geteilt | ≥1 Peer von einem anderen Weg mit konstruktivem Feedback mentoriert | Qualitätsaudit verweist auf spezifische Peer-Artefakte eines anderen Wegs | Prozessverbesserungen vorgeschlagen, die den Workflow des gesamten Teams über Wege hinweg verbessern |

### Engineers (D/E Wege)
*Hauptziel: Ausführung, Automatisierung und CI/CD — mit KI debuggen und optimieren, nicht nur kopieren-einfügen.*

**Kategoriegewichtungen:** KI-Nutzung 15%, Code-Qualität 30%, CI/CD 25%, Präsentation 10%, Debugging-Effektivität 20%.

| Kriterium | Nicht ausreichend (1) | Unter Erwartungen (2) | Erfüllt Erwartungen (3) | Über Erwartungen (4) | Herausragend (5) |
|-----------|--------------------|------------------------|------------------------|------------------------|---------------|
| **KI-Nutzung** | KI nur für initialen Boilerplate-Code verwendet; Output nicht Reviewed oder modifiziert | ≥50% des KI-generierten Codes modifiziert; einige Randfälle behandelt | KI iterativ verwendet — Fehler analysiert, Fixes vorgeschlagen, Lösungen validiert | KI zum Debuggen komplexer Fehler verwendet; KI-generierte Lösungen gegen manuelle Ansätze benchmarked | KI als Co-Pilot throughout verwendet — automatisierte Testgenerierung, selbstheilende Selector, CI-Optimierung |
| **Code-Qualität** | Keine Tests geschrieben; oder Tests verwenden hardcodierte Selector, keine Randfälle | Tests verwenden `data-testid`-Selector; grundlegende Assertions vorhanden | Tests decken Randfälle ab (leere Eingabe, ungültiges JSON); Assertions decken UI + Benachrichtigungen ab | Tests umfassen datengetriebene Szenarien; wiederverwendbare Hilfsmethoden oder Page Objects | Tests verwenden POM-Muster; umfassen Retry-Logik, visuelle Validierung und Fehlerbehandlung; Abdeckung >80% |
| **CI/CD** | Pipeline-Design deckt grundlegende Testausführung ab | Pipeline enthält Token-Budget-Grenze und Retry-Strategie für flaky Tests | Pipeline enthält Qualitätsziele (Abdeckungsschwelle, Linting); läuft bei jedem PR | Pipeline enthält parallele Testausführung, Artifact-Archivierung und Slack/E-Mail-Benachrichtigungen | Vollständige CI/CD: Auto-Deploy bei Merge, Canary-Deployments, Leistungsregressionserkennung |
| **Präsentation** | Kann nicht erklären, was jeder Test macht | Kann erklären, was jeder Test macht | Kann die User-Journey erklären, die die Tests abdecken | Lücken in der User-Journey identifiziert, die kein Test abdeckt; neue Testabdeckung vorgeschlagen | Architekturänderungen vorgeschlagen, um Testbarkeit der Anwendung selbst zu verbessern |
| **Debugging-Effektivität** | Kann Testfehler nicht diagnostizieren; benötigt Instructor-Intervention | Oberflächliche Probleme identifiziert (falscher Selector, fehlendes Element) | Root Cause diagnostiziert (Timing-Problem, State-Mismatch); eigenständig behoben | Komplexe Fehler diagnostiziert (Race Conditions, flaky Tests); präventive Maßnahmen vorgeschlagen | Debugging-Tools oder -Utilities für das Team erstellt; gemeinsame Fehlermuster dokumentiert |

### Architects (F Weg)
*Hauptziel: Systemdesign und ROI — Systeme designen und das Ökosystem optimieren.*

**Kategoriegewichtungen:** KI-Nutzung 10%, Qualitätsmodell 25%, Strategie 25%, Einfluss 20%, Präsentation 20%.

| Kriterium | Nicht ausreichend (1) | Unter Erwartungen (2) | Erfüllt Erwartungen (3) | Über Erwartungen (4) | Herausragend (5) |
|-----------|--------------------|------------------------|------------------------|------------------------|---------------|
| **KI-Nutzung** | KI nur zum Generieren von Ideen und Entwerfen von Dokumenten verwendet | KI zum Simulieren von Szenarien und Stress-Testen von Designs verwendet | KI zum Benchmarking von Designs gegen Industrie-Standards und Best Practices verwendet | KI zum iterativen Verfeinern von Designs basierend auf simulierten Ergebnissen verwendet | KI zum automatisierten Szenarioanalyse über mehrere Dimensionen verwendet; Entscheidungs-Matrix produziert |
| **Qualitätsmodell** | Testpyramide mit ≥3 Schichten dokumentiert | Abdeckungsziele pro Schicht definiert; KI-Integrationspunkte an ≥2 STLC-Stufen identifiziert | Modell umfasst Kosten-Nutzen-Analyse von KI vs. manueller Aufwand pro Schicht; messbare Qualitäts-KPIs definiert | Modell umfasst Automatisierungs-ROI-Prognosen; verknüpft Qualitätsmetriken mit Geschäftsauswirkungen | Modell umfasst kontinuierliche Verbesserungs-Rückkopplungsschleife; passt sich basierend auf Deployment-Daten an |
| **Strategie** | Risikomodell deckt ≥3 Kategorien mit Mitigationen ab | Risikomodell enthält Wahrscheinlichkeits-/Auswertungswertung und Priorisierung | Modell umfasst quantifizierten ROI: Qualitäts-Gewinn pro $ von Token-Aufwand | Modell umfasst Multi-Jahres-Roadmap mit phasenweiser KI-Adoption; identifiziert Risiken und Abhängigkeiten | Modell umfasst Wettbewerbs-Benchmarking; schlägt strategische Initiativen über das aktuelle Team hinaus vor |
| **Einfluss** | ≥1 Peer mit konstruktivem Feedback mentoriert | Qualitätsaudit verweist auf spezifische Scout- und Engineer-Artefakte | Prozessverbesserungen vorgeschlagen, die den Workflow des gesamten Teams verbessern | Umsetzbare Prozessverbesserungen von ≥2 anderen Participants übernommen; für Wiederverwendung dokumentiert | Wiederverwendbaren Rahmen oder Tool veröffentlicht, das das Team auch nach dem Workshop weiter nutzt |
| **Präsentation** | Kann Design-Entscheidungen nicht artikulieren | Präsentiert Design klar; beantwortet grundlegende Fragen | Präsentiert Design mit unterstützenden Beweisen; engagiert Audience mit Q&A | Antizipiert Einwände; passt Präsentation basierend auf Audience-Feedback an | Überzeugende Erzählung mit überzeugenden Daten; Audience handelt auf Empfehlungen |

## 2. Ressourcen-Zuteilung-Checkliste

Führen Sie diese Checkliste **vor Workshop-Beginn** durch. Jeder Participant muss bestehen.

| # | Ressource | Verifikationsschritt | Bestehen-Bedingung |
|---|----------|-------------------|----------------|
| 1 | **KI-Hub-Zugriff** | Participant fragen: "Können Sie mit KI in VS Code chatten?" | Antwort innerhalb von 10 Sekunden erhalten |
| 2 | **opencode.json-Konfiguration** | `cat .vscode/opencode.json | python3 -m json.tool` (oder Projektstamm) | JSON gültig, keine Syntaxfehler |
| 3 | **Mock App** | `npx serve mock/` im Terminal | App lädt unter `http://localhost:3000` |
| 4 | **Playwright (Engineer-Wege)** | `npx playwright --version` | Versionsnummer angezeigt |
| 5 | **Fallback-Ressourcen** | Ausdruck der Jungle-Titel-Wege, zwischengespeicherte JSON-Beispiele verfügbar | Ausgedruckte Kopien bereit |

**Wenn irgendeine Prüfung fehlschlägt:** Vorbereitete Lösung aus der Troubleshooting-Tabelle anwenden. Wenn die Lösung >3 Min. dauert, Participant in Fallback-Track (Scout-Wege mit vorausgefüllten Artefakten) aufnehmen.

## 3. Token-Verteilung

Token-Budgets pro Weg-Gruppe vorab zuweisen. Participants verwalten selbst; Instructor prüft Gesamtsummen.

| Weg-Gruppe | Empfohlenes Budget | Cloud-Modell-Zulassung | Überwachung |
|------------|-------------------|----------------------|-------------|
| **Scouts (A/B/C)** | $15–20 pro Participant | Minimal (nur Brainstorming) | `BUDGET-LOG.md`-Prüfung bei Phase 3 |
| **Engineers (D/E)** | $20–30 pro Participant | Moderat (Debugging, Code-Generierung) | `BUDGET-LOG.md`-Prüfung bei Phase 3 |
| **Architects (F)** | $25–35 pro Participant | Höher (Architekturdesign) | `BUDGET-LOG.md`-Prüfung bei Phase 3 |

**Globale Obergrenzen:**
- Workshop-Gesamtbudget: **$50** (freigemeinsamer KI-Hub-Budget)
- Pro Participant Weiche Obergrenze: $10 Durchschnitt
- Cloud-Modell automatisch deaktiviert bei $45 (konfiguriert in `opencode.json`)

## 4. Automatisches Day-0-Setup

Vor Phase 1 alle Participants laufen lassen:
```bash
./setup-checklist.sh
```

Dieses Skript überprüft:
- ✅ Node.js / npm installiert
- ✅ `opencode.json` Syntax gültig
- ✅ `mock/index.html` vorhanden
- ✅ Playwright-Browser installiert (optional — Engineer-Wege)
- ✅ VS Code KI-Erweiterung aktiv (visuelle Prüfung)

**Ausgabe:** Grüne Häkchen für Bestehen, rotes X mit spezifischer Fehlerbehebung für Fehlschläge.

**Instructor-Aktion:** Sicherstellen, dass alle Participants ≥3 grüne Checks zeigen, bevor Phase 1 (Anforderungsanalyse) beginnt.

**Fallback:** Wenn Skript nicht verfügbar ist, `VS-CODE-AI-HUB-SETUP.md` manuell durchgehen (allocates 10 Min. des 15-Minuten-Setup-Fensters).

## 5. Judging-Rubric-Validierung

Die Judging-Kriterien verwenden eine **5-Punkte-Bewertungsskala** mit Anchor-Beispielen. Führen Sie eine **Vor-Judging-Kalibrierung** (10 Min.) durch, bevor Sie Participants bewerten.

### Bewertungsskala
| Score | Bedeutung | Stufe |
|-------|---------|-------|
| **1** | Nicht demonstriert — Kriterium nicht erfüllt | Nicht ausreichend |
| **2** | Minimal demonstriert — erfüllt Minimum | Unter Erwartungen |
| **3** | Angemessen demonstriert — erfüllt erwarteten Standard | Erfüllt Erwartungen |
| **4** | Stark demonstriert — übertrifft Erwartungen | Über Erwartungen |
| **5** | Herausragend — herausragende, model Participant-Arbeit | Herausragend |

**Anchor-Referenz:** Verwenden Sie die weg-spezifischen 5-Punkte-Anchor-Tabellen (Scouts/Engineers/Architects) für Kriterium-level-Beispiele. Die skalen-level-Beschreibungen oben liefern die semantische Bedeutung für Weg-übergreifenden Vergleich.

### Inter-Rater-Reliabilitäts-Protokoll
1. **Unabhängige Bewertung:** Zwei Instructor bewerten unabhängig voneinander jeden Participant mit der 5-Punkte-Rubric-Tabellen (Scouts/Engineers/Architects). Beide müssen dieselbe Score-Definition verwenden.
2. **Übereinstimmungsprüfung:** Scores pro Kriterium vergleichen. Übereinstimmung = Scores unterscheiden sich um ≤1 Punkt.
3. **Eskalation:** Wenn irgendein Kriterium sich um >1 Punkt unterscheidet → Third-Party-Review (Lead Instructor). Der Lead Instructor Reviewt beide Richter-Begründungen und weist den End-Score zu.
4. **Kalibrierungsprotokollierung:** Übereinstimmungsrate aufzeichnen. Ziel: ≥90% Kriterien-Übereinstimmung innerhalb von ±1 Punkt. Wenn Übereinstimmung <90%, führt der Lead Instructor eine Kalibrierungssitzung mit Muster-Beiträgen durch, bevor das Judging fortgesetzt wird.
5. **Skalenbestätigung:** Zu Beginn jeder Judging-Sitzung bestätigen beide Instructor mündlich, dass sie die 5-Punkte-Rubric-Tabellen verwenden (nicht die 3-Punkte-Zusammenfassungen oder eine andere Skala).

### Vor-Judging-Kalibrierungsübung
- **Zeit:** 10 Minuten, vor Judging-Beginn.
- **Aktivität:** Einen Muster-Participant-Beitrag unabhängig bewerten. Scores vergleichen. Diskrepanzen besprechen.
- **Ergebnis:** Alle Instructor einigen sich auf Score-Definitionen und Anchor-Beispiele.
- **Referenz:** Verwenden Sie den "Judging-Kalibrierungs-Pack" (Muster-Beiträge mit bekannten Scores) für das Training neuer Instructor.

## 🗣 Erste 5 Minuten Skript
1. **00:00:** "Willkommen im Dschungel. Heute sind Sie nicht nur Teilnehmer — Sie sind ein Spezialist, der die Wildnis des Agentic AI durchmisst."
2. **00:02:** "Wir haben ein Budget von $50 und Zugang zu einem Sovereign KI-Agenten. Ihr Ziel ist es, die beste QA-Strategie für Ihre spezifische Rolle aufzubauen."
3. **00:05:** "Öffnen Sie `WORKSHOP-CHALLENGE.md` und finden Sie Ihren **Jungle-Titel**. Dann öffnen Sie `AGENTS.md` und kopieren Sie das Prompt, das zu Ihrem Weg passt."

---

## 6. Pacing & Energiemanagement

Der Workshop-Lieferstrom verwendet ein **3-Stufen-Energiemodell**, um Instructor-Verhalten an die kognitiven Anforderungen jedes Segments anzupassen. Kein einzelnes Energieniveau sollte länger als 30 Minuten am Stück bestehen bleiben, um Participant-Ermüdung zu verhindern.

| Energiestufe | Segmente | Instructor-Verhalten |
|--------------|----------|---------------------|
| **Ruhig / Fokus** | Unabhängiger Sprint (00:45-01:15), Debugging-Zeit | Leise Stimme, minimale Bewegung, keine Unterbrechungen. Participants arbeiten in Stille. Instructor zirkuliert leise mit Whiteboard für Fragen. |
| **Ausgewogen / Aktiv** | Theorie (00:15-00:25), Geführte Demo (00:25-00:45), Peer-Review (02:15-02:30), Abschluss (02:45-03:00) | Normales Sprechvolumen, aktive Bewegung zwischen Participants, strukturierte Interaktion (Q&A, Walkthroughs). |
| **Hoch / Energetisch** | Showdown & Judges (02:30-02:45), Eröffnungsbegrüßung (00:00-00:15) | Erhöhte Stimme, enthusiastischer Ton, sichtbare Bewegung, feierliche Sprache. Participants spüren die "Energie des Dschungels." |

**Pacing-Regel:** Instructor müssen ihr Energieniveau bewusst ändern, wenn sie zwischen Segmenten wechseln. Die 2-Minuten-Puffer zwischen Segmenten ist das "Übergangs-Fenster" — verwenden Sie es, um Ihr Energieniveau vor dem nächsten Segment zurückzusetzen.

---

## 7. Komplementäre Pairing-Strategie

Peer-Review-Sitzungen sollten Participants mit **komplementären Fähigkeiten** (nicht identischen Skill-Leveln) pairren, um pfadübergreifendes Lernen zu maximieren. Der Instructor erleichtert das Pairing mit den folgenden Richtlinien.

### Skill-Diversitäts-Matrix

| Ihr Jungle-Titel | Beste Pairing-Partner (Beispiele) | Lerngewinn |
|-------------------|----------------------------------|------------|
| Trail Explorer (A1) | Mechanic (D2), Pathfinder (E1) | Grundlegende Automatisierungskonzepte lernen |
| River Ranger (A2) | Master Tinkerer (D3), Trap Architect (E2) | Debugging-Techniken lernen |
| Scout Leader (A3) | System Weaver (E3), Code Sorcerer (E4) | Fortgeschrittene Patterns lernen |
| Camp Builder (B1) | Gear Caster (D1), Pathfinder (E1) | Test-Automatisierungsgrundlagen lernen |
| Jungle Guide (B2) | Mechanic (D2), Trap Architect (E2) | Debugging und Randfälle lernen |
| Tactical Planner (B3) | Automation Wizard (D4), System Weaver (E3) | Komplexe Automatisierung lernen |
| Commander (C3) | Automation Wizard (D4), Code Sorcerer (E4) | CI/CD und selbstheilende Tests lernen |
| Gear Caster (D1) | Trail Explorer (A1), Camp Builder (B1) | Test-Design-Denken lernen |
| Mechanic (D2) | River Ranger (A2), Camp Builder (B1) | Anforderungsanalyse lernen |
| Master Tinkerer (D3) | Scout Leader (A3), Tactical Planner (B3) | Fortgeschrittene Teststrategie lernen |
| Automation Wizard (D4) | Commander (C3), Visionary (F3) | Systemdesign lernen |
| Explorer (F1) | Trail Explorer (A1), Gear Caster (D1) | Bodennahes QA lernen |
| Chief Architect (F2) | Jungle Guide (B2), Mechanic (D2) | Praktische Automatisierung lernen |
| Visionary (F3) | Tactical Planner (B3), Master Tinkerer (D3) | Fortgeschrittene Integration lernen |
| King of the Jungle (F4) | Commander (C3), Automation Wizard (D4) | Betriebsexzellenz lernen |

### Pairing-Algorithmus (für wenn Participants unsicher sind)
1. Fragen: "Kennt ihr euren Jungle-Titel?" Wenn ja, pairren Sie sie mit der Matrix oben.
2. Wenn keiner weiß, weist der Instructor basierend auf der "Skill-Diversitäts-Matrix" zu.
3. **Faustregel:** Mindestens einen Manual-fokussierten Weg mit einem Automatisierungsfokussierten Weg pairren. Zwei Participants exakt demselben KI-Level pairren.

---

## 8. Flow-State-Schutz

Der Unabhängige Sprint (00:45-01:15) ist das längste einzelne Arbeitssegment und das zentrale Lernerlebnis. **Flow-State** — tiefe kognitive Immersion — ist wesentlich für den Erwerb von Fähigkeiten. Instructor müssen ihn mit den unten stehenden Protokollen schützen.

### Keine-Unterbrechungs-Regel (nur Unabhängiger Sprint)
- **Instructor unterbrechen Participants NICHT verbal** während des Sprints.
- Instructor zirkulieren still und beobachten den Fortschritt.
- Participant-Fragen werden auf dem "Question Parking Lot" Whiteboard geschrieben und als Batch am Phasenübergang (nach "Hard Stop beim Unabhängigen Sprint!") beantwortet.

### Flow-Pass-System
- Jeder Participant erhält eine "Flow-Pass"-Karte am Workshop-Start.
- Wenn ein Participant während des Sprint Hilfe benötigt, legt er den Flow-Pass auf seinen Schreibtisch (sichtbar für Instructor).
- Der Instructor nähert sich still und bietet Hilfe an, ohne den aktuellen Gedankenstrom des Participants zu unterbrechen.
- Nach dem Sprint wird der Flow-Pass eingesammelt (oder für die nächste Arbeitsphase wiederverwendet).

### Frage-Parking-Lot
- Whiteboard oder Flipchart, wo alle Participants es sehen können.
- Instructor schreibt Participant-Fragen während des Sprint auf.
- Am Phasenübergang liest der Instructor jede Frage als Batch vor und beantwortet sie (2-3 Min. max).
- Unbeantwortete Fragen gehen ins "Parking Lot" für die letzten 10-Minuten-Abschluss.

---

## 9. Instructor-Presence-Levels

Die physische Präsenz und Interaktionsintensität des Instructor muss sich nach Workshop-Phase richten. "One-size-fits-all"-Presence erzeugt entweder Abhängigkeit (Hovering) oder Verlassenheit (Hiding).

| Presence-Level | Segmente | Erwartete Verhaltensweisen |
|----------------|----------|---------------------------|
| **Präsent / Vorderes-Zimmer** | Geführte Demo (00:25-00:45), Showdown & Judges (02:30-02:45) | Sichtbar vorne, den Raum führend, sprechend zu allen, die Narration kontrollierend. |
| **Aktiv / Zirkulierend** | Peer-Review (02:15-02:30), Automatisierung & Review (01:30-02:15) | Zwischen Pairs/Tischen bewegend, Anleitung anbietend, Fragen beantwortend, Zusammenarbeit beobachtend. |
| **Beobachtend / Distant** | Unabhängiger Sprint (00:45-01:15) | Im Raum sichtbar, ABER NICHERND annähernd, es sei denn, ein Flow-Pass wird präsentiert. Provisorische Notizen still. |
| **Unsichtbar** | Pause (01:15-01:30), Setup (00:00-00:15) | Außerhalb der Kamera / Seiten des Raums. Nur engagiert, wenn Participants den Instructor aufsuchen. |

**Presence-Übergangs-Regel:** Bevor Sie die Presence-Level wechseln, kündigen Sie den Übergang klar an: "In 2 Minuten treten wir in den Unabhängigen Sprint ein. Arbeiten Sie für die nächsten 30 Minuten still. Legen Sie einen Flow-Pass auf Ihren Tisch, wenn Sie Hilfe benötigen."

---

## 10. Lerner-Autonomie & Hinweis-Karten

Das zentrale pädagogische Prinzip des Workshops ist **Lerner-Autonomie**: Participants müssen Probleme selbst lösen, um dauerhafte Fähigkeiten aufzubauen. Instructor unterstützen dies durch das **5-Stufen-Hinweis-System**, das strukturierte Führung ohne Antwortverrat bietet.

### 5-Stufen-Hinweis-System

Wenn ein Participant um Hilfe bittet, weisen Sie Hinweise **progressiv** zu — eine Stufe nach der anderen. Keine Stufen überspringen.

| Stufe | Name | Instructor-Aktion | Beispiel-Sprachgebrauch |
|-------|------|-------------------|------------------------|
| **1** | **Anstoß** | Selbstreflexion anregen | "Was haben Sie bisher versucht?" / "Was erwarten Sie, dass passiert?" |
| **2** | **Ressource** | Auf Dokumentation verweisen | "Schauen Sie in die Troubleshooting-Tabelle in INSTRUCTOR-QUICK-REF.md, Section A." / "Schauen Sie sich das data-testid-Attribut in mock/index.html an." |
| **3** | **Gerüst** | Führungsfragen stellen | "Was sagt die Fehlermeldung?" / "Welcher Teil der User-Journey fehlschlägt?" |
| **4** | **Hinweis** | Einen spezifischen Tipp geben | "Prüfen Sie das `gridData`-Feld im JSON — es sollte ein Array sein." / "Versuchen Sie, `waitFor()` vor dem Klicken auf den Export-Button hinzuzufügen." |
| **5** | **Antwort** | Nur nach allen 4 Stufen erschöpft | "Der Selector sollte `[data-testid='export-button']` sein. Versuchen Sie jetzt, den Test erneut auszuführen." |

### Regel: Stufen NICHT überspringen
- Jede Stufe steigert die Spezifität und verringert die Autonomie.
- Wenn Sie Stufe 4 geben, aber der Participant hat Stufe 2 nicht erhalten, haben Sie ihm die Lern-Chance geraubt.
- **Ausnahme:** Stufe 5 (Antwort) ist erlaubt, wenn alle 4 Stufen erschöpft sind UND die Zeit knapp wird (z.B. Participant ist >10 Min. an einer kritischen Weg-Aufgabe stecken geblieben).

### Visuelle Hinweis-Karten (Empfohlen)
Gedruckte farbige Karten für den Instructor, um an Participants weiterzugeben:
- 🟢 Grün = "Anstoß" (Stufe 1)
- 🟡 Gelb = "Ressource" (Stufe 2)
- 🟠 Orange = "Gerüst" (Stufe 3)
- 🔴 Rot = "Hinweis" (Stufe 4)

**Hinweis:** Stufe 5 (Antwort) wird mündlich vom Instructor geliefert — nicht auf einer Karte gedruckt, da sie Ausnahme-nur ist. Participants können sehen, welche Stufe sie haben, indem sie die zurückgegebene Karte sehen, die sie auf ihrem Tisch halten, und selbst eskalieren, indem sie die zurückgegebene Karte wieder auf ihren Tisch legen.

---

## 🏆 Schritt 4: Showdown-Format

Das Showdown & Judges-Segment (02:30–02:45) folgt einem strukturierten Präsentationsformat.

### Zeit-Budget
- **Gesamt: 15 Minuten**
- Participants in Gruppen von ~5 einteilen
- **Pro Gruppe:** 3 Min. Präsentation + 2 Min. Q&A

### Präsentationsstruktur (Für jeden Participant verpflichtend)
Jeder Participant muss dieses Format folgen:
1. **Jungle-Titel & Weg** (15 Sekunden) — "Ich bin [Name], mein Jungle-Titel ist [Titel], Weg [ID]."
2. **Wichtigstes produziertes Artefakt** (30 Sekunden) — "Ich habe [Artefaktname] produziert. Es deckt [wichtige Punkte] ab."
3. **KI-Nutzungs-Highlights** (45 Sekunden) — "Ich habe KI verwendet für [spezifische Aktivitäten]. Das von mir verwendete Tool war [Tool]. Ich habe meine Prompts verfeinert durch [Methode]."
4. **Ergebnis & Reflexion** (60 Sekunden) — "Mein Ergebnis war [Outcome]. Das Überraschendste war [Insight]. Beim nächsten Mal würde ich [Verbesserung]."

### Zuschauer-Regel
- **Nicht-präsentierende Participants bleiben still** während Präsentationen.
- **Fragen nur während des Q&A-Fensters** (die 2 Minuten nach jeder Gruppenpräsentation).
- Fragen müssen konstruktiv sein ("Wie haben Sie sich für X entschieden?") nicht bewertend ("Ist das gut?").

### Fallback-Protokoll
Wenn ein Participant zu nervös ist, technische Probleme hat oder innerhalb des Zeitlimits nicht präsentieren kann:
1. Instructor liest eine 30-Sekunden-Artefakt-Zusammenfassung in seinem Auftrag.
2. Participant wird weiterhin mit dem Judging-Rubric bewertet — Präsentationsfähigkeiten sind kein Judging-Kriterium.
3. Sofort zur nächsten Gruppe wechseln.

## 11. Feier & Anerkennung

Das Showdown enthält ein Feier & Anerkennung-Element, um Motivation aufrechtzuerhalten und das "King of the Jungle"-Thema zu verstärken.

### Auszeichnungszeremonie (2 Minuten)
Am Ende des Judging kündigt der Instructor an:

| Auszeichnung | Kategorie | Beschreibung |
|-------------|----------|-------------|
| 🏆 **Scout Champion** | A/B/C Wege | Beste Risikoanalyse und Teststrategie unter Scouts |
| ⚙️ **Engineer Excellence** | D/E Wege | Beste Automatisierungsansatz und Code-Qualität unter Engineers |
| 🔮 **Architect Visionary** | F Weg | Bestes Systemdesign und ROI-Denken unter Architects |

> **Hinweis:** Ein Gewinner pro Kategorie. Wenn eine Kategorie keine Participants hat, wird die Auszeichnung zurückgehalten — kein erfundener Gewinner.

### Inklusiver Anerkennung (Während jeder Präsentation)
Jeder Participant erhält **mündliche Anerkennung einer spezifischen Stärke** während seiner Präsentation. Beispiele:
- "Großartige KI-Nutzung zum Brainstorming — Sarah, Ihre Risikokategorien waren aufschlussreich."
- "Sauberer Code-Struktur — Mike, Ihr POM-Muster ist ein echter Unternehmensansatz."
- "Mutige Design-Wahl — Alex, Ihr Token-Ökonomie-Modell zeigt Systemdenken."

**Warum:** Dies stellt sicher, dass jeder Participant sich wertgeschätzt und anerkannt fühlt, unabhängig vom End-Score. Generische Lob ("gutes Ergebnis") reicht nicht aus — die Anerkennung muss ein spezifisches Artefakt oder eine Aktion referenzieren.

### Themen-Sprache
Verwenden Sie Dschungel-bezogene Sprache throughout: "Sie haben den Anforderungen-Dschungel erobert," "Ihre KI-Nutzung hat Ihnen den Ranger-Titel verdient," "So gehen Kings mit Qualität um."

## 12. Workshop-Nachbereitung

Nachdem der Workshop endet, strukturieren Nachbereitungsaktivitäten die Engagement und erfassen Lernergebnisse.

### Artefakt-Verteilung (24 Stunden)
Innerhalb von 24 Stunden sendet der Instructor eine Zusammenfassungs-E-Mail an alle Participants mit:
1. **Ihre abgeschlossenen Artefakte** (Risikoanalyse, Testplan, Budget-Log, etc.) — von Participant-Abgaben gesammelt oder kopiert.
2. **Sitzungs-Zusammenfassung** mit wichtigsten Lernergebnissen und gemeinsamen Themen, die während des Judging beobachtet wurden.
3. **Link zur Feedback-Umfrage** für Participants, die sie während der Sitzung nicht abgeschlossen haben.

### Testimonial-Sammlung
Verwenden Sie die folgende Vorlage für Video- oder Text-Testimonials:
- "Was war Ihre größte Erkenntnis aus dem Workshop?"
- "Wie planen Sie, KI-Tools in Ihrer täglichen QA-Arbeit anzuwenden?"
- "Würden Sie diesen Workshop anderen empfehlen? Warum oder warum nicht?"

**Wann:** Sammeln Sie während des Abschlusses (02:50–03:00) oder über die 24-Stunden-Nachbereitungs-E-Mail.

### Nachbereitungs-Zeitplan
| Zeitrahmen | Aktion | Zweck |
|------------|--------|-------|
| **24 Stunden** | Zusammenfassungs-E-Mail mit Artefakten und Umfrage-Link | Sicherstellen, dass alle Materialien erhalten |
| **1 Woche** | Check-in-Umfrage (3 Fragen zur KI-Nutzung in der täglichen Arbeit) | Sofortige Anwendung messen |
| **1 Monat** | Alumni-Umfrage (KI-Adoptionsmetriken, Herausforderungen, Vorschläge) | Langfristige Impact-Verfolgung |

### Jungle-Alumni-Community (Optional)
Erstellen Sie einen Slack/Discord-Kanal oder eine Mailingliste für vergangene Participants, um:
- KI-in-QA-Erfahrungen und Tipps zu teilen
- Laufende Herausforderungen zu diskutieren
- Organisatorübergreifend zu vernetzen
- Einladungen zu zukünftigen Workshop-Sitzungen zu erhalten

## 13. Kontinuierliche Lernwege

Participants sollten ihre KI-in-QA-Lernreise nach dem Workshop fortsetzen. `INSTRUCTOR-QUICK-REF.md` definiert drei progressive Lern-Tracks.

### Lern-Tracks

| Track | Für Weg-Gruppe | Progression |
|-------|----------------|-------------|
| 🟢 **Scout Track** | A/B/C (Scouts) | KI für Testfall-Design → KI für Risikoanalyse → KI für Qualitätsberichterstattung |
| 🔵 **Engineer Track** | D/E (Engineers) | KI-unterstütztes Debugging → KI-generierte Test-Frameworks → CI/CD-Pipeline-Optimierung mit KI |
| 🟡 **Architect Track** | F (Architects) | Token-Ökonomie-Optimierung → Multi-Agenten-QA-Systemdesign → KI-Qualitätsstrategie für Unternehmen |

### Empfohlene Ressourcen
- **KI-Tool-Tutorials:** Playwright mit KI, Bruno CLI für API-Testing, KI-Prompt-Engineering-Anleitungen
- **QA-Blog-Abonnements:** ISTQB-Blog, Ministry of Testing, Test Automation University
- **Community-Foren:** r/QualityAssurance, lokale QA-Meetups, professionelle QA-Vereinigungen

### 30-Tage-KI-QA-Herausforderung

---

## 14. Gamification & Interaktives Leaderboard

### 14.1 Jungle-Badge-Tracking

Instructors track badge progress on the physical or digital leaderboard. Each badge corresponds to a specific achievement:

| Badge | Emoji | Wann vergeben | Max pro Teilnehmer |
|-------|-------|---------------|---------------------|
| Bug Hunter | 🐛 | Teilnehmer findet/fixt einen Sandbox-Bug | 1 |
| Token Saver | 💰 | ≥3 Artefakte für ≤$10 Ausgabe | 1 |
| Debug King/Queen | 🔧 | Erfolgreiches Debugging mit KI-Unterstützung | 1 |
| Quality Champion | ✅ | ≥4 Risikokategorien mit allen Mitigationen | 1 |
| Speed Runner | ⚡ | Schafft alle Aufgaben rechtzeitig mit ≥80% Qualität | 1 |
| Team Player | 🤝 | Hilft Peer von anderem Weg (Kudos bestätigt) | 1 |
| Jungle Explorer | 🌴 | Schafft alle 6 Schritte mit ≥70% Qualität | 1 |

**Badge-Zuweisungs-Protokoll:**
1. Instructor überprüft die Leistung gegen das Rubric.
2. Badge wird auf die Teilnehmerkarte (physisch) oder digitales Profil hinzugefügt.
3. Gesamt-Badge-Punkte werden auf dem Leaderboard aktualisiert.
4. Badge-Fotos werden optional im Workshop-Gruppenkanal geteilt.

**Bekanntgabe-Zeitpunkt:** Badges bei Phasenübergängen bekanntgeben (Ende Unabhängiger Sprint, Ende Peer-Review, Ende Boss Battle).

### 14.2 Leaderboard-Management

**Physical Leaderboard:**
- Use a whiteboard or large poster in the workshop room.
- Update every 30 minutes or after each major milestone.
- Use color-coded markers for different path groups (Scouts = green, Engineers = blue, Architects = purple).

**Digital Leaderboard (Future):**
- TODO: Implement a digital leaderboard in mock/index.html.
- Will display real-time badge counts, points, and achievements.
- GDPR-compliant: Use participant IDs, not names.

### 14.3 Achievement-Unlock-Veranstaltung

When a participant unlocks a new badge:
1. **Announce it publicly:** "🏆 [Name] has earned the [Badge Name]!"
2. **Show the achievement:** Briefly explain what they did to earn it (reinforces learning).
3. **Update the leaderboard:** Immediately update the display.
4. **Take a photo (optional):** For the workshop gallery.

### 14.4 Boss-Battle-Veranstaltung

**Boss Battle** is a team challenge where participants work together to solve a complex, multi-step problem.

**Boss Battle Setup:**
1. Choose a Boss Battle theme (e.g., "Fix the Data Grid XSS vulnerability").
2. Form teams of 3-4 participants from mixed path groups.
3. Give teams 20 minutes to solve the problem.
4. Teams present their solution; instructors judge using the rubric.
5. Winning team earns team recognition during Showdown.

### 14.5 Kudos-System

The Kudos system allows participants to recognize each other's contributions:
1. Each participant gets 3 Kudos tokens.
2. They can give their tokens to peers for helpful contributions.
3. Most Kudos received at Showdown = "🤝 **Team Player**" badge.
4. Kudos are given verbally or via sticky notes during workshops.

### 14.6 Jungle-Crown-Auswahl

Die Jungle Crown ist die höchste Auszeichnung im Workshop:

**Zulassung:** Teilnehmer mit ≥5 Badges.
**Auswahlmethode:** Peer-Voting. Jeder zugelassene Teilnehmer stimmt ab.
**Tiebreak:** Höchster kombinierter Leaderboard-Score (Badges + Kudos + Token-Effizienz).
**Auszeichnung:** Gedrucktes oder digitales Jungle Crown-Medaillon + verbale Anerkennung.

**Bekanntgabe:** Nach den wegspezifischen Auszeichnungen bekanntgeben: "Die Jungle Crown geht an..." mit Dschungel-Themen-Sprache.

---

## 📊 15. Instructor Analytics Dashboard & Echtzeit-Monitoring

### 15.1 Dashboard-Schnellstart

**Purpose:** The instructor analytics dashboard provides real-time visibility into participant progress, budget usage, and engagement.

**Access:** Open the dashboard in your browser at the workshop URL with `?debug=true`.

### 15.2 Dashboard-Panel

| Panel | Content | Update Frequency |
|-------|---------|-----------------|
| **Participant Tracker** | Names, paths, progress through workshop phases | Real-time |
| **Budget Monitor** | Per-participant token usage, cumulative costs | Every 5 min |
| **Badge Counter** | Badge counts per participant and path group | Real-time |
| **Alert Feed** | Warnings for budget overruns, stalled participants | Real-time |
| **Quality Gate** | Test plan compliance, artifact submission status | On artifact update |

### 15.3 Alert-Typen & Reaktionsverfahren

| Alert | Trigger | Instructor Action |
|-------|---------|-------------------|
| 🟢 **On Track** | Budget < 50%, progressing on schedule | No action needed |
| 🟡 **Monitor** | Budget 50-80%, or slight delay | Check in with participant |
| 🔴 **Intervene** | Budget > 80%, or stuck > 15 min | Offer direct assistance |
| 🚫 **Over Budget** | Budget > $50 or $45 alert | Disable cloud model; switch to sovereign |
| ⚠️ **Stalled** | No progress > 15 min | Offer hint or pair with another participant |

### 15.4 Nacharbeits-Berichterstattung

After the workshop, generate a summary report:
1. Export participant data from the dashboard (if available).
2. Compile badge counts, Showdown scores, and budget usage.
3. Create a post-workshop summary for stakeholders.
4. Store the report in `docs/project/WORKSHOP-SUMMARY-<DATE>.md`.

### 15.5 Dashboard-Problembehandlung

| Issue | Fix |
|-------|-----|
| Dashboard not loading | Check `?debug=true` URL parameter; verify sandbox is running |
| Data not updating | Refresh the page; check network connectivity |
| Missing participant data | Verify participant was correctly mapped to their path |

### 15.6 Datenschutz (DSGVO-Konformität)

- **Anonymisierte Exporte:** Dashboard-Exporte enthalten keine Personendaten — nur Team-IDs und aggregierte Daten.
- **Speicherfrist:** Analytics-Daten werden 90 Tage nach Workshop-Ende aufbewahrt, dann gelöscht.
- **Einwilligung:** Teilnehmer müssen vor Workshop-Beginn der Datenerfassung zustimmen.

---
