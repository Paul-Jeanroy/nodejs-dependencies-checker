#!/bin/bash

SITES_DIR="/var/www"
EMAIL="votre email"
LOG_FILE="/tmp/dependency-check.log"

echo "Rapport de vérification des dépendances Node.js - $(date +%Y-%m-%d)" > "$LOG_FILE"
echo "=================================================" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

for site in "$SITES_DIR"/*; do
    if [ -d "$site" ]; then
        SITE_NAME=$(basename "$site")
        
        if [ -f "$site/package.json" ]; then
            echo "📁 Site: $SITE_NAME" >> "$LOG_FILE"
            echo "-------------------" >> "$LOG_FILE"
            cd "$site"
            
            echo "📦 Dépendances à mettre à jour:" >> "$LOG_FILE"
            echo "" >> "$LOG_FILE"
            npm outdated --parseable | awk -F: '{printf "- %s: %s → %s\n", $1, $3, $4}' >> "$LOG_FILE" 2>&1
            echo "" >> "$LOG_FILE"
            
            echo "🔒 Vulnérabilités:" >> "$LOG_FILE"
            npm audit --json 2>/dev/null | jq -r '.metadata.vulnerabilities | "Critiques: \(.critical)\nHautes: \(.high)\nMoyennes: \(.moderate)\nBasses: \(.low)"' >> "$LOG_FILE" 2>/dev/null || echo "Aucune vulnérabilité détectée" >> "$LOG_FILE"
            
            echo "" >> "$LOG_FILE"
            echo "=================================================" >> "$LOG_FILE"
            echo "" >> "$LOG_FILE"
        fi
    fi
done

mail -s "Rapport dépendances Node.js - $(date +%Y-%m-%d)" -a "Content-Type: text/plain; charset=UTF-8" "$EMAIL" < "$LOG_FILE"