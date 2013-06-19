require 'test_helper'

class PublicationsControllerTest < ActionController::TestCase
  setup do
    @publication = publications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:publications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create publication" do
    assert_difference('Publication.count') do
      post :create, publication: { abstract: @publication.abstract, city: @publication.city, date_of_last_access: @publication.date_of_last_access, doi: @publication.doi, edition: @publication.edition, instituion: @publication.instituion, issue: @publication.issue, journal: @publication.journal, keywords: @publication.keywords, pages: @publication.pages, publisher: @publication.publisher, title: @publication.title, url: @publication.url, volume: @publication.volume, year: @publication.year }
    end

    assert_redirected_to publication_path(assigns(:publication))
  end

  test "should show publication" do
    get :show, id: @publication
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @publication
    assert_response :success
  end

  test "should update publication" do
    put :update, id: @publication, publication: { abstract: @publication.abstract, city: @publication.city, date_of_last_access: @publication.date_of_last_access, doi: @publication.doi, edition: @publication.edition, instituion: @publication.instituion, issue: @publication.issue, journal: @publication.journal, keywords: @publication.keywords, pages: @publication.pages, publisher: @publication.publisher, title: @publication.title, url: @publication.url, volume: @publication.volume, year: @publication.year }
    assert_redirected_to publication_path(assigns(:publication))
  end

  test "should destroy publication" do
    assert_difference('Publication.count', -1) do
      delete :destroy, id: @publication
    end

    assert_redirected_to publications_path
  end
end
