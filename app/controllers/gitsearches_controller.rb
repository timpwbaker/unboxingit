class GitsearchesController < ApplicationController
  before_action :set_gitsearch, only: [:show, :edit, :update, :destroy]
  require 'open-uri'

  def index
    @name = params[:gh_name]

    # Request the user's repos from the GitHub API, handle any errors

    begin
      @github_json_object = JSON.parse(open("https://api.github.com/users/"+@name+"/repos").read)
    rescue OpenURI::HTTPError => error
      response = error.io
      if response.status == ["404", "Not Found"] 
        redirect_to root_path(:gh_name => @name), notice: 'That user doesn\'t exist, please check your spelling.' and return
      else
        redirect_to root_path, notice: 'There seems to be a problem with the GitHub API, please check back later.' and return
      end
    end

    # Check that the returned user has some repos

    if @github_json_object === []
      redirect_to root_path, notice: 'That user exists, but doesn\'t have any public repos. Why not try someone else?' and return
    end

    # Extract all of the languages from the user's repos

    @languages_list = []
    @github_json_object.each do |object|
      if object["language"] === nil
        @languages_list.push("Not Specified")
      else
        @languages_list.push(object["language"])
      end
    end

    # Count how many instances of each language there is

    @counts = Hash.new 0
    @languages_list.each do |language|
      @counts[language] += 1
    end

    # Order the languages from highest instance to lowest

    @languages = []
    @numbers = []
    @counts = @counts.sort_by {|k,v| v}.reverse
    @counts.each do |language,count|
      @languages.push(language)
      @numbers.push(count)
    end

    # Check if there is more than one language joint top

    @primary_languages = [@languages[0]];
    @numbers.each_with_index do |number,index|
      if index > 0 
        if number != @numbers[index-1]
          break
        else
          @primary_languages.push(@languages[index])
        end
      end
    end


  end

  private
   
end
