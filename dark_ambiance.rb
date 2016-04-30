use_transpose 7

define :toto do
  sync :euclid_beat
  with_fx :pan, pan: rdist(1, 0) do
    with_synth :fm  do
      play chord(:e3, :minor).choose, release: 0.8, sustain: 1, amp: 0.5
    end
  end
end

live_loop :toto do
  toto
  sleep 0.25
end

live_loop :toto2 do
  sync :toto
  play chord(:e4, :minor).choose, pan: rdist(0.5, 0)
  sleep 2
end

live_loop :drums do
  with_fx :echo, amp: 0.1 do
    with_transpose 9 do
      sync :toto
      sample :drum_cymbal_closed
      sample :bd_boom
      sample :ambi_soft_buzz
      sleep 0.25
    end
  end
end

live_loop :highbeeps do
  sync :toto
  with_synth :mod_fm do
    with_fx :bpf do
      with_fx :flanger do
        play chord(:c3, :minor).choose, amp: 1, pan: rdist(1)
        play chord(:c8, :minor).choose, amp: 0.05, pan: rdist(1) if one_in 4
        sleep 0.25
      end
    end
  end
end

live_loop :euclid_beat do
  with_fx :level do
    with_fx :echo, phase: 0.5, mix: 0.2 do
      sample :elec_bong, amp: 1.0 if (spread 3, 8).tick
      sample :perc_snap, amp: 0.1, rate: 0.3 if (spread 7, 11).look
      sample :bd_haus, amp: 2 if (spread 1, 4).look
      sleep 0.125
    end
  end
end

live_loop :test2 do
  sync :toto
  with_synth :dark_ambience do
    with_fx :reverb do
      with_fx :level, amp: 1.9 do
        if (ring 0, 1, 0, 0).tick
          play :b4
          play :e4
        end
      end
    end
  end
end
