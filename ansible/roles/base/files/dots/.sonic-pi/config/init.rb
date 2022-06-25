# Sonic Pi init file
# Code in here will be evaluated on launch.

SONIC = File.join(ENV['HOME'], ".sonic-pi")

LIBRARY = File.join(ENV['HOME'], "Library")

SOUNDS = File.join(LIBRARY, "Sounds/**")

SAMPLES = File.join(LIBRARY, "Sounds", "samples/**")
COLLECTIONS = File.join(LIBRARY, "Sounds", "collections/**")
DRUMKITS = File.join(LIBRARY, "Sounds", "drumkits/**")
LOOPS = File.join(LIBRARY, "Sounds", "loops/**")
FX = File.join(LIBRARY, "Sounds", "fx/**")

load_snippets SONIC + "/snippets", true

# Run all files in the helpers subdirectory
Dir.glob(SONIC + "/helpers/**/*.{spi,rb}").each do |path|
  run_file path
end
