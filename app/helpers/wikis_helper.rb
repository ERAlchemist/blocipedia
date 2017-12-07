module WikisHelper
    def user_is_authorized_to_create?
        current_user && (current_user.admin? || current_user.premium?)
    end
    
    def user_is_authorized_to_update?
        current_user
    end
    
    def user_is_authorized_to_delete?
        current_user && (current_user == @wiki.user || current_user.admin?)
    end

    
    def show_collaborators
        @wiki.collaborator_users.collect{|user| user.email}.join(', ')
    end
    

end
