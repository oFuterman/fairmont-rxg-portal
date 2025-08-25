class Portal::FairController < PortalController

# WARNING: modifying this file is not recommended unless you are familiar with
# developing for the Ruby on Rails web application framework!
#
# This class inherits the default portal's action methods from PortalController.
# Methods defined here will be available as custom actions of this custom portal
# controller.


  # in this portal, instead of doing the normal quick purchase, we look up the
  # account by its note and give it to them if it matches.
  # if we do find it, we log them in and redirect them to the index.
  # if we don't find it, we render the index with an error message.

  # If we do find, it update the account to not have the identifier in its note
  # so it can not be logged into via this method again.

  #
  # @see PortalController#quick_purchase
  #
  # @return [void]

  def quick_purchase

    # Look up the account based on the identifier provided by the user,
    # then place them into the account.
    plans_coupon = params[:plans_coupon].to_s.strip
    if @account = Account.find_by(note: plans_coupon)
      @account.update(note: nil) # clear the note so it can't be used again

      self.login_session = login_session_for_account(@account)

        if plans_coupon = Coupon.find_by_code(session[:plans_coupon])
          redeemed_coupon = plans_coupon.redeemed_coupons.create!(
            account: @account,
            # usage_plan: @usage_plan,
            code: plans_coupon.code,
            batch: plans_coupon.batch,
            credit: plans_coupon.credit,
            expires_at: plans_coupon.expires_at,
            note: plans_coupon.note,
          )

          # consume the Coupon
          plans_coupon.destroy if !plans_coupon.unlimited_redemptions && (plans_coupon.redeemed_coupons.count >= plans_coupon.max_redemptions)
        end

      redirect_to_action :index and return
    else
      flash.now[:notice] = :invalid_coupon
      render_last_action_or_default :index
    end
  end

#   def quick_purchase
#     if logged_in? && @current_account_or_token
#       flash[:notice] = :already_logged_in
#       redirect_to_back_or_index
#       return
#     end

#     # someone submitted a plans coupon to this form, validate it is the correct
#     # kind of coupon
#     if params[:plans_coupon]
#       coupon = Coupon.find_by_code(params[:plans_coupon])
#       unless coupon&.usage_plans&.present?
#         flash[:notice] = :invalid_usage_plan_access_code
#         redirect_to_back_or_index
#         return
#       end
#     end

#     if usage_plans.empty?
#       if Coupon.usage_plan_access_coupons.exists?
#         flash[:notice] = :invalid_usage_plan_access_code
#       else
#         flash[:notice] = :no_usage_plans_available
#       end
#       redirect_to_back_or_index
#       return
#     end

#     # Flag to easily switch between simple and complete quick purchase form by
#     # extending quick_purchase() in a custom PortalController.
#     @simple_form = false

#     # Select the first plan if there isn't one selected already
#     @usage_plan ||= usage_plans.first
#   end

    # # if a coupon was redeemed, consume it here:
    # if @coupon
    #   # record the coupon redemption by creating a RedeemedCoupon record
    #   @redeemed_coupon = RedeemedCoupon.create!(
    #     account: @account,
    #     code: @coupon.code,
    #     batch: @coupon.batch,
    #     credit: @coupon.credit,
    #     expires_at: @coupon.expires_at,
    #     note: @coupon.note,
    #   )

    #   @ar_trans.redeemed_coupon = @redeemed_coupon
    #   @ar_trans.save!

    #   CustomEmail.deliver_for_event(:coupon_redemption,
    #     account: @account,
    #     message_objs: [ @coupon, @coupon.usage_plan, @account, self.login_session ]
    #   )

    #   # consume the Coupon
    #   @coupon.destroy
    # end


    # if plans_coupon = Coupon.find_by_code(session[:plans_coupon])
    #   redeemed_coupon = plans_coupon.redeemed_coupons.create!(
    #     account: @account,
    #     usage_plan: @usage_plan,
    #     code: plans_coupon.code,
    #     batch: plans_coupon.batch,
    #     credit: plans_coupon.credit,
    #     expires_at: plans_coupon.expires_at,
    #     note: plans_coupon.note,
    #   )

    #   # consume the Coupon
    #   plans_coupon.destroy if !plans_coupon.unlimited_redemptions && (plans_coupon.redeemed_coupons.count >= plans_coupon.max_redemptions)
    # end

end

