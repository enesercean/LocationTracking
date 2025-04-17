; ModuleID = 'marshal_methods.x86.ll'
source_filename = "marshal_methods.x86.ll"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [321 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [636 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 67
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 66
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 107
	i32 32687329, ; 3: Xamarin.AndroidX.Lifecycle.Runtime => 0x1f2c4e1 => 241
	i32 34715100, ; 4: Xamarin.Google.Guava.ListenableFuture.dll => 0x211b5dc => 275
	i32 34839235, ; 5: System.IO.FileSystem.DriveInfo => 0x2139ac3 => 47
	i32 39485524, ; 6: System.Net.WebSockets.dll => 0x25a8054 => 79
	i32 42639949, ; 7: System.Threading.Thread => 0x28aa24d => 141
	i32 66541672, ; 8: System.Diagnostics.StackTrace => 0x3f75868 => 29
	i32 67008169, ; 9: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 316
	i32 68219467, ; 10: System.Security.Cryptography.Primitives => 0x410f24b => 123
	i32 72070932, ; 11: Microsoft.Maui.Graphics.dll => 0x44bb714 => 194
	i32 82292897, ; 12: System.Runtime.CompilerServices.VisualC.dll => 0x4e7b0a1 => 101
	i32 101534019, ; 13: Xamarin.AndroidX.SlidingPaneLayout => 0x60d4943 => 259
	i32 117431740, ; 14: System.Runtime.InteropServices => 0x6ffddbc => 106
	i32 120558881, ; 15: Xamarin.AndroidX.SlidingPaneLayout.dll => 0x72f9521 => 259
	i32 122350210, ; 16: System.Threading.Channels.dll => 0x74aea82 => 199
	i32 134690465, ; 17: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x80736a1 => 279
	i32 142721839, ; 18: System.Net.WebHeaderCollection => 0x881c32f => 76
	i32 149972175, ; 19: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 123
	i32 159306688, ; 20: System.ComponentModel.Annotations => 0x97ed3c0 => 13
	i32 165246403, ; 21: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 215
	i32 176265551, ; 22: System.ServiceProcess => 0xa81994f => 131
	i32 182336117, ; 23: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 261
	i32 184328833, ; 24: System.ValueTuple.dll => 0xafca281 => 147
	i32 195452805, ; 25: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 313
	i32 199333315, ; 26: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 314
	i32 205061960, ; 27: System.ComponentModel => 0xc38ff48 => 18
	i32 209399409, ; 28: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 213
	i32 220171995, ; 29: System.Diagnostics.Debug => 0xd1f8edb => 26
	i32 221063263, ; 30: Microsoft.AspNetCore.Http.Connections.Client => 0xd2d285f => 171
	i32 230216969, ; 31: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0xdb8d509 => 235
	i32 230752869, ; 32: Microsoft.CSharp.dll => 0xdc10265 => 1
	i32 231409092, ; 33: System.Linq.Parallel => 0xdcb05c4 => 58
	i32 231814094, ; 34: System.Globalization => 0xdd133ce => 41
	i32 246610117, ; 35: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 90
	i32 261689757, ; 36: Xamarin.AndroidX.ConstraintLayout.dll => 0xf99119d => 218
	i32 276479776, ; 37: System.Threading.Timer.dll => 0x107abf20 => 143
	i32 278686392, ; 38: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x109c6ab8 => 237
	i32 280482487, ; 39: Xamarin.AndroidX.Interpolator => 0x10b7d2b7 => 234
	i32 280992041, ; 40: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 285
	i32 291076382, ; 41: System.IO.Pipes.AccessControl.dll => 0x1159791e => 53
	i32 298918909, ; 42: System.Net.Ping.dll => 0x11d123fd => 68
	i32 317674968, ; 43: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 313
	i32 318968648, ; 44: Xamarin.AndroidX.Activity.dll => 0x13031348 => 204
	i32 321597661, ; 45: System.Numerics => 0x132b30dd => 82
	i32 336156722, ; 46: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 298
	i32 342366114, ; 47: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 236
	i32 348048101, ; 48: Microsoft.AspNetCore.Http.Connections.Common.dll => 0x14becae5 => 172
	i32 356389973, ; 49: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 297
	i32 360082299, ; 50: System.ServiceModel.Web => 0x15766b7b => 130
	i32 367780167, ; 51: System.IO.Pipes => 0x15ebe147 => 54
	i32 374914964, ; 52: System.Transactions.Local => 0x1658bf94 => 145
	i32 375677976, ; 53: System.Net.ServicePoint.dll => 0x16646418 => 73
	i32 379916513, ; 54: System.Threading.Thread.dll => 0x16a510e1 => 141
	i32 385762202, ; 55: System.Memory.dll => 0x16fe439a => 61
	i32 392610295, ; 56: System.Threading.ThreadPool.dll => 0x1766c1f7 => 142
	i32 395744057, ; 57: _Microsoft.Android.Resource.Designer => 0x17969339 => 317
	i32 403441872, ; 58: WindowsBase => 0x180c08d0 => 161
	i32 423409703, ; 59: LocationTrackingMApp => 0x193cb827 => 0
	i32 435591531, ; 60: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 309
	i32 441335492, ; 61: Xamarin.AndroidX.ConstraintLayout.Core => 0x1a4e3ec4 => 219
	i32 442565967, ; 62: System.Collections => 0x1a61054f => 12
	i32 450948140, ; 63: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 232
	i32 451504562, ; 64: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 124
	i32 456227837, ; 65: System.Web.HttpUtility.dll => 0x1b317bfd => 148
	i32 458494020, ; 66: Microsoft.AspNetCore.SignalR.Common.dll => 0x1b541044 => 175
	i32 459347974, ; 67: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 112
	i32 465846621, ; 68: mscorlib => 0x1bc4415d => 162
	i32 469710990, ; 69: System.dll => 0x1bff388e => 160
	i32 476646585, ; 70: Xamarin.AndroidX.Interpolator.dll => 0x1c690cb9 => 234
	i32 486930444, ; 71: Xamarin.AndroidX.LocalBroadcastManager.dll => 0x1d05f80c => 247
	i32 498788369, ; 72: System.ObjectModel => 0x1dbae811 => 83
	i32 500358224, ; 73: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 296
	i32 503918385, ; 74: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 290
	i32 513247710, ; 75: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 188
	i32 526420162, ; 76: System.Transactions.dll => 0x1f6088c2 => 146
	i32 527452488, ; 77: Xamarin.Kotlin.StdLib.Jdk7 => 0x1f704948 => 279
	i32 530272170, ; 78: System.Linq.Queryable => 0x1f9b4faa => 59
	i32 539058512, ; 79: Microsoft.Extensions.Logging => 0x20216150 => 184
	i32 540030774, ; 80: System.IO.FileSystem.dll => 0x20303736 => 50
	i32 545304856, ; 81: System.Runtime.Extensions => 0x2080b118 => 102
	i32 546455878, ; 82: System.Runtime.Serialization.Xml => 0x20924146 => 113
	i32 548916678, ; 83: Microsoft.Bcl.AsyncInterfaces => 0x20b7cdc6 => 177
	i32 549171840, ; 84: System.Globalization.Calendars => 0x20bbb280 => 39
	i32 557405415, ; 85: Jsr305Binding => 0x213954e7 => 272
	i32 569601784, ; 86: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x21f36ef8 => 270
	i32 577335427, ; 87: System.Security.Cryptography.Cng => 0x22697083 => 119
	i32 592146354, ; 88: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 304
	i32 601371474, ; 89: System.IO.IsolatedStorage.dll => 0x23d83352 => 51
	i32 605376203, ; 90: System.IO.Compression.FileSystem => 0x24154ecb => 43
	i32 613668793, ; 91: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 118
	i32 627609679, ; 92: Xamarin.AndroidX.CustomView => 0x2568904f => 224
	i32 627931235, ; 93: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 302
	i32 639843206, ; 94: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x26233b86 => 230
	i32 643868501, ; 95: System.Net => 0x2660a755 => 80
	i32 662205335, ; 96: System.Text.Encodings.Web.dll => 0x27787397 => 197
	i32 663517072, ; 97: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 266
	i32 666292255, ; 98: Xamarin.AndroidX.Arch.Core.Common.dll => 0x27b6d01f => 211
	i32 672442732, ; 99: System.Collections.Concurrent => 0x2814a96c => 8
	i32 683518922, ; 100: System.Net.Security => 0x28bdabca => 72
	i32 688181140, ; 101: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 284
	i32 690569205, ; 102: System.Xml.Linq.dll => 0x29293ff5 => 151
	i32 691348768, ; 103: Xamarin.KotlinX.Coroutines.Android.dll => 0x29352520 => 281
	i32 693804605, ; 104: System.Windows => 0x295a9e3d => 150
	i32 699345723, ; 105: System.Reflection.Emit => 0x29af2b3b => 91
	i32 700284507, ; 106: Xamarin.Jetbrains.Annotations => 0x29bd7e5b => 276
	i32 700358131, ; 107: System.IO.Compression.ZipFile => 0x29be9df3 => 44
	i32 706645707, ; 108: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 299
	i32 709557578, ; 109: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 287
	i32 720511267, ; 110: Xamarin.Kotlin.StdLib.Jdk8 => 0x2af22123 => 280
	i32 722857257, ; 111: System.Runtime.Loader.dll => 0x2b15ed29 => 108
	i32 735137430, ; 112: System.Security.SecureString.dll => 0x2bd14e96 => 128
	i32 752232764, ; 113: System.Diagnostics.Contracts.dll => 0x2cd6293c => 25
	i32 755313932, ; 114: Xamarin.Android.Glide.Annotations.dll => 0x2d052d0c => 201
	i32 759454413, ; 115: System.Net.Requests => 0x2d445acd => 71
	i32 762598435, ; 116: System.IO.Pipes.dll => 0x2d745423 => 54
	i32 775507847, ; 117: System.IO.Compression => 0x2e394f87 => 45
	i32 777317022, ; 118: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 308
	i32 789151979, ; 119: Microsoft.Extensions.Options => 0x2f0980eb => 187
	i32 790371945, ; 120: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0x2f1c1e69 => 225
	i32 804715423, ; 121: System.Data.Common => 0x2ff6fb9f => 22
	i32 807930345, ; 122: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x302809e9 => 239
	i32 823281589, ; 123: System.Private.Uri.dll => 0x311247b5 => 85
	i32 830298997, ; 124: System.IO.Compression.Brotli => 0x317d5b75 => 42
	i32 832635846, ; 125: System.Xml.XPath.dll => 0x31a103c6 => 156
	i32 832711436, ; 126: Microsoft.AspNetCore.SignalR.Protocols.Json.dll => 0x31a22b0c => 176
	i32 834051424, ; 127: System.Net.Quic => 0x31b69d60 => 70
	i32 843511501, ; 128: Xamarin.AndroidX.Print => 0x3246f6cd => 252
	i32 873119928, ; 129: Microsoft.VisualBasic => 0x340ac0b8 => 3
	i32 877678880, ; 130: System.Globalization.dll => 0x34505120 => 41
	i32 878954865, ; 131: System.Net.Http.Json => 0x3463c971 => 62
	i32 904024072, ; 132: System.ComponentModel.Primitives.dll => 0x35e25008 => 16
	i32 911108515, ; 133: System.IO.MemoryMappedFiles.dll => 0x364e69a3 => 52
	i32 926902833, ; 134: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 311
	i32 928116545, ; 135: Xamarin.Google.Guava.ListenableFuture => 0x3751ef41 => 275
	i32 952186615, ; 136: System.Runtime.InteropServices.JavaScript.dll => 0x38c136f7 => 104
	i32 956575887, ; 137: Xamarin.Kotlin.StdLib.Jdk8.dll => 0x3904308f => 280
	i32 966729478, ; 138: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 273
	i32 967690846, ; 139: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 236
	i32 975236339, ; 140: System.Diagnostics.Tracing => 0x3a20ecf3 => 33
	i32 975874589, ; 141: System.Xml.XDocument => 0x3a2aaa1d => 154
	i32 986514023, ; 142: System.Private.DataContractSerialization.dll => 0x3acd0267 => 84
	i32 987214855, ; 143: System.Diagnostics.Tools => 0x3ad7b407 => 31
	i32 992768348, ; 144: System.Collections.dll => 0x3b2c715c => 12
	i32 994442037, ; 145: System.IO.FileSystem => 0x3b45fb35 => 50
	i32 1001831731, ; 146: System.IO.UnmanagedMemoryStream.dll => 0x3bb6bd33 => 55
	i32 1012816738, ; 147: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 256
	i32 1019214401, ; 148: System.Drawing => 0x3cbffa41 => 35
	i32 1028951442, ; 149: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 182
	i32 1029334545, ; 150: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 286
	i32 1031528504, ; 151: Xamarin.Google.ErrorProne.Annotations.dll => 0x3d7be038 => 274
	i32 1035644815, ; 152: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 209
	i32 1036536393, ; 153: System.Drawing.Primitives.dll => 0x3dc84a49 => 34
	i32 1044663988, ; 154: System.Linq.Expressions.dll => 0x3e444eb4 => 57
	i32 1052210849, ; 155: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 243
	i32 1058641855, ; 156: Microsoft.AspNetCore.Http.Connections.Common => 0x3f1997bf => 172
	i32 1067306892, ; 157: GoogleGson => 0x3f9dcf8c => 169
	i32 1082857460, ; 158: System.ComponentModel.TypeConverter => 0x408b17f4 => 17
	i32 1084122840, ; 159: Xamarin.Kotlin.StdLib => 0x409e66d8 => 277
	i32 1098259244, ; 160: System => 0x41761b2c => 160
	i32 1118262833, ; 161: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 299
	i32 1121599056, ; 162: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0x42da3e50 => 242
	i32 1127624469, ; 163: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 186
	i32 1149092582, ; 164: Xamarin.AndroidX.Window => 0x447dc2e6 => 269
	i32 1168523401, ; 165: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 305
	i32 1170634674, ; 166: System.Web.dll => 0x45c677b2 => 149
	i32 1175144683, ; 167: Xamarin.AndroidX.VectorDrawable.Animated => 0x460b48eb => 265
	i32 1178241025, ; 168: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 250
	i32 1203215381, ; 169: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 303
	i32 1204270330, ; 170: Xamarin.AndroidX.Arch.Core.Common => 0x47c7b4fa => 211
	i32 1208641965, ; 171: System.Diagnostics.Process => 0x480a69ad => 28
	i32 1219128291, ; 172: System.IO.IsolatedStorage => 0x48aa6be3 => 51
	i32 1233093933, ; 173: Microsoft.AspNetCore.SignalR.Client.Core.dll => 0x497f852d => 174
	i32 1234928153, ; 174: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 301
	i32 1243150071, ; 175: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x4a18f6f7 => 270
	i32 1253011324, ; 176: Microsoft.Win32.Registry => 0x4aaf6f7c => 5
	i32 1260983243, ; 177: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 285
	i32 1264511973, ; 178: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0x4b5eebe5 => 260
	i32 1267360935, ; 179: Xamarin.AndroidX.VectorDrawable => 0x4b8a64a7 => 264
	i32 1273260888, ; 180: Xamarin.AndroidX.Collection.Ktx => 0x4be46b58 => 216
	i32 1275534314, ; 181: Xamarin.KotlinX.Coroutines.Android => 0x4c071bea => 281
	i32 1278448581, ; 182: Xamarin.AndroidX.Annotation.Jvm => 0x4c3393c5 => 208
	i32 1293217323, ; 183: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 227
	i32 1309188875, ; 184: System.Private.DataContractSerialization => 0x4e08a30b => 84
	i32 1322716291, ; 185: Xamarin.AndroidX.Window.dll => 0x4ed70c83 => 269
	i32 1324164729, ; 186: System.Linq => 0x4eed2679 => 60
	i32 1335329327, ; 187: System.Runtime.Serialization.Json.dll => 0x4f97822f => 111
	i32 1364015309, ; 188: System.IO => 0x514d38cd => 56
	i32 1373134921, ; 189: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 315
	i32 1376866003, ; 190: Xamarin.AndroidX.SavedState => 0x52114ed3 => 256
	i32 1379779777, ; 191: System.Resources.ResourceManager => 0x523dc4c1 => 98
	i32 1402170036, ; 192: System.Configuration.dll => 0x53936ab4 => 19
	i32 1406073936, ; 193: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 220
	i32 1408764838, ; 194: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 110
	i32 1411638395, ; 195: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 100
	i32 1414043276, ; 196: Microsoft.AspNetCore.Connections.Abstractions.dll => 0x5448968c => 170
	i32 1422545099, ; 197: System.Runtime.CompilerServices.VisualC => 0x54ca50cb => 101
	i32 1430672901, ; 198: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 283
	i32 1434145427, ; 199: System.Runtime.Handles => 0x557b5293 => 103
	i32 1435222561, ; 200: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 273
	i32 1439761251, ; 201: System.Net.Quic.dll => 0x55d10363 => 70
	i32 1452070440, ; 202: System.Formats.Asn1.dll => 0x568cd628 => 37
	i32 1453312822, ; 203: System.Diagnostics.Tools.dll => 0x569fcb36 => 31
	i32 1457743152, ; 204: System.Runtime.Extensions.dll => 0x56e36530 => 102
	i32 1458022317, ; 205: System.Net.Security.dll => 0x56e7a7ad => 72
	i32 1461004990, ; 206: es\Microsoft.Maui.Controls.resources => 0x57152abe => 289
	i32 1461234159, ; 207: System.Collections.Immutable.dll => 0x5718a9ef => 9
	i32 1461719063, ; 208: System.Security.Cryptography.OpenSsl => 0x57201017 => 122
	i32 1462112819, ; 209: System.IO.Compression.dll => 0x57261233 => 45
	i32 1469204771, ; 210: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 210
	i32 1470490898, ; 211: Microsoft.Extensions.Primitives => 0x57a5e912 => 188
	i32 1479771757, ; 212: System.Collections.Immutable => 0x5833866d => 9
	i32 1480492111, ; 213: System.IO.Compression.Brotli.dll => 0x583e844f => 42
	i32 1487239319, ; 214: Microsoft.Win32.Primitives => 0x58a57897 => 4
	i32 1490025113, ; 215: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x58cffa99 => 257
	i32 1493001747, ; 216: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 293
	i32 1514721132, ; 217: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 288
	i32 1536373174, ; 218: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 30
	i32 1543031311, ; 219: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 135
	i32 1543355203, ; 220: System.Reflection.Emit.dll => 0x5bfdbb43 => 91
	i32 1550322496, ; 221: System.Reflection.Extensions.dll => 0x5c680b40 => 92
	i32 1551623176, ; 222: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 308
	i32 1565862583, ; 223: System.IO.FileSystem.Primitives => 0x5d552ab7 => 48
	i32 1566207040, ; 224: System.Threading.Tasks.Dataflow.dll => 0x5d5a6c40 => 137
	i32 1573704789, ; 225: System.Runtime.Serialization.Json => 0x5dccd455 => 111
	i32 1580037396, ; 226: System.Threading.Overlapped => 0x5e2d7514 => 136
	i32 1582372066, ; 227: Xamarin.AndroidX.DocumentFile.dll => 0x5e5114e2 => 226
	i32 1592978981, ; 228: System.Runtime.Serialization.dll => 0x5ef2ee25 => 114
	i32 1597949149, ; 229: Xamarin.Google.ErrorProne.Annotations => 0x5f3ec4dd => 274
	i32 1601112923, ; 230: System.Xml.Serialization => 0x5f6f0b5b => 153
	i32 1604827217, ; 231: System.Net.WebClient => 0x5fa7b851 => 75
	i32 1618516317, ; 232: System.Net.WebSockets.Client.dll => 0x6078995d => 78
	i32 1622152042, ; 233: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 246
	i32 1622358360, ; 234: System.Dynamic.Runtime => 0x60b33958 => 36
	i32 1624863272, ; 235: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 268
	i32 1635184631, ; 236: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x6176eff7 => 230
	i32 1636350590, ; 237: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 223
	i32 1639515021, ; 238: System.Net.Http.dll => 0x61b9038d => 63
	i32 1639986890, ; 239: System.Text.RegularExpressions => 0x61c036ca => 135
	i32 1641389582, ; 240: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 15
	i32 1657153582, ; 241: System.Runtime => 0x62c6282e => 115
	i32 1658241508, ; 242: Xamarin.AndroidX.Tracing.Tracing.dll => 0x62d6c1e4 => 262
	i32 1658251792, ; 243: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 271
	i32 1670060433, ; 244: Xamarin.AndroidX.ConstraintLayout => 0x638b1991 => 218
	i32 1675553242, ; 245: System.IO.FileSystem.DriveInfo.dll => 0x63dee9da => 47
	i32 1677501392, ; 246: System.Net.Primitives.dll => 0x63fca3d0 => 69
	i32 1678508291, ; 247: System.Net.WebSockets => 0x640c0103 => 79
	i32 1679769178, ; 248: System.Security.Cryptography => 0x641f3e5a => 125
	i32 1691477237, ; 249: System.Reflection.Metadata => 0x64d1e4f5 => 93
	i32 1696967625, ; 250: System.Security.Cryptography.Csp => 0x6525abc9 => 120
	i32 1698840827, ; 251: Xamarin.Kotlin.StdLib.Common => 0x654240fb => 278
	i32 1701541528, ; 252: System.Diagnostics.Debug.dll => 0x656b7698 => 26
	i32 1720223769, ; 253: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x66888819 => 239
	i32 1726116996, ; 254: System.Reflection.dll => 0x66e27484 => 96
	i32 1728033016, ; 255: System.Diagnostics.FileVersionInfo.dll => 0x66ffb0f8 => 27
	i32 1729485958, ; 256: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 214
	i32 1736233607, ; 257: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 306
	i32 1743415430, ; 258: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 284
	i32 1744735666, ; 259: System.Transactions.Local.dll => 0x67fe8db2 => 145
	i32 1746115085, ; 260: System.IO.Pipelines.dll => 0x68139a0d => 196
	i32 1746316138, ; 261: Mono.Android.Export => 0x6816ab6a => 165
	i32 1750313021, ; 262: Microsoft.Win32.Primitives.dll => 0x6853a83d => 4
	i32 1758240030, ; 263: System.Resources.Reader.dll => 0x68cc9d1e => 97
	i32 1763938596, ; 264: System.Diagnostics.TraceSource.dll => 0x69239124 => 32
	i32 1765942094, ; 265: System.Reflection.Extensions => 0x6942234e => 92
	i32 1766324549, ; 266: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 261
	i32 1770582343, ; 267: Microsoft.Extensions.Logging.dll => 0x6988f147 => 184
	i32 1776026572, ; 268: System.Core.dll => 0x69dc03cc => 21
	i32 1777075843, ; 269: System.Globalization.Extensions.dll => 0x69ec0683 => 40
	i32 1780572499, ; 270: Mono.Android.Runtime.dll => 0x6a216153 => 166
	i32 1782862114, ; 271: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 300
	i32 1788241197, ; 272: Xamarin.AndroidX.Fragment => 0x6a96652d => 232
	i32 1793755602, ; 273: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 292
	i32 1796167890, ; 274: Microsoft.Bcl.AsyncInterfaces.dll => 0x6b0f58d2 => 177
	i32 1808609942, ; 275: Xamarin.AndroidX.Loader => 0x6bcd3296 => 246
	i32 1813058853, ; 276: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 277
	i32 1813201214, ; 277: Xamarin.Google.Android.Material => 0x6c13413e => 271
	i32 1818569960, ; 278: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 251
	i32 1818787751, ; 279: Microsoft.VisualBasic.Core => 0x6c687fa7 => 2
	i32 1824175904, ; 280: System.Text.Encoding.Extensions => 0x6cbab720 => 133
	i32 1824722060, ; 281: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 110
	i32 1828688058, ; 282: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 185
	i32 1842015223, ; 283: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 312
	i32 1847515442, ; 284: Xamarin.Android.Glide.Annotations => 0x6e1ed932 => 201
	i32 1853025655, ; 285: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 309
	i32 1858542181, ; 286: System.Linq.Expressions => 0x6ec71a65 => 57
	i32 1870277092, ; 287: System.Reflection.Primitives => 0x6f7a29e4 => 94
	i32 1875935024, ; 288: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 291
	i32 1879696579, ; 289: System.Formats.Tar.dll => 0x7009e4c3 => 38
	i32 1885316902, ; 290: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0x705fa726 => 212
	i32 1888955245, ; 291: System.Diagnostics.Contracts => 0x70972b6d => 25
	i32 1889954781, ; 292: System.Reflection.Metadata.dll => 0x70a66bdd => 93
	i32 1898237753, ; 293: System.Reflection.DispatchProxy => 0x7124cf39 => 88
	i32 1900610850, ; 294: System.Resources.ResourceManager.dll => 0x71490522 => 98
	i32 1910275211, ; 295: System.Collections.NonGeneric.dll => 0x71dc7c8b => 10
	i32 1932718519, ; 296: Microsoft.Bcl.TimeProvider => 0x7332f1b7 => 178
	i32 1939592360, ; 297: System.Private.Xml.Linq => 0x739bd4a8 => 86
	i32 1945717188, ; 298: Microsoft.AspNetCore.SignalR.Client.Core => 0x73f949c4 => 174
	i32 1956758971, ; 299: System.Resources.Writer => 0x74a1c5bb => 99
	i32 1961813231, ; 300: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 258
	i32 1967334205, ; 301: Microsoft.AspNetCore.SignalR.Common => 0x7543233d => 175
	i32 1968388702, ; 302: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 179
	i32 1983156543, ; 303: Xamarin.Kotlin.StdLib.Common.dll => 0x7634913f => 278
	i32 1985761444, ; 304: Xamarin.Android.Glide.GifDecoder => 0x765c50a4 => 203
	i32 2003115576, ; 305: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 288
	i32 2011961780, ; 306: System.Buffers.dll => 0x77ec19b4 => 7
	i32 2019465201, ; 307: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 243
	i32 2025202353, ; 308: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 283
	i32 2031763787, ; 309: Xamarin.Android.Glide => 0x791a414b => 200
	i32 2045470958, ; 310: System.Private.Xml => 0x79eb68ee => 87
	i32 2055257422, ; 311: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 238
	i32 2060060697, ; 312: System.Windows.dll => 0x7aca0819 => 150
	i32 2066184531, ; 313: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 287
	i32 2070888862, ; 314: System.Diagnostics.TraceSource => 0x7b6f419e => 32
	i32 2079903147, ; 315: System.Runtime.dll => 0x7bf8cdab => 115
	i32 2090596640, ; 316: System.Numerics.Vectors => 0x7c9bf920 => 81
	i32 2127167465, ; 317: System.Console => 0x7ec9ffe9 => 20
	i32 2142473426, ; 318: System.Collections.Specialized => 0x7fb38cd2 => 11
	i32 2143790110, ; 319: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 158
	i32 2146852085, ; 320: Microsoft.VisualBasic.dll => 0x7ff65cf5 => 3
	i32 2159891885, ; 321: Microsoft.Maui => 0x80bd55ad => 192
	i32 2169148018, ; 322: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 295
	i32 2181898931, ; 323: Microsoft.Extensions.Options.dll => 0x820d22b3 => 187
	i32 2192057212, ; 324: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 185
	i32 2193016926, ; 325: System.ObjectModel.dll => 0x82b6c85e => 83
	i32 2201107256, ; 326: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 282
	i32 2201231467, ; 327: System.Net.Http => 0x8334206b => 63
	i32 2207618523, ; 328: it\Microsoft.Maui.Controls.resources => 0x839595db => 297
	i32 2217644978, ; 329: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x842e93b2 => 265
	i32 2222056684, ; 330: System.Threading.Tasks.Parallel => 0x8471e4ec => 139
	i32 2229158877, ; 331: Microsoft.Extensions.Features.dll => 0x84de43dd => 183
	i32 2244775296, ; 332: Xamarin.AndroidX.LocalBroadcastManager => 0x85cc8d80 => 247
	i32 2252106437, ; 333: System.Xml.Serialization.dll => 0x863c6ac5 => 153
	i32 2256313426, ; 334: System.Globalization.Extensions => 0x867c9c52 => 40
	i32 2265110946, ; 335: System.Security.AccessControl.dll => 0x8702d9a2 => 116
	i32 2266799131, ; 336: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 180
	i32 2267999099, ; 337: Xamarin.Android.Glide.DiskLruCache.dll => 0x872eeb7b => 202
	i32 2270573516, ; 338: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 291
	i32 2279755925, ; 339: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 254
	i32 2293034957, ; 340: System.ServiceModel.Web.dll => 0x88acefcd => 130
	i32 2295906218, ; 341: System.Net.Sockets => 0x88d8bfaa => 74
	i32 2298471582, ; 342: System.Net.Mail => 0x88ffe49e => 65
	i32 2303942373, ; 343: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 301
	i32 2305521784, ; 344: System.Private.CoreLib.dll => 0x896b7878 => 168
	i32 2315684594, ; 345: Xamarin.AndroidX.Annotation.dll => 0x8a068af2 => 206
	i32 2319144366, ; 346: Microsoft.AspNetCore.SignalR.Client => 0x8a3b55ae => 173
	i32 2320631194, ; 347: System.Threading.Tasks.Parallel.dll => 0x8a52059a => 139
	i32 2340441535, ; 348: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 105
	i32 2344264397, ; 349: System.ValueTuple => 0x8bbaa2cd => 147
	i32 2353062107, ; 350: System.Net.Primitives => 0x8c40e0db => 69
	i32 2368005991, ; 351: System.Xml.ReaderWriter.dll => 0x8d24e767 => 152
	i32 2371007202, ; 352: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 179
	i32 2378619854, ; 353: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 120
	i32 2383496789, ; 354: System.Security.Principal.Windows.dll => 0x8e114655 => 126
	i32 2395872292, ; 355: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 296
	i32 2401565422, ; 356: System.Web.HttpUtility => 0x8f24faee => 148
	i32 2403452196, ; 357: Xamarin.AndroidX.Emoji2.dll => 0x8f41c524 => 229
	i32 2421380589, ; 358: System.Threading.Tasks.Dataflow => 0x905355ed => 137
	i32 2423080555, ; 359: Xamarin.AndroidX.Collection.Ktx.dll => 0x906d466b => 216
	i32 2427813419, ; 360: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 293
	i32 2435356389, ; 361: System.Console.dll => 0x912896e5 => 20
	i32 2435904999, ; 362: System.ComponentModel.DataAnnotations.dll => 0x9130f5e7 => 14
	i32 2454642406, ; 363: System.Text.Encoding.dll => 0x924edee6 => 134
	i32 2458678730, ; 364: System.Net.Sockets.dll => 0x928c75ca => 74
	i32 2459001652, ; 365: System.Linq.Parallel.dll => 0x92916334 => 58
	i32 2465532216, ; 366: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x92f50938 => 219
	i32 2471841756, ; 367: netstandard.dll => 0x93554fdc => 163
	i32 2475788418, ; 368: Java.Interop.dll => 0x93918882 => 164
	i32 2480646305, ; 369: Microsoft.Maui.Controls => 0x93dba8a1 => 190
	i32 2483903535, ; 370: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 15
	i32 2484371297, ; 371: System.Net.ServicePoint => 0x94147f61 => 73
	i32 2490993605, ; 372: System.AppContext.dll => 0x94798bc5 => 6
	i32 2501346920, ; 373: System.Data.DataSetExtensions => 0x95178668 => 23
	i32 2505896520, ; 374: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x955cf248 => 241
	i32 2522472828, ; 375: Xamarin.Android.Glide.dll => 0x9659e17c => 200
	i32 2538310050, ; 376: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 90
	i32 2550873716, ; 377: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 294
	i32 2562349572, ; 378: Microsoft.CSharp => 0x98ba5a04 => 1
	i32 2570120770, ; 379: System.Text.Encodings.Web => 0x9930ee42 => 197
	i32 2581783588, ; 380: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x99e2e424 => 242
	i32 2581819634, ; 381: Xamarin.AndroidX.VectorDrawable.dll => 0x99e370f2 => 264
	i32 2585220780, ; 382: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 133
	i32 2585805581, ; 383: System.Net.Ping => 0x9a20430d => 68
	i32 2589602615, ; 384: System.Threading.ThreadPool => 0x9a5a3337 => 142
	i32 2593496499, ; 385: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 303
	i32 2605712449, ; 386: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 282
	i32 2615233544, ; 387: Xamarin.AndroidX.Fragment.Ktx => 0x9be14c08 => 233
	i32 2616218305, ; 388: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 186
	i32 2617129537, ; 389: System.Private.Xml.dll => 0x9bfe3a41 => 87
	i32 2618712057, ; 390: System.Reflection.TypeExtensions.dll => 0x9c165ff9 => 95
	i32 2620871830, ; 391: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 223
	i32 2624644809, ; 392: Xamarin.AndroidX.DynamicAnimation => 0x9c70e6c9 => 228
	i32 2626831493, ; 393: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 298
	i32 2627185994, ; 394: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 30
	i32 2629843544, ; 395: System.IO.Compression.ZipFile.dll => 0x9cc03a58 => 44
	i32 2633051222, ; 396: Xamarin.AndroidX.Lifecycle.LiveData => 0x9cf12c56 => 237
	i32 2637500010, ; 397: Microsoft.Extensions.Features => 0x9d350e6a => 183
	i32 2663391936, ; 398: Xamarin.Android.Glide.DiskLruCache => 0x9ec022c0 => 202
	i32 2663698177, ; 399: System.Runtime.Loader => 0x9ec4cf01 => 108
	i32 2664396074, ; 400: System.Xml.XDocument.dll => 0x9ecf752a => 154
	i32 2665622720, ; 401: System.Drawing.Primitives => 0x9ee22cc0 => 34
	i32 2676780864, ; 402: System.Data.Common.dll => 0x9f8c6f40 => 22
	i32 2686887180, ; 403: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 113
	i32 2693849962, ; 404: System.IO.dll => 0xa090e36a => 56
	i32 2701096212, ; 405: Xamarin.AndroidX.Tracing.Tracing => 0xa0ff7514 => 262
	i32 2715334215, ; 406: System.Threading.Tasks.dll => 0xa1d8b647 => 140
	i32 2717744543, ; 407: System.Security.Claims => 0xa1fd7d9f => 117
	i32 2719963679, ; 408: System.Security.Cryptography.Cng.dll => 0xa21f5a1f => 119
	i32 2724373263, ; 409: System.Runtime.Numerics.dll => 0xa262a30f => 109
	i32 2732626843, ; 410: Xamarin.AndroidX.Activity => 0xa2e0939b => 204
	i32 2735172069, ; 411: System.Threading.Channels => 0xa30769e5 => 199
	i32 2737747696, ; 412: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 210
	i32 2740948882, ; 413: System.IO.Pipes.AccessControl => 0xa35f8f92 => 53
	i32 2748088231, ; 414: System.Runtime.InteropServices.JavaScript => 0xa3cc7fa7 => 104
	i32 2752995522, ; 415: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 304
	i32 2758225723, ; 416: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 191
	i32 2764765095, ; 417: Microsoft.Maui.dll => 0xa4caf7a7 => 192
	i32 2765824710, ; 418: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 132
	i32 2770495804, ; 419: Xamarin.Jetbrains.Annotations.dll => 0xa522693c => 276
	i32 2778768386, ; 420: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 267
	i32 2779977773, ; 421: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0xa5b3182d => 255
	i32 2785988530, ; 422: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 310
	i32 2788224221, ; 423: Xamarin.AndroidX.Fragment.Ktx.dll => 0xa630ecdd => 233
	i32 2801831435, ; 424: Microsoft.Maui.Graphics => 0xa7008e0b => 194
	i32 2803228030, ; 425: System.Xml.XPath.XDocument.dll => 0xa715dd7e => 155
	i32 2806116107, ; 426: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 289
	i32 2810250172, ; 427: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 220
	i32 2819470561, ; 428: System.Xml.dll => 0xa80db4e1 => 159
	i32 2821205001, ; 429: System.ServiceProcess.dll => 0xa8282c09 => 131
	i32 2821294376, ; 430: Xamarin.AndroidX.ResourceInspection.Annotation => 0xa8298928 => 255
	i32 2824502124, ; 431: System.Xml.XmlDocument => 0xa85a7b6c => 157
	i32 2831556043, ; 432: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 302
	i32 2838993487, ; 433: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xa9379a4f => 244
	i32 2849599387, ; 434: System.Threading.Overlapped.dll => 0xa9d96f9b => 136
	i32 2853208004, ; 435: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 267
	i32 2855708567, ; 436: Xamarin.AndroidX.Transition => 0xaa36a797 => 263
	i32 2861098320, ; 437: Mono.Android.Export.dll => 0xaa88e550 => 165
	i32 2861189240, ; 438: Microsoft.Maui.Essentials => 0xaa8a4878 => 193
	i32 2870099610, ; 439: Xamarin.AndroidX.Activity.Ktx.dll => 0xab123e9a => 205
	i32 2875164099, ; 440: Jsr305Binding.dll => 0xab5f85c3 => 272
	i32 2875220617, ; 441: System.Globalization.Calendars.dll => 0xab606289 => 39
	i32 2875347124, ; 442: Microsoft.AspNetCore.Http.Connections.Client.dll => 0xab6250b4 => 171
	i32 2884993177, ; 443: Xamarin.AndroidX.ExifInterface => 0xabf58099 => 231
	i32 2887636118, ; 444: System.Net.dll => 0xac1dd496 => 80
	i32 2899753641, ; 445: System.IO.UnmanagedMemoryStream => 0xacd6baa9 => 55
	i32 2900621748, ; 446: System.Dynamic.Runtime.dll => 0xace3f9b4 => 36
	i32 2901442782, ; 447: System.Reflection => 0xacf080de => 96
	i32 2905242038, ; 448: mscorlib.dll => 0xad2a79b6 => 162
	i32 2909740682, ; 449: System.Private.CoreLib => 0xad6f1e8a => 168
	i32 2916838712, ; 450: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 268
	i32 2919462931, ; 451: System.Numerics.Vectors.dll => 0xae037813 => 81
	i32 2921128767, ; 452: Xamarin.AndroidX.Annotation.Experimental.dll => 0xae1ce33f => 207
	i32 2936416060, ; 453: System.Resources.Reader => 0xaf06273c => 97
	i32 2940926066, ; 454: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 29
	i32 2942453041, ; 455: System.Xml.XPath.XDocument => 0xaf624531 => 155
	i32 2959614098, ; 456: System.ComponentModel.dll => 0xb0682092 => 18
	i32 2968338931, ; 457: System.Security.Principal.Windows => 0xb0ed41f3 => 126
	i32 2972252294, ; 458: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 118
	i32 2978675010, ; 459: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 227
	i32 2987532451, ; 460: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 258
	i32 2996846495, ; 461: Xamarin.AndroidX.Lifecycle.Process.dll => 0xb2a03f9f => 240
	i32 3016983068, ; 462: Xamarin.AndroidX.Startup.StartupRuntime => 0xb3d3821c => 260
	i32 3023353419, ; 463: WindowsBase.dll => 0xb434b64b => 161
	i32 3024354802, ; 464: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xb443fdf2 => 235
	i32 3038032645, ; 465: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 317
	i32 3056245963, ; 466: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0xb62a9ccb => 257
	i32 3057625584, ; 467: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 248
	i32 3059408633, ; 468: Mono.Android.Runtime => 0xb65adef9 => 166
	i32 3059793426, ; 469: System.ComponentModel.Primitives => 0xb660be12 => 16
	i32 3075834255, ; 470: System.Threading.Tasks => 0xb755818f => 140
	i32 3077302341, ; 471: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 295
	i32 3090735792, ; 472: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 124
	i32 3099732863, ; 473: System.Security.Claims.dll => 0xb8c22b7f => 117
	i32 3103600923, ; 474: System.Formats.Asn1 => 0xb8fd311b => 37
	i32 3111772706, ; 475: System.Runtime.Serialization => 0xb979e222 => 114
	i32 3121463068, ; 476: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 46
	i32 3124832203, ; 477: System.Threading.Tasks.Extensions => 0xba4127cb => 138
	i32 3132293585, ; 478: System.Security.AccessControl => 0xbab301d1 => 116
	i32 3147165239, ; 479: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 33
	i32 3148237826, ; 480: GoogleGson.dll => 0xbba64c02 => 169
	i32 3159123045, ; 481: System.Reflection.Primitives.dll => 0xbc4c6465 => 94
	i32 3160747431, ; 482: System.IO.MemoryMappedFiles => 0xbc652da7 => 52
	i32 3178803400, ; 483: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 249
	i32 3192346100, ; 484: System.Security.SecureString => 0xbe4755f4 => 128
	i32 3193515020, ; 485: System.Web => 0xbe592c0c => 149
	i32 3204380047, ; 486: System.Data.dll => 0xbefef58f => 24
	i32 3209718065, ; 487: System.Xml.XmlDocument.dll => 0xbf506931 => 157
	i32 3211777861, ; 488: Xamarin.AndroidX.DocumentFile => 0xbf6fd745 => 226
	i32 3220365878, ; 489: System.Threading => 0xbff2e236 => 144
	i32 3226221578, ; 490: System.Runtime.Handles.dll => 0xc04c3c0a => 103
	i32 3251039220, ; 491: System.Reflection.DispatchProxy.dll => 0xc1c6ebf4 => 88
	i32 3258312781, ; 492: Xamarin.AndroidX.CardView => 0xc235e84d => 214
	i32 3265493905, ; 493: System.Linq.Queryable.dll => 0xc2a37b91 => 59
	i32 3265893370, ; 494: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 138
	i32 3277815716, ; 495: System.Resources.Writer.dll => 0xc35f7fa4 => 99
	i32 3279906254, ; 496: Microsoft.Win32.Registry.dll => 0xc37f65ce => 5
	i32 3280506390, ; 497: System.ComponentModel.Annotations.dll => 0xc3888e16 => 13
	i32 3290767353, ; 498: System.Security.Cryptography.Encoding => 0xc4251ff9 => 121
	i32 3299363146, ; 499: System.Text.Encoding => 0xc4a8494a => 134
	i32 3303498502, ; 500: System.Diagnostics.FileVersionInfo => 0xc4e76306 => 27
	i32 3305363605, ; 501: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 290
	i32 3316684772, ; 502: System.Net.Requests.dll => 0xc5b097e4 => 71
	i32 3317135071, ; 503: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 224
	i32 3317144872, ; 504: System.Data => 0xc5b79d28 => 24
	i32 3340431453, ; 505: Xamarin.AndroidX.Arch.Core.Runtime => 0xc71af05d => 212
	i32 3345895724, ; 506: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xc76e512c => 253
	i32 3346324047, ; 507: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 250
	i32 3357674450, ; 508: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 307
	i32 3358260929, ; 509: System.Text.Json => 0xc82afec1 => 198
	i32 3362336904, ; 510: Xamarin.AndroidX.Activity.Ktx => 0xc8693088 => 205
	i32 3362522851, ; 511: Xamarin.AndroidX.Core => 0xc86c06e3 => 221
	i32 3366347497, ; 512: Java.Interop => 0xc8a662e9 => 164
	i32 3374999561, ; 513: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 254
	i32 3381016424, ; 514: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 286
	i32 3395150330, ; 515: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 100
	i32 3403906625, ; 516: System.Security.Cryptography.OpenSsl.dll => 0xcae37e41 => 122
	i32 3405233483, ; 517: Xamarin.AndroidX.CustomView.PoolingContainer => 0xcaf7bd4b => 225
	i32 3428513518, ; 518: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 181
	i32 3429136800, ; 519: System.Xml => 0xcc6479a0 => 159
	i32 3430777524, ; 520: netstandard => 0xcc7d82b4 => 163
	i32 3441283291, ; 521: Xamarin.AndroidX.DynamicAnimation.dll => 0xcd1dd0db => 228
	i32 3445260447, ; 522: System.Formats.Tar => 0xcd5a809f => 38
	i32 3452344032, ; 523: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 189
	i32 3463511458, ; 524: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 294
	i32 3466904072, ; 525: Microsoft.AspNetCore.SignalR.Client.dll => 0xcea4c208 => 173
	i32 3471940407, ; 526: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 17
	i32 3476120550, ; 527: Mono.Android => 0xcf3163e6 => 167
	i32 3479583265, ; 528: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 307
	i32 3484440000, ; 529: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 306
	i32 3485117614, ; 530: System.Text.Json.dll => 0xcfbaacae => 198
	i32 3486566296, ; 531: System.Transactions => 0xcfd0c798 => 146
	i32 3493954962, ; 532: Xamarin.AndroidX.Concurrent.Futures.dll => 0xd0418592 => 217
	i32 3509114376, ; 533: System.Xml.Linq => 0xd128d608 => 151
	i32 3515174580, ; 534: System.Security.dll => 0xd1854eb4 => 129
	i32 3530912306, ; 535: System.Configuration => 0xd2757232 => 19
	i32 3539954161, ; 536: System.Net.HttpListener => 0xd2ff69f1 => 64
	i32 3560100363, ; 537: System.Threading.Timer => 0xd432d20b => 143
	i32 3570554715, ; 538: System.IO.FileSystem.AccessControl => 0xd4d2575b => 46
	i32 3580758918, ; 539: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 314
	i32 3597029428, ; 540: Xamarin.Android.Glide.GifDecoder.dll => 0xd6665034 => 203
	i32 3598340787, ; 541: System.Net.WebSockets.Client => 0xd67a52b3 => 78
	i32 3608519521, ; 542: System.Linq.dll => 0xd715a361 => 60
	i32 3624195450, ; 543: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 105
	i32 3627220390, ; 544: Xamarin.AndroidX.Print.dll => 0xd832fda6 => 252
	i32 3633644679, ; 545: Xamarin.AndroidX.Annotation.Experimental => 0xd8950487 => 207
	i32 3638274909, ; 546: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 48
	i32 3641597786, ; 547: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 238
	i32 3643446276, ; 548: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 311
	i32 3643854240, ; 549: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 249
	i32 3645089577, ; 550: System.ComponentModel.DataAnnotations => 0xd943a729 => 14
	i32 3657292374, ; 551: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 180
	i32 3660523487, ; 552: System.Net.NetworkInformation => 0xda2f27df => 67
	i32 3672681054, ; 553: Mono.Android.dll => 0xdae8aa5e => 167
	i32 3682565725, ; 554: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 213
	i32 3684561358, ; 555: Xamarin.AndroidX.Concurrent.Futures => 0xdb9df1ce => 217
	i32 3691870036, ; 556: Microsoft.AspNetCore.SignalR.Protocols.Json => 0xdc0d7754 => 176
	i32 3697841164, ; 557: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 316
	i32 3700866549, ; 558: System.Net.WebProxy.dll => 0xdc96bdf5 => 77
	i32 3706696989, ; 559: Xamarin.AndroidX.Core.Core.Ktx.dll => 0xdcefb51d => 222
	i32 3716563718, ; 560: System.Runtime.Intrinsics => 0xdd864306 => 107
	i32 3718780102, ; 561: Xamarin.AndroidX.Annotation => 0xdda814c6 => 206
	i32 3724971120, ; 562: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 248
	i32 3732100267, ; 563: System.Net.NameResolution => 0xde7354ab => 66
	i32 3737834244, ; 564: System.Net.Http.Json.dll => 0xdecad304 => 62
	i32 3748608112, ; 565: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 195
	i32 3751444290, ; 566: System.Xml.XPath => 0xdf9a7f42 => 156
	i32 3786282454, ; 567: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 215
	i32 3787005001, ; 568: Microsoft.AspNetCore.Connections.Abstractions => 0xe1b91c49 => 170
	i32 3792276235, ; 569: System.Collections.NonGeneric => 0xe2098b0b => 10
	i32 3800979733, ; 570: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 189
	i32 3802395368, ; 571: System.Collections.Specialized.dll => 0xe2a3f2e8 => 11
	i32 3819260425, ; 572: System.Net.WebProxy => 0xe3a54a09 => 77
	i32 3823082795, ; 573: System.Security.Cryptography.dll => 0xe3df9d2b => 125
	i32 3829621856, ; 574: System.Numerics.dll => 0xe4436460 => 82
	i32 3841636137, ; 575: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 182
	i32 3844307129, ; 576: System.Net.Mail.dll => 0xe52378b9 => 65
	i32 3849253459, ; 577: System.Runtime.InteropServices.dll => 0xe56ef253 => 106
	i32 3870376305, ; 578: System.Net.HttpListener.dll => 0xe6b14171 => 64
	i32 3873536506, ; 579: System.Security.Principal => 0xe6e179fa => 127
	i32 3875112723, ; 580: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 121
	i32 3885497537, ; 581: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 76
	i32 3885922214, ; 582: Xamarin.AndroidX.Transition.dll => 0xe79e77a6 => 263
	i32 3888767677, ; 583: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0xe7c9e2bd => 253
	i32 3889960447, ; 584: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 315
	i32 3896106733, ; 585: System.Collections.Concurrent.dll => 0xe839deed => 8
	i32 3896760992, ; 586: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 221
	i32 3901907137, ; 587: Microsoft.VisualBasic.Core.dll => 0xe89260c1 => 2
	i32 3920810846, ; 588: System.IO.Compression.FileSystem.dll => 0xe9b2d35e => 43
	i32 3921031405, ; 589: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 266
	i32 3928044579, ; 590: System.Xml.ReaderWriter => 0xea213423 => 152
	i32 3930554604, ; 591: System.Security.Principal.dll => 0xea4780ec => 127
	i32 3931092270, ; 592: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 251
	i32 3941852471, ; 593: LocationTrackingMApp.dll => 0xeaf3e537 => 0
	i32 3945713374, ; 594: System.Data.DataSetExtensions.dll => 0xeb2ecede => 23
	i32 3953953790, ; 595: System.Text.Encoding.CodePages => 0xebac8bfe => 132
	i32 3955647286, ; 596: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 209
	i32 3959773229, ; 597: Xamarin.AndroidX.Lifecycle.Process => 0xec05582d => 240
	i32 3980434154, ; 598: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 310
	i32 3987592930, ; 599: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 292
	i32 4003436829, ; 600: System.Diagnostics.Process.dll => 0xee9f991d => 28
	i32 4015948917, ; 601: Xamarin.AndroidX.Annotation.Jvm.dll => 0xef5e8475 => 208
	i32 4017318820, ; 602: Microsoft.Bcl.TimeProvider.dll => 0xef736ba4 => 178
	i32 4023392905, ; 603: System.IO.Pipelines => 0xefd01a89 => 196
	i32 4025784931, ; 604: System.Memory => 0xeff49a63 => 61
	i32 4046471985, ; 605: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 191
	i32 4054681211, ; 606: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 89
	i32 4068434129, ; 607: System.Private.Xml.Linq.dll => 0xf27f60d1 => 86
	i32 4073602200, ; 608: System.Threading.dll => 0xf2ce3c98 => 144
	i32 4094352644, ; 609: Microsoft.Maui.Essentials.dll => 0xf40add04 => 193
	i32 4099507663, ; 610: System.Drawing.dll => 0xf45985cf => 35
	i32 4100113165, ; 611: System.Private.Uri => 0xf462c30d => 85
	i32 4101593132, ; 612: Xamarin.AndroidX.Emoji2 => 0xf479582c => 229
	i32 4102112229, ; 613: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 305
	i32 4125707920, ; 614: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 300
	i32 4126470640, ; 615: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 181
	i32 4127667938, ; 616: System.IO.FileSystem.Watcher => 0xf60736e2 => 49
	i32 4130442656, ; 617: System.AppContext => 0xf6318da0 => 6
	i32 4147896353, ; 618: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 89
	i32 4150914736, ; 619: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 312
	i32 4151237749, ; 620: System.Core => 0xf76edc75 => 21
	i32 4159265925, ; 621: System.Xml.XmlSerializer => 0xf7e95c85 => 158
	i32 4161255271, ; 622: System.Reflection.TypeExtensions => 0xf807b767 => 95
	i32 4164802419, ; 623: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 49
	i32 4181436372, ; 624: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 112
	i32 4182413190, ; 625: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 245
	i32 4185676441, ; 626: System.Security => 0xf97c5a99 => 129
	i32 4196529839, ; 627: System.Net.WebClient.dll => 0xfa21f6af => 75
	i32 4213026141, ; 628: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 195
	i32 4256097574, ; 629: Xamarin.AndroidX.Core.Core.Ktx => 0xfdaee526 => 222
	i32 4258378803, ; 630: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xfdd1b433 => 244
	i32 4260525087, ; 631: System.Buffers => 0xfdf2741f => 7
	i32 4271975918, ; 632: Microsoft.Maui.Controls.dll => 0xfea12dee => 190
	i32 4274976490, ; 633: System.Runtime.Numerics => 0xfecef6ea => 109
	i32 4292120959, ; 634: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 245
	i32 4294763496 ; 635: Xamarin.AndroidX.ExifInterface.dll => 0xfffce3e8 => 231
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [636 x i32] [
	i32 67, ; 0
	i32 66, ; 1
	i32 107, ; 2
	i32 241, ; 3
	i32 275, ; 4
	i32 47, ; 5
	i32 79, ; 6
	i32 141, ; 7
	i32 29, ; 8
	i32 316, ; 9
	i32 123, ; 10
	i32 194, ; 11
	i32 101, ; 12
	i32 259, ; 13
	i32 106, ; 14
	i32 259, ; 15
	i32 199, ; 16
	i32 279, ; 17
	i32 76, ; 18
	i32 123, ; 19
	i32 13, ; 20
	i32 215, ; 21
	i32 131, ; 22
	i32 261, ; 23
	i32 147, ; 24
	i32 313, ; 25
	i32 314, ; 26
	i32 18, ; 27
	i32 213, ; 28
	i32 26, ; 29
	i32 171, ; 30
	i32 235, ; 31
	i32 1, ; 32
	i32 58, ; 33
	i32 41, ; 34
	i32 90, ; 35
	i32 218, ; 36
	i32 143, ; 37
	i32 237, ; 38
	i32 234, ; 39
	i32 285, ; 40
	i32 53, ; 41
	i32 68, ; 42
	i32 313, ; 43
	i32 204, ; 44
	i32 82, ; 45
	i32 298, ; 46
	i32 236, ; 47
	i32 172, ; 48
	i32 297, ; 49
	i32 130, ; 50
	i32 54, ; 51
	i32 145, ; 52
	i32 73, ; 53
	i32 141, ; 54
	i32 61, ; 55
	i32 142, ; 56
	i32 317, ; 57
	i32 161, ; 58
	i32 0, ; 59
	i32 309, ; 60
	i32 219, ; 61
	i32 12, ; 62
	i32 232, ; 63
	i32 124, ; 64
	i32 148, ; 65
	i32 175, ; 66
	i32 112, ; 67
	i32 162, ; 68
	i32 160, ; 69
	i32 234, ; 70
	i32 247, ; 71
	i32 83, ; 72
	i32 296, ; 73
	i32 290, ; 74
	i32 188, ; 75
	i32 146, ; 76
	i32 279, ; 77
	i32 59, ; 78
	i32 184, ; 79
	i32 50, ; 80
	i32 102, ; 81
	i32 113, ; 82
	i32 177, ; 83
	i32 39, ; 84
	i32 272, ; 85
	i32 270, ; 86
	i32 119, ; 87
	i32 304, ; 88
	i32 51, ; 89
	i32 43, ; 90
	i32 118, ; 91
	i32 224, ; 92
	i32 302, ; 93
	i32 230, ; 94
	i32 80, ; 95
	i32 197, ; 96
	i32 266, ; 97
	i32 211, ; 98
	i32 8, ; 99
	i32 72, ; 100
	i32 284, ; 101
	i32 151, ; 102
	i32 281, ; 103
	i32 150, ; 104
	i32 91, ; 105
	i32 276, ; 106
	i32 44, ; 107
	i32 299, ; 108
	i32 287, ; 109
	i32 280, ; 110
	i32 108, ; 111
	i32 128, ; 112
	i32 25, ; 113
	i32 201, ; 114
	i32 71, ; 115
	i32 54, ; 116
	i32 45, ; 117
	i32 308, ; 118
	i32 187, ; 119
	i32 225, ; 120
	i32 22, ; 121
	i32 239, ; 122
	i32 85, ; 123
	i32 42, ; 124
	i32 156, ; 125
	i32 176, ; 126
	i32 70, ; 127
	i32 252, ; 128
	i32 3, ; 129
	i32 41, ; 130
	i32 62, ; 131
	i32 16, ; 132
	i32 52, ; 133
	i32 311, ; 134
	i32 275, ; 135
	i32 104, ; 136
	i32 280, ; 137
	i32 273, ; 138
	i32 236, ; 139
	i32 33, ; 140
	i32 154, ; 141
	i32 84, ; 142
	i32 31, ; 143
	i32 12, ; 144
	i32 50, ; 145
	i32 55, ; 146
	i32 256, ; 147
	i32 35, ; 148
	i32 182, ; 149
	i32 286, ; 150
	i32 274, ; 151
	i32 209, ; 152
	i32 34, ; 153
	i32 57, ; 154
	i32 243, ; 155
	i32 172, ; 156
	i32 169, ; 157
	i32 17, ; 158
	i32 277, ; 159
	i32 160, ; 160
	i32 299, ; 161
	i32 242, ; 162
	i32 186, ; 163
	i32 269, ; 164
	i32 305, ; 165
	i32 149, ; 166
	i32 265, ; 167
	i32 250, ; 168
	i32 303, ; 169
	i32 211, ; 170
	i32 28, ; 171
	i32 51, ; 172
	i32 174, ; 173
	i32 301, ; 174
	i32 270, ; 175
	i32 5, ; 176
	i32 285, ; 177
	i32 260, ; 178
	i32 264, ; 179
	i32 216, ; 180
	i32 281, ; 181
	i32 208, ; 182
	i32 227, ; 183
	i32 84, ; 184
	i32 269, ; 185
	i32 60, ; 186
	i32 111, ; 187
	i32 56, ; 188
	i32 315, ; 189
	i32 256, ; 190
	i32 98, ; 191
	i32 19, ; 192
	i32 220, ; 193
	i32 110, ; 194
	i32 100, ; 195
	i32 170, ; 196
	i32 101, ; 197
	i32 283, ; 198
	i32 103, ; 199
	i32 273, ; 200
	i32 70, ; 201
	i32 37, ; 202
	i32 31, ; 203
	i32 102, ; 204
	i32 72, ; 205
	i32 289, ; 206
	i32 9, ; 207
	i32 122, ; 208
	i32 45, ; 209
	i32 210, ; 210
	i32 188, ; 211
	i32 9, ; 212
	i32 42, ; 213
	i32 4, ; 214
	i32 257, ; 215
	i32 293, ; 216
	i32 288, ; 217
	i32 30, ; 218
	i32 135, ; 219
	i32 91, ; 220
	i32 92, ; 221
	i32 308, ; 222
	i32 48, ; 223
	i32 137, ; 224
	i32 111, ; 225
	i32 136, ; 226
	i32 226, ; 227
	i32 114, ; 228
	i32 274, ; 229
	i32 153, ; 230
	i32 75, ; 231
	i32 78, ; 232
	i32 246, ; 233
	i32 36, ; 234
	i32 268, ; 235
	i32 230, ; 236
	i32 223, ; 237
	i32 63, ; 238
	i32 135, ; 239
	i32 15, ; 240
	i32 115, ; 241
	i32 262, ; 242
	i32 271, ; 243
	i32 218, ; 244
	i32 47, ; 245
	i32 69, ; 246
	i32 79, ; 247
	i32 125, ; 248
	i32 93, ; 249
	i32 120, ; 250
	i32 278, ; 251
	i32 26, ; 252
	i32 239, ; 253
	i32 96, ; 254
	i32 27, ; 255
	i32 214, ; 256
	i32 306, ; 257
	i32 284, ; 258
	i32 145, ; 259
	i32 196, ; 260
	i32 165, ; 261
	i32 4, ; 262
	i32 97, ; 263
	i32 32, ; 264
	i32 92, ; 265
	i32 261, ; 266
	i32 184, ; 267
	i32 21, ; 268
	i32 40, ; 269
	i32 166, ; 270
	i32 300, ; 271
	i32 232, ; 272
	i32 292, ; 273
	i32 177, ; 274
	i32 246, ; 275
	i32 277, ; 276
	i32 271, ; 277
	i32 251, ; 278
	i32 2, ; 279
	i32 133, ; 280
	i32 110, ; 281
	i32 185, ; 282
	i32 312, ; 283
	i32 201, ; 284
	i32 309, ; 285
	i32 57, ; 286
	i32 94, ; 287
	i32 291, ; 288
	i32 38, ; 289
	i32 212, ; 290
	i32 25, ; 291
	i32 93, ; 292
	i32 88, ; 293
	i32 98, ; 294
	i32 10, ; 295
	i32 178, ; 296
	i32 86, ; 297
	i32 174, ; 298
	i32 99, ; 299
	i32 258, ; 300
	i32 175, ; 301
	i32 179, ; 302
	i32 278, ; 303
	i32 203, ; 304
	i32 288, ; 305
	i32 7, ; 306
	i32 243, ; 307
	i32 283, ; 308
	i32 200, ; 309
	i32 87, ; 310
	i32 238, ; 311
	i32 150, ; 312
	i32 287, ; 313
	i32 32, ; 314
	i32 115, ; 315
	i32 81, ; 316
	i32 20, ; 317
	i32 11, ; 318
	i32 158, ; 319
	i32 3, ; 320
	i32 192, ; 321
	i32 295, ; 322
	i32 187, ; 323
	i32 185, ; 324
	i32 83, ; 325
	i32 282, ; 326
	i32 63, ; 327
	i32 297, ; 328
	i32 265, ; 329
	i32 139, ; 330
	i32 183, ; 331
	i32 247, ; 332
	i32 153, ; 333
	i32 40, ; 334
	i32 116, ; 335
	i32 180, ; 336
	i32 202, ; 337
	i32 291, ; 338
	i32 254, ; 339
	i32 130, ; 340
	i32 74, ; 341
	i32 65, ; 342
	i32 301, ; 343
	i32 168, ; 344
	i32 206, ; 345
	i32 173, ; 346
	i32 139, ; 347
	i32 105, ; 348
	i32 147, ; 349
	i32 69, ; 350
	i32 152, ; 351
	i32 179, ; 352
	i32 120, ; 353
	i32 126, ; 354
	i32 296, ; 355
	i32 148, ; 356
	i32 229, ; 357
	i32 137, ; 358
	i32 216, ; 359
	i32 293, ; 360
	i32 20, ; 361
	i32 14, ; 362
	i32 134, ; 363
	i32 74, ; 364
	i32 58, ; 365
	i32 219, ; 366
	i32 163, ; 367
	i32 164, ; 368
	i32 190, ; 369
	i32 15, ; 370
	i32 73, ; 371
	i32 6, ; 372
	i32 23, ; 373
	i32 241, ; 374
	i32 200, ; 375
	i32 90, ; 376
	i32 294, ; 377
	i32 1, ; 378
	i32 197, ; 379
	i32 242, ; 380
	i32 264, ; 381
	i32 133, ; 382
	i32 68, ; 383
	i32 142, ; 384
	i32 303, ; 385
	i32 282, ; 386
	i32 233, ; 387
	i32 186, ; 388
	i32 87, ; 389
	i32 95, ; 390
	i32 223, ; 391
	i32 228, ; 392
	i32 298, ; 393
	i32 30, ; 394
	i32 44, ; 395
	i32 237, ; 396
	i32 183, ; 397
	i32 202, ; 398
	i32 108, ; 399
	i32 154, ; 400
	i32 34, ; 401
	i32 22, ; 402
	i32 113, ; 403
	i32 56, ; 404
	i32 262, ; 405
	i32 140, ; 406
	i32 117, ; 407
	i32 119, ; 408
	i32 109, ; 409
	i32 204, ; 410
	i32 199, ; 411
	i32 210, ; 412
	i32 53, ; 413
	i32 104, ; 414
	i32 304, ; 415
	i32 191, ; 416
	i32 192, ; 417
	i32 132, ; 418
	i32 276, ; 419
	i32 267, ; 420
	i32 255, ; 421
	i32 310, ; 422
	i32 233, ; 423
	i32 194, ; 424
	i32 155, ; 425
	i32 289, ; 426
	i32 220, ; 427
	i32 159, ; 428
	i32 131, ; 429
	i32 255, ; 430
	i32 157, ; 431
	i32 302, ; 432
	i32 244, ; 433
	i32 136, ; 434
	i32 267, ; 435
	i32 263, ; 436
	i32 165, ; 437
	i32 193, ; 438
	i32 205, ; 439
	i32 272, ; 440
	i32 39, ; 441
	i32 171, ; 442
	i32 231, ; 443
	i32 80, ; 444
	i32 55, ; 445
	i32 36, ; 446
	i32 96, ; 447
	i32 162, ; 448
	i32 168, ; 449
	i32 268, ; 450
	i32 81, ; 451
	i32 207, ; 452
	i32 97, ; 453
	i32 29, ; 454
	i32 155, ; 455
	i32 18, ; 456
	i32 126, ; 457
	i32 118, ; 458
	i32 227, ; 459
	i32 258, ; 460
	i32 240, ; 461
	i32 260, ; 462
	i32 161, ; 463
	i32 235, ; 464
	i32 317, ; 465
	i32 257, ; 466
	i32 248, ; 467
	i32 166, ; 468
	i32 16, ; 469
	i32 140, ; 470
	i32 295, ; 471
	i32 124, ; 472
	i32 117, ; 473
	i32 37, ; 474
	i32 114, ; 475
	i32 46, ; 476
	i32 138, ; 477
	i32 116, ; 478
	i32 33, ; 479
	i32 169, ; 480
	i32 94, ; 481
	i32 52, ; 482
	i32 249, ; 483
	i32 128, ; 484
	i32 149, ; 485
	i32 24, ; 486
	i32 157, ; 487
	i32 226, ; 488
	i32 144, ; 489
	i32 103, ; 490
	i32 88, ; 491
	i32 214, ; 492
	i32 59, ; 493
	i32 138, ; 494
	i32 99, ; 495
	i32 5, ; 496
	i32 13, ; 497
	i32 121, ; 498
	i32 134, ; 499
	i32 27, ; 500
	i32 290, ; 501
	i32 71, ; 502
	i32 224, ; 503
	i32 24, ; 504
	i32 212, ; 505
	i32 253, ; 506
	i32 250, ; 507
	i32 307, ; 508
	i32 198, ; 509
	i32 205, ; 510
	i32 221, ; 511
	i32 164, ; 512
	i32 254, ; 513
	i32 286, ; 514
	i32 100, ; 515
	i32 122, ; 516
	i32 225, ; 517
	i32 181, ; 518
	i32 159, ; 519
	i32 163, ; 520
	i32 228, ; 521
	i32 38, ; 522
	i32 189, ; 523
	i32 294, ; 524
	i32 173, ; 525
	i32 17, ; 526
	i32 167, ; 527
	i32 307, ; 528
	i32 306, ; 529
	i32 198, ; 530
	i32 146, ; 531
	i32 217, ; 532
	i32 151, ; 533
	i32 129, ; 534
	i32 19, ; 535
	i32 64, ; 536
	i32 143, ; 537
	i32 46, ; 538
	i32 314, ; 539
	i32 203, ; 540
	i32 78, ; 541
	i32 60, ; 542
	i32 105, ; 543
	i32 252, ; 544
	i32 207, ; 545
	i32 48, ; 546
	i32 238, ; 547
	i32 311, ; 548
	i32 249, ; 549
	i32 14, ; 550
	i32 180, ; 551
	i32 67, ; 552
	i32 167, ; 553
	i32 213, ; 554
	i32 217, ; 555
	i32 176, ; 556
	i32 316, ; 557
	i32 77, ; 558
	i32 222, ; 559
	i32 107, ; 560
	i32 206, ; 561
	i32 248, ; 562
	i32 66, ; 563
	i32 62, ; 564
	i32 195, ; 565
	i32 156, ; 566
	i32 215, ; 567
	i32 170, ; 568
	i32 10, ; 569
	i32 189, ; 570
	i32 11, ; 571
	i32 77, ; 572
	i32 125, ; 573
	i32 82, ; 574
	i32 182, ; 575
	i32 65, ; 576
	i32 106, ; 577
	i32 64, ; 578
	i32 127, ; 579
	i32 121, ; 580
	i32 76, ; 581
	i32 263, ; 582
	i32 253, ; 583
	i32 315, ; 584
	i32 8, ; 585
	i32 221, ; 586
	i32 2, ; 587
	i32 43, ; 588
	i32 266, ; 589
	i32 152, ; 590
	i32 127, ; 591
	i32 251, ; 592
	i32 0, ; 593
	i32 23, ; 594
	i32 132, ; 595
	i32 209, ; 596
	i32 240, ; 597
	i32 310, ; 598
	i32 292, ; 599
	i32 28, ; 600
	i32 208, ; 601
	i32 178, ; 602
	i32 196, ; 603
	i32 61, ; 604
	i32 191, ; 605
	i32 89, ; 606
	i32 86, ; 607
	i32 144, ; 608
	i32 193, ; 609
	i32 35, ; 610
	i32 85, ; 611
	i32 229, ; 612
	i32 305, ; 613
	i32 300, ; 614
	i32 181, ; 615
	i32 49, ; 616
	i32 6, ; 617
	i32 89, ; 618
	i32 312, ; 619
	i32 21, ; 620
	i32 158, ; 621
	i32 95, ; 622
	i32 49, ; 623
	i32 112, ; 624
	i32 245, ; 625
	i32 129, ; 626
	i32 75, ; 627
	i32 195, ; 628
	i32 222, ; 629
	i32 244, ; 630
	i32 7, ; 631
	i32 190, ; 632
	i32 109, ; 633
	i32 245, ; 634
	i32 231 ; 635
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ a8cd27e430e55df3e3c1e3a43d35c11d9512a2db"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
