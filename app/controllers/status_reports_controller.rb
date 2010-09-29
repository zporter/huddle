class StatusReportsController < ApplicationController
  # GET /status_reports
  # GET /status_reports.xml
  def index
    @status_reports = StatusReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @status_reports }
    end
  end

  # GET /status_reports/1
  # GET /status_reports/1.xml
  def show
    @status_report = StatusReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status_report }
    end
  end

  # GET /status_reports/new
  # GET /status_reports/new.xml
  def new
    @status_report = StatusReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status_report }
    end
  end

  # GET /status_reports/1/edit
  def edit
    @status_report = StatusReport.find(params[:id])
  end

  # POST /status_reports
  # POST /status_reports.xml
  def create
    @status_report = StatusReport.new(params[:status_report])
    @status_report.status_date = Date.today

    respond_to do |format|
      if @status_report.save
        format.html { redirect_to(@status_report, :notice => 'Status report was successfully created.') }
        format.xml  { render :xml => @status_report, :status => :created, :location => @status_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /status_reports/1
  # PUT /status_reports/1.xml
  def update
    @status_report = StatusReport.find(params[:id])

    respond_to do |format|
      if @status_report.update_attributes(params[:status_report])
        format.html { redirect_to(@status_report, :notice => 'Status report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /status_reports/1
  # DELETE /status_reports/1.xml
  def destroy
    @status_report = StatusReport.find(params[:id])
    @status_report.destroy

    respond_to do |format|
      format.html { redirect_to(status_reports_url) }
      format.xml  { head :ok }
    end
  end
end
