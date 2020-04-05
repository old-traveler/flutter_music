import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/bloc/base_bloc.dart';
import 'package:music/components/input_dialog.dart';
import 'package:music/entity/song_list_entity.dart';
import 'package:music/entity/user_entity.dart';
import 'package:music/http/http_manager.dart';
import 'package:music/util/stream_manager.dart';
import 'package:music/util/toast_util.dart';
import 'package:provider/provider.dart';
import 'package:music/api/api_url.dart' as api_url;

class MyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyProfileState();
}

class MyProfileBloc with ResponseWorker {
  void _fetchSongList() {
    dealResponse<SongListEntity>(responseProvider: () {
      return HttpManager.getInstance().get(api_url.singListUrl);
    });
  }

  void _login(String name) {
    /// 执行登录请求
    dealResponse<UserEntity>(
        responseProvider: () {
          return HttpManager.getMockApi().get('login.json');
        },
        dataConvert: (data) => data..name = name);
  }
}

class MyProfileState extends State<MyProfilePage>
    with AutomaticKeepAliveClientMixin {
  MyProfileBloc _myProfileBloc = MyProfileBloc();

  @override
  void initState() {
    super.initState();
    _myProfileBloc._fetchSongList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InheritedProvider.value(
        value: _myProfileBloc.streamManager,
        updateShouldNotify: (o, n) => false,
        child: SingleChildScrollView(child: _buildContent()));
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        UserInfoWidget(_myProfileBloc),
        RibbonWidget(),
        _buildMyLikeWidget(),
        PromoteWidget(),
        SongListWidget(),
      ],
    );
  }

  Widget _buildMyLikeWidget() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Color(0xFFF4899D), borderRadius: BorderRadius.circular(5.0)),
        child: Image.asset(
          'images/like.png',
          width: 25,
          fit: BoxFit.fitWidth,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          '我喜欢',
          style: TextStyle(fontSize: 14),
        ),
      ),
      subtitle: Text('189首', style: TextStyle(fontSize: 12)),
      trailing: Icon(
        Icons.more_horiz,
        size: 15,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UserInfoWidget extends StatelessWidget {
  final MyProfileBloc _myProfileBloc;

  UserInfoWidget(this._myProfileBloc);

  Future _showLoginDialog(BuildContext context) async {
    String name = await showInputDialog(context, title: '登录', hint: '请输入用户名');
    if (name == null) {
      print('取消登录');
    } else if (name.isEmpty) {
      /// 点击确定未输入信息
      ToastUtil.show(context: context, msg: '用户名不能为空');
    } else {
      _myProfileBloc._login(name);
    }
  }

  Widget _buildInfo(BuildContext context, UserEntity data) {
    if (data?.name?.isEmpty ?? true) {
      return GestureDetector(
        child: Text(
          data?.name ?? '点击登录，享精准歌曲推荐',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        onTap: () {
          _showLoginDialog(context);
        },
      );
    }
    return _buildUserInfoWidget(data);
  }

  Widget _buildUserInfoWidget(UserEntity data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(data.name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        _buildVipTipWidget()
      ],
    );
  }

  Widget _buildVipTipWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          decoration: BoxDecoration(
              color: Color(0xffD7AF77),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Image.asset(
            'images/svip.png',
            height: 15,
            fit: BoxFit.fitHeight,
          ),
        ),
        SizedBox(width: 5),
        Image.asset(
          'images/king.png',
          height: 18,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartStatePage<UserEntity>(
        height: 100,
        initialData: UserEntity(),
        builder: (context, data) {
          return Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Image.asset(
                (data?.name?.isEmpty ?? true)
                    ? 'images/default_image.png'
                    : 'images/avtor.png',
                width: 60,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                width: 10,
              ),
              _buildInfo(context, data),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.mic_none),
                ),
              )
            ],
          );
        });
  }
}

class RibbonWidget extends StatelessWidget {
  final list = <ProfileItem>[
    ProfileItem('images/duv.png', '本地', '0'),
    ProfileItem('images/dux.png', '收藏', '0'),
    ProfileItem('images/duz.png', '下载', '0'),
    ProfileItem('images/dv4.png', '云盘', '0'),
    ProfileItem('images/dv6.png', '最近', '0'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      height: 165,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular((10.0))),
      child: Column(
        children: <Widget>[
          SizedBox(height: 15),
          _buildVipCenter(),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: Divider(height: 1),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildItem(),
            ),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }

  Widget _buildVipCenter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 20),
        Image.asset('images/vip.png', width: 21),
        SizedBox(width: 5),
        Text('会员中心',
            style: TextStyle(
                color: Color(0xffD7AF77), fontWeight: FontWeight.bold)),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '会员享受付费库下载特权',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                SizedBox(
                  width: 1,
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 15,
                  color: Colors.black54,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildItem() {
    List<Widget> widgets = [];
    for (var value in list) {
      widgets.add(Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              value.assetUrl,
              width: 40,
              height: 40,
            ),
            Text(
              value.name,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              value.count,
              style: TextStyle(color: Colors.black38),
            )
          ],
        ),
      ));
    }
    return widgets;
  }
}

class ProfileItem {
  String assetUrl;
  String name;
  String count;

  ProfileItem(this.assetUrl, this.name, this.count);
}

class PromoteWidget extends StatefulWidget {
  final textList = [
    '看得见的铃声，解锁来电新玩法',
    '都2020年了，不许你不知道这个识曲神器',
    '【乐舞雅集】二次元直播专场',
    '30个小时长续航，运动必备'
  ];

  @override
  State<StatefulWidget> createState() {
    return PromoteState();
  }
}

class PromoteState extends State<PromoteWidget> with WidgetsBindingObserver {
  Timer _timer;
  PageController _pageController;
  int _curIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController();
    _startAnimation();
  }

  void _startAnimation() {
    _timer?.cancel();
    const period = const Duration(seconds: 5);
    Timer.periodic(period, (timer) {
      _timer = timer;
      setState(() {
        _pageController.animateToPage(++_curIndex,
            duration: Duration(seconds: 1), curve: Curves.easeInOut);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _timer = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    /// 监听app前后台切换事件，避免无用计时器行为
    if (state == AppLifecycleState.paused) {
      print('取消_timer计时行为');
      _timer?.cancel();
    } else if (state == AppLifecycleState.resumed) {
      print('开启_timer计时行为');
      _startAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '推广',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 5,
          ),
          Image.asset(
            'images/broadcast.png',
            width: 20,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return _buildPromoteItem(index);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPromoteItem(int index) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.textList[index % widget.textList.length],
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}

class SongListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartStatePage<SongListEntity>(
        height: 400,
        isNoData: (data) => (data?.data?.info?.length == 0 ?? true),
        builder: (context, data) {
          final widgets = <Widget>[];
          widgets.add(Padding(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
            child: Text(
              '你可能感兴趣的歌单',
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ));
          for (var value in data.data.info) {
            widgets.add(ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              leading: Image.network(value.imgurl),
              title: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  value.filename,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Text(value.singername),
            ));
          }
          return Column(
            children: widgets,
            crossAxisAlignment: CrossAxisAlignment.start,
          );
        });
  }
}
