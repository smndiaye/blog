# Go Init

## Installation
### Set Paths:
```
export GOPATH=$GOPATH:$HOME/Documents/webdev/gokode  // for source code
export GOPATH=$HOME/Documents/webdev/golang // for libraries source code and binaries
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
```
### Install go
- brew install go
- brew install go@{version} // specific version
- brew unlink go // unlink current version
- brew link --force go@{version} // force link specific version

## Terminology
- package: collection of source files in the same directory that are compiled together.
  Functions, types, variables, and constants defined in one source file are visible to all other source files within the same package.

- module: collection of related Go packages that are released together

- a repository contains one or more modules

"A Go repository typically contains only one module, located at the root of the repository. A file named go.mod there declares the module path: the import path prefix for all packages within the module. The module contains the packages in the directory containing its go.mod file as well as subdirectories of that directory, up to the next subdirectory containing another go.mod file (if any)." 👉 [参考](https://golang.org/doc/code.html#Organization)

## Project Init
![serignembackendiaye_ML-00281noMacBook-Pro____Documents_webdev_gokode](https://user-images.githubusercontent.com/15072227/77771875-9d97f200-708a-11ea-9c29-14eb803ac9ba.png)

![serignembackendiaye_ML-00281noMacBook-Pro____Documents_webdev_gokode_src_github_com_smndiaye_jataay](https://user-images.githubusercontent.com/15072227/77771893-a1c40f80-708a-11ea-90d5-3f5bcf029475.png)

![serignembackendiaye_ML-00281noMacBook-Pro____Documents_webdev_gokode_src_github_com_smndiaye_jataay](https://user-images.githubusercontent.com/15072227/77772462-87d6fc80-708b-11ea-8045-df15e20b48b8.png)


## Project Structure
Let's say we want to make an app that handles student grades

### Flat
Go'ing simple is the easy option

```
sample/
 |-----handlers.go
 |-----main.go
 |-----models.go
 |-----repositories.go
```

🙅‍♂️but seriously only for demo app

### Group By Modules
```
sample/
 |-----grades
          |---handler.go
          |---grade.go 
 |-----subjects
          |---handler.go
          |---subject.go
 |-----users
          |---handler.go
          |---user.go
 |-----main.go
```

### Group By Domain

🌟DDD

[Good Summary](https://domainlanguage.com/wp-content/uploads/2016/05/DDD_Reference_2015-03.pdf) of **Domain-Driven Design: Tackling Complexity in the Heart of Software by Eric Evans**

- Domains: students management domain, subjects management domain, grade domain
- Entities: Student, Subject, Grade

      Student
         |
         |
      Subject
         |
         |
       Grade

- Services: IStudentService, ISubjectService, IGradeService
- Repositories: IStudentRepository, ISubjectRepository, IGradeRepository
- Domain Events:
    - CREATE/READ/UPDATE/DELETE student
    - CREATE/READ/UPDATE/DELETE student subject
    - CREATE/READ/UPDATE/DELETE student subject grade

```
sample/
|-----handlers
      |---grade.go 
      |---subject.go
      |---user.go 
|-----entities
      |---grade.go 
      |---subject.go
      |---user.go 
|-----repositories
      |---grade.go 
      |---subject.go
      |---user.go 
|-----services
      |---grade.go 
      |---subject.go
      |---user.go 
|-----main.go
```

### Clean Architecture
[https://medium.com/@eminetto/clean-architecture-using-golang-b63587aa5e3f](https://medium.com/@eminetto/clean-architecture-using-golang-b63587aa5e3f)

### A good way to start
🎬 [Ready, Go!](https://www.golang-book.com/books/intro)

### Play around with data types

- **Integers**
    - uint8: byte
    - uint16
    - uint32
    - uint64
    - int8
    - int16
    - int32: rune
    - int64

- **Machine dependent integers (size depends on the type of architecture)**
    - uint
    - int
    - uintptr

- **Floating Point Numbers**
    - float32
    - float64

- **Complex**
    - complex64
    - comple128
```
// var declaration then assignment
var i int
i = 10
	
// var declaration and assignment
var j int = 10
k := 10 // coooool
	
fmt.Println(i)
fmt.Println(j)
fmt.Println(k)
	
// binaries
var l int8 = 10 // 00001010
fmt.Printf("%b\n", l)
fmt.Println("l<<3", l<<3) // 00010100 00101000 01010000  = 10 * 2^3
fmt.Printf("%b\n", l<<3)
fmt.Println("l>>3", l>>3) // 00000101 00000010 00000001  = 10 / 2^3
fmt.Printf("%b\n", l>>3)
	
// complex
var m complex64 = 1 + 1i
var n complex64 = 1 + 2i
var o complex128 = 100 + 1i
var p complex128 = complex(3, 4)
	
fmt.Println("(1 + 1i) + (1 + 2i) ", m+n)
fmt.Printf("%v %T\n", o, o)
fmt.Printf("%v %T\n", real(n), imag(n)) // 1   float32
fmt.Printf("%v %T\n", real(o), imag(o)) // 100 float64
fmt.Printf("%v %T\n", imag(o), real(o)) // 1   float64
fmt.Printf("%v %T\n", p, p)             // (3+4i) complex128
```

👉 [string data type 参考](https://medium.com/rungo/string-data-type-in-go-8af2b639478)

```
s := "what a wonderful word"
	
fmt.Printf("%v, %T\n", s[3], s[3]) // 116, uint8  ==> Strings in Go are UTF-8 encoded by default
```

👉 [char encoding 参考](https://itnext.io/introduction-to-character-encoding-3b9735f265a6)

👉 [ASCII chart](https://www.asciichart.com/)

```
// String characters are valid ASCII characters, then each character occupies only 8 bits (a byte) in memory
	
fmt.Printf("%c, %T\n", s[3], s[3])                 // t, uint8
fmt.Printf("%v, %T\n", string(s[3]), string(s[3])) // t, string
fmt.Println("len(s)", len(s))                      // 21
	
s = "this is"
t := " a wonderful word"
u := s + " not" + t
fmt.Printf("%v, %T\n", u, u) // this is not a wonderful word, string
	
s = "enjoy"
v := []byte(s)
	
fmt.Printf("%v %T", v, v) // [101 110 106 111 121] []uint8
	
// strings are immutable
// s[0] = 'i' // cannot assign to s[0] (value of type byte)
w := []uint8{99, 97, 114}
x := string(w)
	
fmt.Println("string([]uint8{99, 97, 114})", x) // car
	
// rune: any UTF32 character, string: any UTF8 character
// 🥴 any valid UTF8 character is a valid UTF32 character
var r rune = 'r'
rr := 's'
fmt.Printf("%v %T\n", r, r)   // 114 int32
fmt.Printf("%v %T\n", rr, rr) // 115 int32
```	

### Enumerated Const iota

```
  const (
  _  = iota
  KB = 1 << (10 * iota) // 1 << (10 * 1) ==> 1 << 10
  // = 0100 0000 0000 = 2^10
  MB                    // = 2^20
  GB                    // = 2^30
  TB                    // = 2^40
  PB                    // = 2^50
  EB                    // = 2^60
  )
  
  func main() {
  fmt.Printf("%v %T\n", KB, KB) // 1024 int
  fmt.Printf("%v %T\n", MB, MB) // 1048576 int
  fmt.Printf("%v %T\n", GB, GB) // 1073741824 int
  fmt.Printf("%v %T\n", TB, TB) // 1099511627776 int
  }
```
	
```
const (
isSuperAdmin = 1 << iota // 1 << 0 ==> 0001
isAdmin                  // 1 << 1 ==> 0010
isSubAdmin               // 1 << 2 ==> 0100
isUser                   // 1 << 3 ==> 1000
)

func main() {
var roles byte = isAdmin | isSubAdmin
fmt.Printf("%b\n", roles) // 0110
fmt.Printf("is SuperAdmin ? %v\n", roles&isSuperAdmin == isSuperAdmin) // is SuperAdmin ? false
}
```

### Collection types
- Arrays
```
var roles = [2]string{"admin", "user"}
var languages = [...]string{"java", "go"}
fmt.Printf("%v\n", roles)       // [admin user]
fmt.Printf("%v\n", languages)   // [java go]

newLang := languages            // new array created
newLang[0] = "ruby"
newLang[1] = "python"
fmt.Printf("%v\n", languages)  // [java go]
fmt.Printf("%v\n", newLang)    // [ruby python]

newLangPtr := &languages       // point to same array
newLangPtr[0] = "ruby"
fmt.Printf("%v\n", languages)  //  [ruby go]
fmt.Printf("%v\n", newLangPtr) // &[ruby go]
```

- Slices

backed by arrays
```
var languages = []string{"java", "go"}
fmt.Printf("%v\n", languages) // [java go]

// slices are reference type
newLang := languages          // point to same array
newLang[0] = "ruby"
fmt.Printf("%v\n", languages) // [ruby go]
fmt.Printf("%v\n", newLang)   // [ruby go]
```

```
//                         0      1       2        3
var languages = []string{"java", "go", "python", "ruby"}
newLang := append(languages[:2], languages[3:]...) // append with spread operation
fmt.Printf("%v\n", languages[3:])                  // [ruby]
fmt.Printf("%v\n", newLang)                        // [java go ruby]
fmt.Printf("%v\n", languages)                      // [java go ruby ruby] 😱
```

- Maps
Maps are reference type


```
userAges := map[string]int{
"Aliou":  59,
"Lamine": 33,
}

userHeight := make(map[string]int)
userHeight = map[string]int{
"Aliou":  159,
"Lamine": 133,
}

fmt.Printf("%v\n", userAges)   // map[Aliou:59 Lamine:33]
fmt.Printf("%v\n", userHeight) // map[Aliou:159 Lamine:133]

delete(userAges, "Aliou")
fmt.Printf("%v\n", userAges) // map[Lamine:33]

aliouAge, isPresent := userAges["Aliou"]
fmt.Printf("%v\n", aliouAge)  // 0
fmt.Printf("%v\n", isPresent) // false

_, isPresent = userAges["Lamine"]
fmt.Printf("%v\n", isPresent) // true
```

- Struct
	
```
// Exportable
type User struct {
Name string
Age  int
}

// Not Exportable
type user struct {
name string
age  int
}

// Composition (Inheritance in GO: Go does not support inheritance)
type Admin struct {
User
roles []string
}

// Tags
type Dragon struct {
Weight int `required min: 4000`
}

func main() {

	// anonymous struct
	aUser := struct {
		name string
		age  int
	}{name: "Aliou", age: 18}
	fmt.Println(aUser) // {Lamine 18}
	
	// our User struct
	anotherUser := User{"Lamine", 18}
	fmt.Println(anotherUser) // {Lamine 18}
	
	// structs are value type not reference type
	anotherUserAgain := anotherUser
	anotherUserAgain.Name = "Modou"
	fmt.Println(anotherUser)      // {Lamine 18}
	fmt.Println(anotherUserAgain) // {Modou 18}
	
	// Composition
	admin := Admin{
		User{"Doudou", 20},
		[]string{"deleteROLE", "updateROLE"},
	}
	
	fmt.Println(admin)      // {{Doudou 20} [deleteROLE updateROLE]}
	fmt.Println(admin.Name) // Doudou
	fmt.Println(admin.Age)  // 20
}
```

### Defer, Panic, Recover

- Defer
```
// Prints:
// One
// Two
// Three
fmt.Println("One")
fmt.Println("Two")
fmt.Println("Three")

// Prints:
// One
// Three
// Two
fmt.Println("One")
defer fmt.Println("Two")
fmt.Println("Three")

// Prints in LIFO:
// Three
// Two
// One
defer fmt.Println("One")
defer fmt.Println("Two")
defer fmt.Println("Three")

// Prints value at time defer was called, so 'One'
a := "One"
defer fmt.Println(a)
a = "Two"
```

- Panic

No exception, error value returned instead

```
a, b := 1, 0
defer fmt.Println(a / b) // panic: runtime error: integer divide by zero

fmt.Println("One") // panic: Hell nooo
panic("Hell nooo") // panic: Hell nooo
fmt.Println("Two") // unreachable code
```

```
// panic happens after defer
// One
// Two
// panic: Hell nooo
fmt.Println("One")
defer fmt.Println("Two")
panic("Hell nooo")
fmt.Println("Three") // unreachable code
```

- Recover

👉 [Better call Saul](https://blog.golang.org/defer-panic-and-recover)

### Pointers
### Functions
### Methods
### Interfaces

### lii loumou
```
func makeEvenGenerator() func() uint {
i := uint(1)
fmt.Println("i outside", i)

	return func() (ret uint) {
		ret = i
		fmt.Println("i inside ", i)
		i += 2
		return
	}
}

func main() {
nextEven := makeEvenGenerator()
fmt.Println(nextEven()) // 1
fmt.Println(nextEven()) // 3
fmt.Println(nextEven()) // 5
}
```
