define :play_pattern_timed_multi do |notes, timings, synths, transpos|
  notes.each do |note|
    synths.each do |synth|
      with_synth synth do
        transpos.each do |transpo|
          with_transpose transpo do
            play note
          end
        end
      end
    end
    sleep timings.tick
  end
end

define :arpege_intro do |synths=[:fm], transpos=[0]|
  #  notes = [:e, :g, :fs, :fs, :fs,
  #           :g, :e, :fs, :fs, :fs]
  notes = [:d, :f, :e, :e, :e,
           :f, :d, :e, :e, :e]
  
  
  times1 = (ring 0.75, 0.75, 1, 1, 0.5)
  times2 = (ring 0.75, 0.75, 1, 1, 0.5,
            1, 1, 0.5, 0.75, 0.75)
  play_pattern_timed_multi notes, times1, synths, transpos
  play_pattern_timed_multi notes, times2, synths, transpos
end

define :drums1 do |t, s=1|
  t.times do
    sample :drum_heavy_kick, amp: 2
    sleep s
  end
end

define :drums2 do |t, s=1|
  (t / 2).times do
    sample :drum_heavy_kick, amp: 2
    sample :bd_klub, amp: 2
    sleep s
    sample :drum_heavy_kick, amp: 2
    sample :elec_hi_snare, amp: 2
    sleep s
  end
end

define :perc1 do |t|
  timings = (ring 1, 0.5, 0.25, 0.75, 1.5)
  
  (t / 4).times do
    timings.each do |slp|
      sample :elec_wood, pitch: 10, amp: 2, release: 0
      sleep slp
    end
  end
end

use_bpm 135


#perc1 8
#stop

synths = [:fm, :saw, :prophet]

in_thread do
  with_fx :bitcrusher, bits: 4 do
    with_fx :flanger, phase: 1, wave: 1, invert_wave: 1 do
      #    with_synth :supersaw do
      #      play :e3, sustain: 16
      #    end
      80.times do
        sample :elec_wood, pitch: 10, amp: 0.5, sustain: 8
        sleep 0.25
      end
    end
  end
end

arpege_intro synths=synths, transpos=[-12]
in_thread do
  drums1 16
end
arpege_intro synths=synths, transpos=[-12, 0, -7]

#2.times do
#  in_thread do
#    drums2 16
#  end
#  arpege_intro synths=synths, transpos=[-12, 0, -7]
# end

2.times do
  in_thread do
    drums2 16
  end
  in_thread do
    perc1 16
  end
  arpege_intro synths=synths, transpos=[-12, 0, -7]
end

stop
