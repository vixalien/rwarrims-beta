class Admin::DocumentsController < AdminController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :approve]

  # GET /documents
  # GET /documents.json
  def index
    params[:employee] ||= Employee.all.ids
    @employees = Employee.find(params[:employee])
    if params[:only] == "approved"
      @only = "Approved"
      @documents = Document.where(approved: true, employee: @employees)
    elsif params[:only] == "pending"
      @only = "Pending"
      @documents = Document.where(approved: false, employee: @employees)
    else
      @documents = Document.where(employee: @employees)
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end


  # GET /documents/1/edit
  def edit
  end

  # GET /documents/1/approve
  def approve
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    if document_params[:approved].to_i == 1
      @document.approved_by = current_employee.id
    end
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to admin_document_path(@document), notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_document_path(@document) }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to admin_documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :approved, :attachment)
    end
end
