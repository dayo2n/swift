func foo() -> Int{
  var aaa = 1 + 2
  aaa = aaa + 3
  if aaa == 3 { aaa = 4 }
  return aaa
}

func foo1() -> Int { return 0 }
class C { func foo() {} }
struct S { func foo() {} }


// RUN: %target-swift-ide-test -range -pos=8:1 -end-pos 8:32 -source-filename %s | %FileCheck %s -check-prefix=CHECK1
// RUN: %target-swift-ide-test -range -pos=9:1 -end-pos 9:26 -source-filename %s | %FileCheck %s -check-prefix=CHECK2
// RUN: %target-swift-ide-test -range -pos=10:1 -end-pos 10:27 -source-filename %s | %FileCheck %s -check-prefix=CHECK3
// RUN: %target-swift-ide-test -range -pos=3:1 -end-pos=4:26 -source-filename %s | %FileCheck %s -check-prefix=CHECK4
// RUN: %target-swift-ide-test -range -pos=3:1 -end-pos=5:13 -source-filename %s | %FileCheck %s -check-prefix=CHECK5
// RUN: %target-swift-ide-test -range -pos=4:1 -end-pos=5:13 -source-filename %s | %FileCheck %s -check-prefix=CHECK6

// CHECK1: <Kind>SingleDecl</Kind>
// CHECK1-NEXT: <Content>func foo1() -> Int { return 0 }</Content>
// CHECK1-NEXT: <Declared>foo1</Declared>
// CHECK1-NEXT: <end>

// CHECK2: <Kind>SingleDecl</Kind>
// CHECK2-NEXT: <Content>class C { func foo() {} }</Content>
// CHECK2-NEXT: <Declared>C</Declared>
// CHECK2-NEXT: <end>

// CHECK3: <Kind>SingleDecl</Kind>
// CHECK3-NEXT: <Content>struct S { func foo() {} }</Content>
// CHECK3-NEXT: <Declared>S</Declared>
// CHECK3-NEXT: <end>

// CHECK4: <Kind>MultiStatement</Kind>
// CHECK4-NEXT: <Content>aaa = aaa + 3
// CHECK4-NEXT: if aaa == 3 { aaa = 4 }</Content>
// CHECK4-NEXT: <Declared>foo</Declared>
// CHECK4-NEXT: <Referenced>aaa</Referenced>
// CHECK4-NEXT: <Referenced>+</Referenced>
// CHECK4-NEXT: <end>

// CHECK5: <Kind>MultiStatement</Kind>
// CHECK5-NEXT: <Content>aaa = aaa + 3
// CHECK5-NEXT: if aaa == 3 { aaa = 4 }
// CHECK5-NEXT: return aaa</Content>
// CHECK5-NEXT: <Declared>foo</Declared>
// CHECK5-NEXT: <Referenced>aaa</Referenced>
// CHECK5-NEXT: <Referenced>+</Referenced>
// CHECK5-NEXT: <Referenced>==</Referenced>
// CHECK5-NEXT: <end>

// CHECK6: <Kind>MultiStatement</Kind>
// CHECK6-NEXT: if aaa == 3 { aaa = 4 }
// CHECK6-NEXT: return aaa</Content>
// CHECK6-NEXT: <Declared>foo</Declared>
// CHECK6-NEXT: <Referenced>aaa</Referenced>
// CHECK6-NEXT: <Referenced>==</Referenced>
// CHECK6-NEXT: <end>
