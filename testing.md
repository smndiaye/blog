## Automated code testing

### Table of Contents
  - [Is writing test code really needed ?](#is-writing-test-code-really-needed)
  - [What to test ?](#what-to-test)
  - [How to test ?](#how-to-test)
  - [Conclusion](#conclusion)
  - [References](#references)

<h3 id="is-writing-test-code-really-needed">Is writing test code really needed ?</h3>

**--> Why aren't we testing ?**

- we don't have time for writing test
  - can take as much time or even more time to write a test code than to implement it’s feature
  - deadline problem: let's release first then write test code later

- there is a test team they will find bugs manually

- don't know how to do testing 🤷‍♂️ 
  - a java developer will also have to learn JUnit, Mockito, ...
  - a rails developer should be familiar with Rspec
  but how many of us did take time to learn to use these frameworks correctly ?

- writing test is boring 🥱

- client said not to write test code: time costs money 💸. Do Project Managers even care about test code ? 🤔

- in some cases, writing test code will be a pain because of poor application design (no loose coupling)


**--> Problem**

![unit-testing](https://user-images.githubusercontent.com/15072227/92097755-671d8a80-ee13-11ea-9125-92632e3a049c.png) **ref. 1**

**--> What is the benefit of testing ?**

- forces code quality improvement when TDD is followed: think hard first by writing test code then start feature implementation
- finds bugs before production release: failing on CI is always better than failing on production
- facilitates code refactoring or dependencies upgrade
- provides another way to document your code: sometimes it is much easier to understand code base from the test code
- helps avoid implementation and money costs

**--> But does writing test code really safe us from bugs ?**

- what if the test code is passing but wrong ?
  - a wrong mock assumption
  - a loophole in the test logic

- are we even seriously reviewing test code ? 🤥  

<h3 id="what-to-test">What to test ?</h3>

![Page-7](https://user-images.githubusercontent.com/15072227/92103743-5b35c680-ee1b-11ea-8091-61190278f22d.png) Ok there are really good benefits of writing test code, but should we test everything ?
- 🙅‍♀️ It is almost impossible to test everything (100% test coverage) but at least important parts of the code base should be covered.

Looking at following go project architecture, we can decide that most of the work is done inside the `usecase layer` so we can be tempted to mainly focus on unit testing that part

![backend_go_arch](https://user-images.githubusercontent.com/15072227/92108744-d353ba80-ee22-11ea-8d0b-c62e0b6e9250.png)

![layers](https://user-images.githubusercontent.com/15072227/92109789-9dafd100-ee24-11ea-9e13-1406a4d78940.png)

- but what about the `repository layer` ? Is a query results less important than the logic using it ?
- what about the `handler layer` ? Can't a missed request parameter validation introduce a NPE bug in my `usecase layer` ?
- also are we safe not testing our routes ? Are all our routes ending up in proper handler ?
```
route.Put("/user/edit/{id}", user.Delete)
```

There is no one formula on what to test. It is really per project and feature based. Identifying critical parts and writing test code from router to DB call must be encouraged.

<h3 id="how-to-test">How to test ?</h3>

There are mainly 3 types of automated code testing

- Unit Testing: tests small piece of code that can be isolated
- Integration Testing: combines small pieces of code and tests them as a group
- E2E (End-to-End) Testing: replicates real user scenario and tests the whole system

E2E is difficult to achieve for complex web applications but tools such as [selenium](https://www.selenium.dev/documentation/en/introduction/), [katalon](https://www.katalon.com/homepage/?pk_abe=AB_testing_Homepage_08_2020&pk_abv=layout2),... can make it easy

**--> How to unit test ?**

- AAA: Arrange, Act, Assert
    
 ```
 int foo(int x, int y) {
     int z = 0;
     if (x > 0 && y > 0) {
         z = x;
     }
     return z;
 }

 void shouldReturnZero() {
   // given
   int x, y = 0;

   // when
   int z = foo(0, 0);

   // then
   assertEquals(z, 0);
 }
 ```

- test method name should be explicit: `shouldReturnZero`

- mocking/stubbing

When a method is depending on DB and/or external service(s), we should use a mock/stub instead of a real call.
The benefits of that would be fast CI setup, fast test running time, ...

```
void shouldSuccessfullyReturnUserList() {
    // given
    User userOne = new User(1L, "test_1@test.co.jp");
    User userTwo = new User(2L, "test_2@test.co.jp");

    // mock
    when(userRepository.findAll())
        .thenReturn(Arrays.asList(userOne, userTwo));

    // when
    UserListResponse response = userService.getUserList();

    // then
    assertEquals(2, response.getUsers.size());
}
```

🤔 But should we mock everything ?

  - there is a reported incident that a mocked external service call was in fact failing in real case because of wrong credentials
  - in some cases, you won't be able to make the external service return a specific scenario required by your test case: mocking would make sense then
  - sometimes, we are mocking to just escape CI setup burden or to avoid having our tests taking too much time to complete. 
    - when your tests are fully independent (they should be), running them in parallel can help significantly reduce the execution time. 
    - are we safe mocking all our repository layer because setting up a DB and running migration and/or seed data is a burden ?
    - what if a query fails for a certain real case scenario that we are not covering by mocking it

There is no standard way of unit testing. 
Some articles even state that all method calls inside a method to unit test should be mocked. Allowing external calls would mean doing integration test. 

**--> How deep are we testing ?**

When testing we should also care about covering all possible scenario
Following are coverage standards that can help you find the degree of which your system is tested

C0: every line of the source code is tested
C1: all control statement (if statement, switch cases, while loops, ...) branches are tested
C2: all conditions true and false scenario are tested

```
 int foo (int x, int y)
 {
     int z = 0;
     if ((x > 0) && (y > 0))
     {
         z = x;
     }
     return z;
 }
```

- any call of foo(x, y) satisfies C0
- foo(1, 1) satisfies C1
- foo(0, 1) and foo(1, 1) satisfy C2

Code coverage libraries like Jacoco can be used to force coverage rules in your projects. For example a specific service class or directory test can be set to only pass when above 80% coverage

Below is an example when using [danger-jacoco](https://github.com/Malinskiy/danger-jacoco)

```
jacoco.minimum_package_coverage_map = {
  'jp/co/my_project/api/controllers/' => 80,
  'jp/co/my_project/api/services/' => 80
}

jacoco.minimum_class_coverage_map = {
  'jp/co/my_project/api/controllers/' => 50,
  'jp/co/my_project/api/services/' => 50
}
```

Test results can also be posted as github comments. 

![cover](https://user-images.githubusercontent.com/15072227/92201713-39d6e800-eeb8-11ea-9b76-0df2c2d58346.png)

<h3 id="conclusion">Conclusion</h3>

- identify and always test critical parts of your system
- avoid excessive use of mocking: not all dependencies should be mocked
  - don't mock a scenario that can be satisfied with a real call
  - mock only when it helps achieving difficult scenario
  - if your CI takes time to test, think about running your tests in parallel
- test depth also matters
  - use tools such as danger-jacoco to force coverage rules
  - all tests should satisfy C1 && C2 

<h3 id="references">References</h3>

- 1 https://www.guru99.com/unit-testing-guide.html
- 2 https://enterprisecraftsmanship.com/posts/when-to-mock
- 3 https://www.youtube.com/watch?v=EZ05e7EMOLM
- 4 https://en.wikipedia.org/wiki/Code_coverage
