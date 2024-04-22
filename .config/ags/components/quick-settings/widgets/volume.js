const audio = await Service.import("audio");

const VolumeIndicator = (type) => {
  let isMuted = false;
  const icon = Utils.watch("󰸈", audio[type], () => {
    if (audio[type].is_muted) {
      isMuted = true;
      return "󰸈";
    }
    isMuted = false;
    const volume = Math.floor(audio[type].volume * 100);

    if (volume < 33) {
      return "";
    } else if (volume < 67) {
      return "";
    } else {
      return "";
    }
  });

  return Widget.Label({
    hpack: "start",
    label: icon,
    className: "volume-icon " + (isMuted ? "less" : "more"),
  });
};

const VolumeSlider = (type) =>
  Widget.Overlay({
    hexpand: true,
    passThrough: true,
    child: Widget.Slider({
      drawValue: false,
      on_change: ({ value, dragging }) => {
        if (dragging) {
          audio[type].volume = value;
          audio[type].is_muted = false;
        }
      },
      value: audio[type].bind("volume"),
      className: "volume-slider",
    }),

    overlays: [VolumeIndicator(type)],
  });

const VolumeMute = (type) => {
  const isMuted = Utils.watch(false, audio[type], () => {
    if (audio[type].is_muted) {
      return true;
    }
    return false;
  });

  return Widget.Button({
    onClicked: () => {
      audio[type].is_muted = !audio[type].is_muted;
    },
    className: "volume-mute " + (isMuted ? "active" : ""),
    child: Widget.Label({
      label: "󰝟",
    }),
  });
};

export const Volume = () =>
  Widget.Box({
    class_name: "volume",
    children: [
      VolumeSlider("speaker"),
      VolumeMute("speaker"),
      // Widget.Box({
      //   vpack: "center",
      //   child: Arrow("sink-selector"),
      // }),
      // Widget.Box({
      //   vpack: "center",
      //   child: Arrow("app-mixer"),
      //   visible: audio.bind("apps").as((a) => a.length > 0),
      // }),
    ],
  });
