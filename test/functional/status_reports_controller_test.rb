require 'test_helper'

class StatusReportsControllerTest < ActionController::TestCase
  setup do
    login_as_one
    @status_report = status_reports(:one)
  end

  # Rails scaffold generated tests
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:status_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create status_report" do
    assert_difference('StatusReport.count') do
      post :create, :status_report => @status_report.attributes
    end

    assert_redirected_to status_report_path(assigns(:status_report))
  end

  test "should show status_report" do
    get :show, :id => @status_report.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @status_report.to_param
    assert_response :success
  end

  test "should update status_report" do
    put :update, :id => @status_report.to_param, :status_report => @status_report.attributes
    assert_redirected_to status_report_path(assigns(:status_report))
  end

  test "should destroy status_report" do
    assert_difference('StatusReport.count', -1) do
      delete :destroy, :id => @status_report.to_param
    end

    assert_redirected_to status_reports_path
  end
  
  # Developer-defined tests
  test "creation of status report with data" do
    set_current_project(:one)
    assert_difference "StatusReport.count", 1 do
      post :create, :status_report => {
        :yesterday => "I did stuff",
        :today => "I'll do stuff"
      }
    end
    actual = assigns(:status_report)
    assert_equal(projects(:one).id, actual.project.id)
    assert_equal(users(:one).id, actual.user.id)
    assert_equal(Date.today.to_s(:db), actual.status_date.to_s(:db))
    assert_redirected_to status_report_path(actual)
  end
  
  test "redirect and logout if the user tries to snipe a user id" do
    noel = User.create!(:email => 'railsprescriptions@gmail.com', :password => 'banana', :password_confirmation => 'banana')
    set_current_project(:one)
    assert_no_difference "StatusReport.count" do
      post :create, :status_report => { :user_id => noel.id, :yesterday => 'I did stuff', :today => "I'll do stuff" }
    end
    assert_nil(session[:user_id])
    assert_redirected_to new_user_session_path
  end
  
  # view tests
  test "new form has expected elements" do
    get :new
    assert_select 'form[id=new_status_report][action=/status_reports]' do
      assert_select '#status_report_project', :count => 0
      assert_select '#status_report_user', :count => 0
      assert_select 'textarea#status_report_today'
      assert_select 'textarea#status_report_yesterday'
      assert_select '#status_report_status_date_li', :count => 0
    end
  end
end
