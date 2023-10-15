class WebsiteFormatter {
  static String getLogo(int category) {
    String logoUrl = '';
    switch (category) {
      case 1:
        logoUrl =
            'https://seeklogo.com/images/W/web-icon-logo-A6B586D114-seeklogo.com.png';
        break;
      case 2:
        logoUrl =
            "https://www.clipartmax.com/png/full/284-2848088_fandom-logos-fandom-wikia-logo-png.png";
        break;
      case 3:
        logoUrl =
            'https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Wikipedia_svg_logo-pt.svg/1784px-Wikipedia_svg_logo-pt.svg.png';
        break;
      case 4:
        logoUrl =
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Facebook_f_logo_%282019%29.svg/1024px-Facebook_f_logo_%282019%29.svg.png';
        break;
      case 5:
        logoUrl =
            'https://freelogopng.com/images/all_img/1690643591twitter-x-logo-png.png';
        break;
      case 6:
        logoUrl =
            'https://freelogopng.com/images/all_img/1656151504twitch-logo-image.png';
        break;
      case 8:
        logoUrl =
            'https://seeklogo.com/images/I/instagram-new-2016-logo-4773FE3F99-seeklogo.com.png';
        break;
      case 9:
        logoUrl =
            'https://freelogopng.com/images/all_img/1656501968youtube-icon-png.png';
        break;
      case 10:
        logoUrl = 'https://pngfre.com/wp-content/uploads/apple-logo-13.png';
        break;
      case 11:
        logoUrl = 'https://pngfre.com/wp-content/uploads/apple-logo-13.png';
        break;
      case 12:
        logoUrl = 'https://cdn-icons-png.flaticon.com/512/732/732208.png';
        break;
      case 13:
        logoUrl =
            'https://upload.wikimedia.org/wikipedia/commons/c/c1/Steam_Logo.png';
        break;
      case 14:
        logoUrl =
            'https://seeklogo.com/images/R/reddit-logo-23F13F6A6A-seeklogo.com.png';
        break;
      case 15:
        logoUrl =
            'https://static-00.iconduck.com/assets.00/itch-io-icon-2048x2048-i6hzclad.png';
        break;
      case 16:
        logoUrl =
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Epic_Games_logo.svg/1764px-Epic_Games_logo.svg.png';
        break;
      case 17:
        logoUrl =
            'https://www.iconarchive.com/download/i125353/pictogrammers/material/gog.1024.png';
        break;
      case 18:
        logoUrl =
            'https://static.vecteezy.com/system/resources/previews/018/930/718/original/discord-logo-discord-icon-transparent-free-png.png';
        break;
    }

    return logoUrl;
  }

  static String getName(int category) {
    String name = '';
    switch (category) {
      case 1:
        name = 'Site Oficial';
        break;
      case 2:
        name = "Wikia";
        break;
      case 3:
        name = 'Wikipedia';
        break;
      case 4:
        name = 'Facebook';
        break;
      case 5:
        name = 'X / Twitter';
        break;
      case 6:
        name = 'Twitch';
        break;
      case 8:
        name = 'Instagram';
        break;
      case 9:
        name = 'Youtube';
        break;
      case 10:
        name = 'Apple Store';
        break;
      case 11:
        name = 'Apple Store';
        break;
      case 12:
        name = 'Google Play';
        break;
      case 13:
        name = 'Steam';
        break;
      case 14:
        name = 'Reddit';
        break;
      case 15:
        name = 'Itch';
        break;
      case 16:
        name = 'Epic Games';
        break;
      case 17:
        name = 'GOG';
        break;
      case 18:
        name = 'Discord';
        break;
    }
    return name;
  }
}
