#### Notes ####
# Took commas off in csv files
# Removed District of Columbia and Puerto Rico

#### loading libraries ####
library(reshape2)     # creating long form data
library(dplyr)        # ording data
library(car)          # checking multicollinearity
library(DataCombine)  # generating lagged variables
library(foreign)      # exporting as .dta fiel

#### ID Variables ####
State <- rep(c("AL", "AK", "AZ", "AR", "CA",
               "CO", "CT", "DE", "FL", "GA",
               "HI", "ID", "IL", "IN", "IA",
               "KS", "KY", "LA", "ME", "MD",
               "MA", "MI", "MN", "MS", "MO",
               "MT", "NE", "NV", "NH", "NJ",
               "NM", "NY", "NC", "ND", "OH",
               "OK", "OR", "PA", "RI", "SC",
               "SD", "TN", "TX", "UT", "VT",
               "VA", "WA", "WV", "WI", "WY"), each = 7)

Year <- rep(c(2010, 2011, 2012, 2013, 2014, 2015, 2016), times = 50)

Lags <- rep(c(0, 1, 2, 3, 4, 5, 6), times = 50)

#### crime2010 ####
# read crime2010
origin <- read.csv(file = "crime2010.csv",
                   skip = 3,
                   nrows = 503,
                   stringsAsFactors = FALSE)

crime2010 <- origin[-c(78:83),]

attach(crime2010)

pop <- suppressWarnings(as.numeric(Population))
kill <- suppressWarnings(as.numeric(Murder.and.nonnegligent.manslaughter))

# 2010 crime variables
AL2010 <- c(pop[1] / pop[10], pop[4] / pop[10], pop[7] / pop[10], kill[10] / pop[10], kill[10])
AK2010 <- c(pop[12] / pop[19], pop[14] / pop[19], pop[17] / pop[19], kill[19] / pop[19], kill[19])
AZ2010 <- c(pop[21] / pop[30], pop[24] / pop[30], pop[27] / pop[30], kill[30] / pop[30], kill[30])
AR2010 <- c(pop[32] / pop[41], pop[35] / pop[41], pop[38] / pop[41], kill[41] / pop[41], kill[41])
CA2010 <- c(pop[43] / pop[49], pop[45] / pop[49], pop[47] / pop[49], kill[49] / pop[49], kill[49])
CO2010 <- c(pop[51] / pop[60], pop[54] / pop[60], pop[57] / pop[60], kill[60] / pop[60], kill[60])
CT2010 <- c(pop[62] / pop[68], pop[64] / pop[68], pop[66] / pop[68], kill[68] / pop[68], kill[68])
DE2010 <- c(pop[70] / pop[76], pop[72] / pop[76], pop[74] / pop[76], kill[76] / pop[76], kill[76])
FL2010 <- c(pop[78] / pop[86], pop[81] / pop[86], pop[84] / pop[86], kill[86] / pop[86], kill[86])
GA2010 <- c(pop[88] / pop[97], pop[91] / pop[97], pop[94] / pop[97], kill[97] / pop[97], kill[97])
HI2010 <- c(pop[99] / pop[104], pop[101] / pop[104], pop[102] / pop[104], kill[104] / pop[104], kill[104])
ID2010 <- c(pop[106] / pop[115], pop[109] / pop[115], pop[112] / pop[115], kill[115] / pop[115], kill[115])
IL2010 <- c(pop[117] / pop[126], pop[120] / pop[126], pop[123] / pop[126], kill[126] / pop[126], kill[126])
IN2010 <- c(pop[128] / pop[137], pop[131] / pop[137], pop[134] / pop[137], kill[137] / pop[137], kill[137])
IA2010 <- c(pop[139] / pop[148], pop[142] / pop[148], pop[145] / pop[148], kill[148] / pop[148], kill[148])
KS2010 <- c(pop[150] / pop[159], pop[153] / pop[159], pop[156] / pop[159], kill[159] / pop[159], kill[159])
KY2010 <- c(pop[161] / pop[170], pop[164] / pop[170], pop[167] / pop[170], kill[170] / pop[170], kill[170])
LA2010 <- c(pop[172] / pop[181], pop[175] / pop[181], pop[178] / pop[181], kill[181] / pop[181], kill[181])
ME2010 <- c(pop[183] / pop[189], pop[185] / pop[189], pop[187] / pop[189], kill[189] / pop[189], kill[189])
MD2010 <- c(pop[191] / pop[197], pop[193] / pop[197], pop[195] / pop[197], kill[197] / pop[197], kill[197])
MA2010 <- c(pop[199] / pop[206], pop[202] / pop[206], pop[204] / pop[206], kill[206] / pop[206], kill[206])
MI2010 <- c(pop[208] / pop[217], pop[211] / pop[217], pop[214] / pop[217], kill[217] / pop[217], kill[217])
MN2010 <- c(pop[219] / pop[228], pop[222] / pop[228], pop[225] / pop[228], kill[228] / pop[228], kill[228])
MS2010 <- c(pop[230] / pop[239], pop[233] / pop[239], pop[236] / pop[239], kill[239] / pop[239], kill[239])
MO2010 <- c(pop[241] / pop[250], pop[244] / pop[250], pop[247] / pop[250], kill[250] / pop[250], kill[250])
MT2010 <- c(pop[252] / pop[260], pop[254] / pop[260], pop[257] / pop[260], kill[260] / pop[260], kill[260])
NE2010 <- c(pop[262] / pop[271], pop[265] / pop[271], pop[268] / pop[271], kill[271] / pop[271], kill[271])
NV2010 <- c(pop[273] / pop[279], pop[275] / pop[279], pop[277] / pop[279], kill[279] / pop[279], kill[279])
NH2010 <- c(pop[281] / pop[290], pop[284] / pop[290], pop[287] / pop[290], kill[290] / pop[290], kill[290])
NJ2010 <- c(pop[292] / pop[296], pop[294] / pop[296], pop[295] / pop[296], kill[296] / pop[296], kill[296])
NM2010 <- c(pop[298] / pop[307], pop[301] / pop[307], pop[304] / pop[307], kill[307] / pop[307], kill[307])
NY2010 <- c(pop[309] / pop[317], pop[312] / pop[317], pop[315] / pop[317], kill[317] / pop[317], kill[317])
NC2010 <- c(pop[319] / pop[328], pop[322] / pop[328], pop[325] / pop[328], kill[328] / pop[328], kill[328])
ND2010 <- c(pop[330] / pop[338], pop[332] / pop[338], pop[335] / pop[338], kill[338] / pop[338], kill[338])
OH2010 <- c(pop[340] / pop[349], pop[343] / pop[349], pop[346] / pop[349], kill[349] / pop[349], kill[349])
OK2010 <- c(pop[351] / pop[358], pop[353] / pop[358], pop[356] / pop[358], kill[358] / pop[358], kill[358])
OR2010 <- c(pop[360] / pop[369], pop[363] / pop[369], pop[366] / pop[369], kill[369] / pop[369], kill[369])
PA2010 <- c(pop[371] / pop[379], pop[374] / pop[379], pop[377] / pop[379], kill[379] / pop[379], kill[379])
RI2010 <- c(pop[381] / pop[386], pop[383] / pop[386], pop[384] / pop[386], kill[386] / pop[386], kill[386])
SC2010 <- c(pop[388] / pop[396], pop[391] / pop[396], pop[394] / pop[396], kill[396] / pop[396], kill[396])
SD2010 <- c(pop[398] / pop[407], pop[401] / pop[407], pop[404] / pop[407], kill[407] / pop[407], kill[407])
TN2010 <- c(pop[409] / pop[415], pop[411] / pop[415], pop[413] / pop[415], kill[415] / pop[415], kill[415])
TX2010 <- c(pop[417] / pop[426], pop[420] / pop[426], pop[423] / pop[426], kill[426] / pop[426], kill[426])
UT2010 <- c(pop[428] / pop[437], pop[431] / pop[437], pop[434] / pop[437], kill[437] / pop[437], kill[437])
VT2010 <- c(pop[439] / pop[447], pop[441] / pop[447], pop[444] / pop[447], kill[447] / pop[447], kill[447])
VA2010 <- c(pop[449] / pop[455], pop[451] / pop[455], pop[453] / pop[455], kill[455] / pop[455], kill[455])
WA2010 <- c(pop[457] / pop[465], pop[460] / pop[465], pop[463] / pop[465], kill[465] / pop[465], kill[465])
WV2010 <- c(pop[467] / pop[476], pop[470] / pop[476], pop[473] / pop[476], kill[476] / pop[476], kill[476])
WI2010 <- c(pop[478] / pop[487], pop[481] / pop[487], pop[484] / pop[487], kill[487] / pop[487], kill[487])
WY2010 <- c(pop[489] / pop[496], pop[491] / pop[496], pop[494] / pop[496], kill[496] / pop[496], kill[496])

# creating dataset
clean2010 <- data.frame(rbind(AL2010, AK2010, AZ2010, AR2010, CA2010, CO2010, CT2010, DE2010, FL2010, GA2010,
                              HI2010, ID2010, IL2010, IN2010, IA2010, KS2010, KY2010, LA2010, ME2010, MD2010,
                              MA2010, MI2010, MN2010, MS2010, MO2010, MT2010, NE2010, NV2010, NH2010, NJ2010,
                              NM2010, NY2010, NC2010, ND2010, OH2010, OK2010, OR2010, PA2010, RI2010, SC2010,
                              SD2010, TN2010, TX2010, UT2010, VT2010, VA2010, WA2010, WV2010, WI2010, WY2010))

clean2010[is.na(clean2010)] <- 0

names(clean2010) <- c("MSA.r", "Cities.r", "NonMSA.r", "Murders.r", "Murders")

summary(lm(formula = Murders.r ~ MSA.r + Cities.r + NonMSA.r,
           data = clean2010))

#### crime2011 ####

# read crime2011
origin <- read.csv(file = "crime2011.csv",
                   skip = 3,
                   nrows = 511,
                   stringsAsFactors = FALSE)

crime2011 <- origin[-c(79:84, 389:394),]

attach(crime2011)

pop <- suppressWarnings(as.numeric(Population))
kill <- suppressWarnings(as.numeric(Murder.and.nonnegligent.manslaughter))

# 2011 crime variables
AL2011 <- c(pop[1] / pop[10], pop[4] / pop[10], pop[7] / pop[10], kill[10] / pop[10], kill[10])
AK2011 <- c(pop[12] / pop[19], pop[14] / pop[19], pop[17] / pop[19], kill[19] / pop[19], kill[19])
AZ2011 <- c(pop[21] / pop[30], pop[24] / pop[30], pop[27] / pop[30], kill[30] / pop[30], kill[30])
AR2011 <- c(pop[32] / pop[41], pop[35] / pop[41], pop[38] / pop[41], kill[41] / pop[41], kill[41])
CA2011 <- c(pop[43] / pop[50], pop[46] / pop[50], pop[48] / pop[50], kill[50] / pop[50], kill[50])
CO2011 <- c(pop[52] / pop[61], pop[55] / pop[61], pop[58] / pop[61], kill[61] / pop[61], kill[61])
CT2011 <- c(pop[63] / pop[69], pop[65] / pop[69], pop[67] / pop[69], kill[69] / pop[69], kill[69])
DE2011 <- c(pop[71] / pop[77], pop[73] / pop[77], pop[75] / pop[77], kill[77] / pop[77], kill[77])
FL2011 <- c(pop[79] / pop[87], pop[82] / pop[87], pop[85] / pop[87], kill[87] / pop[87], kill[87])
GA2011 <- c(pop[89] / pop[98], pop[92] / pop[98], pop[95] / pop[98], kill[98] / pop[98], kill[98])
HI2011 <- c(pop[100] / pop[106], pop[102] / pop[106], pop[103] / pop[106], kill[106] / pop[106], kill[106])
ID2011 <- c(pop[114] / pop[116], pop[111] / pop[116], pop[114] / pop[116], kill[116] / pop[116], kill[116])
IL2011 <- c(pop[118] / pop[127], pop[121] / pop[127], pop[124] / pop[127], kill[127] / pop[127], kill[127])
IN2011 <- c(pop[129] / pop[138], pop[132] / pop[138], pop[135] / pop[138], kill[138] / pop[138], kill[138])
IA2011 <- c(pop[140] / pop[149], pop[143] / pop[149], pop[146] / pop[149], kill[149] / pop[149], kill[149])
KS2011 <- c(pop[151] / pop[160], pop[154] / pop[160], pop[157] / pop[160], kill[160] / pop[160], kill[160])
KY2011 <- c(pop[162] / pop[171], pop[165] / pop[171], pop[168] / pop[171], kill[171] / pop[171], kill[171])
LA2011 <- c(pop[173] / pop[182], pop[176] / pop[182], pop[179] / pop[182], kill[182] / pop[182], kill[182])
ME2011 <- c(pop[184] / pop[190], pop[186] / pop[190], pop[188] / pop[190], kill[190] / pop[190], kill[190])
MD2011 <- c(pop[192] / pop[198], pop[194] / pop[198], pop[196] / pop[198], kill[198] / pop[198], kill[198])
MA2011 <- c(pop[200] / pop[207], pop[203] / pop[207], pop[205] / pop[207], kill[207] / pop[207], kill[207])
MI2011 <- c(pop[209] / pop[218], pop[212] / pop[218], pop[215] / pop[218], kill[218] / pop[218], kill[218])
MN2011 <- c(pop[220] / pop[229], pop[223] / pop[229], pop[226] / pop[229], kill[229] / pop[229], kill[229])
MS2011 <- c(pop[231] / pop[240], pop[234] / pop[240], pop[237] / pop[240], kill[240] / pop[240], kill[240])
MO2011 <- c(pop[242] / pop[250], pop[244] / pop[250], pop[247] / pop[250], kill[250] / pop[250], kill[250])
MT2011 <- c(pop[252] / pop[260], pop[254] / pop[260], pop[257] / pop[260], kill[260] / pop[260], kill[260])
NE2011 <- c(pop[262] / pop[271], pop[265] / pop[271], pop[268] / pop[271], kill[271] / pop[271], kill[271])
NV2011 <- c(pop[273] / pop[280], pop[275] / pop[280], pop[277] / pop[280], kill[280] / pop[280], kill[280])
NH2011 <- c(pop[282] / pop[291], pop[285] / pop[291], pop[288] / pop[291], kill[291] / pop[291], kill[291])
NJ2011 <- c(pop[293] / pop[297], pop[295] / pop[297], pop[296] / pop[297], kill[297] / pop[297], kill[297])
NM2011 <- c(pop[299] / pop[307], pop[301] / pop[307], pop[304] / pop[307], kill[307] / pop[307], kill[307])
NY2011 <- c(pop[309] / pop[318], pop[312] / pop[318], pop[315] / pop[318], kill[318] / pop[318], kill[318])
NC2011 <- c(pop[320] / pop[329], pop[323] / pop[329], pop[326] / pop[329], kill[329] / pop[329], kill[329])
ND2011 <- c(pop[331] / pop[340], pop[334] / pop[340], pop[337] / pop[340], kill[340] / pop[340], kill[340])
OH2011 <- c(pop[342] / pop[351], pop[345] / pop[351], pop[348] / pop[351], kill[351] / pop[351], kill[351])
OK2011 <- c(pop[353] / pop[360], pop[355] / pop[360], pop[358] / pop[360], kill[360] / pop[360], kill[360])
OR2011 <- c(pop[362] / pop[371], pop[365] / pop[371], pop[368] / pop[371], kill[371] / pop[371], kill[371])
PA2011 <- c(pop[373] / pop[381], pop[376] / pop[381], pop[379] / pop[381], kill[381] / pop[381], kill[381])
RI2011 <- c(pop[383] / pop[388], pop[385] / pop[388], pop[386] / pop[388], kill[388] / pop[388], kill[388])
SC2011 <- c(pop[390] / pop[398], pop[393] / pop[398], pop[396] / pop[398], kill[398] / pop[398], kill[398])
SD2011 <- c(pop[400] / pop[409], pop[403] / pop[409], pop[406] / pop[409], kill[409] / pop[409], kill[409])
TN2011 <- c(pop[411] / pop[417], pop[413] / pop[417], pop[415] / pop[417], kill[417] / pop[417], kill[417])
TX2011 <- c(pop[419] / pop[428], pop[422] / pop[428], pop[425] / pop[428], kill[428] / pop[428], kill[428])
UT2011 <- c(pop[430] / pop[439], pop[433] / pop[439], pop[436] / pop[439], kill[439] / pop[439], kill[439])
VT2011 <- c(pop[441] / pop[449], pop[443] / pop[449], pop[446] / pop[449], kill[449] / pop[449], kill[449])
VA2011 <- c(pop[451] / pop[458], pop[453] / pop[458], pop[456] / pop[458], kill[458] / pop[458], kill[458])
WA2011 <- c(pop[460] / pop[468], pop[463] / pop[468], pop[466] / pop[468], kill[468] / pop[468], kill[468])
WV2011 <- c(pop[470] / pop[479], pop[473] / pop[479], pop[476] / pop[479], kill[479] / pop[479], kill[479])
WI2011 <- c(pop[481] / pop[489], pop[484] / pop[489], pop[487] / pop[489], kill[489] / pop[489], kill[489])
WY2011 <- c(pop[491] / pop[498], pop[493] / pop[498], pop[496] / pop[498], kill[498] / pop[498], kill[498])

# creating dataset
clean2011 <- data.frame(rbind(AL2011, AK2011, AZ2011, AR2011, CA2011, CO2011, CT2011, DE2011, FL2011, GA2011,
                              HI2011, ID2011, IL2011, IN2011, IA2011, KS2011, KY2011, LA2011, ME2011, MD2011,
                              MA2011, MI2011, MN2011, MS2011, MO2011, MT2011, NE2011, NV2011, NH2011, NJ2011,
                              NM2011, NY2011, NC2011, ND2011, OH2011, OK2011, OR2011, PA2011, RI2011, SC2011,
                              SD2011, TN2011, TX2011, UT2011, VT2011, VA2011, WA2011, WV2011, WI2011, WY2011))

clean2011[is.na(clean2011)] <- 0

names(clean2011) <- c("MSA.r", "Cities.r", "NonMSA.r", "Murders.r", "Murders")

summary(lm(formula = Murders.r ~ MSA.r + Cities.r + NonMSA.r,
           data = clean2011)) # double-check!

#### crime2012 ####

# read crime2012
origin <- read.csv(file = "crime2012.csv",
                   skip = 3,
                   nrows = 502,
                   stringsAsFactors = FALSE)

crime2012 <- origin[-c(76:81, 381:386),]

attach(crime2012)

pop <- suppressWarnings(as.numeric(Population))
kill <- suppressWarnings(as.numeric(Murder.and.nonnegligent.manslaughter))

# 2012 crime variables
AL2012 <- c(pop[1] / pop[10], pop[4] / pop[10], pop[7] / pop[10], kill[10] / pop[10], kill[10])
AK2012 <- c(pop[12] / pop[19], pop[14] / pop[19], pop[17] / pop[19], kill[19] / pop[19], kill[19])
AZ2012 <- c(pop[21] / pop[29], pop[24] / pop[29], pop[27] / pop[29], kill[29] / pop[29], kill[29])
AR2012 <- c(pop[31] / pop[40], pop[34] / pop[40], pop[37] / pop[40], kill[40] / pop[40], kill[40])
CA2012 <- c(pop[42] / pop[49], pop[45] / pop[49], pop[47] / pop[49], kill[49] / pop[49], kill[49])
CO2012 <- c(pop[51] / pop[60], pop[54] / pop[60], pop[57] / pop[60], kill[60] / pop[60], kill[60])
CT2012 <- c(pop[62] / pop[68], pop[64] / pop[68], pop[66] / pop[68], kill[68] / pop[68], kill[68])
DE2012 <- c(pop[70] / pop[74], pop[72] / pop[74], pop[73] / pop[74], kill[74] / pop[74], kill[74])
FL2012 <- c(pop[76] / pop[84], pop[79] / pop[84], pop[82] / pop[84], kill[84] / pop[84], kill[84])
GA2012 <- c(pop[86] / pop[95], pop[89] / pop[95], pop[92] / pop[95], kill[95] / pop[95], kill[95])
HI2012 <- c(pop[97] / pop[102], pop[99] / pop[102], pop[100] / pop[102], kill[102] / pop[102], kill[102])
ID2012 <- c(pop[104] / pop[111], pop[107] / pop[111], pop[109] / pop[111], kill[111] / pop[111], kill[111])
IL2012 <- c(pop[113] / pop[122], pop[116] / pop[122], pop[119] / pop[122], kill[122] / pop[122], kill[122])
IN2012 <- c(pop[124] / pop[133], pop[127] / pop[133], pop[130] / pop[133], kill[133] / pop[133], kill[133])
IA2012 <- c(pop[135] / pop[144], pop[138] / pop[144], pop[141] / pop[144], kill[144] / pop[144], kill[144])
KS2012 <- c(pop[146] / pop[155], pop[149] / pop[155], pop[152] / pop[155], kill[155] / pop[155], kill[155])
KY2012 <- c(pop[157] / pop[166], pop[160] / pop[166], pop[163] / pop[166], kill[166] / pop[166], kill[166])
LA2012 <- c(pop[168] / pop[177], pop[171] / pop[177], pop[174] / pop[177], kill[177] / pop[177], kill[177])
ME2012 <- c(pop[179] / pop[185], pop[181] / pop[185], pop[183] / pop[185], kill[185] / pop[185], kill[185])
MD2012 <- c(pop[187] / pop[193], pop[189] / pop[193], pop[191] / pop[193], kill[193] / pop[193], kill[193])
MA2012 <- c(pop[195] / pop[203], pop[198] / pop[203], pop[201] / pop[203], kill[203] / pop[203], kill[203])
MI2012 <- c(pop[205] / pop[214], pop[208] / pop[214], pop[211] / pop[214], kill[214] / pop[214], kill[214])
MN2012 <- c(pop[216] / pop[222], pop[218] / pop[222], pop[220] / pop[222], kill[222] / pop[222], kill[222])
MS2012 <- c(pop[224] / pop[233], pop[227] / pop[233], pop[230] / pop[233], kill[233] / pop[233], kill[233])
MO2012 <- c(pop[235] / pop[243], pop[238] / pop[243], pop[241] / pop[243], kill[243] / pop[243], kill[243])
MT2012 <- c(pop[245] / pop[253], pop[247] / pop[253], pop[250] / pop[253], kill[253] / pop[253], kill[253])
NE2012 <- c(pop[255] / pop[264], pop[258] / pop[264], pop[261] / pop[264], kill[264] / pop[264], kill[264])
NV2012 <- c(pop[266] / pop[272], pop[268] / pop[272], pop[270] / pop[272], kill[272] / pop[272], kill[272])
NH2012 <- c(pop[274] / pop[283], pop[277] / pop[283], pop[280] / pop[283], kill[283] / pop[283], kill[283])
NJ2012 <- c(pop[285] / pop[290], pop[288] / pop[290], pop[289] / pop[290], kill[290] / pop[290], kill[290])
NM2012 <- c(pop[292] / pop[301], pop[295] / pop[301], pop[298] / pop[301], kill[301] / pop[301], kill[301])
NY2012 <- c(pop[303] / pop[311], pop[306] / pop[311], pop[309] / pop[311], kill[311] / pop[311], kill[311])
NC2012 <- c(pop[313] / pop[322], pop[316] / pop[322], pop[319] / pop[322], kill[322] / pop[322], kill[322])
ND2012 <- c(pop[324] / pop[332], pop[326] / pop[332], pop[329] / pop[332], kill[332] / pop[332], kill[332])
OH2012 <- c(pop[334] / pop[343], pop[337] / pop[343], pop[340] / pop[343], kill[343] / pop[343], kill[343])
OK2012 <- c(pop[345] / pop[352], pop[347] / pop[352], pop[350] / pop[352], kill[352] / pop[352], kill[352])
OR2012 <- c(pop[354] / pop[363], pop[357] / pop[363], pop[360] / pop[363], kill[363] / pop[363], kill[363])
PA2012 <- c(pop[365] / pop[373], pop[368] / pop[373], pop[371] / pop[373], kill[373] / pop[373], kill[373])
RI2012 <- c(pop[375] / pop[380], pop[377] / pop[380], pop[378] / pop[380], kill[380] / pop[380], kill[380])
SC2012 <- c(pop[382] / pop[390], pop[385] / pop[390], pop[388] / pop[390], kill[390] / pop[390], kill[390])
SD2012 <- c(pop[392] / pop[401], pop[395] / pop[401], pop[398] / pop[401], kill[401] / pop[401], kill[401])
TN2012 <- c(pop[403] / pop[409], pop[405] / pop[409], pop[407] / pop[409], kill[409] / pop[409], kill[409])
TX2012 <- c(pop[411] / pop[420], pop[414] / pop[420], pop[417] / pop[420], kill[420] / pop[420], kill[420])
UT2012 <- c(pop[422] / pop[431], pop[425] / pop[431], pop[428] / pop[431], kill[431] / pop[431], kill[431])
VT2012 <- c(pop[433] / pop[440], pop[435] / pop[440], pop[438] / pop[440], kill[440] / pop[440], kill[440])
VA2012 <- c(pop[442] / pop[448], pop[444] / pop[448], pop[446] / pop[448], kill[448] / pop[448], kill[448])
WA2012 <- c(pop[450] / pop[457], pop[452] / pop[457], pop[455] / pop[457], kill[457] / pop[457], kill[457])
WV2012 <- c(pop[459] / pop[468], pop[462] / pop[468], pop[465] / pop[468], kill[468] / pop[468], kill[468])
WI2012 <- c(pop[470] / pop[479], pop[473] / pop[479], pop[476] / pop[479], kill[479] / pop[479], kill[479])
WY2012 <- c(pop[481] / pop[489], pop[483] / pop[489], pop[486] / pop[489], kill[489] / pop[489], kill[489])

# creating dataset
clean2012 <- data.frame(rbind(AL2012, AK2012, AZ2012, AR2012, CA2012, CO2012, CT2012, DE2012, FL2012, GA2012,
                              HI2012, ID2012, IL2012, IN2012, IA2012, KS2012, KY2012, LA2012, ME2012, MD2012,
                              MA2012, MI2012, MN2012, MS2012, MO2012, MT2012, NE2012, NV2012, NH2012, NJ2012,
                              NM2012, NY2012, NC2012, ND2012, OH2012, OK2012, OR2012, PA2012, RI2012, SC2012,
                              SD2012, TN2012, TX2012, UT2012, VT2012, VA2012, WA2012, WV2012, WI2012, WY2012))

clean2012[is.na(clean2012)] <- 0

names(clean2012) <- c("MSA.r", "Cities.r", "NonMSA.r", "Murders.r", "Murders")

summary(lm(formula = Murders.r ~ MSA.r + Cities.r + NonMSA.r,
           data = clean2012))

#### Crime 2013 ####

# read crime2013
origin <- read.csv(file = "crime2013.csv",
                   skip = 3,
                   nrows = 507,
                   stringsAsFactors = FALSE)

crime2013 <- origin[-c(77:82, 384:389),]

attach(crime2013)

pop <- suppressWarnings(as.numeric(Population))
kill <- suppressWarnings(as.numeric(Murder.and.nonnegligent.manslaughter))

# 2013 crime variables
AL2013 <- c(pop[1] / pop[10], pop[4] / pop[10], pop[7] / pop[10], kill[10] / pop[10], kill[10])
AK2013 <- c(pop[12] / pop[19], pop[14] / pop[19], pop[17] / pop[19], kill[19] / pop[19], kill[19])
AZ2013 <- c(pop[21] / pop[29], pop[24] / pop[29], pop[27] / pop[29], kill[29] / pop[29], kill[29])
AR2013 <- c(pop[31] / pop[40], pop[34] / pop[40], pop[37] / pop[40], kill[40] / pop[40], kill[40])
CA2013 <- c(pop[42] / pop[49], pop[45] / pop[49], pop[47] / pop[49], kill[49] / pop[49], kill[49])
CO2013 <- c(pop[51] / pop[60], pop[54] / pop[60], pop[57] / pop[60], kill[60] / pop[60], kill[60])
CT2013 <- c(pop[62] / pop[68], pop[64] / pop[68], pop[66] / pop[68], kill[68] / pop[68], kill[68])
DE2013 <- c(pop[70] / pop[75], pop[72] / pop[75], pop[73] / pop[75], kill[75] / pop[75], kill[75])
FL2013 <- c(pop[77] / pop[86], pop[80] / pop[86], pop[83] / pop[86], kill[86] / pop[86], kill[86])
GA2013 <- c(pop[88] / pop[97], pop[91] / pop[97], pop[94] / pop[97], kill[97] / pop[97], kill[97])
HI2013 <- c(pop[99] / pop[104], pop[101] / pop[104], pop[102] / pop[104], kill[104] / pop[104], kill[104])
ID2013 <- c(pop[106] / pop[113], pop[109] / pop[113], pop[111] / pop[113], kill[113] / pop[113], kill[113])
IL2013 <- c(pop[115] / pop[124], pop[118] / pop[124], pop[121] / pop[124], kill[124] / pop[124], kill[124])
IN2013 <- c(pop[126] / pop[135], pop[129] / pop[135], pop[132] / pop[135], kill[135] / pop[135], kill[135])
IA2013 <- c(pop[137] / pop[146], pop[140] / pop[146], pop[143] / pop[146], kill[146] / pop[146], kill[146])
KS2013 <- c(pop[148] / pop[157], pop[151] / pop[157], pop[154] / pop[157], kill[157] / pop[157], kill[157])
KY2013 <- c(pop[159] / pop[168], pop[162] / pop[168], pop[165] / pop[168], kill[168] / pop[168], kill[168])
LA2013 <- c(pop[170] / pop[179], pop[173] / pop[179], pop[176] / pop[179], kill[179] / pop[179], kill[179])
ME2013 <- c(pop[181] / pop[187], pop[183] / pop[187], pop[185] / pop[187], kill[187] / pop[187], kill[187])
MD2013 <- c(pop[189] / pop[195], pop[191] / pop[195], pop[193] / pop[195], kill[195] / pop[195], kill[195])
MA2013 <- c(pop[197] / pop[205], pop[200] / pop[205], pop[203] / pop[205], kill[205] / pop[205], kill[205])
MI2013 <- c(pop[207] / pop[216], pop[210] / pop[216], pop[213] / pop[216], kill[216] / pop[216], kill[216])
MN2013 <- c(pop[218] / pop[225], pop[221] / pop[225], pop[223] / pop[225], kill[225] / pop[225], kill[225])
MS2013 <- c(pop[227] / pop[236], pop[230] / pop[236], pop[233] / pop[236], kill[236] / pop[236], kill[236])
MO2013 <- c(pop[238] / pop[246], pop[241] / pop[246], pop[244] / pop[246], kill[246] / pop[246], kill[246])
MT2013 <- c(pop[248] / pop[256], pop[250] / pop[256], pop[253] / pop[256], kill[256] / pop[256], kill[256])
NE2013 <- c(pop[258] / pop[267], pop[261] / pop[267], pop[264] / pop[267], kill[267] / pop[267], kill[267])
NV2013 <- c(pop[269] / pop[276], pop[271] / pop[276], pop[273] / pop[276], kill[276] / pop[276], kill[276])
NH2013 <- c(pop[278] / pop[287], pop[281] / pop[287], pop[284] / pop[287], kill[287] / pop[287], kill[287])
NJ2013 <- c(pop[289] / pop[294], pop[292] / pop[294], pop[293] / pop[294], kill[294] / pop[294], kill[294])
NM2013 <- c(pop[296] / pop[305], pop[299] / pop[305], pop[298] / pop[302], kill[305] / pop[305], kill[305])
NY2013 <- c(pop[307] / pop[315], pop[310] / pop[315], pop[313] / pop[315], kill[315] / pop[315], kill[315])
NC2013 <- c(pop[317] / pop[326], pop[320] / pop[326], pop[323] / pop[326], kill[326] / pop[326], kill[326])
ND2013 <- c(pop[328] / pop[336], pop[330] / pop[336], pop[333] / pop[336], kill[336] / pop[336], kill[336])
OH2013 <- c(pop[338] / pop[347], pop[341] / pop[347], pop[344] / pop[347], kill[347] / pop[347], kill[347])
OK2013 <- c(pop[349] / pop[355], pop[351] / pop[355], pop[353] / pop[355], kill[355] / pop[355], kill[355])
OR2013 <- c(pop[357] / pop[366], pop[360] / pop[366], pop[363] / pop[366], kill[366] / pop[366], kill[366])
PA2013 <- c(pop[368] / pop[376], pop[371] / pop[376], pop[374] / pop[376], kill[376] / pop[376], kill[376])
RI2013 <- c(pop[378] / pop[383], pop[380] / pop[383], pop[381] / pop[383], kill[383] / pop[383], kill[383])
SC2013 <- c(pop[385] / pop[393], pop[388] / pop[393], pop[391] / pop[393], kill[393] / pop[393], kill[393])
SD2013 <- c(pop[395] / pop[404], pop[398] / pop[404], pop[401] / pop[404], kill[404] / pop[404], kill[404])
TN2013 <- c(pop[406] / pop[413], pop[409] / pop[413], pop[411] / pop[413], kill[413] / pop[413], kill[413])
TX2013 <- c(pop[415] / pop[424], pop[418] / pop[424], pop[421] / pop[424], kill[424] / pop[424], kill[424])
UT2013 <- c(pop[426] / pop[435], pop[429] / pop[435], pop[432] / pop[435], kill[435] / pop[435], kill[435])
VT2013 <- c(pop[437] / pop[444], pop[439] / pop[444], pop[442] / pop[444], kill[444] / pop[444], kill[444])
VA2013 <- c(pop[446] / pop[453], pop[449] / pop[453], pop[451] / pop[453], kill[453] / pop[453], kill[453])
WA2013 <- c(pop[455] / pop[462], pop[457] / pop[462], pop[460] / pop[462], kill[462] / pop[462], kill[462])
WV2013 <- c(pop[464] / pop[473], pop[467] / pop[473], pop[470] / pop[473], kill[473] / pop[473], kill[473])
WI2013 <- c(pop[475] / pop[484], pop[478] / pop[484], pop[481] / pop[484], kill[484] / pop[484], kill[484])
WY2013 <- c(pop[486] / pop[494], pop[488] / pop[494], pop[491] / pop[494], kill[494] / pop[494], kill[494])

# creating dataset
clean2013 <- data.frame(rbind(AL2013, AK2013, AZ2013, AR2013, CA2013, CO2013, CT2013, DE2013, FL2013, GA2013,
                              HI2013, ID2013, IL2013, IN2013, IA2013, KS2013, KY2013, LA2013, ME2013, MD2013,
                              MA2013, MI2013, MN2013, MS2013, MO2013, MT2013, NE2013, NV2013, NH2013, NJ2013,
                              NM2013, NY2013, NC2013, ND2013, OH2013, OK2013, OR2013, PA2013, RI2013, SC2013,
                              SD2013, TN2013, TX2013, UT2013, VT2013, VA2013, WA2013, WV2013, WI2013, WY2013))

clean2013[is.na(clean2013)] <- 0

names(clean2013) <- c("MSA.r", "Cities.r", "NonMSA.r", "Murders.r", "Murders")

summary(lm(formula = Murders.r ~ MSA.r + Cities.r + NonMSA.r,
           data = clean2013)) #double-check!

#### Crime 2014 ####

# read crime2014
origin <- read.csv(file = "crime2014.csv",
                   skip = 3,
                   nrows = 505,
                   stringsAsFactors = FALSE)

crime2014 <- origin[-c(77:82, 381:386),]

attach(crime2014)

pop <- suppressWarnings(as.numeric(Population))
kill <- suppressWarnings(as.numeric(Murder.and.nonnegligent.manslaughter))

# 2014 crime variables
AL2014 <- c(pop[1] / pop[10], pop[4] / pop[10], pop[7] / pop[10], kill[10] / pop[10], kill[10])
AK2014 <- c(pop[12] / pop[19], pop[14] / pop[19], pop[17] / pop[19], kill[19] / pop[19], kill[19])
AZ2014 <- c(pop[21] / pop[29], pop[24] / pop[29], pop[27] / pop[29], kill[29] / pop[29], kill[29])
AR2014 <- c(pop[31] / pop[40], pop[34] / pop[40], pop[37] / pop[40], kill[40] / pop[40], kill[40])
CA2014 <- c(pop[42] / pop[49], pop[45] / pop[49], pop[47] / pop[49], kill[49] / pop[49], kill[49])
CO2014 <- c(pop[51] / pop[60], pop[54] / pop[60], pop[57] / pop[60], kill[60] / pop[60], kill[60])
CT2014 <- c(pop[62] / pop[68], pop[64] / pop[68], pop[66] / pop[68], kill[68] / pop[68], kill[68])
DE2014 <- c(pop[70] / pop[75], pop[72] / pop[75], pop[73] / pop[75], kill[75] / pop[75], kill[75])
FL2014 <- c(pop[77] / pop[86], pop[80] / pop[86], pop[83] / pop[86], kill[86] / pop[86], kill[86])
GA2014 <- c(pop[88] / pop[97], pop[91] / pop[97], pop[94] / pop[97], kill[97] / pop[97], kill[97])
HI2014 <- c(pop[99] / pop[104], pop[101] / pop[104], pop[102] / pop[104], kill[104] / pop[104], kill[104])
ID2014 <- c(pop[106] / pop[113], pop[109] / pop[113], pop[111] / pop[113], kill[113] / pop[113], kill[113])
IL2014 <- c(pop[115] / pop[124], pop[118] / pop[124], pop[121] / pop[124], kill[124] / pop[124], kill[124])
IN2014 <- c(pop[126] / pop[135], pop[129] / pop[135], pop[132] / pop[135], kill[135] / pop[135], kill[135])
IA2014 <- c(pop[137] / pop[146], pop[140] / pop[146], pop[143] / pop[146], kill[146] / pop[146], kill[146])
KS2014 <- c(pop[148] / pop[157], pop[151] / pop[157], pop[154] / pop[157], kill[157] / pop[157], kill[157])
KY2014 <- c(pop[159] / pop[168], pop[162] / pop[168], pop[165] / pop[168], kill[168] / pop[168], kill[168])
LA2014 <- c(pop[170] / pop[178], pop[173] / pop[178], pop[176] / pop[178], kill[178] / pop[178], kill[178])
ME2014 <- c(pop[180] / pop[186], pop[182] / pop[186], pop[184] / pop[186], kill[186] / pop[186], kill[186])
MD2014 <- c(pop[188] / pop[194], pop[190] / pop[194], pop[192] / pop[194], kill[194] / pop[194], kill[194])
MA2014 <- c(pop[196] / pop[204], pop[199] / pop[204], pop[202] / pop[204], kill[204] / pop[204], kill[204])
MI2014 <- c(pop[206] / pop[215], pop[209] / pop[215], pop[212] / pop[215], kill[215] / pop[215], kill[215])
MN2014 <- c(pop[217] / pop[224], pop[220] / pop[224], pop[222] / pop[224], kill[224] / pop[224], kill[224])
MS2014 <- c(pop[226] / pop[235], pop[229] / pop[235], pop[232] / pop[235], kill[235] / pop[235], kill[235])
MO2014 <- c(pop[237] / pop[245], pop[240] / pop[245], pop[243] / pop[245], kill[245] / pop[245], kill[245])
MT2014 <- c(pop[247] / pop[255], pop[249] / pop[255], pop[252] / pop[255], kill[255] / pop[255], kill[255])
NE2014 <- c(pop[257] / pop[266], pop[260] / pop[266], pop[263] / pop[266], kill[266] / pop[266], kill[266])
NV2014 <- c(pop[268] / pop[275], pop[270] / pop[275], pop[272] / pop[275], kill[275] / pop[275], kill[275])
NH2014 <- c(pop[277] / pop[285], pop[280] / pop[285], pop[283] / pop[285], kill[285] / pop[285], kill[285])
NJ2014 <- c(pop[287] / pop[291], pop[289] / pop[291], pop[290] / pop[291], kill[291] / pop[291], kill[291])
NM2014 <- c(pop[293] / pop[302], pop[296] / pop[302], pop[299] / pop[302], kill[302] / pop[302], kill[302])
NY2014 <- c(pop[304] / pop[313], pop[307] / pop[313], pop[310] / pop[313], kill[313] / pop[313], kill[313])
NC2014 <- c(pop[315] / pop[324], pop[318] / pop[324], pop[321] / pop[324], kill[324] / pop[324], kill[324])
ND2014 <- c(pop[326] / pop[333], pop[328] / pop[333], pop[330] / pop[333], kill[333] / pop[333], kill[333])
OH2014 <- c(pop[335] / pop[344], pop[338] / pop[344], pop[341] / pop[344], kill[344] / pop[344], kill[344])
OK2014 <- c(pop[346] / pop[352], pop[348] / pop[352], pop[350] / pop[352], kill[352] / pop[352], kill[352])
OR2014 <- c(pop[354] / pop[363], pop[357] / pop[363], pop[360] / pop[363], kill[363] / pop[363], kill[363])
PA2014 <- c(pop[365] / pop[373], pop[368] / pop[373], pop[371] / pop[373], kill[373] / pop[373], kill[373])
RI2014 <- c(pop[375] / pop[380], pop[377] / pop[380], pop[378] / pop[380], kill[380] / pop[380], kill[380])
SC2014 <- c(pop[382] / pop[390], pop[385] / pop[390], pop[388] / pop[390], kill[390] / pop[390], kill[390])
SD2014 <- c(pop[392] / pop[401], pop[395] / pop[401], pop[398] / pop[401], kill[401] / pop[401], kill[401])
TN2014 <- c(pop[403] / pop[410], pop[406] / pop[410], pop[408] / pop[410], kill[410] / pop[410], kill[410])
TX2014 <- c(pop[412] / pop[421], pop[415] / pop[421], pop[418] / pop[421], kill[421] / pop[421], kill[421])
UT2014 <- c(pop[423] / pop[432], pop[426] / pop[432], pop[429] / pop[432], kill[432] / pop[432], kill[432])
VT2014 <- c(pop[434] / pop[441], pop[436] / pop[441], pop[439] / pop[441], kill[441] / pop[441], kill[441])
VA2014 <- c(pop[443] / pop[451], pop[446] / pop[451], pop[449] / pop[451], kill[451] / pop[451], kill[451])
WA2014 <- c(pop[453] / pop[461], pop[456] / pop[461], pop[459] / pop[461], kill[461] / pop[461], kill[461])
WV2014 <- c(pop[463] / pop[472], pop[466] / pop[472], pop[469] / pop[472], kill[472] / pop[472], kill[472])
WI2014 <- c(pop[474] / pop[482], pop[477] / pop[482], pop[480] / pop[482], kill[482] / pop[482], kill[482])
WY2014 <- c(pop[484] / pop[492], pop[486] / pop[492], pop[489] / pop[492], kill[492] / pop[492], kill[492])

# creating dataset
clean2014 <- data.frame(rbind(AL2014, AK2014, AZ2014, AR2014, CA2014, CO2014, CT2014, DE2014, FL2014, GA2014,
                              HI2014, ID2014, IL2014, IN2014, IA2014, KS2014, KY2014, LA2014, ME2014, MD2014,
                              MA2014, MI2014, MN2014, MS2014, MO2014, MT2014, NE2014, NV2014, NH2014, NJ2014,
                              NM2014, NY2014, NC2014, ND2014, OH2014, OK2014, OR2014, PA2014, RI2014, SC2014,
                              SD2014, TN2014, TX2014, UT2014, VT2014, VA2014, WA2014, WV2014, WI2014, WY2014))

clean2014[is.na(clean2014)] <- 0

names(clean2014) <- c("MSA.r", "Cities.r", "NonMSA.r", "Murders.r", "Murders")

summary(lm(formula = Murders.r ~ MSA.r + Cities.r + NonMSA.r,
           data = clean2014))

#### Crime 2015 ####
origin <- read.csv(file = "crime2015.csv",
                   skip = 3,
                   nrows = 502,
                   stringsAsFactors = FALSE)

crime2015 <- origin[-c(77:82, 379:384),]

attach(crime2015)

pop <- suppressWarnings(as.numeric(Population))
kill <- suppressWarnings(as.numeric(Murder.and.nonnegligent.manslaughter))

# 2015 crime variables
AL2015 <- c(pop[1] / pop[10], pop[4] / pop[10], pop[7] / pop[10], kill[10] / pop[10], kill[10])
AK2015 <- c(pop[12] / pop[19], pop[14] / pop[19], pop[17] / pop[19], kill[19] / pop[19], kill[19])
AZ2015 <- c(pop[21] / pop[29], pop[24] / pop[29], pop[27] / pop[29], kill[29] / pop[29], kill[29])
AR2015 <- c(pop[31] / pop[40], pop[34] / pop[40], pop[37] / pop[40], kill[40] / pop[40], kill[40])
CA2015 <- c(pop[42] / pop[49], pop[45] / pop[49], pop[47] / pop[49], kill[49] / pop[49], kill[49])
CO2015 <- c(pop[51] / pop[60], pop[54] / pop[60], pop[57] / pop[60], kill[60] / pop[60], kill[60])
CT2015 <- c(pop[62] / pop[68], pop[64] / pop[68], pop[66] / pop[68], kill[68] / pop[68], kill[68])
DE2015 <- c(pop[70] / pop[75], pop[72] / pop[75], pop[73] / pop[75], kill[75] / pop[75], kill[75])
FL2015 <- c(pop[77] / pop[86], pop[80] / pop[86], pop[83] / pop[86], kill[86] / pop[86], kill[86])
GA2015 <- c(pop[88] / pop[97], pop[91] / pop[97], pop[94] / pop[97], kill[97] / pop[97], kill[97])
HI2015 <- c(pop[99] / pop[104], pop[101] / pop[104], pop[102] / pop[104], kill[104] / pop[104], kill[104])
ID2015 <- c(pop[106] / pop[113], pop[109] / pop[113], pop[111] / pop[113], kill[113] / pop[113], kill[113])
IL2015 <- c(pop[115] / pop[124], pop[118] / pop[124], pop[121] / pop[124], kill[124] / pop[124], kill[124])
IN2015 <- c(pop[126] / pop[135], pop[129] / pop[135], pop[132] / pop[135], kill[135] / pop[135], kill[135])
IA2015 <- c(pop[137] / pop[145], pop[140] / pop[145], pop[143] / pop[145], kill[145] / pop[145], kill[145])
KS2015 <- c(pop[147] / pop[156], pop[150] / pop[156], pop[153] / pop[156], kill[156] / pop[156], kill[156])
KY2015 <- c(pop[158] / pop[165], pop[160] / pop[165], pop[163] / pop[165], kill[165] / pop[165], kill[165])
LA2015 <- c(pop[167] / pop[176], pop[170] / pop[176], pop[173] / pop[176], kill[176] / pop[176], kill[176])
ME2015 <- c(pop[178] / pop[184], pop[180] / pop[184], pop[182] / pop[184], kill[184] / pop[184], kill[184])
MD2015 <- c(pop[186] / pop[192], pop[188] / pop[192], pop[190] / pop[192], kill[192] / pop[192], kill[192])
MA2015 <- c(pop[194] / pop[202], pop[197] / pop[202], pop[200] / pop[202], kill[202] / pop[202], kill[202])
MI2015 <- c(pop[204] / pop[213], pop[207] / pop[213], pop[210] / pop[213], kill[213] / pop[213], kill[213])
MN2015 <- c(pop[215] / pop[221], pop[217] / pop[221], pop[219] / pop[221], kill[221] / pop[221], kill[221])
MS2015 <- c(pop[223] / pop[232], pop[226] / pop[232], pop[229] / pop[232], kill[232] / pop[232], kill[232])
MO2015 <- c(pop[234] / pop[242], pop[237] / pop[242], pop[240] / pop[242], kill[242] / pop[242], kill[242])
MT2015 <- c(pop[244] / pop[253], pop[247] / pop[253], pop[250] / pop[253], kill[253] / pop[253], kill[253])
NE2015 <- c(pop[255] / pop[264], pop[258] / pop[264], pop[261] / pop[264], kill[264] / pop[264], kill[264])
NV2015 <- c(pop[266] / pop[272], pop[268] / pop[272], pop[270] / pop[272], kill[272] / pop[272], kill[272])
NH2015 <- c(pop[274] / pop[282], pop[277] / pop[282], pop[280] / pop[282], kill[282] / pop[282], kill[282])
NJ2015 <- c(pop[284] / pop[288], pop[286] / pop[288], pop[287] / pop[288], kill[288] / pop[288], kill[288])
NM2015 <- c(pop[290] / pop[299], pop[293] / pop[299], pop[296] / pop[299], kill[299] / pop[299], kill[299])
NY2015 <- c(pop[301] / pop[309], pop[304] / pop[309], pop[307] / pop[309], kill[309] / pop[309], kill[309])
NC2015 <- c(pop[311] / pop[320], pop[314] / pop[320], pop[317] / pop[320], kill[317] / pop[320], kill[320])
ND2015 <- c(pop[322] / pop[328], pop[324] / pop[328], pop[326] / pop[328], kill[328] / pop[328], kill[328])
OH2015 <- c(pop[330] / pop[339], pop[333] / pop[339], pop[336] / pop[339], kill[339] / pop[339], kill[339])
OK2015 <- c(pop[341] / pop[350], pop[344] / pop[350], pop[347] / pop[350], kill[350] / pop[350], kill[350])
OR2015 <- c(pop[352] / pop[361], pop[355] / pop[361], pop[358] / pop[361], kill[361] / pop[361], kill[361])
PA2015 <- c(pop[363] / pop[371], pop[366] / pop[371], pop[369] / pop[371], kill[371] / pop[371], kill[371])
RI2015 <- c(pop[373] / pop[378], pop[375] / pop[378], pop[376] / pop[378], kill[378] / pop[378], kill[378])
SC2015 <- c(pop[380] / pop[389], pop[383] / pop[389], pop[386] / pop[389], kill[389] / pop[389], kill[389])
SD2015 <- c(pop[391] / pop[400], pop[394] / pop[400], pop[397] / pop[400], kill[400] / pop[400], kill[400])
TN2015 <- c(pop[402] / pop[408], pop[404] / pop[408], pop[406] / pop[408], kill[408] / pop[408], kill[408])
TX2015 <- c(pop[410] / pop[419], pop[413] / pop[419], pop[416] / pop[419], kill[419] / pop[419], kill[419])
UT2015 <- c(pop[421] / pop[430], pop[424] / pop[430], pop[427] / pop[430], kill[430] / pop[430], kill[430])
VT2015 <- c(pop[432] / pop[438], pop[434] / pop[438], pop[436] / pop[438], kill[438] / pop[438], kill[438])
VA2015 <- c(pop[440] / pop[448], pop[443] / pop[448], pop[446] / pop[448], kill[448] / pop[448], kill[448])
WA2015 <- c(pop[450] / pop[458], pop[453] / pop[458], pop[456] / pop[458], kill[458] / pop[458], kill[458])
WV2015 <- c(pop[460] / pop[469], pop[463] / pop[469], pop[466] / pop[469], kill[469] / pop[469], kill[469])
WI2015 <- c(pop[471] / pop[479], pop[474] / pop[479], pop[477] / pop[479], kill[479] / pop[479], kill[479])
WY2015 <- c(pop[481] / pop[489], pop[483] / pop[489], pop[486] / pop[489], kill[489] / pop[489], kill[489])

# creating dataset
clean2015 <- data.frame(rbind(AL2015, AK2015, AZ2015, AR2015, CA2015, CO2015, CT2015, DE2015, FL2015, GA2015,
                              HI2015, ID2015, IL2015, IN2015, IA2015, KS2015, KY2015, LA2015, ME2015, MD2015,
                              MA2015, MI2015, MN2015, MS2015, MO2015, MT2015, NE2015, NV2015, NH2015, NJ2015,
                              NM2015, NY2015, NC2015, ND2015, OH2015, OK2015, OR2015, PA2015, RI2015, SC2015,
                              SD2015, TN2015, TX2015, UT2015, VT2015, VA2015, WA2015, WV2015, WI2015, WY2015))

clean2015[is.na(clean2015)] <- 0

names(clean2015) <- c("MSA.r", "Cities.r", "NonMSA.r", "Murders.r", "Murders")

summary(lm(formula = Murders.r ~ MSA.r + Cities.r + NonMSA.r,
           data = clean2015))

#### Crime 2016 ####
origin <- read.csv(file = "crime2016.csv",
                   skip = 3,
                   nrows = 501,
                   stringsAsFactors = FALSE)

crime2016 <- origin[-c(76:81, 379:384),]

attach(crime2016)

pop <- suppressWarnings(as.numeric(Population))
kill <- suppressWarnings(as.numeric(Murder.and.nonnegligent.manslaughter))

# 2016 crime variables
AL2016 <- c(pop[1] / pop[10], pop[4] / pop[10], pop[7] / pop[10], kill[10] / pop[10], kill[10])
AK2016 <- c(pop[12] / pop[19], pop[14] / pop[19], pop[17] / pop[19], kill[19] / pop[19], kill[19])
AZ2016 <- c(pop[21] / pop[28], pop[24] / pop[28], pop[26] / pop[28], kill[28] / pop[28], kill[28])
AR2016 <- c(pop[29] / pop[39], pop[33] / pop[39], pop[36] / pop[39], kill[39] / pop[39], kill[39])
CA2016 <- c(pop[41] / pop[48], pop[44] / pop[48], pop[46] / pop[48], kill[48] / pop[48], kill[48])
CO2016 <- c(pop[50] / pop[59], pop[53] / pop[59], pop[56] / pop[59], kill[59] / pop[59], kill[59])
CT2016 <- c(pop[61] / pop[67], pop[63] / pop[67], pop[65] / pop[67], kill[67] / pop[67], kill[67])
DE2016 <- c(pop[69] / pop[74], pop[71] / pop[74], pop[72] / pop[74], kill[74] / pop[74], kill[74])
FL2016 <- c(pop[76] / pop[84], pop[79] / pop[84], pop[82] / pop[84], kill[84] / pop[84], kill[84])
GA2016 <- c(pop[86] / pop[95], pop[89] / pop[95], pop[92] / pop[95], kill[95] / pop[95], kill[95])
HI2016 <- c(pop[97] / pop[102], pop[99] / pop[102], pop[100] / pop[102], kill[102] / pop[102], kill[102])
ID2016 <- c(pop[104] / pop[111], pop[106] / pop[111], pop[109] / pop[111], kill[111] / pop[111], kill[111])
IL2016 <- c(pop[113] / pop[122], pop[116] / pop[122], pop[119] / pop[122], kill[122] / pop[122], kill[122])
IN2016 <- c(pop[124] / pop[133], pop[127] / pop[133], pop[130] / pop[133], kill[133] / pop[133], kill[133])
IA2016 <- c(pop[135] / pop[144], pop[138] / pop[144], pop[141] / pop[144], kill[144] / pop[144], kill[144])
KS2016 <- c(pop[146] / pop[155], pop[149] / pop[155], pop[152] / pop[155], kill[155] / pop[155], kill[155])
KY2016 <- c(pop[157] / pop[163], pop[159] / pop[163], pop[161] / pop[163], kill[163] / pop[163], kill[163])
LA2016 <- c(pop[165] / pop[174], pop[168] / pop[174], pop[171] / pop[174], kill[174] / pop[174], kill[174])
ME2016 <- c(pop[176] / pop[182], pop[178] / pop[182], pop[180] / pop[182], kill[182] / pop[182], kill[182])
MD2016 <- c(pop[184] / pop[191], pop[187] / pop[191], pop[189] / pop[191], kill[191] / pop[191], kill[191])
MA2016 <- c(pop[193] / pop[201], pop[196] / pop[201], pop[199] / pop[201], kill[201] / pop[201], kill[201])
MI2016 <- c(pop[203] / pop[212], pop[206] / pop[212], pop[209] / pop[212], kill[212] / pop[212], kill[212])
MN2016 <- c(pop[214] / pop[220], pop[216] / pop[220], pop[218] / pop[220], kill[220] / pop[220], kill[220])
MS2016 <- c(pop[222] / pop[231], pop[225] / pop[231], pop[228] / pop[231], kill[231] / pop[231], kill[231])
MO2016 <- c(pop[233] / pop[241], pop[236] / pop[241], pop[239] / pop[241], kill[241] / pop[241], kill[241])
MT2016 <- c(pop[243] / pop[251], pop[246] / pop[251], pop[248] / pop[251], kill[251] / pop[251], kill[251])
NE2016 <- c(pop[253] / pop[262], pop[256] / pop[262], pop[259] / pop[262], kill[262] / pop[262], kill[262])
NV2016 <- c(pop[264] / pop[270], pop[266] / pop[270], pop[268] / pop[270], kill[270] / pop[270], kill[270])
NH2016 <- c(pop[272] / pop[281], pop[275] / pop[281], pop[278] / pop[281], kill[281] / pop[281], kill[281])
NJ2016 <- c(pop[283] / pop[287], pop[285] / pop[287], pop[286] / pop[287], kill[287] / pop[287], kill[287])
NM2016 <- c(pop[289] / pop[298], pop[292] / pop[298], pop[295] / pop[298], kill[298] / pop[298], kill[298])
NY2016 <- c(pop[300] / pop[308], pop[303] / pop[308], pop[306] / pop[308], kill[308] / pop[308], kill[308])
NC2016 <- c(pop[310] / pop[319], pop[313] / pop[319], pop[316] / pop[319], kill[319] / pop[319], kill[319])
ND2016 <- c(pop[321] / pop[328], pop[323] / pop[328], pop[326] / pop[328], kill[328] / pop[328], kill[328])
OH2016 <- c(pop[330] / pop[339], pop[333] / pop[339], pop[336] / pop[339], kill[339] / pop[339], kill[339])
OK2016 <- c(pop[341] / pop[350], pop[344] / pop[350], pop[347] / pop[350], kill[350] / pop[350], kill[350])
OR2016 <- c(pop[352] / pop[361], pop[355] / pop[361], pop[358] / pop[361], kill[361] / pop[361], kill[361])
PA2016 <- c(pop[363] / pop[371], pop[366] / pop[371], pop[369] / pop[371], kill[371] / pop[371], kill[371])
RI2016 <- c(pop[373] / pop[378], pop[375] / pop[378], pop[376] / pop[378], kill[378] / pop[378], kill[378])
SC2016 <- c(pop[380] / pop[389], pop[383] / pop[389], pop[386] / pop[389], kill[389] / pop[389], kill[389])
SD2016 <- c(pop[391] / pop[400], pop[394] / pop[400], pop[397] / pop[400], kill[400] / pop[400], kill[400])
TN2016 <- c(pop[402] / pop[408], pop[404] / pop[408], pop[406] / pop[408], kill[408] / pop[408], kill[408])
TX2016 <- c(pop[410] / pop[419], pop[413] / pop[419], pop[416] / pop[419], kill[419] / pop[419], kill[419])
UT2016 <- c(pop[421] / pop[430], pop[424] / pop[430], pop[427] / pop[430], kill[430] / pop[430], kill[430])
VT2016 <- c(pop[432] / pop[438], pop[434] / pop[438], pop[436] / pop[438], kill[438] / pop[438], kill[438])
VA2016 <- c(pop[440] / pop[447], pop[442] / pop[447], pop[445] / pop[447], kill[447] / pop[447], kill[447])
WA2016 <- c(pop[449] / pop[457], pop[452] / pop[457], pop[455] / pop[457], kill[457] / pop[457], kill[457])
WV2016 <- c(pop[459] / pop[468], pop[462] / pop[468], pop[465] / pop[468], kill[468] / pop[468], kill[468])
WI2016 <- c(pop[470] / pop[478], pop[473] / pop[478], pop[476] / pop[478], kill[478] / pop[478], kill[478])
WY2016 <- c(pop[480] / pop[488], pop[482] / pop[488], pop[485] / pop[488], kill[488] / pop[488], kill[488])

# creating dataset
clean2016 <- data.frame(rbind(AL2016, AK2016, AZ2016, AR2016, CA2016, CO2016, CT2016, DE2016, FL2016, GA2016,
                              HI2016, ID2016, IL2016, IN2016, IA2016, KS2016, KY2016, LA2016, ME2016, MD2016,
                              MA2016, MI2016, MN2016, MS2016, MO2016, MT2016, NE2016, NV2016, NH2016, NJ2016,
                              NM2016, NY2016, NC2016, ND2016, OH2016, OK2016, OR2016, PA2016, RI2016, SC2016,
                              SD2016, TN2016, TX2016, UT2016, VT2016, VA2016, WA2016, WV2016, WI2016, WY2016))

clean2016[is.na(clean2016)] <- 0

names(clean2016) <- c("MSA.r", "Cities.r", "NonMSA.r", "Murders.r", "Murders")

summary(lm(formula = Murders.r ~ MSA.r + Cities.r + NonMSA.r,
           data = clean2016)) #double-check!

#### All Crime ####
ALfull <- rbind(AL2010, AL2011, AL2012, AL2013, AL2014, AL2015, AL2016)
AKfull <- rbind(AK2010, AK2011, AK2012, AK2013, AK2014, AK2015, AK2016)
AZfull <- rbind(AZ2010, AZ2011, AZ2012, AZ2013, AZ2014, AZ2015, AZ2016)
ARfull <- rbind(AR2010, AR2011, AR2012, AR2013, AR2014, AR2015, AR2016)
CAfull <- rbind(CA2010, CA2011, CA2012, CA2013, CA2014, CA2015, CA2016)
COfull <- rbind(CO2010, CO2011, CO2012, CO2013, CO2014, CO2015, CO2016)
CTfull <- rbind(CT2010, CT2011, CT2012, CT2013, CT2014, CT2015, CT2016)
DEfull <- rbind(DE2010, DE2011, DE2012, DE2013, DE2014, DE2015, DE2016)
FLfull <- rbind(FL2010, FL2011, FL2012, FL2013, FL2014, FL2015, FL2016)
GAfull <- rbind(GA2010, GA2011, GA2012, GA2013, GA2014, GA2015, GA2016)
HIfull <- rbind(HI2010, HI2011, HI2012, HI2013, HI2014, HI2015, HI2016)
IDfull <- rbind(ID2010, ID2011, ID2012, ID2013, ID2014, ID2015, ID2016)
ILfull <- rbind(IL2010, IL2011, IL2012, IL2013, IL2014, IL2015, IL2016)
INfull <- rbind(IN2010, IN2011, IN2012, IN2013, IN2014, IN2015, IN2016)
IAfull <- rbind(IA2010, IA2011, IA2012, IA2013, IA2014, IA2015, IA2016)
KSfull <- rbind(KS2010, KS2011, KS2012, KS2013, KS2014, KS2015, KS2016)
KYfull <- rbind(KY2010, KY2011, KY2012, KY2013, KY2014, KY2015, KY2016)
LAfull <- rbind(LA2010, LA2011, LA2012, LA2013, LA2014, LA2015, LA2016)
MEfull <- rbind(ME2010, ME2011, ME2012, ME2013, ME2014, ME2015, ME2016)
MDfull <- rbind(MD2010, MD2011, MD2012, MD2013, MD2014, MD2015, MD2016)
MAfull <- rbind(MA2010, MA2011, MA2012, MA2013, MA2014, MA2015, MA2016)
MIfull <- rbind(MI2010, MI2011, MI2012, MI2013, MI2014, MI2015, MI2016)
MNfull <- rbind(MN2010, MN2011, MN2012, MN2013, MN2014, MN2015, MN2016)
MSfull <- rbind(MS2010, MS2011, MS2012, MS2013, MS2014, MS2015, MS2016)
MOfull <- rbind(MO2010, MO2011, MO2012, MO2013, MO2014, MO2015, MO2016)
MTfull <- rbind(MT2010, MT2011, MT2012, MT2013, MT2014, MT2015, MT2016)
NEfull <- rbind(NE2010, NE2011, NE2012, NE2013, NE2014, NE2015, NE2016)
NVfull <- rbind(NV2010, NV2011, NV2012, NV2013, NV2014, NV2015, NV2016)
NHfull <- rbind(NH2010, NH2011, NH2012, NH2013, NH2014, NH2015, NH2016)
NJfull <- rbind(NJ2010, NJ2011, NJ2012, NJ2013, NJ2014, NJ2015, NJ2016)
NMfull <- rbind(NM2010, NM2011, NM2012, NM2013, NM2014, NM2015, NM2016)
NYfull <- rbind(NY2010, NY2011, NY2012, NY2013, NY2014, NY2015, NY2016)
NCfull <- rbind(NC2010, NC2011, NC2012, NC2013, NC2014, NC2015, NC2016)
NDfull <- rbind(ND2010, ND2011, ND2012, ND2013, ND2014, ND2015, ND2016)
OHfull <- rbind(OH2010, OH2011, OH2012, OH2013, OH2014, OH2015, OH2016)
OKfull <- rbind(OK2010, OK2011, OK2012, OK2013, OK2014, OK2015, OK2016)
ORfull <- rbind(OR2010, OR2011, OR2012, OR2013, OR2014, OR2015, OR2016)
PAfull <- rbind(PA2010, PA2011, PA2012, PA2013, PA2014, PA2015, PA2016)
RIfull <- rbind(RI2010, RI2011, RI2012, RI2013, RI2014, RI2015, RI2016)
SCfull <- rbind(SC2010, SC2011, SC2012, SC2013, SC2014, SC2015, SC2016)
SDfull <- rbind(SD2010, SD2011, SD2012, SD2013, SD2014, SD2015, SD2016)
TNfull <- rbind(TN2010, TN2011, TN2012, TN2013, TN2014, TN2015, TN2016)
TXfull <- rbind(TX2010, TX2011, TX2012, TX2013, TX2014, TX2015, TX2016)
UTfull <- rbind(UT2010, UT2011, UT2012, UT2013, UT2014, UT2015, UT2016)
VTfull <- rbind(VT2010, VT2011, VT2012, VT2013, VT2014, VT2015, VT2016)
VAfull <- rbind(VA2010, VA2011, VA2012, VA2013, VA2014, VA2015, VA2016)
WAfull <- rbind(WA2010, WA2011, WA2012, WA2013, WA2014, WA2015, WA2016)
WVfull <- rbind(WV2010, WV2011, WV2012, WV2013, WV2014, WV2015, WV2016)
WIfull <- rbind(WI2010, WI2011, WI2012, WI2013, WI2014, WI2015, WI2016)
WYfull <- rbind(WY2010, WY2011, WY2012, WY2013, WY2014, WY2015, WY2016)

crimefull <- data.frame(rbind(ALfull, AKfull, AZfull, ARfull, CAfull,
                              COfull, CTfull, DEfull, FLfull, GAfull,
                              HIfull, IDfull, ILfull, INfull, IAfull,
                              KSfull, KYfull, LAfull, MEfull, MDfull,
                              MAfull, MIfull, MNfull, MSfull, MOfull,
                              MTfull, NEfull, NVfull, NHfull, NJfull,
                              NMfull, NYfull, NCfull, NDfull, OHfull,
                              OKfull, ORfull, PAfull, RIfull, SCfull,
                              SDfull, TNfull, TXfull, UTfull, VTfull,
                              VAfull, WAfull, WVfull, WIfull, WYfull))

crimefull[is.na(crimefull)] <- 0

names(crimefull) <- c("MSA.r", "Cities.r", "NonMSA.r", "Murders.r", "Murders")

summary(lm(formula = Murders.r ~ MSA.r + Cities.r + NonMSA.r,
           data = crimefull))

#### FSS ####
# read Total Suicides
origin <- read.csv(file = "total_suicides.csv",
                   stringsAsFactors = FALSE,
                   nrow = 408)

t_suicide <- origin[-(65:72),]
r <- 1:nrow(t_suicide)
t_suicide <- t_suicide[!(r%%8 == 0),c("Deaths", "Crude.Rate")]

# read Firearm Suicides
origin <- read.csv(file = "firearm_suicides.csv",
                   stringsAsFactors = FALSE,
                   nrow = 408)
f_suicide <- origin[-(65:72),]
r <- 1:nrow(f_suicide)
f_suicide <- f_suicide[!(r%%8 == 0), c("Deaths", "Crude.Rate")]

# All Suicides
suicide <- data.frame(cbind(f_suicide, t_suicide))
names(suicide) <- c("F_Deaths", "F_Death.Rate", "T_Deaths", "T_Death.Rate")
suicide$FSS <- as.numeric(suicide$F_Death.Rate) / as.numeric(suicide$T_Death.Rate)

#### Income ####
# read income
origin <- read.csv(file = "income.csv",
                   stringsAsFactors = FALSE,
                   skip = 5,
                   nrow = 52)

income <- origin[-c(1,10),c(1, seq(2,16,2))]
names(income) <- c("States", 2016, 2015, 2014, "new_2013", "old_2013", 2012, 2011, 2010)
attach(income)

# 2013.1 vs. 2013.2 t-test
t.test(new_2013, old_2013, data = income) # both 2013 methods are equal

# transposing data
income <- as.data.frame(t(income))
colnames(income) <- as.character(States)
income <- income[-c(1,6),]
income$Year <- c(2016, 2015, 2014, 2013, 2012, 2011, 2010)
income <- income %>% arrange(-row_number())

# melting data
income <- melt(data = income,
               id.vars = "Year",
               variable.name = "State")
income <- income[3]
colnames(income) <- "MedInc"
income$MedInc <- as.numeric(income$MedInc)

#### Unemployment ####
# AL to ID
origin <- read.csv(file = "ALUR_IDUR.csv")
AL_ID <- melt(data = origin,
              id.vars = "DATE",
              variable.name = "State_UR")

# IL to MS
origin <- read.csv(file = "ILUR_MSUR.csv")
IL_MS <- melt(data = origin,
              id.vars = "DATE",
              variable.name = "State_UR")

# MO to OK
origin <- read.csv(file = "MOUR_OKUR.csv")
MO_OK <- melt(data = origin,
              id.vars = "DATE",
              variable.name = "State_UR")

# OR to WV
origin <- read.csv(file = "ORUR_WVUR.csv")
OR_WV <- melt(data = origin,
              id.vars = "DATE",
              variable.name = "State_UR")

# WI to WY
origin <- read.csv(file = "WIUR_WYUR.csv")
WI_WY <- melt(data = origin,
              id.vars = "DATE",
              variable.name = "State_UR")

# All Unemployment
u.rate <- rbind(AL_ID, IL_MS, MO_OK, OR_WV, WI_WY)
u.rate <- u.rate[3]
colnames(u.rate) <- "UR"
u.rate$UR <- as.numeric(u.rate$UR)
u.rate$UR <- u.rate$UR * .01

#### Full Table ####
master <- cbind(State, Year, Lags, suicide, crimefull, income, u.rate)
attach(master)

#### Generating Variables ####

# time dummies
master$t1 <- ifelse(master$Lags == 1, 1, 0)
master$t2 <- ifelse(master$Lags == 2, 1, 0)
master$t3 <- ifelse(master$Lags == 3, 1, 0)
master$t4 <- ifelse(master$Lags == 4, 1, 0)
master$t5 <- ifelse(master$Lags == 5, 1, 0)
master$t6 <- ifelse(master$Lags == 6, 1, 0)

# Lag * FSS
master$FSS.t <- master$Lags * master$FSS

# Lag * Murders.r (not included)
#master$Murders.r.t <- master$Lags * master$Murders.r

# Laging Murders.r
master <- slide(data = master, Var = "Murders.r", slideBy = -1)
master$`Murders.r-1` <- ifelse(master$Lags == 0, 0 , master$`Murders.r-1`)

# log of MedInc
master$lMedInc <- log(master$MedInc)

#### Outputting File ####
write.dta(master, "master.dta")

#### Test Linear Regression ####
master.lm1 <- lm(formula = Murders.r ~ FSS + MSA.r + log(MedInc) + UR,
                 data = master)

master.lm2 <- lm(formula = Murders.r ~ Murders.r.t + MSA.r + log(MedInc) + UR + t1 + t2 + t3 + t4 + t5 + t6,
                 data = master)

master.lm3 <- lm(formula = Murders.r ~ FSS + FSS.t + MSA.r + log(MedInc) + UR + t1 + t2 + t3 + t4 + t5 + t6,
                 data = master)

master.lm4 <- lm(formula = Murders.r ~ Murders.r.t + FSS + FSS.t + MSA.r + log(MedInc) + UR + t1 + t2 + t3 + t4 + t5 + t6,
                 data = master)

summary(master.lm1)
summary(master.lm2)
summary(master.lm3)
summary(master.lm4)

#### Checking Multicollinearity ####
vif(master.lm1)
vif(master.lm2)
vif(master.lm3)
vif(master.lm4)