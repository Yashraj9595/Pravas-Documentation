# PowerShell script to update navigation in HTML files
# This script replaces the sidebar navigation with an empty sidebar container

# Define files to update
$filesToUpdate = @(
    "prototypes.html",
    "features\chatbot.html",
    "features\feedback.html",
    "features\marketplace.html",
    "features\navigation.html",
    "technologies\ar-vr.html",
    "technologies\blockchain.html", 
    "technologies\cloud.html",
    "how-it-works\core-functions.html",
    "how-it-works\data-security.html",
    "how-it-works\user-flow.html",
    "impact\social.html"
)

# Process each file
foreach ($file in $filesToUpdate) {
    $filePath = Join-Path (Get-Location) $file
    
    if (Test-Path $filePath) {
        Write-Host "Processing: $file"
        
        try {
            # Read the file content
            $content = Get-Content $filePath -Raw -Encoding UTF8
            
            # Use regex to find and replace the sidebar content
            # This pattern matches from <aside class="sidebar"> to </aside>
            $pattern = '(?s)<aside class="sidebar">.*?</aside>'
            $replacement = '<aside class="sidebar">`r`n        </aside>'
            
            # Replace the sidebar content
            $newContent = $content -replace $pattern, $replacement
            
            # Write the updated content back to file
            Set-Content $filePath -Value $newContent -Encoding UTF8
            
            Write-Host "Updated: $file" -ForegroundColor Green
        }
        catch {
            Write-Host "Error processing $file : $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    else {
        Write-Host "File not found: $file" -ForegroundColor Yellow
    }
}

Write-Host "Navigation update completed!" -ForegroundColor Cyan