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
    ["q"] = "Θ",  -- theta
    ["i"] = "Ι",   -- iota
    ["k"] = "Κ",   -- kappa
    ["l"] = "Λ",   -- lambda
    ["m"] = "Μ",   -- mu
    ["n"] = "Ν",   -- nu
    ["x"] = "Ξ",   -- xi
    ["p"] = "Π",   -- pi
    ["r"] = "Ρ",   -- rho
    ["s"] = "Σ",   -- sigma
    ["t"] = "Τ",   -- tau
    ["y"] = "Υ",   -- upsilon
    ["f"] = "Φ",  -- phi
    ["y"] = "Ψ",  -- psi
    ["o"] = "Ω"   -- omega
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
    
    -- NUOVA LOGICA BUFFER: 
    -- Se è ∆, aggiungilo al buffer
    -- Se è una lettera normale, SOSTITUISCI il buffer con solo quella lettera
    
    if char == "∆" then
        buffer = buffer .. char  -- Aggiungi ∆ al buffer esistente
        print("🔍 Aggiunto ∆ al buffer: '" .. buffer .. "'")
    else
        buffer = char  -- SOSTITUISCI il buffer con solo questa lettera
        print("🔍 Nuovo buffer (solo ultima lettera): '" .. buffer .. "'")
    end
    
    -- Controlla se il buffer termina con ∆
    if string.match(buffer, "∆$") then
        print("🔍 RILEVATO DELTA!")
        
        -- Estrai SOLO l'ultimo carattere prima di ∆
        local latin_char = string.match(buffer, "([^∆])∆$")
        
        print("🔍 Buffer completo era: '" .. buffer .. "'")
        print("🔍 Ultimo carattere prima di ∆: '" .. (latin_char or "NESSUNO") .. "'")
        
        if latin_char then
            -- Pulisci il carattere (anche se dovrebbe essere già pulito)
            latin_char = string.gsub(latin_char, "%c", "")
            latin_char = string.gsub(latin_char, "%s", "")
            
            print("🔍 Carattere latino pulito: '" .. latin_char .. "'")
            
            -- Cerca la corrispondenza (ora sempre 1 carattere)
            local greek_letter = latin_to_greek[latin_char:lower()]
            
            if greek_letter then
                -- SEMPLICE E VELOCE:
                -- 1. Cancella lettera latina (backspace)  
                -- 2. Inserisci lettera greca
                
                hs.eventtap.keyStroke({}, "delete")      -- Cancella lettera latina
                hs.eventtap.keyStrokes(greek_letter)     -- Inserisci lettera greca
                
                --print("✅ " .. latin_char .. "∆ → " .. greek_letter)
            else
                --print("❌ Nessuna corrispondenza per: '" .. latin_char .. "'")
            end
        else
            --print("❌ Non riesco a estrarre l'ultimo carattere dal buffer")
        end
        
        buffer = ""  -- Resetta il buffer dopo la sostituzione
        return true -- BLOCCA l'evento originale SUBITO
    end
    
    -- Non c'è più pulizia del buffer per lunghezza - teniamo solo l'ultima lettera
    
    return false
end)

-- Avvia il listener
--print("🔧 Tentativo di avvio listener...")

local success, error = pcall(function()
    listener:start()
end)

if success then
    --print("✅ Listener avviato senza errori")
    --print("📊 Stato listener:", listener:isEnabled())
    
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
