class Season {
  Season(this.name) {
    description = getDescriptionForSeason(name);
  }

  String name;
  late String description = getDescriptionForSeason(name);

  String getDescriptionForSeason(String seasonName) {
    switch (seasonName.toLowerCase()) {
      case 'winter':
        return 'As winter descends upon the Martian landscape, the already desolate red planet undergoes a dramatic transformation. Frigid temperatures plummet even further, causing carbon dioxide to freeze into frosty polar caps at the poles. The thin atmosphere, composed mostly of carbon dioxide, allows for limited heat retention, resulting in stark temperature contrasts between day and night. The rusty-red terrain becomes coated in a layer of icy regolith, creating an otherworldly vista of crimson and white. Dust storms, though less frequent in the cold, can still sweep across the plains, carrying fine particles through the thin air and enhancing the ethereal beauty of Mars\' winter.';
      case 'fall':
        return 'During the Martian autumn, the planet experiences a subtle shift in its atmosphere and landscape. As temperatures moderate from the extremes of summer, the polar ice caps begin to recede, revealing intricate patterns of underlying terrain. The rust-colored soil takes on a richer hue, and gusts of wind carry fine dust particles through the thin atmosphere, creating a soft, reddish haze that bathes the Martian surface. Despite the overall arid conditions, seasonal changes in temperature and wind patterns contribute to a dynamic and visually captivating Martian fall.';
      case 'summer':
        return 'Mars\' summer is characterized by relentless sunlight and elevated temperatures, particularly in the southern hemisphere. The polar ice caps, mostly composed of water and carbon dioxide, begin to sublimate, releasing thin wisps of vapor into the atmosphere. Dust devils dance across the plains, propelled by strong seasonal winds that pick up fine particles and cast them into the air, creating a reddish veil over the Martian landscape. The combination of the extended daylight hours and the planet\'s elliptical orbit intensifies the summer heat, giving the Martian surface a vibrant and dynamic energy.';
      case 'spring':
        return 'As spring arrives on Mars, the planet undergoes a gradual awakening from the winter chill. The polar caps start to thaw, releasing frozen carbon dioxide and water back into the atmosphere. The surface temperature begins to rise, and dormant dust devils re-emerge, swirling across the landscape and picking up loose regolith. Springs on Mars are marked by the emergence of transient surface features like dark streaks, formed by seasonal flows of briny water. The rusty-red plains come to life with subtle hues as dormant vegetation, if it existed, responds to the changing conditions, creating a brief but captivating burst of color on the Martian canvas.';
      default:
        return 'No description available';
    }
  }
}
