import 'package:flutter/material.dart';

const COLOR_BLACK = Color.fromRGBO(48, 47, 48, 1.0);
const COLOR_GREY = Color.fromRGBO(141, 141, 141, 1.0);
const COLOR_RED = Color.fromRGBO(255, 2, 49, 1.0);

const COLOR_WHITE = Colors.white;
const COLOR_DARK_BLUE = Color.fromRGBO(20, 25, 45, 1.0);

const BREAK_SCREEN_SIZE = 1080;

const String ANONYMOUS_PHOTO_URL = "https://firebasestorage.googleapis.com/v0/b/intelligent-plant.appspot.com/o/profilepictures%2FAnonymous.jpg?alt=media&token=c2ac8078-1128-4be5-9a93-1ad317b11a4d";

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
    displayLarge: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 26),
    displayMedium: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    displaySmall: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
    headlineMedium: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 16),
    headlineSmall: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    titleLarge: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    bodyLarge: TextStyle(
        color: COLOR_BLACK, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    bodyMedium: TextStyle(
        color:  COLOR_GREY, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    titleMedium:
    TextStyle(color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(
        color: COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w400));

const TextTheme TEXT_THEME_SMALL = TextTheme(
    displayLarge: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    displayMedium: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
    displaySmall: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 18),
    headlineMedium: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    headlineSmall: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    titleLarge: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 10),
    bodyLarge: TextStyle(
        color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    bodyMedium: TextStyle(
        color:  COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    titleMedium:
    TextStyle(color: COLOR_BLACK, fontSize: 10, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(
        color: COLOR_GREY, fontSize: 10, fontWeight: FontWeight.w400));

TextTheme TEXT_THEME_DEFAULT_DARK = TextTheme(
    displayLarge: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 26),
    displayMedium: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 22),
    displaySmall: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 20),
    headlineMedium: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 16),
    headlineSmall: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 14),
    titleLarge: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 12),
    bodyLarge: TextStyle(
        color: COLOR_WHITE, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    bodyMedium: TextStyle(
        color:  COLOR_GREY, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    titleMedium:
    TextStyle(color: COLOR_WHITE, fontSize: 12, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(
        color: COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w400));

TextTheme TEXT_THEME_SMALL_DARK = TextTheme(
    displayLarge: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 22),
    displayMedium: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 20),
    displaySmall: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 18),
    headlineMedium: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 14),
    headlineSmall: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 12),
    titleLarge: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w700, fontSize: 10),
    bodyLarge: TextStyle(
        color: COLOR_WHITE, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    bodyMedium: TextStyle(
        color:  COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    titleMedium:
    TextStyle(color: COLOR_WHITE, fontSize: 10, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(
        color: COLOR_GREY, fontSize: 10, fontWeight: FontWeight.w400));

const TextTheme TEXT_THEME_DEFAULT_RED = TextTheme(
    displayLarge: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 26),
    displayMedium: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 22),
    displaySmall: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 20),
    headlineMedium: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 16),
    headlineSmall: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 14),
    titleLarge: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 12),
    bodyLarge: TextStyle(
        color: COLOR_RED, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    bodyMedium: TextStyle(
        color:  COLOR_GREY, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    titleMedium:
    TextStyle(color: COLOR_RED, fontSize: 12, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(
        color: COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w400));

const TextTheme TEXT_THEME_SMALL_RED = TextTheme(
    displayLarge: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 22),
    displayMedium: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 20),
    displaySmall: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 18),
    headlineMedium: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 14),
    headlineSmall: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 12),
    titleLarge: TextStyle(
        color: COLOR_RED, fontWeight: FontWeight.w700, fontSize: 10),
    bodyLarge: TextStyle(
        color: COLOR_RED, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    bodyMedium: TextStyle(
        color:  COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    titleMedium:
    TextStyle(color: COLOR_RED, fontSize: 10, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(
        color: COLOR_GREY, fontSize: 10, fontWeight: FontWeight.w400));


enum PLANT_SPECIES {
    Unknown,
    AfricanViolet,
    AechmeaFasciata,
    Aglaonema,
    AloeVera,
    AluminumPlant,
    Anthurium,
    Aphelandra,
    Arboricola,
    AsparagusFern,
    Aspidistra,
    AspleniumNidus,
    BarbertonDaisy,
    BeachSpiderLily,
    BelladonnaLily,
    BirdsNestFern,
    BostonFern,
    Bromeliad,
    BuddhistPine,
    Cactus,
    Calathea,
    CastIronPlant,
    ChineseEvergreen,
    ChineseMoneyPlant,
    ChlorophytumComosum,
    Croton,
    Dieffenbachia,
    Dracaena,
    EnglishIvy,
    FicusBenjamina,
    FicusLyrata,
    Fittonia,
    GoldenPothos,
    Guzmania,
    Hoya,
    JadePlant,
    KentiaPalm,
    LadyPalm,
    LipstickPlant,
    MadagascarDragonTree,
    MaidenhairFern,
    MarantaPrayerPlant,
    Monstera,
    MonsteraAdansonii,
    MonsteraDeliciosa,
    NephrolepisExaltata,
    Orchid,
    PachiraAquatica,
    ParlorPalm,
    PeaceLily,
    Philodendron,
    PileaCadierei,
    PileaPeperomioides,
    Pothos,
    RubberPlant,
    Sansevieria,
    Schefflera,
    Spathiphyllum,
    SpiderPlant,
    Strelitzia,
    Syngonium,
    Tillandsia,
    TradescantiaZebrina,
    VrieseaSplendens,
    WalkingIris,
    WaxBegonia,
    Yucca,
    ZamioculcasZamiifolia,
    Bonsai,
    MoneyTree,
    MothOrchid,
    NervePlant,
    Oxalis,
    PaddlePlant,
    PandaPlant,
    Peperomia,
    PinkQuill,
    PonytailPalm,
    PurpleHeart,
    PurpleShamrock,
    RattlesnakePlant,
    RedAglaonema,
    RedMaranta,
    RedVeinedSorrel,
    RexBegonia,
    RubberTree,
    SnakePlant,
    StringOfHearts,
    StringOfPearls,
    SwissCheesePlant,
    UmbrellaTree,
    VenusFlytrap,
    WeepingFig,
    ZZPlant
}

enum DATA_TYPES { Light, Temperature, Water }

enum LIGHT_DATA_TYPE { inLux, inPercent }
enum TEMP_DATA_TYPE { inC, inF, inPercent }