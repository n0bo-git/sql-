# 01 系统开发架构
前后端分离开发：**前端、后端、数据库各自独立，分别跑在不一样的端口之上，各自之间通过各自的技术手段进行联系，从而对整体的功能进行整合。**

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751695780812-78c4d47c-43b4-4614-876c-5cdeeb5fd14f.png" width="540.5714285714286" title="" crop="0,0,1,1" id="u265678c2" class="ne-image">

图1：前后端分离开发架构图

+ 前端跟后端之间，通过http协议，进行网络交互。后端通过SpringMVC进行接口层（视图层）开发。前端使用Axios作为网络交互技术（这是一个第三方网络请求框架，封装的Ajax）。
+ 后端跟数据库之间，通过MybatisPlus（是Mybatis的增强）持久化框架进行交互。

# 02 后端项目结构
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751696923050-07eb5e46-f4e8-4012-8cc3-5e8dd3dac314.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u00ba926c" class="ne-image">

## file：存放项目图片的地方
我的一些项目，存的是pic

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751697105242-07b6d753-7e89-4205-b7c8-92c83e802234.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u016fb3c7" class="ne-image">

后端的SpringBoot框架使用到的应用服务器是Tomcat（9.0.30），一些涉及图片上传的场景，图片资源上传至内嵌的Tomcat里面，会返回图片在Tomcat里面相对的缓存数据，凭着这个链接就可以访问到这张图片。好处就是操作简单，无额外的成本支出；坏处就是加剧服务器的压力，容易失效。

## aop：使用AOP技术及切面开发的功能类所在
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751697424397-8ed59a3f-cb26-4bd4-a1ec-241afef2d99a.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u3828cd3e" class="ne-image">

Pager注解配合PagerAspect分页切面类实现分页参数的自动化转换。

## Web配置类
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751697941264-d058e9a1-0257-4d90-b429-4e5a3a39f3c4.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u8ab4fec2" class="ne-image">

WebConfig：后端配置跨域的地方。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751698112062-61712edf-4192-47e4-ba5c-f46d42dfde1f.png" width="956" title="" crop="0,0,1,1" id="uf77931d6" class="ne-image">

## context包：本地线程配置类所在
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751698217703-b59f16ab-aeaa-4bba-b552-44db26ea0f20.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u3e5156a7" class="ne-image">

<font style="color:#080808;background-color:#ffffff;">LocalThreadHolder：本地线程，即存放在本地线程的数据，在线程执行各个环节中都可以共享使用其中存储的数据。</font>

## <font style="color:#080808;background-color:#ffffff;">controller：接口层</font>
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751698337732-11f76e7f-3415-4505-912e-3b748ea5d568.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u94e0c5ce" class="ne-image">

controller：后端开发出来的功能，要暴露给外界进行使用（调用），所以我们需要去写对外暴露出来的这些“口子”，使得前端能够通过http协议访问到咱们开放出来的这些功能接口，从而使用到咱们写好的一项项功能。这些“口子”，就是在controller包下写的。所以**通常我们会把controller称之为控制器层、接口层、视图层**。**这些暴露出来的“口子”，我们称之为接口，也叫API（行话）。**

## **exception：异常配置**
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751698695039-13e88f01-e3bd-4764-9ae0-cc56bbf5c40c.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u7da9bdb0" class="ne-image">

exception：下面有两个类，一个是全局异常处理，一个是细分的业务异常处理，下文会专门有一节课进行介绍描述，这里不做过多拓展了。

## interceptor：拦截器
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751698935247-42fa9290-f82b-4db3-85df-073ba421cfe9.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u289030bf" class="ne-image">interceptor：“拦截器”配置所在的包，什么叫拦截器，可以理解为后端项目的“防火墙”，可以在外界访问后端API之前，进行必要的校验验证等操作。

## mapper：持久层
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751699216479-25685a40-d4f1-4715-a71c-cc4566440e84.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ubd1eff56" class="ne-image">

mapper：所谓的持久层，就是**跟数据库打交道的，定义好持久化接口之后，写对应的xml文件或者通过注解的方式进行对应，声明好去数据库里面哪张表做什么操作、得到什么结果。**

## **pojo：后端实体存放的包**
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751699398449-ae539ddf-beae-4c7b-b774-da851c60a424.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ue6b8cd03" class="ne-image">

+ api：定义了后端统一的响应返回类。
+ dto：一般就是存放后端接口层从前端需要接收的参数类。
+ em：枚举类的包。
+ entity：实体类所在的包。Java是一门面向对象的开发语言，咱们使用的MySQL（关系型数据库）数据库，设计出来的各种表需要有实体与之对应，entity包下的这些实体，就是与数据库表对应的。
+ vo：一般就是定义返回前端的数据对象，通常就是需要返回的数据存在外键以外的拓展表信息时需要定义。

## service：业务逻辑层
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751700212698-277d1adb-1e01-4493-8b87-8d6d4ef46553.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ub2ad8ef3" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751700404664-b8bbd8b7-4da5-4056-b351-5d37574b7341.png" width="828.5714285714286" title="" crop="0,0,1,1" id="uf017cdfa" class="ne-image">

+ 一般来说，后端就是分的controller、service、mapper三层
+ controller（接口层）：负责前端请求的接收与响应。
+ service（业务逻辑层）：负责业务逻辑处理，往往就是接收controller传递过来的参数、调用mapper持久化层完成各种不一样的逻辑处理，处理完成再转发回controller，controller再转发回前端。
+ mapper（持久化层）：负责与数据库打交道。往往一个业务功能的本质就是对于不同数据的增删改查。

## utils：工具类存放的包
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751700782787-a9fba241-a815-4d77-a27e-29c09c26bf9d.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u29c9dde5" class="ne-image">

## application.yml：后端配置文件
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751700898904-0ebdbbec-8b1c-4281-9188-06e509c1ee75.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u1e3ca714" class="ne-image">

# 03 后端 - 通用返回封装类ApiResult
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751702543373-bbfee27a-04d5-4ed4-bdaa-54a9c7b23d6d.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u465cac41" class="ne-image">

## ApiResult：后端响应通用返回封装类
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751702778196-9b51f0f4-8e17-414b-8226-e369223f3275.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ue3cf80ea" class="ne-image">

ApiResult继承了Result响应基类，所以拥有了两项基础的属性：响应码、响应消息，除此之外自己也拓展出来的两项属性：响应消息（这个就是后端需要返回前端的数据了）、数据总项。**ApiResult里面的泛型设计，需要着重理解，所谓泛型就是说设计的时候，我并不限制只能装什么类型，等你使用的时候给我指定就行了，好处就是高度灵活。使用泛型设计以及方法重载，使得后端统一了返回前端的响应数据、后端可以返回任意数据类型的响应数据。**

## Result：后端响应通用返回封装类基类
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703331033-86e96ed4-cf15-411d-9628-a6c876df6150.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uc82a5a91" class="ne-image">

定义了响应码以及响应消息，方便子类直接集成使用、复用。

## ResultCode：后端响应通用响应码
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751702652180-17fb4d0b-c8ef-4b56-a8a5-df6eab2782d7.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u1d2e3309" class="ne-image">

定义了两种状态码，一种是成功，此时的状态码是200；另一种是失败，此时的状态码是400。

# 04 后端 - JWT鉴权全流程
## 什么是JWT？
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703663220-b3cb0c1e-fe19-4803-945d-f798913e011d.png" width="933.1428571428571" title="" crop="0,0,1,1" id="u4a0bef9b" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703683245-76744607-ba04-46af-8a42-555780f80699.png" width="821.1428571428571" title="" crop="0,0,1,1" id="u77c2806a" class="ne-image">

## JWT技术在项目中的使用流程
### 前端调试流程
第一步，用户在登录页，填写了账号密码之后，点击“立即登录”

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703863103-c43a3bfb-d57a-403d-8292-0b94d8ba89a8.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u4c289c15" class="ne-image">

第二步，为了方便调试，打开控制台，点击“网络”，找到登录API并调试。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703908121-fdbe8f2b-8e57-4780-8044-ea22972e5d86.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u91d30974" class="ne-image">

第三步，通过请求里面的“载荷”可知，本次登录携带的参数：账号（accounting）、密码（password）

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703912887-6939bdac-5ec2-4512-8781-7bbc50ba95ca.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u048aa960" class="ne-image">

第四步，通过响应可知本次登录请求后端响应的数据，里面data数据项的token属性就是JWT生成Token。

```java
{
    "code": 200,
    "message": "登录成功",
    "data": {
        "id": 1,
        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwicm9sZSI6MSwic3ViIjoi55So5oi36K6k6K-BIiwiZXhwIjoxNzUyMzA4Njc2LCJqdGkiOiJkZmVmN2M0OS1hYzUwLTQ3ZDctODIxNi0xY2ZlNWM1ZGNhZmUifQ.qohJG37IA1BhpW-ywoFbKJyoIG_KOCZo4yL2cELTL8w",
        "role": 1
    },
    "total": null
}
```

:::color5
此时data里面的id是用户的ID、token就是登录之后生成的令牌，里面有用户的ID以及角色、role是用户角色，前端通过这个角色知道他是哪个用户角色，从而应该跳转什么功能页面。

:::

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703912622-89c14dd5-53a0-450b-acda-c82fb1420566.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u844e8da8" class="ne-image">

### 后端实现原理
#### 生成过程
前端登录请求到达用户控制器里面的登录API接口之后，转发至UserServiceImpl.java用户业务逻辑接口实现类里面的登录方法进行处理。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703963880-a1095cac-c732-414a-8433-dc1025b04ec0.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u9325eaab" class="ne-image">

在登录方法里面，经过各种校验：**非空校验、用户身份有效性校验、密码校验**，全部都通过校验之后，调用**<font style="color:#080808;background-color:#ffffff;">String token = JwtUtil.toToken(user.getId(), user.getRole());</font>**<font style="color:#080808;background-color:#ffffff;">这一样代码生成Token，传进去的参数有用户ID、角色ID。</font>

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703999708-badb6f25-e1c3-4195-80d3-f38c2f2ec2db.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u1caf35fc" class="ne-image">

JwtUtil就是生成Token以及解析Token的地方。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751703815593-37f3e665-a9c0-4627-8bea-08ca3f9b7ad1.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uc7b52a95" class="ne-image">

#### 解析过程
用户登录成功之后，将生成回来的Token存储至浏览器里面的LocalStorage里面。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751705174945-18230cce-8bd6-4005-98d6-2763c41e8e54.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uc8385b42" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751705090746-95ad265e-9c98-4435-ad54-c887da99b5b5.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uab92fc01" class="ne-image">

在后续的网络请求中，通过getToken可以取出存在localStorage里面的token，并设置在http协议的头部，跟着请求一起到达后端。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751705082502-04b71784-b3ba-4e0b-87d6-5bdbe4044b13.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uf3023365" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751705103537-d008779b-12f8-424d-b2b8-9e2adcba75d8.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u7d68be8a" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751705077899-6a75081d-41e4-4751-b902-cded57023601.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ub70d9f02" class="ne-image">

请求到达后端，进去控制器（controller）之前，拦截器拦截了下来。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751705326473-14be7a23-6113-4f8a-b0d1-f633d3c87ed3.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ud51c8244" class="ne-image">

取出token之后，如果校验不通过，直接就是返回了，进不去后端。如果进去之后，证明Token校验成功了，此时你的这个token要调用**JwtUtil.fromToken（token）**方法解析**Token**，从里面拿出存储进去的用户ID以及用户角色。再把这个用户ID以及用户角色去存储至本地线程里面（**LocalThreadHolder.java**），此时这个用户ID就是当前操作对应功能的用户身份ID。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751705420894-5522215e-30bd-4ca1-ac92-8dc0a68799bb.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u4e9ff9ea" class="ne-image">

### 某些API接口不需要鉴权怎么办？
很简单，只需要在JwtInteceptor.java里面，在需要放行的路径里面写下对应API接口即可。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751705757376-d7902f33-7f42-4eb1-af5e-2728ae6634a1.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ucf572f99" class="ne-image">

放行的接口，不能通过这种方式去取得当前操作者的用户ID。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751705952781-9a2e46c8-61f7-4fab-adc5-b81d9c7b68e4.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uf23d7794" class="ne-image">

# 05 后端 - 全局异常处理
## BusinessException.java业务异常类
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751706859648-ff36c2ba-ac42-4989-b5f3-ff082c5f5145.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u77b3dea0" class="ne-image">

## GlobalException.java全局异常类
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751706876547-48c48add-1cc0-435b-a071-64770215bc2b.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uedfeaf47" class="ne-image">

## AssertUtils.java断言工具类
业务异常以及全局异常要配合AssertUtils.java进行使用

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751707261512-1183f1dc-8f5a-4c4f-9973-8174607b3ff1.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ub52e649c" class="ne-image">

根据待校验数据类型，选用里面不一样的静态方法，非常丝滑。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751707251630-570ce8ac-b3bc-476d-aad3-3cbc558a3474.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ua91e8154" class="ne-image">

思路总结：**首先定义了BusinessException.java业务异常类，同时定义了GlobalException.java全局异常类，在全局异常类里面捕获BusinessException.java业务异常类，再配合断言工具类进行处理即可。**

# 06 后端 - 各种注解的作用
## <font style="color:#080808;background-color:#ffffff;">@RestController注解与@RequestMapping注解</font>
<font style="color:#080808;background-color:#ffffff;">@RestController注解的作用就是把我们写的类变成控制器层，@RequestMapping注解的作用就是将我们设置的path路径与对应的类法联系起来。</font>

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751708585939-971ecad6-7ee8-444a-8710-05bd76d06b8e.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uca39a5f8" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751708793002-86a82f87-18b7-48f9-9445-dbc62f14dd2b.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u8bb05c0d" class="ne-image">

## <font style="color:#080808;background-color:#ffffff;">@Resource注解与@Autowired注解</font>
两个注解都可以注入功能类进行使用，区别就是<font style="color:#080808;background-color:#ffffff;">@Resource注解是Java提供的，@Autowired注解是Spring框架提供的，底层的实现原理有所区别：</font>

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751709080397-9f715b6c-1c55-4ba8-ac07-ad394358a9a2.png" width="984" title="" crop="0,0,1,1" id="u78d4ec48" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751708915543-afab4f38-342c-4cf9-95c6-19236dda2485.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ue3d246bd" class="ne-image">

## <font style="color:#080808;background-color:#ffffff;">@DeleteMapping注解、@GetMapping注解、@PutMapping注解、@PostMapping注解、@ResponseBody注解、@RequestBody注解</font>
+ <font style="color:#080808;background-color:#ffffff;">@DeleteMapping注解：放置在控制器的方法之上，此时通过里面指定的value值绑定路径，也就意味着通过控制器路径再加上方法路径，可以具体定位至这个API接口。同时，要求此API接口必须用delete请求方式才能去进行调用。</font>**<font style="color:#080808;background-color:#ffffff;">一般就是应用于删除的API请求场景。</font>**
+ <font style="color:#080808;background-color:#ffffff;">@GetMapping注解：放置在控制器的方法之上，此时通过里面指定的value值绑定路径，也就意味着通过控制器路径再加上方法路径，可以具体定位至这个API接口。同时，要求此API接口必须用get请求方式才能去进行调用。</font>**<font style="color:#080808;background-color:#ffffff;">一般就是应用于查询的API请求场景。</font>**
+ <font style="color:#080808;background-color:#ffffff;">@PutMapping注解：放置在控制器的方法之上，此时通过里面指定的value值绑定路径，也就意味着通过控制器路径再加上方法路径，可以具体定位至这个API接口。同时，要求此API接口必须用put请求方式才能去进行调用。</font>**<font style="color:#080808;background-color:#ffffff;">一般就是应用于修改的API请求场景。</font>**
+ <font style="color:#080808;background-color:#ffffff;">@PostMapping注解：放置在控制器的方法之上，此时通过里面指定的value值绑定路径，也就意味着通过控制器路径再加上方法路径，可以具体定位至这个API接口。同时，要求此API接口必须用Post请求方式才能去进行调用。</font>**<font style="color:#080808;background-color:#ffffff;">一般就是应用于新增、查询的API请求场景。</font>**
+ <font style="color:#080808;background-color:#ffffff;">@ResponseBody注解：将后端返回的响应数据实体对象，转换成JSON数据并返回前端。</font>

:::success
Restful

:::

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751709419828-cd8a0e5f-b29c-4708-99ca-2d2afa465efa.png" width="977.1428571428571" title="" crop="0,0,1,1" id="u1c123576" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751709142693-23385c81-d09d-437a-b19e-f9b1317daf05.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u6c9e77a0" class="ne-image">

<font style="color:#080808;background-color:#ffffff;">关于@ResponseBody注解，比如现在对于查询用户数据（“/user/query”）接口，返回的是Result<List<User>>后台通用返回封装类，但是前端拿到的响应的JSON字符串，就是加了这个注解之后，SpringMVC框架帮我们进行的转换，任何其他API接口都是一样。</font>

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751709706215-998664c7-0685-49dd-88e8-6ebd2d233b92.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u851363d3" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751709775953-4c2a021f-9722-426a-a3de-4d6b5ac012ec.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ub1569af8" class="ne-image">

<font style="color:#080808;background-color:#ffffff;">关于@RequestBody注解，作用就是前端传过来的参数JSON字符串，就是加了这个注解之后，SpringMVC框架帮我们转换后端对应的Java实体对象。</font>

## <font style="color:#080808;background-color:#ffffff;">@PathVariable注解</font>
拿到接口请求路径上面携带的参数

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751709952951-2d51c691-82a6-4fbe-a62b-545543c57c51.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uca9aa1be" class="ne-image">

## @Service注解跟@Mapper注解与<font style="color:#080808;background-color:#ffffff;">@Component注解</font>
都是声明目标类是一个Bean，并托管给Spring管理器生命周期。

# 07 调通一个功能
前端：在所在的功能页面处，打开控制台页面，切换至网络 -> 去重复你的页面操作 -> 针对已经出现的网络请求，查看它的完整执行情况（**表头、载荷、响应**）-> 后端：通过请求执行情况，能够定位出功能对应的控制器（controller）、业务逻辑层（service）、持久化层（mapper）

以管理员后台【用户管理】页面为例，现在计划调试“**用户列表查询**”功能。其他的功能，都是这样的调试过程。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751719314698-ef0a1d27-7e70-4174-b69f-1d6ab0ed1e54.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u91fdece6" class="ne-image">

在界面上，鼠标右键，选中“检查”，然后切换至“网络”项。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751719345659-cccc9195-33ba-43fe-ba99-c27390ee174b.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u4d8423e0" class="ne-image">

重复你的“功能操作”，比如现在要调试的是用户列表数据查询，重新切换Tab页让它再次请求即可。

请求出来之后，点击进去具体的请求，三个部分需要重点关注：

+ 标头：标头就是http协议的请求头。标头的部分，通过请求URL定位后端的功能控制器；请求的方法就是该控制器里面定义的接口需要用怎么的请求方式去交互。
+ 载荷：本次请求通过http协议转送至后端什么样的数据（JSON字符串）。
+ 响应：本次请求后端返回了怎么的数据。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751719479234-fbe76d91-fca8-4463-8a7b-aa55d7762cda.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u68705791" class="ne-image">

通过路径/user找到控制器：

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751719825949-e67a61e8-b3ff-4c0a-a4ad-c1243d6cbe30.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u413ab964" class="ne-image">

IDEA里面，通过快捷键“**Ctrl Shilf F**”检索“/user”路径出现的地方，很快就可以定位出UserController里面定义了这个路径。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751719868915-ff584de7-7232-4b70-99fc-85f7e8726533.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u9c947628" class="ne-image">

找到了控制器所在，剩下的路径是“/query”，在UserController.java代码页面里面，使用“**Ctrl F**”快捷键在文件里面快速定位出来指定的API接口。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751719971111-db2ce4a0-ccf5-4cf5-8a83-875d8760d18f.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u1030efd6" class="ne-image">

输入关键路径之后，点击箭头所示往下面切换就可以了，API接口顺利找到。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751720051910-71e3e639-0b02-4ac3-85f5-05165f3a34f2.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uf254ce76" class="ne-image">

找到API接口之后，捕捉关键信息。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751720339050-3f9a5696-ddbc-460e-95f1-bc74ccf9fdff.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u29e7e4cc" class="ne-image">

继续往下面寻找，顺利找到该用户列表信息查询的业务逻辑实现方法。**此时，如果这个代码比较复杂，你完全看不懂，请复制这个方法的代码丢进去AI（DeepSeek），辅助理解。**同时顺利找到业务逻辑所关联的所有mapper层方法，以及依赖的数据库相关信息。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751720373654-311b14d5-4aeb-4aa9-a1b7-88657fe650b4.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ue96b94eb" class="ne-image">

# 08 API调试之ApiPost
这是它的站点：

[Apipost-API 文档、设计、调试、自动化测试一体化协作平台](https://www.apipost.cn/)

下载安装之后，登录之后，点击新建 -> 新建项目

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751722645262-df7c71ae-83e3-4710-8285-0c2d3f36fef7.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ub1a091c5" class="ne-image">

在项目里面，点击“新建”，选中“HTTP”。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751722798096-88410767-76a7-474d-a356-1a41d8cc2f06.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u751cec06" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751723117492-d6d1215c-557e-4056-b585-320cf938bf24.png" width="1462.857142857143" title="" crop="0,0,1,1" id="yfhJy" class="ne-image">

API接口信息逐一填写：

1. 接口描述：描述好本接口是做的什么操作就行。
2. 请求方式，根据API定义时的请求方式来。即将要调试的接口上面使用的是PostMapping，所以选中post请求。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751723377440-ccf1ece1-b4a6-46bf-88bb-79b7f153d06f.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ub58118bc" class="ne-image">

3. 接口的地址，参照application.yml文件里面确认。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751723314476-25ec66c4-6bc1-4ed0-99eb-a0a154d3d713.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u8a5375c6" class="ne-image">

4. 选中Body，选中raw，在里面填写请求参数的JSON。

一些需要鉴权的接口，请在Header里面设置对应的Token。

需要认证的接口，获取Token之后，设置参数名为Authorization，参数值设置为Bearer 【Token值】，记住中间是隔有空格的。

:::color1
注意，我的旧的项目，token就是token，是不需要在token前面加这个Bearer 空格的，具体看后端的JwtInteceptor.java类

:::

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751723633405-5bc08717-353c-4296-ac61-225cb120e866.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u93ff3f7f" class="ne-image">

获取Token的两种方式：

1. 用户登录之后，通过控制台获取。

:::success
localStorage.getItem("token");

:::

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751723573536-487a915f-9097-490a-a9f3-c5c81b7a7739.png" width="1462.857142857143" title="" crop="0,0,1,1" id="JPxeq" class="ne-image">

2. 去登录页面调试登录请求，登录成功之后也会返回。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751723835670-def0cae7-76ff-401d-b6ac-9bc96cc5128b.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u77625b0a" class="ne-image">

Token设置上之后，顺利调试。

:::tips
【调试时请注意】，我的原始的项目，key是叫token。具体要在后端JwtInteceptor.java类里面看！看看token名是叫token还是Authorization 

:::

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751723863153-59617f2e-ab5f-4d17-be09-a6ccc2b03fac.png" width="1462.857142857143" title="" crop="0,0,1,1" id="ub83eba69" class="ne-image">

# 09 脚手架数据库讲解
## 用户表（user）
```java
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `account` varchar(50) DEFAULT NULL COMMENT '用户账号',
  `username` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `password` varchar(100) DEFAULT NULL COMMENT '用户密码',
  `avatar` text COMMENT '用户头像',
  `email` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
  `role` int(11) DEFAULT NULL COMMENT '用户角色',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别：1-女；2-男；',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `create_time` datetime DEFAULT NULL COMMENT '用户注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
```

## 评论表（evaluations）
:::info
content_type（内容类型）、content_id（内容ID）、parent_id（父级评论ID）

content_type：表示该条评论数据属于哪一个模块下面。（比如宠物领养系统：宠物、公告、宠物经验帖子信息，模块可以设置为pet、notice、pet_post）

content_id：表示该条评论属于指定模块下面的那一篇内容。

parent_id：为了构建评论之间的从属关系设计的。

:::

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751785001684-c947a5a1-416d-4caa-a173-3baeb51c891f.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u1669c6a1" class="ne-image">

```java
CREATE TABLE `evaluations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级评论ID',
  `commenter_id` int(11) DEFAULT NULL COMMENT '评论者ID',
  `replier_id` int(11) DEFAULT NULL COMMENT '回复者ID',
  `content_type` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '内容类型',
  `content_id` int(11) DEFAULT NULL COMMENT '内容ID',
  `content` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '评论内容',
  `create_time` datetime DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
```

## 评论点赞表（evaluations_upvote）
```java
CREATE TABLE `evaluations_upvote` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论点赞表ID',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `evaluations_id` int(11) DEFAULT NULL COMMENT '点赞ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
```

# 10 前端项目结构
<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751785754666-a8c2e9e4-77d9-4502-8b30-bf20ae400795.png" width="181.71428571428572" title="" crop="0,0,1,1" id="ue8a168b2" class="ne-image">

## node_modules
其实就是前端依赖的各种第三方包所在的位置。

## public文件夹
存放首页，可以放置图片，可以修改一些文字之类

## src/assets文件夹
存放写的全局样式的地方。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751785929970-0d6a2a20-9bac-46de-b896-4bf5d17cb6d8.png" width="1462.857142857143" title="" crop="0,0,1,1" id="udef0e91b" class="ne-image">

## src/components
这是系统的组件所在。

## src/router/index.js
路由配置文件，非常重要，找页面时来这里面找。

## src/utils
前端工具类所在。

## src/views
存放各类功能代码，配合路由配置文件（router/index.js）查看。

# 修改项目的配置
## 修改前后端的端口
前端：vue.config.js里面，port修改为你想要改的端口，改完之后按住ctrl s进行保存。

### <img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751786855881-28ebefbe-a862-4ece-baa0-d5e583ab4d57.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u6592d90a" class="ne-image">
后端：application.yml里面，port改成你想要改的端口。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751786966757-fa170ed1-5543-4994-bf82-42482ae0a19f.png" width="1462.857142857143" title="" crop="0,0,1,1" id="uca17a2b1" class="ne-image">

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751787036476-f1d36f42-e5a6-46e2-b8cf-1f97fb42490f.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u9d809923" class="ne-image">

紧接着，在vscode里面，使用快捷键ctrl shilf f搜索原来的端口:21090，替换成为新的端口:12341，然后点击替换按钮。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751787059863-fbc62cbb-aa74-4467-8492-c772b0c6a4c0.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u581ae415" class="ne-image">

替换完端口之后，如果发现图片无法上传，action前面加上后端api接口的具体路径 。

<img src="https://cdn.nlark.com/yuque/0/2025/png/32649796/1751787321320-be1eeb7f-2ff3-4c1b-8038-eb1f882c5114.png" width="1462.857142857143" title="" crop="0,0,1,1" id="u66e426f7" class="ne-image">
