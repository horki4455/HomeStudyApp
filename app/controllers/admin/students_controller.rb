class Admin::StudentsController < Admin::BaseController
    before_action :set_student, only: %i[show update destroy edit]

    def index
      @students = Student.all.includes(:user).order(created_at: :desc)
    end

    def show
      @memo = Memo.new
    end

    def new
      @student = Student.new
    end

    def create
      @student = Student.new(student_params)
      @student.user = current_user
      if @student.save!
        redirect_to(admin_students_path, success: '掲示板を作成しました。')
      else
        flash.now[:danger] = '掲示板の作成に失敗しました。'
        render :new
      end
    end

    def edit
      @student = current_user.students.find(params[:id])
    end

    def update
      @student = current_user.students.find(params[:id])
      if @student.update(student_params)
        redirect_to(admin_students_path(@student), success: '掲示板を更新しました。')
      else
        flash.now[:danger] = '掲示板の更新に失敗しました。'
        render :edit
      end
    end

    def destroy
      @student.destroy!
      redirect_to(admin_students_path, success: '掲示板を消去しました。')
    end

    private

    def student_params
      params.require(:student).permit(:name, :body, :image, :mail).merge(user_id: params[:user_id])
    end

    def set_student
      @student = Student.find(params[:id])
    end
end
