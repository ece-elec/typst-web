# Justfile - Command runner pour typst-web (Haita)

default:
    @just --list

# Compiler le site web et le PDF dans dist/
build:
    @rm -rf dist
    typst compile --features bundle,html --format bundle main.typ dist
    typst compile --features bundle,html --format pdf main.typ dist/cours-complet.pdf
    @echo "✅ Site web multi-pages et PDF compilés avec succès dans dist/."

# Lancer un serveur web local de prévisualisation
serve: build
    @echo "🌐 Serveur disponible sur http://localhost:8000"
    python3 -m http.server -d dist 8000

# Mode watch (recompilation automatique à chaque modification)
watch:
    typst watch --features bundle,html --format bundle main.typ dist

# Nettoyer les fichiers générés
clean:
    rm -rf dist
    @echo "🧹 Dossier dist/ nettoyé."
