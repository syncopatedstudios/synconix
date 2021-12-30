define :midiarpeggiate do |progressions, tonic, mode=:major, pattern=[0, 1, 2, 3], repititions=2|
  scale_notes = scale(tonic, mode, num_octaves: 4)
  progressions.each do |deg|
    puts "prog", progressions
    repititions.times do
      with_synth :pluck do
        midi scale_notes[deg-1] - 12, sustain: 0.9, amp: 2
      end
      t = 1.0 / pattern.length
      pattern.each do |i|
        n = scale_notes[deg - 1 + 2*i + (i+1) / 4]
        midi n, sustain: 1.5 * t, amp: 0.8
        sleep t
      end
    end
  end
end

define :arpeggiate do |prog, tonic, mode=:major, pattern=[0, 1, 2, 3], reps=2|
  sc = scale(tonic, mode, num_octaves: 4)
  prog.each do |deg|
    puts "prog", prog
    reps.times do
      with_synth :pluck do
        play sc[deg-1] - 12, sustain: 0.9, amp: 2
      end
      t = 1.0 / pattern.length
      pattern.each do |i|
        n = sc[deg - 1 + 2*i + (i+1) / 4]
        #puts "n", n
        with_synth :mod_beep do
          play n, sustain: 1.5 * t, amp: 0.8
          sleep t
        end
      end
    end
  end
end
