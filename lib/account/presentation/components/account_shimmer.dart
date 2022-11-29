import 'package:flutter/cupertino.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:jdolh_flutter/core/utils/shimmer_effect.dart';

Column userAvatarShimmer() => Column(
      children: [
        ShimmerEffect.shimmerBox(width: 100, height: 100, borderRaduis: 100),
        vertical(10),
        ShimmerEffect.shimmerBox(width: 160, height: 20, borderRaduis: 100),
        vertical(5),
        ShimmerEffect.shimmerBox(width: 100, height: 15, borderRaduis: 100),
      ],
    );

Row followerFollowingCountShimmer() => Row(
      children: [
        Expanded(child: ShimmerEffect.shimmerBox(height: 98, borderRaduis: 15)),
        horizontal(4),
        Expanded(child: ShimmerEffect.shimmerBox(height: 98, borderRaduis: 15)),
        horizontal(4),
        Expanded(child: ShimmerEffect.shimmerBox(height: 98, borderRaduis: 15)),
      ],
    );
