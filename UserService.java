public class UserService {
    private UserDAO userDAO = new UserDAO();

    public void add(User user) {
        userDAO.insert(user);
        System.out.println("添加用户成功");
    }

    public void queryByUsername(String username) {
        userDAO.selectByUsername(username);
        System.out.println("根据用户名查询用户成功");
    }
}
