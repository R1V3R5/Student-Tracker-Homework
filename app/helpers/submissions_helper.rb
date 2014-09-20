module SubmissionsHelper
  def display_links(submission)
    if submission.workflow_state == 'new'
      a = link_to "Review", 'javascript:void(0);', class: "review change_workflow", submission_url: reviewing_location_course_assignment_submission_path(@location, @course, @assignment, submission) if can? :update, Submission
    elsif submission.workflow_state == 'reviewing'
      a = link_to "Incomplete", 'javascript:void(0);', class: "incomplete change_workflow", submission_url: incomplete_location_course_assignment_submission_path(@location, @course, @assignment, submission) if can? :update, Submission
      a +='|'
      a += link_to "Complete", 'javascript:void(0);', class: "complete change_workflow", submission_url: complete_location_course_assignment_submission_path(@location, @course, @assignment, submission) if can? :update, Submission
      a
    elsif submission.workflow_state == 'incomplete'
      a = link_to "Re-Review", 'javascript:void(0);', class: "re_review change_workflow", submission_url: reviewing_location_course_assignment_submission_path(@location, @course, @assignment, submission) if can? :update, Submission
      a +='|'
      a += link_to "Complete", 'javascript:void(0);', class: "complete change_workflow", submission_url: complete_location_course_assignment_submission_path(@location, @course, @assignment, submission) if can? :update, Submission
      a 
    elsif submission.workflow_state == 'complete'
    end
  end
end
