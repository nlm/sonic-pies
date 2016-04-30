use_bpm 125

live_loop :drums do
  sample :drum_bass_hard
  sample :drum_bass_soft
  if (ring false, true).tick then
    sample :drum_snare_soft
  end
  sleep 1
end

live_loop :hiss do
  sync :drums
  sample :ambi_drone, beat_stretch: 0.96, pitch_dis: 3, amp: 0.6
  if one_in 4 then
    sample :ambi_lunar_land, beat_stretch: 4
  end
  sleep 4
end

live_loop :bass do
  sync :drums
  with_synth :dsaw do |s|
    with_fx :wobble, phase: 0.5, amp: 0.2, pan: -0.5 do |f|
      play (chord :f1, :minor7).reverse.tick, release: 16, sustain: 8
      play (chord :a2, :minor7).reverse.tick, release: 16, sustain: 8, amp: 0.2
      for x in range(0, 4) do
          sleep 4
          phaz = ((x + 1) * 2)
          control f, phase: phaz
        end
      end
    end
  end
  
  live_loop :bass2 do
    sync :drums
    with_fx :ixi_techno do
      with_fx :reverb, pan: 0.5, amp: 0.75 do
        with_synth :chiplead do
          play :e4, release: 0.5
          sleep 0.125
          play :eb4, release: 0.5
          sleep 2 - 0.125
        end
      end
    end
    sleep 0
  end
  
  live_loop :tick do
    sync :drums
    sample :loop_amen, beat_stretch: 4, amp: 1.2
    sleep 4
  end
