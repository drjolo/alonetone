# -*- encoding : utf-8 -*-

class PagesController < ApplicationController
  skip_filter _process_action_callbacks.map(&:filter), :only => :help_an_app_support_brutha_out
  layout "pages"
  caches_page :sitemap
  
  
  class Hell < StandardError; end

  def twentyfour
    render :layout => '24houralbum'
  end

  def rpm_challenge
    ids_2010 = [2140,2037,2151,2096,2152,2082,2158,2157,2107,
                2045,2161,2163,2160,2127,2162,2021,2139,2147,
                2141,2164,2167,2046,2084,2153,2173,2172,2007,
                2138,2175,2125,2148,2180,2044,2129,2184,2165,
                2078,2108,2029,2195,2083,2194,2187,2182,2196,
                2174,2197,2200,2202,2150,2209,2012,2215,2245,
                2241,2234]
    ids_2009 = [ 986, 951,945, 924,912, 915, 916, 918, 921, 923, 
            926, 927, 928, 933, 935, 944, 910,
            906, 904, 899, 893, 892, 891, 887, 886, 882, 880, 
            879, 877, 875, 872, 864, 863, 860, 858, 857, 856, 
            855, 852, 849, 846, 845, 843, 842, 841, 
            840, 838, 836, 834, 832, 831, 829, 828, 827, 
            826, 825, 824, 823, 822, 821, 818, 817, 816, 814, 
            812, 810, 806, 805, 804, 802, 801, 800, 716, 799, 798, 
            797, 790, 787, 786, 767, 762 , 
            760, 753, 745, 742, 739, 724, 729,809, 819, 830]
    @albums_2009 = Playlist.where(:id => ids_2009).order('created_at ASC').includes([:pic, :user])
    @albums_2010 = Playlist.where(:id => ids_2010).includes([:user,:pic])
    render :layout => 'rpm_challenge'
  end

  def index
    @page_title = "About alonetone, the kickass home for musicians"
  end

  def home
  
  end
  
  def error
    @page_title = "Whups, alonetone slipped and fell!"
    flash[:error] = "We have a problem. But, it is not you...it's me."
  end
  
  def four_oh_four
    @page_title = "Not found"
    flash[:error] = "Gone looking but did not find? Try searching, or let us know!"
  end

  def help_an_app_support_brutha_out
    query      = "SELECT version FROM schema_migrations ORDER BY version DESC LIMIT 1"
    version    = ActiveRecord::Base.connection.select_value(query)
    time       = Time.now.to_formatted_s(:rfc822)
    render(:text => "O Hai. You can haz alonetone. kthxbai!")
  end

  def about
    @page_title = "About alonetone, the kickass home for musicians"
  end
  
  def donate
    @page_title = "Donate to alonetone"
  end
  
  def donate_thanks
    @page_title = "Thanks for your donation!"
  end
  
  def press
  end
  
  def stats
    @page_title = "Listening and Song Statistics"
    @number_of_musicians = User.musicians.count
    @comments_per_user = User.average('comments_count').ceil
    @average_length_of_track = Asset.formatted_time(Asset.average('length').ceil)
    @listens_per_track = Asset.average('listens_count').ceil
    @listens_per_user = User.average('listens_count').ceil
    @tracks_per_user = User.average('assets_count').ceil
    @listens_per_week_per_track = Asset.average('listens_per_week').ceil
    @posts_per_user = User.average('posts_count')
  end
  
  def actually_going_somewhere_with_facebooker_and_rails
    render :partial => 'facebooker', :layout => true
  end

  def answers
    raise Hell
  end
  
  def not_yet
    render :layout => false
  end
  
  def itunes
    @page_title = "How to get your music on iTunes (as a music podcast) with alonetone"
  end
  
  def sitemap
    respond_to do |wants|
      wants.xml
    end
  end
end
