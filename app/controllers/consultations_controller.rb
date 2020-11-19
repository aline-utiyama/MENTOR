class ConsultationsController < ApplicationController

  def index
    @consultations = policy_scope(Consultation).order(created_at: :desc)
  end

  def show
    @consultation = Consultation.find(params[:id])
    authorize @consultation
  end

  def create
    @mentor = Mentor.find(params[:mentor_id])
    @consultation = Consultation.new(consultation_params)
    @consultation.user = current_user
    @consultation.mentor = @mentor
    authorize @consultation

    if @consultation.save
      redirect_to consultations_path
    else
      render "mentors/show"
    end
  end

  def update
    @consultation = Consultation.find(params[:id])
    authorize @consultation

    if @consultation.update(consultation_params)
      redirect_to mentor_consultation_path
    else
      render mentor_consultation_path
    end

  end

  private

  def consultation_params
    params.require(:consultation).permit(:details, :start_time, :duration, :status, tag_ids: [])
  end
end
