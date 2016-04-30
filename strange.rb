base_note = :e3

live_loop :toto do
  with_synth :prophet do
    play base_note - 12
    sleep 0.25
    play :e1
    sleep 0.25
    cue :toto
    play :d1
    sleep 0.125
    play :e1
    sleep 0.5 - 0.125
  end
end

live_loop :synth do
  sync :toto
  with_fx :bitcrusher do
    with_fx :reverb, len: 2 do
      with_synth  :chipbass do
        play choose([:e4]), sustain: 0.5
        sleep 0.25
      end
    end
  end
end

live_loop :bar do
  sync :toto
  with_synth :tb303 do
    play :e2
  end
  sleep 4
end

live_loop :blop do
  sync :toto
  sleep 0.25
  with_fx :bitcrusher do
    play choose scale :e3, :minor_pentatonic
    sleep 1
  end
end
