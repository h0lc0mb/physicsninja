module SessionsHelper

	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "Please sign in."
		end
	end

	def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end

	def admin_user
		redirect_to root_url, notice: "Sorry, grasshopper: You must be an admin to view that page." unless current_user.try(:admin?)
	end

	def ninja_user
		redirect_to root_url, notice: "Sorry, grasshopper: You must be a ninja to view that page." unless current_user.try(:ninja?)
	end

	def new_comment
    Question.includes(:responses, :comments).where("responses.user_id = ? and comments.created_at < ?", id, "DATE_SUB(CURDATE(), INTERVAL 1 DAY)")
  end
end