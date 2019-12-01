/*
集合类型

*/

class Three {
  static void run() {
    //1 List类型
    List<String> names = ["az", "ss", "ccc", 'ss'];

//2 Set类型： {元素1， 元素2...}
//元素不可重复
//应用：对List去重
    Set<int> nums = {111, 121, 111, 131};
    print(nums);

//3 Map类型 {key/value}
    Map<String, dynamic> myMap = {
      "name": "aaa",
      "age": 12,
      "height": 1.2,
    };

  }
}
