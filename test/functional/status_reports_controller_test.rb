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
    assert_difference "StatusReport.count", 1 do
      post :create, :status_report => {
        :project_id => projects(:one).to_param,
        :user_id => users(:one).to_param,
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
end
