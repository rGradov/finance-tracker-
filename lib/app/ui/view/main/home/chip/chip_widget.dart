import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';
class CustomChip extends StatelessWidget {
  const CustomChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>const _ChipWrapper();
}

///как это должно работать у нас есть билдер метод который отрисует нужное количетсво
///элементов затем мы берем ширину родителя и делим на количество элементов, после
///этого по нажатию на текущий элемент получаем currentIndex значение и позицию
///виджета умнажаем на currentIndex, тем самым мы получаем центральную точку ге
///находится нужный виджет, В иделае повторить контроллер, затем в блок запихать контроллер
///и после этого иметь доступ к данным
///
class _ChipWrapper extends StatelessWidget {
  const _ChipWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (_,constraint){
          debugPrint((constraint.maxWidth/4).floor().toString());
          return _ChipRename(constraints: constraint,count: 4,);
        },
      ),
    );
  }
}

class _ChipRename extends StatefulWidget {
  final BoxConstraints constraints;
  final int count;
  const _ChipRename({Key? key,
    required this.count,
    required this.constraints}) : super(key: key);

  @override
  _ChipRenameState createState() => _ChipRenameState();
}

class _ChipRenameState extends State<_ChipRename> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 0,end:widget.constraints.maxWidth.toDouble()).animate(_animationController);
    super.initState();
  }
  void _animateTo(){

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: ()=>debugPrint('vv'),
          child: Container(
            width: widget.constraints.maxWidth/widget.count,
            height: 25,
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius:  BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const[
            _UnActiveChip(text: 'Today',),
            _UnActiveChip(text: 'Week',),
            _UnActiveChip(text: 'Month',),
            _UnActiveChip(text: 'year',),
          ],
        ),
      ],
    );
  }
}

class _UnActiveChip extends StatelessWidget {
  final String text;
  const _UnActiveChip({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,style: TextStyle(color: AppColor.baseLight[20]),
    );
  }
}
/// Create custom controller
class ChipController extends ChangeNotifier {
  final int initialIndex;
  final int count;
  AnimationController _animationController;
  AnimationController get controller =>_animationController;
  /// by default initial index is 0
  ChipController({this.initialIndex=0,required this.count,required TickerProvider vsync}):
        _animationController = AnimationController.unbounded(
    value: initialIndex.toDouble(),
    vsync: vsync,
  );
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

}
