# Sonic Pi init file
# Code in here will be evaluated on launch.

SONIC = File.join(ENV['HOME'], ".sonic-pi")


STUDIO = File.join(ENV['HOME'], "Studio")
LIBRARY = File.join(STUDIO, "library")
SOUNDS = File.join(LIBRARY, "sounds/**")


SAMPLES = File.join(LIBRARY, "sounds", "samples/**")
COLLECTIONS = File.join(LIBRARY, "sounds", "collections/**")
DRUMKITS = File.join(LIBRARY, "sounds", "drumkits/**")
LOOPS = File.join(LIBRARY, "sounds", "loops/**")
FX = File.join(LIBRARY, "sounds", "fx/**")
SYNTHS = File.join(LIBRARY, "sounds", "synths/**")
SOUNDSCAPES = File.join(LIBRARY, "sounds", "soundscapes/**")
PERCUSSIVE = File.join(LIBRARY, "sounds", "percussive/**")
INSTRUMENTS = File.join(LIBRARY, "sounds", "instruments/**")
PACKS = File.join(ENV['HOME'], "sounds", "fx/**")

load_snippets SONIC + "/snippets", true

# Run all files in the helpers subdirectory
Dir.glob(SONIC + "/helpers/**/*.{spi,rb}").each do |path|
  run_file path
end
