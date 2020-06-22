import 'dart:ui';
import 'dart:ui' as ui show TextStyle;
import 'dart:math';

import 'package:box2d_flame/box2d.dart';
import 'package:flutter/material.dart';

Paragraph buildParagraph(String text, double textSize, double constWidth,
    TextAlign lor, Color colour) {
  ParagraphBuilder builder = ParagraphBuilder(
    ParagraphStyle(
      textAlign: lor,
      fontSize: textSize,
      fontWeight: FontWeight.normal,
    ),
  );
  builder.pushStyle(ui.TextStyle(color: colour));
  builder.addText(text);
  ParagraphConstraints constraints = ParagraphConstraints(width: constWidth);
  return builder.build()..layout(constraints);
}

Vector2 offsetToVec(Offset offset) {
  return Vector2(offset.dx / 50, offset.dy / 50);
}

Offset vecToOffset(Vector2 vec) {
  return Offset(vec.x * 50, vec.y * 50);
}

void renderPolygon(Canvas canvas, List<Offset> points, Color color) {
  final path = Path()..addPolygon(points, true);
  final Paint paint = Paint()..color = color;
  // ..style = PaintingStyle.stroke
  // ..strokeWidth = 2;
  canvas.drawPath(path, paint);
}

Offset updateRotation(Offset corner, Offset center, double angle) {
  var rad = -angle;
  var offDiff = corner - center;
  return Offset((offDiff.dx) * cos(rad) + (offDiff.dy) * sin(rad) + center.dx,
      (-offDiff.dx) * sin(rad) + (offDiff.dy) * cos(rad) + center.dy);
}

List<Offset> shrink(List<Offset> points) {
  var centre = points.reduce((value, element) => value + element) / 4;
  var shrinkList = List<Offset>();
  points.forEach((point) {
    var dir = centre - point;
    var off = Offset.fromDirection(dir.direction, 2.0);
    shrinkList.add(point + off);
  });
  return shrinkList;
}

class Coor {
  final double x;
  final double y;

  Coor({this.x, this.y});
}

List<Map> myJson() {
  List<Map> countries = List<Map>();
  countries.addAll([
    {"id": 'afg', "image": 'assets/images/afg.png', "name": 'Afghanistan'},
    {"id": 'and', "image": 'assets/images/and.png', "name": 'Andorra'},
    {"id": 'alb', "image": 'assets/images/alb.png', "name": 'Albania'},
    {"id": 'alg', "image": 'assets/images/alg.png', "name": 'Algeria'},
    {"id": 'asa', "image": 'assets/images/asa.png', "name": 'American Samoa'},
    {"id": 'ang', "image": 'assets/images/ang.png', "name": 'Angola'},
    {"id": 'aia', "image": 'assets/images/aia.png', "name": 'Anguilla'},
    {
      "id": 'atg',
      "image": 'assets/images/atg.png',
      "name": 'Antigua and Barbuda'
    },
    {"id": 'arg', "image": 'assets/images/arg.png', "name": 'Argentina'},
    {"id": 'arm', "image": 'assets/images/arm.png', "name": 'Armenia'},
    {"id": 'aru', "image": 'assets/images/aru.png', "name": 'Aruba'},
    {"id": 'aus', "image": 'assets/images/aus.png', "name": 'Australia'},
    {"id": 'aut', "image": 'assets/images/aut.png', "name": 'Austria'},
    {"id": 'aze', "image": 'assets/images/aze.png', "name": 'Azerbaijan'},
    {"id": 'bah', "image": 'assets/images/bah.png', "name": 'Bahamas'},
    {"id": 'bhr', "image": 'assets/images/bhr.png', "name": 'Bahrain'},
    {"id": 'ban', "image": 'assets/images/ban.png', "name": 'Bangladesh'},
    {"id": 'brb', "image": 'assets/images/brb.png', "name": 'Barbados'},
    {"id": 'blr', "image": 'assets/images/blr.png', "name": 'Belarus'},
    {"id": 'bel', "image": 'assets/images/bel.png', "name": 'Belgium'},
    {"id": 'blz', "image": 'assets/images/blz.png', "name": 'Belize'},
    {"id": 'ben', "image": 'assets/images/ben.png', "name": 'Benin'},
    {"id": 'ber', "image": 'assets/images/ber.png', "name": 'Bermuda'},
    {"id": 'bhu', "image": 'assets/images/bhu.png', "name": 'Bhutan'},
    {"id": 'bol', "image": 'assets/images/bol.png', "name": 'Bolivia'},
    {
      "id": 'bih',
      "image": 'assets/images/bih.png',
      "name": 'Bosnia and Herzegovina'
    },
    {"id": 'bot', "image": 'assets/images/bot.png', "name": 'Botswana'},
    {"id": 'bra', "image": 'assets/images/bra.png', "name": 'Brazil'},
    {
      "id": 'vgb',
      "image": 'assets/images/vgb.png',
      "name": 'British Virgin Islands'
    },
    {
      "id": 'bru',
      "image": 'assets/images/bru.png',
      "name": 'Brunei Darussalam'
    },
    {"id": 'bul', "image": 'assets/images/bul.png', "name": 'Bulgaria'},
    {"id": 'bfa', "image": 'assets/images/bfa.png', "name": 'Burkina Faso'},
    {"id": 'bdi', "image": 'assets/images/bdi.png', "name": 'Burundi'},
    {"id": 'cpv', "image": 'assets/images/cpv.png', "name": 'Cabo Verde'},
    {"id": 'cam', "image": 'assets/images/cam.png', "name": 'Cambodia'},
    {"id": 'cmr', "image": 'assets/images/cmr.png', "name": 'Cameroon'},
    {"id": 'can', "image": 'assets/images/can.png', "name": 'Canada'},
    {"id": 'cay', "image": 'assets/images/cay.png', "name": 'Cayman Islands'},
    {
      "id": 'cta',
      "image": 'assets/images/cta.png',
      "name": 'Central African Republic'
    },
    {"id": 'cha', "image": 'assets/images/cha.png', "name": 'Chad'},
    {"id": 'chi', "image": 'assets/images/chi.png', "name": 'Chile'},
    {"id": 'chn', "image": 'assets/images/chn.png', "name": 'China PR'},
    {"id": 'tpe', "image": 'assets/images/tpe.png', "name": 'Chinese Taipei'},
    {"id": 'col', "image": 'assets/images/col.png', "name": 'Colombia'},
    {"id": 'com', "image": 'assets/images/com.png', "name": 'Comoros'},
    {"id": 'cgo', "image": 'assets/images/cgo.png', "name": 'Congo'},
    {"id": 'cod', "image": 'assets/images/cod.png', "name": 'Congo DR'},
    {"id": 'cok', "image": 'assets/images/cok.png', "name": 'Cook Islands'},
    {"id": 'crc', "image": 'assets/images/crc.png', "name": 'Costa Rica'},
    {"id": 'civ', "image": 'assets/images/civ.png', "name": 'Côte dIvoire'},
    {"id": 'cro', "image": 'assets/images/cro.png', "name": 'Croatia'},
    {"id": 'cub', "image": 'assets/images/cub.png', "name": 'Cuba'},
    {"id": 'cuw', "image": 'assets/images/cuw.png', "name": 'Curaçao'},
    {"id": 'cyp', "image": 'assets/images/cyp.png', "name": 'Cyprus'},
    {"id": 'cze', "image": 'assets/images/cze.png', "name": 'Czech Republic'},
    {"id": 'den', "image": 'assets/images/den.png', "name": 'Denmark'},
    {"id": 'dji', "image": 'assets/images/dji.png', "name": 'Djibouti'},
    {"id": 'dma', "image": 'assets/images/dma.png', "name": 'Dominica'},
    {
      "id": 'dom',
      "image": 'assets/images/dom.png',
      "name": 'Dominican Republic'
    },
    {"id": 'ecu', "image": 'assets/images/ecu.png', "name": 'Ecuador'},
    {"id": 'egy', "image": 'assets/images/egy.png', "name": 'Egypt'},
    {"id": 'slv', "image": 'assets/images/slv.png', "name": 'El Salvador'},
    {"id": 'eng', "image": 'assets/images/eng.png', "name": 'England'},
    {
      "id": 'eqg',
      "image": 'assets/images/eqg.png',
      "name": 'Equatorial Guinea'
    },
    {"id": 'eri', "image": 'assets/images/eri.png', "name": 'Eritrea'},
    {"id": 'est', "image": 'assets/images/est.png', "name": 'Estonia'},
    {"id": 'swz', "image": 'assets/images/swz.png', "name": 'Eswatini'},
    {"id": 'eth', "image": 'assets/images/eth.png', "name": 'Ethiopia'},
    {"id": 'fro', "image": 'assets/images/fro.png', "name": 'Faroe Islands'},
    {"id": 'fij', "image": 'assets/images/fij.png', "name": 'Fiji'},
    {"id": 'fin', "image": 'assets/images/fin.png', "name": 'Finland'},
    {"id": 'fra', "image": 'assets/images/fra.png', "name": 'France'},
    {"id": 'ger', "image": 'assets/images/ger.png', "name": 'Germany'},
    {"id": 'geo', "image": 'assets/images/geo.png', "name": 'Georgia'},
    {"id": 'gam', "image": 'assets/images/gam.png', "name": 'Gambia'},
    {"id": 'gab', "image": 'assets/images/gab.png', "name": 'Gabon'},
    {"id": 'gha', "image": 'assets/images/gha.png', "name": 'Ghana'},
    {"id": 'gib', "image": 'assets/images/gib.png', "name": 'Gibraltar'},
    {"id": 'gre', "image": 'assets/images/gre.png', "name": 'Greece'},
    {"id": 'grn', "image": 'assets/images/grn.png', "name": 'Grenada'},
    {"id": 'gnb', "image": 'assets/images/gnb.png', "name": 'Guinea-Bissau'},
    {"id": 'gui', "image": 'assets/images/gui.png', "name": 'Guinea'},
    {"id": 'gua', "image": 'assets/images/gua.png', "name": 'Guatemala'},
    {"id": 'gum', "image": 'assets/images/gum.png', "name": 'Guam'},
    {"id": 'guy', "image": 'assets/images/guy.png', "name": 'Guyana'},
    {"id": 'hai', "image": 'assets/images/hai.png', "name": 'Haiti'},
    {"id": 'hon', "image": 'assets/images/hon.png', "name": 'Honduras'},
    {"id": 'hkg', "image": 'assets/images/hkg.png', "name": 'Hong Kong'},
    {"id": 'idn', "image": 'assets/images/idn.png', "name": 'Indonesia'},
    {"id": 'ind', "image": 'assets/images/ind.png', "name": 'India'},
    {"id": 'isl', "image": 'assets/images/isl.png', "name": 'Iceland'},
    {"id": 'hun', "image": 'assets/images/hun.png', "name": 'Hungary'},
    {"id": 'irn', "image": 'assets/images/irn.png', "name": 'IR Iran'},
    {"id": 'irq', "image": 'assets/images/irq.png', "name": 'Iraq'},
    {"id": 'isr', "image": 'assets/images/isr.png', "name": 'Israel'},
    {"id": 'ita', "image": 'assets/images/ita.png', "name": 'Italy'},
    {"id": 'kaz', "image": 'assets/images/kaz.png', "name": 'Kazakhstan'},
    {"id": 'jor', "image": 'assets/images/jor.png', "name": 'Jordan'},
    {"id": 'jpn', "image": 'assets/images/jpn.png', "name": 'Japan'},
    {"id": 'jam', "image": 'assets/images/jam.png', "name": 'Jamaica'},
    {"id": 'ken', "image": 'assets/images/ken.png', "name": 'Kenya'},
    {"id": 'prk', "image": 'assets/images/prk.png', "name": 'Korea DPR'},
    {"id": 'kor', "image": 'assets/images/kor.png', "name": 'Korea Republic'},
    {"id": 'kvx', "image": 'assets/images/kvx.png', "name": 'Kosovo'},
    {"id": 'lva', "image": 'assets/images/lva.png', "name": 'Latvia'},
    {"id": 'lao', "image": 'assets/images/lao.png', "name": 'Laos'},
    {"id": 'kgz', "image": 'assets/images/kgz.png', "name": 'Kyrgyz Republic'},
    {"id": 'kuw', "image": 'assets/images/kuw.png', "name": 'Kuwait'},
    {"id": 'lbn', "image": 'assets/images/lbn.png', "name": 'Lebanon'},
    {"id": 'les', "image": 'assets/images/les.png', "name": 'Lesotho'},
    {"id": 'lbr', "image": 'assets/images/lbr.png', "name": 'Liberia'},
    {"id": 'lby', "image": 'assets/images/lby.png', "name": 'Libya'},
    {"id": 'mac', "image": 'assets/images/mac.png', "name": 'Macau'},
    {"id": 'lux', "image": 'assets/images/lux.png', "name": 'Luxembourg'},
    {"id": 'ltu', "image": 'assets/images/ltu.png', "name": 'Lithuania'},
    {"id": 'lie', "image": 'assets/images/lie.png', "name": 'Liechtenstein'},
    {"id": 'mad', "image": 'assets/images/mad.png', "name": 'Madagascar'},
    {"id": 'mwi', "image": 'assets/images/mwi.png', "name": 'Malawi'},
    {"id": 'mas', "image": 'assets/images/mas.png', "name": 'Malaysia'},
    {"id": 'mdv', "image": 'assets/images/mdv.png', "name": 'Maldives'},
    {"id": 'mri', "image": 'assets/images/mri.png', "name": 'Mauritius'},
    {"id": 'mtn', "image": 'assets/images/mtn.png', "name": 'Mauritania'},
    {"id": 'mlt', "image": 'assets/images/mlt.png', "name": 'Malta'},
    {"id": 'mli', "image": 'assets/images/mli.png', "name": 'Mali'},
    {"id": 'mex', "image": 'assets/images/mex.png', "name": 'Mexico'},
    {"id": 'mda', "image": 'assets/images/mda.png', "name": 'Moldova'},
    {"id": 'mng', "image": 'assets/images/mng.png', "name": 'Mongolia'},
    {"id": 'mne', "image": 'assets/images/mne.png', "name": 'Montenegro'},
    {"id": 'mya', "image": 'assets/images/mya.png', "name": 'Myanmar'},
    {"id": 'moz', "image": 'assets/images/moz.png', "name": 'Mozambique'},
    {"id": 'mar', "image": 'assets/images/mar.png', "name": 'Morocco'},
    {"id": 'msr', "image": 'assets/images/msr.png', "name": 'Montserrat'},
    {"id": 'nam', "image": 'assets/images/nam.png', "name": 'Namibia'},
    {"id": 'nep', "image": 'assets/images/nep.png', "name": 'Nepal'},
    {"id": 'ned', "image": 'assets/images/ned.png', "name": 'Netherlands'},
    {"id": 'ncl', "image": 'assets/images/ncl.png', "name": 'New Caledonia'},
    {"id": 'nga', "image": 'assets/images/nga.png', "name": 'Nigeria'},
    {"id": 'nig', "image": 'assets/images/nig.png', "name": 'Niger'},
    {"id": 'nca', "image": 'assets/images/nca.png', "name": 'Nicaragua'},
    {"id": 'nzl', "image": 'assets/images/nzl.png', "name": 'New Zealand'},
    {"id": 'mkd', "image": 'assets/images/mkd.png', "name": 'North Macedonia'},
    {"id": 'nir', "image": 'assets/images/nir.png', "name": 'Northern Ireland'},
    {"id": 'nor', "image": 'assets/images/nor.png', "name": 'Norway'},
    {"id": 'oma', "image": 'assets/images/oma.png', "name": 'Oman'},
    {"id": 'png', "image": 'assets/images/png.png', "name": 'Papua New Guinea'},
    {"id": 'pan', "image": 'assets/images/pan.png', "name": 'Panama'},
    {"id": 'ple', "image": 'assets/images/ple.png', "name": 'Palestine'},
    {"id": 'pak', "image": 'assets/images/pak.png', "name": 'Pakistan'},
    {"id": 'par', "image": 'assets/images/par.png', "name": 'Paraguay'},
    {"id": 'per', "image": 'assets/images/per.png', "name": 'Peru'},
    {"id": 'phi', "image": 'assets/images/phi.png', "name": 'Philippines'},
    {"id": 'pol', "image": 'assets/images/pol.png', "name": 'Poland'},
    {
      "id": 'irl',
      "image": 'assets/images/irl.png',
      "name": 'Republic of Ireland'
    },
    {"id": 'qat', "image": 'assets/images/qat.png', "name": 'Qatar'},
    {"id": 'pur', "image": 'assets/images/pur.png', "name": 'Puerto Rico'},
    {"id": 'por', "image": 'assets/images/por.png', "name": 'Portugal'},
    {"id": 'rou', "image": 'assets/images/rou.png', "name": 'Romania'},
    {"id": 'rus', "image": 'assets/images/rus.png', "name": 'Russia'},
    {"id": 'rwa', "image": 'assets/images/rwa.png', "name": 'Rwanda'},
    {"id": 'sam', "image": 'assets/images/sam.png', "name": 'Samoa'},
    {"id": 'sco', "image": 'assets/images/sco.png', "name": 'Scotland'},
    {"id": 'ksa', "image": 'assets/images/ksa.png', "name": 'Saudi Arabia'},
    {
      "id": 'stp',
      "image": 'assets/images/stp.png',
      "name": 'São Tomé and Príncipe'
    },
    {"id": 'smr', "image": 'assets/images/smr.png', "name": 'San Marino'},
    {"id": 'sen', "image": 'assets/images/sen.png', "name": 'Senegal'},
    {"id": 'srb', "image": 'assets/images/srb.png', "name": 'Serbia'},
    {"id": 'sey', "image": 'assets/images/sey.png', "name": 'Seychelles'},
    {"id": 'sle', "image": 'assets/images/sle.png', "name": 'Sierra Leone'},
    {"id": 'sol', "image": 'assets/images/sol.png', "name": 'Solomon Islands'},
    {"id": 'svn', "image": 'assets/images/svn.png', "name": 'Slovenia'},
    {"id": 'svk', "image": 'assets/images/svk.png', "name": 'Slovakia'},
    {"id": 'sin', "image": 'assets/images/sin.png', "name": 'Singapore'},
    {"id": 'som', "image": 'assets/images/som.png', "name": 'Somalia'},
    {"id": 'rsa', "image": 'assets/images/rsa.png', "name": 'South Africa'},
    {"id": 'ssd', "image": 'assets/images/ssd.png', "name": 'South Sudan'},
    {"id": 'esp', "image": 'assets/images/esp.png', "name": 'Spain'},
    {
      "id": 'vin',
      "image": 'assets/images/vin.png',
      "name": 'St. Vincent and the Grenadinese'
    },
    {"id": 'lca', "image": 'assets/images/lca.png', "name": 'St. Luciae'},
    {
      "id": 'skn',
      "image": 'assets/images/skn.png',
      "name": 'St. Kitts and Nevise'
    },
    {"id": 'sri', "image": 'assets/images/sri.png', "name": 'Sri Lanka'},
    {"id": 'sdn', "image": 'assets/images/sdn.png', "name": 'Sudan'},
    {"id": 'sur', "image": 'assets/images/sur.png', "name": 'Suriname'},
    {"id": 'swe', "image": 'assets/images/swe.png', "name": 'Sweden'},
    {"id": 'sui', "image": 'assets/images/sui.png', "name": 'Switzerland'},
    {"id": 'tan', "image": 'assets/images/tan.png', "name": 'Tanzania'},
    {"id": 'tjk', "image": 'assets/images/tjk.png', "name": 'Tajikistan'},
    {"id": 'tah', "image": 'assets/images/tah.png', "name": 'Tahiti'},
    {"id": 'syr', "image": 'assets/images/syr.png', "name": 'Syria'},
    {"id": 'tha', "image": 'assets/images/tha.png', "name": 'Thailand'},
    {"id": 'tls', "image": 'assets/images/tls.png', "name": 'Timor-Leste'},
    {"id": 'tog', "image": 'assets/images/tog.png', "name": 'Togo'},
    {"id": 'tga', "image": 'assets/images/tga.png', "name": 'Tonga'},
    {"id": 'tkm', "image": 'assets/images/tkm.png', "name": 'Turkmenistan'},
    {"id": 'tur', "image": 'assets/images/tur.png', "name": 'Turkey'},
    {"id": 'tun', "image": 'assets/images/tun.png', "name": 'Tunisia'},
    {
      "id": 'tri',
      "image": 'assets/images/tri.png',
      "name": 'Trinidad and Tobago'
    },
    {
      "id": 'tca',
      "image": 'assets/images/tca.png',
      "name": 'Turks and Caicos Islands'
    },
    {"id": 'uga', "image": 'assets/images/uga.png', "name": 'Uganda'},
    {"id": 'ukr', "image": 'assets/images/ukr.png', "name": 'Ukraine'},
    {
      "id": 'uae',
      "image": 'assets/images/uae.png',
      "name": 'United Arab Emirates'
    },
    {"id": 'uzb', "image": 'assets/images/uzb.png', "name": 'Uzbekistan'},
    {"id": 'usa', "image": 'assets/images/usa.png', "name": 'USA'},
    {
      "id": 'vir',
      "image": 'assets/images/vir.png',
      "name": 'US Virgin Islands'
    },
    {"id": 'uru', "image": 'assets/images/uru.png', "name": 'Uruguay'},
    {"id": 'van', "image": 'assets/images/van.png', "name": 'Vanuatu'},
    {"id": 'ven', "image": 'assets/images/ven.png', "name": 'Venezuela'},
    {"id": 'vie', "image": 'assets/images/vie.png', "name": 'Vietnam'},
    {"id": 'wal', "image": 'assets/images/wal.png', "name": 'Wales'},
    {"id": 'zim', "image": 'assets/images/zim.png', "name": 'Zimbabwe'},
    {"id": 'zam', "image": 'assets/images/zam.png', "name": 'Zambia'},
    {"id": 'yem', "image": 'assets/images/yem.png', "name": 'Yemen'},
  ]);
  // countries.sort((a, b) {
  //   return a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
  // });
  return countries;
}

List<String> countryCodes() {
  return [
    'yem','zam','zim','wal','vie','ven','van','uru','vir','usa',
    'uzb','uae','ukr','uga','tca','tri','tun','tur','tkm','tga',
    'tog','tls','tha','syr','tah','tjk','tan','sui','swe','sur',
    'sdn','sri','skn','lca','vin','esp','ssd','rsa','som','sin',
    'svk','svn','sol','sle','sey','srb','sen','smr','stp','ksa',
    'sco','sam','rwa','rus','rou','por','pur','qat','irl','pol',
    'phi','per','par','pak','ple','pan','png','oma','nor','nir',
    'mkd','nzl','nca','nig','nga','ncl','ned','nep','nam','msr',
    'mar','moz','mya','mne','mng','mda','mex','mli','mlt','mtn',
    'mri','mdv','mas','mwi','mad','lie','ltu','lux','mac','lby',
    'lbr','les','lbn','kuw','kgz','lao','lva','kvx','kor','prk',
    'ken','jam','jpn','jor','kaz','ita','isr','irq','irn','hun',
    'isl','ind','idn','hkg','hon','hai','guy','gum','gua','gui',
    'gnb','grn','gre','gib','gha','gab','gam','geo','ger','fra',
    'fin','fij','fro','eth','swz','est','eri','eqg','eng','slv',
    'egy','ecu','dom','dma','dji','den','cze','cyp','cuw','cub',
    'cro','civ','crc','cok','cod','cgo','com','col','tpe','chn',
    'chi','cha','cta','cay','can','cmr','cam','cpv','bdi','bfa',
    'bul','bru','vgb','bra','bot','bih','bol','bhu','ber','ben',
    'blz','bel','blr','brb','ban','bhr','bah','aze','aut','aus',
    'aru','arm','arg','atg','aia','ang','asa','alg','alb','and','afg'
  ];
}
