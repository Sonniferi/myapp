public class UserController {
    private UserService userService = new UserService();

    public void login(String username, String password) {
        System.out.println("登录成功");
    }

    public void reg(User user) {
        userService.add(user);
        System.out.println("注册成功");
    }
}
