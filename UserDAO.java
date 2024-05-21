public class UserDAO {
    public void insert(User user) {
        System.out.println("插入用户成功");
    }

    public void delete(int userId) {
        System.out.println("删除用户成功");
    }

    public void update(User user) {
        System.out.println("更新用户成功");
    }

    public void selectAll() {
        System.out.println("已选择所有用户");
    }

    public void selectByUsername(String username) {
        System.out.println("根据用户名选择用户成功");
    }
}
