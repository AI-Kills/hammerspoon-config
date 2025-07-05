-- GREEK LETTERS CONVERTER
-- Converte lettere latine + ∆ in lettere greche
-- Esempio: digita "ph∆" → diventa "Φ"

local buffer = ""

-- Mappatura tra lettere latine e greche
local latin_to_greek = {
    ["a"] = "Α",   -- alpha
    ["b"] = "Β",   -- beta
    ["g"] = "Γ",   -- gamma
    ["d"] = "Δ",   -- delta
    ["e"] = "Ε",   -- epsilon
    ["z"] = "Ζ",   -- zeta
    ["h"] = "Η",   -- eta
    ["th"] = "Θ",  -- theta
    ["i"] = "Ι",   -- iota
    ["k"] = "Κ",   -- kappa
    ["l"] = "Λ",   -- lambda
    ["m"] = "Μ",   -- mu
    ["n"] = "Ν",   -- nu
    ["x"] = "Ξ",   -- xi
    ["o"] = "Ο",   -- omicron
    ["p"] = "Π",   -- pi
    ["r"] = "Ρ",   -- rho
    ["s"] = "Σ",   -- sigma
    ["t"] = "Τ",   -- tau
    ["y"] = "Υ",   -- upsilon
    ["ph"] = "Φ",  -- phi
    ["ch"] = "Χ",  -- chi
    ["ps"] = "Ψ",  -- psi
    ["om"] = "Ω"   -- omega
}

print("Greek Letters Converter attivato")
print("Uso: digita lettera + ∆ (es: ph∆ → Φ)")

-- Verifica permessi
local hasPermissions = hs.accessibilityState(true)
if not hasPermissions then
    print("❌ ERRORE: Mancano i permessi di accessibilità!")
    print("   Vai in Preferenze > Privacy e Sicurezza > Accessibilità")
    print("   Aggiungi e abilita Hammerspoon")
    return
end

-- Listener per catturare i tasti
local listener = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local char = event:getCharacters()
    
    -- DEBUG BASICO: Verifica che il listener funzioni
    print("🔍 TASTO PREMUTO: '" .. (char or "NIL") .. "'")
    
    -- Ignora tasti speciali e caratteri vuoti
    if not char or char == "" then
        print("🔍 Carattere vuoto, ignorato")
        return false
    end
    
    buffer = buffer .. char
    print("🔍 Buffer: '" .. buffer .. "'")
    
    -- Controlla se il buffer termina con ∆
    if string.match(buffer, "∆$") then
        print("🔍 RILEVATO DELTA!")
        
        -- Salva il buffer prima di resettarlo
        local buffer_to_process = buffer
        
        -- BLOCCA IMMEDIATAMENTE l'evento per evitare interferenze
        buffer = ""
        
        -- Estrai la parte prima di ∆
        local latin_part = string.match(buffer_to_process, "(.*)∆$")
        
        if latin_part then
            -- Pulisci caratteri invisibili
            latin_part = string.gsub(latin_part, "%c", "")
            latin_part = string.gsub(latin_part, "%s", "")
            latin_part = latin_part:gsub("[\0\1\2\3\4\5\6\7\8\9\10\11\12\13\14\15\16\17\18\19\20\21\22\23\24\25\26\27\28\29\30\31\127]", "")
            
            print("🔍 Parte latina pulita: '" .. latin_part .. "'")
            
            -- Cerca la corrispondenza
            local greek_letter = latin_to_greek[latin_part:lower()]
            
            if greek_letter then
                print("🔍 DEBUG: Trovata lettera greca: " .. greek_letter)
                
                -- SOSTITUZIONE ASINCRONA per evitare conflitti di timing
                hs.timer.doAfter(0.01, function()
                    print("🔍 DEBUG: Inizio sostituzione asincrona...")
                    
                    -- Cancella il testo (conta solo i caratteri visibili)
                    local visible_length = utf8.len(latin_part) + 1  -- +1 per ∆
                    print("🔍 DEBUG: Invio " .. visible_length .. " backspace per '" .. latin_part .. "∆'...")
                    
                    for i = 1, visible_length do
                        hs.eventtap.keyStroke({}, "delete")
                    end
                    
                    -- Piccolo delay prima dell'inserimento
                    hs.timer.doAfter(0.01, function()
                        print("🔍 DEBUG: Inserisco lettera greca...")
                        hs.pasteboard.setContents(greek_letter)
                        hs.eventtap.keyStroke({"cmd"}, "v")
                        
                        print("✅ Convertito: " .. latin_part .. "∆ → " .. greek_letter)
                    end)
                end)
            else
                print("❌ Nessuna corrispondenza per: '" .. latin_part .. "'")
            end
        end
        
        return true -- BLOCCA l'evento originale SUBITO
    end
    
    -- Pulisce il buffer se diventa troppo lungo
    if #buffer > 20 then
        buffer = ""
    end
    
    return false
end)

-- Avvia il listener
print("🔧 Tentativo di avvio listener...")

local success, error = pcall(function()
    listener:start()
end)

if success then
    print("✅ Listener avviato senza errori")
    print("📊 Stato listener:", listener:isEnabled())
    
    if listener:isEnabled() then
        print("✅ Listener confermato ATTIVO")
    else
        print("❌ Listener NON ATTIVO nonostante l'avvio!")
    end
else
    print("❌ ERRORE nell'avvio listener:", error)
end

-- Verifica permessi aggiornati
print("🔒 Ricontrollo permessi...")
local permissions = hs.accessibilityState(true)
print("📋 Permessi accessibilità:", permissions)

-- Test immediato dell'eventtap
print("🧪 Test immediato eventtap...")
hs.timer.doAfter(2, function()
    print("⏰ Controllo dopo 2 secondi...")
    print("📊 Listener ancora attivo:", listener:isEnabled())
    
    if not listener:isEnabled() then
        print("⚠️ Listener si è fermato! Tentativo di riavvio...")
        listener:start()
        print("📊 Stato dopo riavvio:", listener:isEnabled())
    end
    
    print("👉 ADESSO prova a premere un tasto!")
end)

print("✅ Greek Letters Converter pronto!")
print("📝 Esempi di utilizzo:")
print("   g∆ → Γ     a∆ → Α     b∆ → Β")
print("   ph∆ → Φ    th∆ → Θ    ch∆ → Χ")
print("   ps∆ → Ψ    om∆ → Ω    x∆ → Ξ")
